From: Jeff King <peff@peff.net>
Subject: Re: t6392 broken on pu (Mac OS X)
Date: Mon, 9 May 2016 12:07:25 -0400
Message-ID: <20160509160725.GA11861@sigill.intra.peff.net>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 09 18:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azniX-0000Vt-NF
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbcEIQH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 12:07:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36353 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbcEIQH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:07:29 -0400
Received: (qmail 18467 invoked by uid 102); 9 May 2016 16:07:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:07:28 -0400
Received: (qmail 20171 invoked by uid 107); 9 May 2016 16:07:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:07:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 12:07:25 -0400
Content-Disposition: inline
In-Reply-To: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294005>

On Sat, May 07, 2016 at 06:15:19PM +0200, Torsten B=C3=B6gershausen wro=
te:

> These tests fail here under Mac OS,
> they pass under Linux:
> commit ff3d9b660a4b6e9d3eeb664ce1febe717adff737
> I haven't had a chance to dig further.

I assume you mean t6302. It looks like the difference is not Mac OS, bu=
t
rather that the GPG prerequisite is not fulfilled, so we are missing a
few of the tags.

Commit 618310a introduced a helper to munge the "expect" output. Using
that fixes some of the cases, but not test 34. That one is expecting
blank lines for tags, so test_prepare_expect doesn't know which lines
are related to GPG.

We could fix it by tweaking the test like this:

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
index 7420e48..04042e1 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -343,29 +343,27 @@ test_expect_success 'improper usage of %(if), %(t=
hen), %(else) and %(end) atoms'
 '
=20
 test_expect_success 'check %(if)...%(then)...%(end) atoms' '
-	git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname): =
%(refname)%(end)" >actual &&
-	cat >expect <<-\EOF &&
-	A U Thor: refs/heads/master
-	A U Thor: refs/heads/side
-	A U Thor: refs/odd/spot
-
-
-
-	A U Thor: refs/tags/foo1.10
-	A U Thor: refs/tags/foo1.3
-	A U Thor: refs/tags/foo1.6
-	A U Thor: refs/tags/four
-	A U Thor: refs/tags/one
-
-	A U Thor: refs/tags/three
-	A U Thor: refs/tags/two
+	git for-each-ref --format=3D"%(refname):%(if)%(authorname)%(then) aut=
hor=3D%(authorname)%(end)" >actual &&
+	test_prepare_expect >expect <<-\EOF &&
+	refs/heads/master: author=3DA U Thor
+	refs/heads/side: author=3DA U Thor
+	refs/odd/spot: author=3DA U Thor
+	refs/tags/annotated-tag:
+	refs/tags/doubly-annotated-tag:
+	refs/tags/foo1.10: author=3DA U Thor
+	refs/tags/foo1.3: author=3DA U Thor
+	refs/tags/foo1.6: author=3DA U Thor
+	refs/tags/four: author=3DA U Thor
+	refs/tags/one: author=3DA U Thor
+	refs/tags/three: author=3DA U Thor
+	refs/tags/two: author=3DA U Thor
 	EOF
 	test_cmp expect actual
 '
=20
 test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname)%(=
else)No author%(end): %(refname)" >actual &&
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	A U Thor: refs/heads/master
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
@@ -385,7 +383,7 @@ test_expect_success 'check %(if)...%(then)...%(else=
)...%(end) atoms' '
 '
 test_expect_success 'ignore spaces in %(if) atom usage' '
 	git for-each-ref --format=3D"%(refname:short): %(if)%(HEAD)%(then)Hea=
d ref%(else)Not Head ref%(end)" >actual &&
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	master: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref


Though we'd perhaps want to tweak the subsequent tests to use the same
format, just to make things easier to read later.

However, I wonder if we could improve on the strategy in 618310a, and
simply create non-signed versions of the "signed" tags when GPG is not
available. That would make tests looking at the whole ref namespace
more consistent. And any tests which wanted to look specifically at the
signed attributes should be protected with the GPG prereq anyway (it
doesn't look like there are any currently, though).

I.e., something like:

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
index 7420e48..a3df472 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -6,12 +6,8 @@ test_description=3D'test for-each-refs usage of ref-fi=
lter APIs'
 . "$TEST_DIRECTORY"/lib-gpg.sh
=20
 test_prepare_expect () {
-	if test_have_prereq GPG
-	then
-		cat
-	else
-		sed '/signed/d'
-	fi
+	# XXX this could now go away entirely, and just use cat in each test
+	cat
 }
=20
 test_expect_success 'setup some history and refs' '
@@ -24,9 +20,12 @@ test_expect_success 'setup some history and refs' '
 	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
 	if test_have_prereq GPG
 	then
-		git tag -s -m "A signed tag" signed-tag &&
-		git tag -s -m "Signed doubly" doubly-signed-tag signed-tag
+		sign=3D-s
+	else
+		sign=3D
 	fi &&
+	git tag $sign -m "A signed tag" signed-tag &&
+	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '

-Peff
