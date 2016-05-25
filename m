From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Wed, 25 May 2016 17:39:04 -0500
Message-ID: <20160525223904.GD13776@sigill.intra.peff.net>
References: <20160525015649.GA13258@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hSO-0000Ky-QU
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcEYWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:39:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:44283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbcEYWjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2016 18:39:08 -0400
Received: (qmail 22621 invoked by uid 102); 25 May 2016 22:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:39:07 -0400
Received: (qmail 14697 invoked by uid 107); 25 May 2016 22:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 17:39:04 -0500
Content-Disposition: inline
In-Reply-To: <20160525015649.GA13258@zoidberg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295601>

On Tue, May 24, 2016 at 08:56:49PM -0500, Edward Thomson wrote:

> Check that we are configured to display colors in the given context when
> the user specifies a format string of `%C(auto)`.  This brings that
> behavior in line with the behavior of `%C(auto,<colorname>)`, which will
> display the given color only when the configuration specifies to do so.
> 
> This allows the user the ability to specify that color should be
> displayed only when the output is a tty, and to use the default color
> for the given context (instead of a hardcoded color value).
> 
> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>

I somehow had trouble figuring out the problem from this description and
the patch. It seems to be about much more than just color=auto or a
given context, and more like:

  When %C(auto) is used, we unconditionally turn on color for any
  subsequent placeholders, even if the user said "--no-color", or color
  config is turned off, or it is set to "auto" and we are not going to a
  tty.

It's possible somebody is relying on the ability to unconditionally turn
on color for "auto-colored" placeholders like "%H" or "%d", but I'm
inclined to call this a strict bug-fix, for two reasons:

  1. It says "%C(auto)", not "%C(on)".

  2. This is documented as behaving like "%C(auto,...)", which as you
     note works in a more sane way.

I think it's worth mentioning this explicitly in the commit message. We
could also add "%C(on)", I guess, but it's unclear to me whether anybody
would want it (they would probably just use "--color" in that case,
unless they really want unconditional coloring for just _some_
elements).

I'm adding Duy to the cc as the original author of %C(auto), in case
there is something subtle I'm missing.

> ---
>  pretty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like we didn't have any tests at all for %C(auto). And the tests
for %C(auto,...) were labeled as %C(auto), making it all the more
confusing. Perhaps it is worth squashing this in:

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b77d4c9..a1dcdb8 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -184,38 +184,38 @@ commit $head1
 [1;31;43mfoo[m
 EOF
 
-test_expect_success '%C(auto) does not enable color by default' '
+test_expect_success '%C(auto,...) does not enable color by default' '
 	git log --format=$AUTO_COLOR -1 >actual &&
 	has_no_color actual
 '
 
-test_expect_success '%C(auto) enables colors for color.diff' '
+test_expect_success '%C(auto,...) enables colors for color.diff' '
 	git -c color.diff=always log --format=$AUTO_COLOR -1 >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) enables colors for color.ui' '
+test_expect_success '%C(auto,...) enables colors for color.ui' '
 	git -c color.ui=always log --format=$AUTO_COLOR -1 >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --color' '
+test_expect_success '%C(auto,...) respects --color' '
 	git log --format=$AUTO_COLOR -1 --color >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --no-color' '
+test_expect_success '%C(auto,...) respects --no-color' '
 	git -c color.ui=always log --format=$AUTO_COLOR -1 --no-color >actual &&
 	has_no_color actual
 '
 
-test_expect_success TTY '%C(auto) respects --color=auto (stdout is tty)' '
+test_expect_success TTY '%C(auto,...) respects --color=auto (stdout is tty)' '
 	test_terminal env TERM=vt100 \
 		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
+test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
 	(
 		TERM=vt100 && export TERM &&
 		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
@@ -223,6 +223,18 @@ test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
 	)
 '
 
+test_expect_success '%C(auto) respects --color' '
+	git log --color --format="%C(auto)%H" -1 >actual &&
+	printf "\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%C(auto) respects --no-color' '
+	git log --no-color --format="%C(auto)%H" -1 >actual &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
+
 iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
 Test printing of complex bodies
 
