From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] http-push: remove remote locks on exit signals
Date: Fri, 23 May 2008 14:40:41 -0700
Message-ID: <7vod6wr95y.fsf@gitster.siamese.dyndns.org>
References: <20080522195546.GA29911@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri May 23 23:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzf1a-0005Dl-Pt
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 23:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbYEWVky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYEWVky
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 17:40:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbYEWVkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 17:40:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 101FC6770;
	Fri, 23 May 2008 17:40:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 28ED9676F; Fri, 23 May 2008 17:40:46 -0400 (EDT)
In-Reply-To: <20080522195546.GA29911@localhost> (Clemens Buchacher's message
 of "Thu, 22 May 2008 21:55:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8A837CE-2910-11DD-89A8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82761>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/http-push.c b/http-push.c
> index 5b23038..b1f5302 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1349,6 +1349,24 @@ static int unlock_remote(struct remote_lock *lock)
>  	return rc;
>  }
>  
> +static void remove_locks(void)
> +{
> +	struct remote_lock *lock = remote->locks;
> +	
> +	fprintf(stderr, "Removing remote locks...\n");
> +	while (lock) {
> +		unlock_remote(lock);
> +		lock = lock->next;
> +	}
> +}
> +
> +static void remove_locks_on_signal(int signo)
> +{
> +	remove_locks();
> +	signal(SIGINT, SIG_DFL);
> +	raise(signo);
> +}
> +

If you caught signo, shouldn't you be resetting that signo not SIGINT?

>  static void remote_ls(const char *path, int flags,
>  		      void (*userFunc)(struct remote_ls_ctx *ls),
>  		      void *userData);
> @@ -2255,6 +2273,8 @@ int main(int argc, char **argv)
>  		goto cleanup;
>  	}
>  
> +	signal(SIGINT, remove_locks_on_signal);
> +

and you may care more than just INT but perhaps HUP and others?


>  	/* Check whether the remote has server info files */
>  	remote->can_update_info_refs = 0;
>  	remote->has_info_refs = remote_exists("info/refs");

Having said that, I do not use http-push myself, so I'll wait for others
who do use it to comment on this; success reports are welcomed, reports on
bad side effects, if any, are even more appreciated.
