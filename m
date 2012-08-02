From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 2 Aug 2012 17:33:46 -0400
Message-ID: <20120802213346.GA575@sigill.intra.peff.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Butcher <dev.lists@jessamine.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx324-0001vF-Q7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab2HBVdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 17:33:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49115 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab2HBVdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 17:33:54 -0400
Received: (qmail 18462 invoked by uid 107); 2 Aug 2012 21:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Aug 2012 17:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2012 17:33:46 -0400
Content-Disposition: inline
In-Reply-To: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202796>

On Thu, Aug 02, 2012 at 10:11:02PM +0100, Adam Butcher wrote:

> From 01730a741cc5fd7d0a5d8bd0d3df80d12c81fe48 Mon Sep 17 00:00:00 2001
> From: Adam Butcher <dev.lists@jessamine.co.uk>
> Date: Wed, 1 Aug 2012 22:25:09 +0100
> Subject: [PATCH] Fix 'No newline...' annotation in rewrite diffs.

You can drop these lines from the email body; they are redundant with
what's in your actual header.

> When operating in --break-rewrites (-B) mode on a file with no newline
> terminator (and assuming --break-rewrites determines that the diff
> _is_ a rewrite), git diff previously concatenated the indicator comment
> '\ No newline at end of file' directly to the terminating line rather
> than on a line of its own.  The resulting diff is broken; claiming
> that the last line actually contains the indicator text.  Without -B
> there is no problem with the same files.
> 
> This patch fixes the former case by inserting a newline into the
> output prior to emitting the indicator comment.

Makes sense.

> Potential issue: Currently this emits an ASCII 10 newline character
> only.  I'm not sure whether this will be okay on all platforms; it
> seems to work fine on Windows and GNU at least.

This should not be a problem. Git always outputs newlines; it is stdio
who might munge it into CRLF if need be (and your patch uses putc, so we
should be fine).

> A couple of tests have been added to the rewrite suite to confirm that
> the indicator comment is generated on its own line in both plain diff
> and rewrite mode.  The latter test fails if the functional part of
> this patch (i.e. diff.c) is reverted.

Yay, tests.

> ---
>  diff.c                  |  1 +
>  t/t4022-diff-rewrite.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 95706a5..77d4e84 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -574,6 +574,7 @@ static void emit_rewrite_lines(struct
> emit_callback *ecb,

Your patch is line-wrapped and cannot be applied as-is (try turning off
"flowed text" in your MUA).

>  	if (!endp) {
>  		const char *plain = diff_get_color(ecb->color_diff,
>  						   DIFF_PLAIN);
> +		putc('\n', ecb->opt->file);
>  		emit_line_0(ecb->opt, plain, reset, '\\',
>  			    nneof, strlen(nneof));
>  	}

Looks correct. I was curious how the regular (non-rewrite) code path did
this, and it just sticks the "\n" as part of the nneof string. However,
we would not want that here, because each line should have its own
color markers.

> +# create a file containing numbers with no newline at
> +# the end and modify it such that the starting 10 lines
> +# are unchanged, the next 101 are rewritten and the last
> +# line differs only in that in is terminated by a newline.
> +seq 1 10 > seq
> +seq 100 +1 200 >> seq
> +printf 201 >> seq
> +(git add seq; git commit seq -m seq) >/dev/null
> +seq 1 10 > seq
> +seq 300 -1 200 >> seq

Seq is (unfortunately) not portable. I usually use a perl snippet
instead, like:

  perl -le 'print for (1..10)'

Though I think we are adjusting that to use $PERL_PATH these days.

-Peff
