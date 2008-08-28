From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question: how to ignore extral CR when diff dos format files
 with 'color=auto'
Date: Wed, 27 Aug 2008 19:32:14 -0700
Message-ID: <7vbpzdkgy9.fsf@gitster.siamese.dyndns.org>
References: <1219728743111-783231.post@n2.nabble.com>
 <1219887555724-788498.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: goooguo <erwangg@fortemedia.com.cn>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXKA-00071w-4L
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbYH1CcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYH1CcW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:32:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYH1CcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:32:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3650F530CD;
	Wed, 27 Aug 2008 22:32:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B2B4530CC; Wed, 27 Aug 2008 22:32:16 -0400 (EDT)
In-Reply-To: <1219887555724-788498.post@n2.nabble.com>
 (erwangg@fortemedia.com.cn's message of "Wed, 27 Aug 2008 18:39:15 -0700
 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89422314-74A9-11DD-A617-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94020>

> From dae20e25960c73bd7ccc0939fe096bb68a009fb5 Mon Sep 17 00:00:00 2001
> From: erwangg <erwangg@fortemedia.com.cn>
> Date: Wed, 27 Aug 2008 12:22:43 +0800
> Subject: [PATCH] ingore cr at eol when diff with color=auto
>
> ---

Thanks.  A few comments.

> diff --git a/diff.c b/diff.c
> index 18fa7a7..846a9af 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -517,9 +517,16 @@ static void emit_line(FILE *file, const char *set,
> const char *reset, const char
>  	if (has_trailing_newline)
>  		len--;
>  
> +	int has_trailing_return = (len > 0 && line[len-1] == '\r');

decl-after-statement.

> +	if (has_trailing_return)
> +        len--;
> +
>  	fputs(set, file);
>  	fwrite(line, len, 1, file);
>  	fputs(reset, file);
> +
> +    if (has_trailing_return)
> +        fputc('\r', file);
>  	if (has_trailing_newline)
>  		fputc('\n', file);
>  }

We indent with tab which jumps the cursor to next column that is multiple
of 8.

Otherwise this hunk is good.

> @@ -535,7 +542,7 @@ static void emit_add_line(const char *reset, struct
> emit_callback *ecbdata, cons
>  		/* Emit just the prefix, then the rest. */
>  		emit_line(ecbdata->file, set, reset, line, ecbdata->nparents);
>  		ws_check_emit(line + ecbdata->nparents,
> -			      len - ecbdata->nparents, ecbdata->ws_rule,
> +			      len - ecbdata->nparents, ecbdata->ws_rule|WS_CR_AT_EOL,
>  			      ecbdata->file, set, reset, ws);
>  	}
>  }

I do not think you want to force WS_CR_AT_EOL here.

That is a policy issue (not "git policy", but the policy of the contents
that is managed by git, in other words, your repository) that you should
control with core.whitespace (and if you want finer grain control, then
with .gitattributes).

Your patch is whitespace damanged, and has style issues, and lacks any
comment to defend the change.  It does not have a Sign-off, either.  Even
though the intent is good, I cannot apply this as-is.  Please look at
Documentation/SubmittingPatches and emulate patches from other git
regulars.

You say "when color=auto" in the patch title, but there is nothing that
restricts the effect of this change only to that case in your patch.  A
comment to defend the change should address things like that, and here is
how I would write it.

    When the tracked contents have CRLF line endings, colored diff output
    shows "^M" at the end of output lines, which is distracting, even
    though the pager we use by default ("less") knows to hide them.

    The problem is that "less" hides a carriage-return only at the end of
    the line, immediately before a line feed.  The colored diff output
    does not take this into account, and emits four element sequence for
    each line:

       - force this color;
       - the line up to but not including the terminating line feed;
       - reset color
       - line feed.

    By including the carriage return at the end of the line in the second
    item, we are breaking the smart our pager has in order not to show
    "^M".  This can be fixed by changing the sequence to:

       - force this color;
       - the line up to but not including the terminating end-of-line;
       - reset color
       - end-of-line.

    where end-of-line is either a single linefeed or a CRLF pair.
    When the output is not colored, "force this color" and "reset color"
    sequences are both empty, so we won't have this problem with or
    without this patch.    

If we drop the hunk to emit_add_line() that forces WS_CR_AT_EOL, I find
that the intent and the approach of the patch is quite good.  I suspect
that combined-diff output routines have the same issue that you need to
fix the same way, but I didn't look.
