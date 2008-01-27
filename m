From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH] Fix some memory leaks in various places
Date: Sat, 26 Jan 2008 18:18:36 -0800
Message-ID: <7v4pd0yps3.fsf@gitster.siamese.dyndns.org>
References: <1201344627-21609-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 03:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIx7A-0003sI-Uf
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 03:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598AbYA0CSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 21:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757325AbYA0CSt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 21:18:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497AbYA0CSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 21:18:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 00CF6460E;
	Sat, 26 Jan 2008 21:18:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F7B460D;
	Sat, 26 Jan 2008 21:18:38 -0500 (EST)
In-Reply-To: <1201344627-21609-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Sat, 26 Jan 2008 11:50:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71797>

Mike Hommey <mh@glandium.org> writes:

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index e1393b8..df61758 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -415,6 +415,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	safe_create_dir(path, 1);
>  	strcpy(path+len, "/info");
>  	safe_create_dir(path, 1);
> +	free(path);
>  
>  	if (shared_repository) {
>  		char buf[10];

This is "technically correct but do we care?" category
immediately before exiting.

> diff --git a/http-walker.c b/http-walker.c
> index 2c37868..1a02f86 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -231,6 +231,8 @@ static void finish_object_request(struct object_request *obj_req)
>  {
>  	struct stat st;
>  
> +	free(obj_req->url);
> +
>  	fchmod(obj_req->local, 0444);
>  	close(obj_req->local); obj_req->local = -1;
>  

I am not sure about this.  Instead of freeing this memory early,
the function's sole caller, process_object_response(), may be
the right place to do this after calling this function.

Who is responsible for reclaiming the memory for obj_req itself
that is passed to the callback function process_object_response()?
Having two different functions release_object_request() and
finish_object_request() that clean things up differently makes
me feel somewhat queasy.

> @@ -897,9 +899,17 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
>  static void cleanup(struct walker *walker)
>  {
>  	struct walker_data *data = walker->data;
> +	struct alt_base *prev_altbase, *altbase = data->alt;
> +	while (altbase) {
> +		free(altbase->base);
> +		prev_altbase = altbase;
> +		altbase = altbase->next;
> +		free(prev_altbase);
> +	}
>  	http_cleanup();
>  
>  	curl_slist_free_all(data->no_pragma_header);
> +	free(data);
>  }
>  
>  struct walker *get_http_walker(const char *url)

Looks Ok.

> diff --git a/walker.c b/walker.c
> index adc3e80..64fc419 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -299,6 +299,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  			goto unlock_and_fail;
>  	}
>  	free(msg);
> +	free(sha1);
>  
>  	return 0;
>  
> @@ -306,6 +307,7 @@ unlock_and_fail:
>  	for (i = 0; i < targets; i++)
>  		if (lock[i])
>  			unlock_ref(lock[i]);
> +	free(sha1);
>  
>  	return -1;
>  }

This does not seem to free something that should not get freed,
but there is another leak, I think.  If write_ref_log_details is
set and write_ref_sha1() fails, goto unlock_and_fail will leak
msg, won't it?
