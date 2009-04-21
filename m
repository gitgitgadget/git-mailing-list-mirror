From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] more automation for cover letter generation
Date: Mon, 20 Apr 2009 23:32:13 -0400
Message-ID: <20090421033213.GA14881@coredump.intra.peff.net>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6k6-0000L3-CG
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZDUDcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZDUDcT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:32:19 -0400
Received: from peff.net ([208.65.91.99]:43648 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZDUDcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:32:18 -0400
Received: (qmail 6378 invoked by uid 107); 21 Apr 2009 03:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 23:32:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 23:32:13 -0400
Content-Disposition: inline
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117086>

On Sat, Apr 18, 2009 at 06:16:15PM +0200, Frank Terbeck wrote:

> I like cover letters, in fact I like them enough to always want
> --cover-letter to format-patch. The problem with that are patch "series"
> that are only one patch long, where a cover letter would feel silly.
> 
> For now, I solved that by using a shell function that wrapped around
> format-patch and did the trick for me.
> 
> With this series, format-patch can do it and do it better than my
> wrapper could.

That seems like a reasonable goal.

> The following setup would suit me pretty well:
> 
> [format]
>     coverletter = true
>     coveronepatch = false
>     overwritecoverletter = false

Something about "coveronepatch" seems a bit hack-ish to me. Perhaps it
should be "generate cover letter if there are more than N patches". You
could even just overload "format.coverletter" as:

  true - always generate cover letter
  false - never generate cover letter
  <number> - generate if there are at least <number> patches

?

> The series is based on master and doesn't seem to break anything
> within the test suite. It could maybe use own tests, but I must admit
> that I didn't look too closely at how git's test suite works and where
> to put in tests for this.

The tests below were not actually run (and you can see they are based on
what I proposed above, not your existing patches), but they should give
hopefully give you a headstart.

---
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 11061dd..9e13ee9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -151,6 +151,27 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
+test_expect_success 'format.coverletter=true generates cover letter' '
+	rm -rf patches &&
+	git config core.coverletter true
+	git format-patch -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverletter=number generates cover letter' '
+	rm -rf patches &&
+	git config core.coverletter 3 &&
+	git format-patch -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverletter respects minimum patchset size' '
+	rm -rf patches &&
+	git config core.coverletter 4 &&
+	git format-patch -o patches/ master &&
+	! test -f patches/0000-cover-letter.patch
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
