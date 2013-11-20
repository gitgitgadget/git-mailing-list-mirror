From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Wed, 20 Nov 2013 15:04:23 -0800
Message-ID: <xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
References: <528D385F.2070906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 21 00:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjGoy-00068b-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 00:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3KTXE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 18:04:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309Ab3KTXE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 18:04:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0824154839;
	Wed, 20 Nov 2013 18:04:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=40lh9uQMZ6nfUM84VC4MkZ+xLQc=; b=S9VGkU
	juRhxyTA1dVKk5GjFQxqOWpo6mBXHQ2pJsXELDysu/QWb2EHmy79LFauFKCdMZjf
	F4+c7eHyAJbWoUxFbQ3ICfKcF57yB3YQ6N2m9AEJQNJf+bpJxRKxpDktPnYJwotl
	jGsRNf3sx0p0xznNN37c+ojxp7pSu4fCzofCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hiTod7YckPt1wKgzUPCL2xZ4ibBK/i5f
	6GoSCkrfSdKi8cPs/9qoyVb0DcfSm0UOqJQT+8857eOc2NIxnWtcIKvUf5xp48ux
	Iu3qvoFBCe2MXisZnUderjgnO2WZLDQcAppL8p2hNFWdb/UyAnoLwZJDFuFfUfCr
	XoaDyXeNnxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E690D54838;
	Wed, 20 Nov 2013 18:04:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E39754837;
	Wed, 20 Nov 2013 18:04:26 -0500 (EST)
In-Reply-To: <528D385F.2070906@web.de> (Jens Lehmann's message of "Wed, 20 Nov
	2013 23:31:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A229546-5238-11E3-BE9C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238105>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Changes since v2:
>
> - Honor the core.commentChar setting and add a test for that.
>
> - Fix the submodule test to set the editor in a portable way.
>
> - Only print scissor and description lines when not going to stdout
>   (otherwise a "git status -v" prints that on stdout too, which
>   doesn't make much sense). Now we definitely do not have to care
>   about coloring these lines either.

Hmph.  It makes me suspect that we were drunk when we decided to let
"git status -v" to keep showing diff when we declared that "git
status" is different from "git commit --dry-run", but it is too late
to fix it now, I think.

> - Nicer formatting of the commit message.

Certainly a lot easier to read, at least to me.

> @@ -1601,11 +1601,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	}
>
>  	/* Truncate the message just before the diff, if any. */

I wonder if this comment still is valid, but it probably is OK.

> -	if (verbose) {
> -		p = strstr(sb.buf, "\ndiff --git ");
> -		if (p != NULL)
> -			strbuf_setlen(&sb, p - sb.buf + 1);
> -	}
> +	if (verbose)
> +		wt_status_truncate_message_at_cut_line(&sb);

> diff --git a/wt-status.c b/wt-status.c
> index b4e44ba..734f94b 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -16,6 +16,9 @@
>  #include "column.h"
>  #include "strbuf.h"
>
> +static char wt_status_cut_line[] = /* 'X' is replaced with comment_line_char */
> +"X ------------------------ >8 ------------------------\n";
> +
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
>  	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
> @@ -767,6 +770,15 @@ conclude:
>  	status_printf_ln(s, GIT_COLOR_NORMAL, "");
>  }
>
> +void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
> +{
> +	const char *p;
> +
> +	p = strstr(buf->buf, wt_status_cut_line);
> +	if (p && (p == buf->buf || p[-1] == '\n'))
> +		strbuf_setlen(buf, p - buf->buf);
> +}

Perhaps it may happen that all the current callers have called
wt_status_print_verbose() to cause wt_status_cut_line[0] to hold
comment_line_char, but relying on that calling sequence somehow
makes me feel uneasy.

Perhaps cut_line[] should only have "--- >8 ---" part and both
printing side (below) and finding side (this one) should check these
separately?  That is:

	p = buf->buf;
	while (p && *p) {
		p = strchr(p, comment_line_char);
                if (!p)
			break;
		if (strstr(p + 1, cut_line) == p + 1)
			break;
		p++;
                continue;
	}
        if (p && *p && (p == buf->buf || p[-1] == '\n'))
		strbuf_setlen(buf, p - buf->buf);

or something (the above is deliberately less-efficient-than-ideal,
because I want to keep the code structure in such a way that we can
later turn comment_line_char to a string[] that can hold "//" to
allow a multi-char comment introducer more easily)?

>  static void wt_status_print_verbose(struct wt_status *s)
>  {
>  	struct rev_info rev;
> @@ -787,10 +799,17 @@ static void wt_status_print_verbose(struct wt_status *s)
>  	 * If we're not going to stdout, then we definitely don't
>  	 * want color, since we are going to the commit message
>  	 * file (and even the "auto" setting won't work, since it
> -	 * will have checked isatty on stdout).
> +	 * will have checked isatty on stdout). But we then do want
> +	 * to insert the scissor line here to reliably remove the
> +	 * diff before committing.
>  	 */
> -	if (s->fp != stdout)
> +	if (s->fp != stdout) {
>  		rev.diffopt.use_color = 0;
> +		wt_status_cut_line[0] = comment_line_char;
> +		fprintf(s->fp, wt_status_cut_line);
> +		fprintf(s->fp, _("%c Do not touch the line above.\n"), comment_line_char);
> +		fprintf(s->fp, _("%c Everything below will be removed.\n"), comment_line_char);
> +	}

I didn't bother with my "how about this" version, but we may want to
use strbuf_add_commented_lines() to help i18n/l10n folks.  Depending
on the l10n, this message may want to become more or less than 2
lines.

>  	run_diff_index(&rev, 1);
>  }
>
> diff --git a/wt-status.h b/wt-status.h
> index 6c29e6f..30a4812 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -91,6 +91,7 @@ struct wt_status_state {
>  	unsigned char cherry_pick_head_sha1[20];
>  };
>
> +void wt_status_truncate_message_at_cut_line(struct strbuf *);
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
