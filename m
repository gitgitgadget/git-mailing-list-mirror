From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow multiple merges to invalid HEAD
Date: Sun, 03 Apr 2011 01:08:56 -0700
Message-ID: <7vei5jg3jb.fsf@alter.siamese.dyndns.org>
References: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Chen <tnachen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 10:09:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6INL-0002Nw-21
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 10:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab1DCIJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 04:09:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab1DCIJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 04:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D20D02D32;
	Sun,  3 Apr 2011 04:10:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/5vWjT0TZxNqjdBIwCKdAtIMcE=; b=T21HjO
	2rkQSO/i7VKv8+XSuGg0OkMnDdg6zya+iB7iJMg4TrpHkasrZMH9MYjYP897vm5w
	Ramo7jDOfxvz03u4YmBcpkVBCAUKvPIc8NuamQIf36yyhw3d2sWe/NYt+unnK05U
	dHcWXF1F9y08EmAIhN8AFPw1k6cCFR4XznCSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZHAiv3qoFSy8bZi6lCYSxvsTbTQRxXka
	aHfwMYcZ7MwKgIefccLBp84eetNFYdou1nyg8HRLDoYHMtqNwyjdxsMb8Szw2urb
	hxKC8vUfQhal/z2LJv66RBbdKMeRK9HhAO3vMyD/r47FATVm7N2ILl09S1bg37p9
	NV9/c/7rbsI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 675212D31;
	Sun,  3 Apr 2011 04:10:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 686F12D30; Sun,  3 Apr 2011
 04:10:49 -0400 (EDT)
In-Reply-To: <1301813216-19507-1-git-send-email-tnachen@gmail.com> (Timothy
 Chen's message of "Sat, 2 Apr 2011 23:46:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E46F87B6-5DC9-11E0-93F0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170683>

Timothy Chen <tnachen@gmail.com> writes:

> This patch will allow multiple branches to be passed in,
> and first updates current HEAD to the first branch's head then subsequently
> merge the rest of the branches.

I've questioned the motivation of the patch already, but let's comment on
the mechanics as well while I am waiting for some builds to finish ;-)

> diff --git a/builtin/merge.c b/builtin/merge.c
> index d54e7dd..290e0d4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1090,9 +1090,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		 * to forbid "git merge" into a branch yet to be born.
>  		 * We do the same for "git pull".
>  		 */
>  		if (squash)
>  			die(_("Squash commit into empty head not supported yet"));
>  		if (!allow_fast_forward)
> @@ -1101,36 +1098,44 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
>  		if (!remote_head)
>  			die(_("%s - not something we can merge"), argv[0]);
>  		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
>  				DIE_ON_ERR);

You are going to perform a series of operations that is a lot more complex
than what we traditionally have done at this point.  I do not think it is
safe at all to update the ref this early before even knowing if the rest
of the command succeeds.

> +		if (argc < 2)
> +			return 0;
> +
> +		hashcpy(head, remote_head->sha1);
> +		read_empty(remote_head->sha1, 0);
> +		head_arg = argv[0];
> +		argc--;
> +		argv++;
> +	}
> +
> +	struct strbuf merge_names = STRBUF_INIT;

Decl-after-statement.

> +	/* We are invoked directly as the first-class UI. */
> +	if(!head_invalid)

SP after syntactic keyword and the open paren associated with it.

>  		head_arg = "HEAD";
>  
> +	/*
> +	 * All the rest are the commits being merged;
> +	 * prepare the standard merge summary message to
> +	 * be appended to the given message.  If remote
> +	 * is invalid we will die later in the common
> +	 * codepath so we discard the error in this
> +	 * loop.
> +	 */
> +	for (i = 0; i < argc; i++)
> +		merge_name(argv[i], &merge_names);
> +
> +	if (!have_message || shortlog_len) {
> +		fmt_merge_msg(&merge_names, &merge_msg, !have_message,
> +				  shortlog_len);
> +		if (merge_msg.len)
> +			strbuf_setlen(&merge_msg, merge_msg.len - 1);
>  	}
>  
> +	if (!argc)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);
