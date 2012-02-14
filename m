From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] Refactor submodule push check to use string list
 instead of integer
Date: Mon, 13 Feb 2012 19:28:24 -0800
Message-ID: <7vbop29jqf.fsf@alter.siamese.dyndns.org>
References: <20120213092541.GA15585@t1405.greatnet.de>
 <20120213092900.GC15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 04:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx94D-0000xW-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 04:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926Ab2BND22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 22:28:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab2BND21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 22:28:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C268373BC;
	Mon, 13 Feb 2012 22:28:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y6xQQnN4WjCgjcc+G+n0aTc9ju4=; b=dHY7Hj
	GVnQ8tvMvkX0l4hfcD/jMLrEDnF40Ej3wBoCXcDu+HDVe4MF/LYEbfbrBTnvsr26
	r8tO7eDvCbkMoNQCzO5SXUBUyHaW07KEldn7WDu1pbRaYtKfmVJ7Gp6Xwl4TcyqV
	i1pDFLkA+7DnBCs5kGINqW3J5mdt4qXG8b5TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kc0h5aShq15hIWKv3lloC4rTmH8we4gn
	J+lKYIIMA38fWXKoMruh9cU50e8qk2r7OfMAX1XtMHY92lD73QWmLBKa5+cGUk6g
	GLzSTNnKCH2Ulwdrm37gijXKc5Un0cqTKyKmJ4xUZpMQzlUOBul2VaLUiiRWA5ko
	Q5+Sc4Ca1Tc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B937A73BB;
	Mon, 13 Feb 2012 22:28:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E8BD73BA; Mon, 13 Feb 2012
 22:28:26 -0500 (EST)
In-Reply-To: <20120213092900.GC15585@t1405.greatnet.de> (Heiko Voigt's
 message of "Mon, 13 Feb 2012 10:29:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4B24F5A-56BB-11E1-88D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190698>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This allows us to tell the user which submodules have not been pushed.
> Additionally this is helpful when we want to automatically try to push
> submodules that have not been pushed.

Makes sense.

> diff --git a/submodule.c b/submodule.c
> index 645ff5d..3c714c2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -357,21 +357,20 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
>  					 void *data)
>  {
>  	int i;
> -	int *needs_pushing = data;
> +	struct string_list *needs_pushing = data;
>  
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		if (!S_ISGITLINK(p->two->mode))
>  			continue;
>  		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
> -			*needs_pushing = 1;
> -			break;
> +			if (!string_list_has_string(needs_pushing, p->two->path))
> +				string_list_insert(needs_pushing, p->two->path);

Does string_list API have "look for this and insert if it doesn't exist
but otherwise don't do anything"?  Running get_entry_index() to answer
has_string() once and then calling it again to find where to insert to
respond to insert() looks a bit wasteful.

Just wondering.

>  		}
>  	}
>  }
>  
> -
> -static void commit_need_pushing(struct commit *commit, int *needs_pushing)
> +static void commit_need_pushing(struct commit *commit, struct string_list *needs_pushing)
>  {
>  	struct rev_info rev;
>  
> @@ -382,14 +381,15 @@ static void commit_need_pushing(struct commit *commit, int *needs_pushing)
>  	diff_tree_combined_merge(commit, 1, &rev);
>  }
>  
> -int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
> +int check_submodule_needs_pushing(unsigned char new_sha1[20],
> +		const char *remotes_name, struct string_list *needs_pushing)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
>  	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
>  	int argc = ARRAY_SIZE(argv) - 1;
>  	char *sha1_copy;
> -	int needs_pushing = 0;
> +
>  	struct strbuf remotes_arg = STRBUF_INIT;
>  
>  	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
> @@ -401,14 +401,14 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
>  	if (prepare_revision_walk(&rev))
>  		die("revision walk setup failed");
>  
> -	while ((commit = get_revision(&rev)) && !needs_pushing)
> -		commit_need_pushing(commit, &needs_pushing);
> +	while ((commit = get_revision(&rev)) != NULL)
> +		commit_need_pushing(commit, needs_pushing);

Now the helper function to find list of submodules that need pushing given
one commit starting to look more and more misnamed.  It used to be "learn
if something needs pushing", but now it is "find what needs pushing".

Can somebody think of a good adjective to describe a submodule (or a set
of submodules) in this state, so that we can name this helper function
find_blue_submodules(), if the adjective were "blue"?

"Unpushed" submodule is the word used in the later part of the patch.
