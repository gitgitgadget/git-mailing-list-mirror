From: Jeff King <peff@peff.net>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Tue, 19 Mar 2013 14:10:42 -0400
Message-ID: <20130319181042.GA14295@sigill.intra.peff.net>
References: <20130319175756.GA13760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 19 19:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI10F-0000uC-EY
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 19:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419Ab3CSSKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 14:10:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58685 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933397Ab3CSSKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 14:10:47 -0400
Received: (qmail 467 invoked by uid 107); 19 Mar 2013 18:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 14:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 14:10:42 -0400
Content-Disposition: inline
In-Reply-To: <20130319175756.GA13760@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218546>

On Tue, Mar 19, 2013 at 01:57:56PM -0400, Jeff King wrote:

> Prior to v1.8.1.1, if I did this:
> 
>   git init
>   echo content >foo &&
>   mkdir subdir &&
>   echo content >subdir/bar &&
>   echo "subdir export-ignore" >.gitattributes
>   git add . &&
>   git commit -m one &&
>   git archive HEAD | tar tf -
> 
> my archive would contain only "foo" and ".gitattributes", not subdir. As
> of v1.8.1.1, the attribute on subdir is ignored unless it is written
> with a trailing slash, like:
> 
>   subdir/ export-ignore
> 
> The issue bisects to 94bc671 (Add directory pattern matching to
> attributes, 2012-12-08). That commit actually tests not only that
> "subdir/" matches, but also that just "subdir" does not match.

Sorry, I mis-read the tests. They are not testing that "subdir" does not
work, only that "subdir/" will match only a directory, not a regular
file. Which does make sense.

So I think the regression is accidental. And we would want tests like
this on top (which currently fail):

diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 0c847fb..3be809c 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -27,6 +27,10 @@ test_expect_success 'setup' '
 	echo ignored-only-if-dir/ export-ignore >>.git/info/attributes &&
 	git add ignored-only-if-dir &&
 
+	mkdir -p ignored-without-slash &&
+	echo ignored without slash >ignored-without-slash/foo &&
+	git add ignored-without-slash/foo &&
+	echo ignored-without-slash export-ignore >>.git/info/attributes &&
 
 	mkdir -p one-level-lower/two-levels-lower/ignored-only-if-dir &&
 	echo ignored by ignored dir >one-level-lower/two-levels-lower/ignored-only-if-dir/ignored-by-ignored-dir &&
@@ -49,6 +53,8 @@ test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
 test_expect_exists	archive/not-ignored-dir/
 test_expect_missing	archive/ignored-only-if-dir/
 test_expect_missing	archive/ignored-ony-if-dir/ignored-by-ignored-dir
+test_expect_missing     archive/ignored-without-slash/ &&
+test_expect_missing     archive/ignored-without-slash/foo &&
 test_expect_exists	archive/one-level-lower/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-only-if-dir/
 test_expect_missing	archive/one-level-lower/two-levels-lower/ignored-ony-if-dir/ignored-by-ignored-dir
