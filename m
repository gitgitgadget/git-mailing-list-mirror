From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using git commit --amend on a commit with an empty message
Date: Mon, 09 Jul 2012 10:25:46 -0700
Message-ID: <7v7guclucl.fsf@alter.siamese.dyndns.org>
References: <20120709142437.GQ13885@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 19:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoHic-0002wh-MW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 19:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2GIRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 13:25:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab2GIRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 13:25:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFAF59E41;
	Mon,  9 Jul 2012 13:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FBlhqW+6umzeY8iKCk/X87wBmaw=; b=nsnKt0
	hY7FE+BwJNhTXhsfw6lSJwweljsYHJEmkr+K4XD9fWDw55DbOiZ6RDET2P15+BMZ
	GDtnA1XJ9hIpT2Br4lWZJSMLRRS34CoEq/tXcpubzm9z8+yM79lMifjpHPDSn9OL
	rQh/mDJ/IjEWytJh7M9+1fweKeoHGNAEEoCvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZuO0rt9BAeQSgq8AjsOpCC+YAQBz205
	LgXvFC4aysDKTQzze9xl4lVQiA51vaINqNxVzs7NZkVzjd9P1T2cw1conY6y4OZh
	p13tvSWKHjj1vtCJInVQnwBfol9v0epITdX5D/YoUuapG+v4S97sYQWjy2H2Syj0
	EyDYIBxuKD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5E4B9E40;
	Mon,  9 Jul 2012 13:25:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2D239E3B; Mon,  9 Jul 2012
 13:25:47 -0400 (EDT)
In-Reply-To: <20120709142437.GQ13885@arachsys.com> (Chris Webb's message of
 "Mon, 9 Jul 2012 15:24:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F60E516-C9EB-11E1-9ED8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201212>

Chris Webb <chris@arachsys.com> writes:

> In fact, we even fail to start the editor if --allow-empty-message is
> explicitly provided:
>
>   $ git commit --allow-empty --allow-empty-message -m ''
>   $ git commit --amend --allow-empty-message
>   fatal: commit has empty message
>
> Assuming this isn't intentional for some reason I don't understand, I think
> this is the correct tiny fix? make test succeeds fine both before and after.

Yeah, it is a "bug" that exists only because nobody sane uses empty
message commits, let alone tries to amend such commits, hence went
unnoticed for a long time.

The patch looks sane; if we want to keep this as a feature or a
bugfix, we may want to pretect it with a new test, though.

Thanks.

> -- >8 --
> Subject: [PATCH] Allow edit of empty message with commit --amend
>
> If git commit --amend is used on a commit with an empty message, it fails
> unless -m is given, whether or not --allow-empty-message is specified.
>
> Instead, allow it to proceed to the editor with an empty commit message.
> Unless --allow-empty-message is in force, it will still abort later if an
> empty message is saved from the editor. (That check was already present
> and necessary to prevent a non-empty commit message being edited to an
> empty one.)
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  builtin/commit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index f43eaaf..6515da2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -640,7 +640,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg1 = "message";
>  	} else if (use_message) {
>  		buffer = strstr(use_message_buffer, "\n\n");
> -		if (!buffer || buffer[2] == '\0')
> +		if (!use_editor && (!buffer || buffer[2] == '\0'))
>  			die(_("commit has empty message"));
>  		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
>  		hook_arg1 = "commit";
