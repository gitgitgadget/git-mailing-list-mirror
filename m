From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 23:54:09 -0400
Message-ID: <20150619035408.GA23679@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
 <20150618204505.GD14550@peff.net>
 <20150618212356.GA20271@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jun 19 05:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5nNi-0007b3-7c
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 05:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbbFSDyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 23:54:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:48584 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751484AbbFSDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 23:54:12 -0400
Received: (qmail 19206 invoked by uid 102); 19 Jun 2015 03:54:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 22:54:12 -0500
Received: (qmail 11612 invoked by uid 107); 19 Jun 2015 03:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 23:54:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 23:54:09 -0400
Content-Disposition: inline
In-Reply-To: <20150618212356.GA20271@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272097>

On Thu, Jun 18, 2015 at 05:23:56PM -0400, Jeff King wrote:

> +# Return the individual diff-able items of the hunk, but with any
> +# diff or color prefix/suffix for each line split out (we assume that the
> +# prefix/suffix for each line will be the same).
> +sub split_hunk {
> +	my ($prefix, $suffix, @r);
> +	foreach my $line (@_) {
> +		$line =~ /^($COLOR*[+-]$COLOR*)(.*)($COLOR*)/
> +			or die "eh, this is supposed to match everything!";

This isn't quite right. We'll never match the suffix, because it gets
sucked up by the greedy (.*). But making that non-greedy matches
nothing, unless we also add "$" at the end.

_But_, there is still something else weird going on. I replaced this
split:

> +		push @r, split(//, $2), "\n";

with:

  push @r, split(/([[:space:][:punct:]])/, $2), "\n";

which behaves much better. With that, 99a2cfb shows:

  -       <if> (!peel_ref(path, peeled)) {
  -               <is>_annotated = !!<hashcmp>(<sha1>, peeled);
  +       <if> (!peel_ref(path, peeled<.hash>)) {
  +               <is>_annotated = !!<oidcmp>(<oid>, <&>peeled);

The latter half of both lines looks perfect. But what's that weird
highlighting of the initial "if" and "is" on those lines?

It turns out that the colored output we produce is quite odd:

  $ git show --color 99a2cfb | grep peel_ref | cat -A
  ^[[31m-^Iif (!peel_ref(path, peeled)) {^[[m$
  ^[[32m+^[[m^I^[[32mif (!peel_ref(path, peeled.hash)) {^[[m$

For the pre-image, we print the color, the "-", and then the line data.
Makes sense.

For the post-image, we print the color, "+", a reset, then the initial
whitespace, then the color again!

So of course the diff algorithm says "hey, there's this weird color in
here". The original implementation of diff-highlight didn't care,
because it skipped leading whitespace and colors as "boring". But this
one cannot do that. It pulls the strict prefix out of each line (and it
must, because it must get the same prefix for each line of a hunk).

I think git is actually wrong here; it's mingling the ANSI colors and
the actual content. Nobody ever noticed because it looks OK to a human,
and who would be foolish enough to try machine-parsing colorized diff
output?

The fix is:

diff --git a/diff.c b/diff.c
index 87b16d5..a80b5b4 100644
--- a/diff.c
+++ b/diff.c
@@ -501,9 +501,9 @@ static void emit_line_checked(const char *reset,
 		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+		emit_line_0(ecbdata->opt, set, "", sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+			      ecbdata->opt->file, "", reset, ws);
 	}
 }
 

But I'm a little worried it may interfere with the way the
whitespace-checker emits colors (e.g., it may emit its own colors for
the leading spaces, and we would need to re-assert our color before
showing the rest of the line). So I think you could also argue that
because of whitespace-highlighting, colorized diffs are fundamentally
going to have colors intermingled with the content and should not be
parsed this way.

All the more reason to try to move this inside diff.c, I guess.

-Peff
