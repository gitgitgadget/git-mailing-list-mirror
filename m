From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sat, 8 Feb 2014 11:45:49 -0500
Message-ID: <20140208164548.GA24600@sigill.intra.peff.net>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 17:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCB2T-00047S-A3
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 17:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaBHQpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 11:45:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:47052 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751453AbaBHQpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 11:45:51 -0500
Received: (qmail 31149 invoked by uid 102); 8 Feb 2014 16:45:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (65.115.226.27)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Feb 2014 10:45:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Feb 2014 11:45:49 -0500
Content-Disposition: inline
In-Reply-To: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241839>

On Sat, Feb 08, 2014 at 03:10:02PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Trailing spaces are invisible in most standard editors (*). "git diff=
"
> does show trailing spaces by default. But that does not help newly
> written .gitignore files. And trailing spaces are the source of
> frustration when writing .gitignore.

I guess leading spaces are not as frustrating, but I wonder if it would
be more consistent to say that we soak up all whitespace. That is also =
a
regression, but I agree that these are exceptional cases, and as long a=
s
we provide an "out" for people to cover them via quoting, ignoring the
whitespace seems like a sane default.

> People can still quote trailing spaces, which will not be ignored (an=
d
> much more visible). Quoting comes with a cost of doing fnmatch(). But
> I won't optimize it until I see someone shows me they have a use case
> for it.

I naively expected that:

  echo 'trailing\ \ ' >.gitignore

would count as quoting, but your patch doesn't handle that. It _does_
seem to work currently (that is, the backslashes go away and we treat i=
t
literally), but I am not sure if that is planned, or simply happens to
work.

I guess by quoting you meant:

  echo '"trailing  "' >.gitignore

Anyway, here are some tests I wrote up while playing with this. They do
not pass with your current patch for the reasons above, but maybe they
will be useful to squash in (either after tweaking the tests, or
tweaking the patch).

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index b4d98e6..4dde314 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -775,4 +775,33 @@ test_expect_success PIPE 'streaming support for --=
stdin' '
 	echo "$response" | grep "^::	two"
 '
=20
+######################################################################=
######
+#
+# test whitespace handling
+
+test_expect_success 'leading/trailing whitespace is ignored' '
+	mkdir whitespace &&
+	>whitespace/leading &&
+	>whitespace/trailing &&
+	>whitespace/untracked &&
+	{
+		echo "    whitespace/leading" &&
+		echo "whitespace/trailing   "
+	} >ignore &&
+	echo whitespace/untracked >expect &&
+	git ls-files -o -X ignore whitespace >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'quoting allows trailing whitespace' '
+	rm -rf whitespace &&
+	mkdir whitespace &&
+	>"whitespace/trailing  " &&
+	>whitespace/untracked &&
+	echo "whitespace/trailing\\ \\ " >ignore &&
+	echo whitespace/untracked >expect &&
+	git ls-files -o -X ignore whitespace >actual &&
+	test_cmp expect actual
+'
+
 test_done
