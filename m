From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Notes: Connect the %N flag to --{show,no}-notes
Date: Sat, 10 Apr 2010 14:51:55 -0700
Message-ID: <7v1venvuv8.fsf@alter.siamese.dyndns.org>
References: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
 <1270935032-10536-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 23:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ib9-0001c9-FZ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 23:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0DJVwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 17:52:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab0DJVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 17:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C8DA91DD;
	Sat, 10 Apr 2010 17:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=71Y0GST4Ye2jhWrQJf1HuXO1fUk=; b=j4jr4t
	MWqzIbEreAoGL/u1HfZ3Cs5+tKrrlOK/6z88qJQUN/Y9fG8tTj/nm/NXtiv+PVc7
	jNW/Z7ZE4Dh+pzWPPhEhPQ8bnLKUmROY/LdUUC+1hh6PeHX2H+uwEbJTTwOpoA/u
	qisXOsSnMgpD7DN8PSnNB48NI3RXa2ivML0tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BUrr3wLh4EDLW1pEj0Qrgrq9WWrUQLjo
	cYSwIC6yvMfiaGaowuCEPV7hxaKsKdDwyh8US+z65MiVyp0i73H5LhilPSStWJtd
	XuKRwvvj3j6USLt/0UstG+m58H2yOyNodImy+Dp/iPR30TLZzAdi19KgMyV8/yl4
	nVtroCpZflg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D004BA91DB;
	Sat, 10 Apr 2010 17:52:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6950A91D9; Sat, 10 Apr
 2010 17:51:56 -0400 (EDT)
In-Reply-To: <1270935032-10536-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Sat\, 10 Apr 2010 23\:30\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B72C5AC-44EB-11DF-9E55-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144598>

Johannes Gilger <heipei@hackvalue.de> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index b706a5f..029d7b8 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -58,9 +58,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  		usage(builtin_log_usage);
>  	argc = setup_revisions(argc, argv, rev, opt);
>  
> -	if (!rev->show_notes_given && !rev->pretty_given)
> +	if (!rev->show_notes_given)
>  		rev->show_notes = 1;

I am puzzled by this change and its possible interaction with codepaths
that do not have anything to do with %N.  When there is no show-notes and
an explicit --pretty, we do not want to have rev->show_notes set.

Admittedly, the real end result we want to see in such a case is just that
notes are not shown (and rev->show_notes being false is one natural way to
achieve that), and if ...

> -	if (rev->show_notes)
> +	if (rev->show_notes && (!rev->pretty_given || rev->show_notes_given))
>  		init_display_notes(&rev->notes_opt);

... this change is about ensuring the same outcome by not initializing the
notes tree, that may work, but it somehow feels iffy.  It would leave some
codepaths (and another one you just added, I think, with the other hunk in
this patch) that say "do this only when rev->show_notes is set" and some
other codepaths that say "unconditionally try to show notes and rely on
the caller not have initialized the notes tree when it is not wanted."  Is
that what is going on?

Unfortunately I don't think of a better and cleaner solution offhand
(perhaps such a cleaner solution would involve adding a bit more state in
the rev structure, but I haven't thought things through).

> diff --git a/notes.c b/notes.c
> index e425e19..ad14a8b 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1183,7 +1183,9 @@ void format_display_notes(const unsigned char *object_sha1,
>  			  struct strbuf *sb, const char *output_encoding, int flags)
>  {
>  	int i;
> -	assert(display_notes_trees);
> +	if(!display_notes_trees)
> +		init_display_notes(NULL);
> +
>  	for (i = 0; display_notes_trees[i]; i++)
>  		format_note(display_notes_trees[i], object_sha1, sb,
>  			    output_encoding, flags);
> diff --git a/pretty.c b/pretty.c
> index 6ba3da8..8e828a1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -775,9 +775,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  		}
>  		return 0;	/* unknown %g placeholder */
>  	case 'N':
> -		format_display_notes(commit->object.sha1, sb,
> -			    git_log_output_encoding ? git_log_output_encoding
> -						    : git_commit_encoding, 0);
> +		if (c->pretty_ctx->show_notes)
> +			format_display_notes(commit->object.sha1, sb,
> +					     git_log_output_encoding ? git_log_output_encoding
> +					     : git_commit_encoding, 0);
>  		return 1;
>  	}
>  
> -- 
> 1.7.0.2.201.g80978
