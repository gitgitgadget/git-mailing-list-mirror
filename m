From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH/RFC v2 4/4] remote-curl: main test case for the OS command
 line overflow
Date: Tue, 27 Mar 2012 08:28:06 +0200
Message-ID: <4F715DF6.7080401@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPsc-0002aZ-IN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab2C0G1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:27:38 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:39126 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756788Ab2C0G1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:27:37 -0400
Received: (qmail invoked by alias); 27 Mar 2012 06:27:36 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp040) with SMTP; 27 Mar 2012 08:27:36 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX1+O/ckulyGO5fHa0FELDD1js7yGtrLz/xLXeTYBn4
	BAs13Qmjj21Stk
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F715CF7.5070903@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194023>

This is main test case for the original problem that triggered this
patch series. We create a repo with 50k tags and then test whether
git-clone over the smart HTTP protocol succeeds.

Note that we construct the repo in a slightly different way than the
original script used to reproduce the problem. This is because the
original script just created 50k tags all pointing to the same commit,
so if there was a bug where remote-curl.c was not passing all the refs
to fetch-pack we wouldn't know. The clone would succed even if only one
tag was passed, because all the other tags were pointing at the same SHA
and would be considered present.

Instead we create a repo with 50k independent (dangling) commits and
then tag each of those commits with a unique tag. This way if one of the
tags is not given to fetch-pack, later stages of the clone would
complain about it.

This allows us to test both that the command line overflow was fixed, as
well as that it was fixed in a way that doesn't leave out any of the
refs.
---
 t/t5551-http-fetch.sh |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 26d355725f..fb970bda22 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -109,5 +109,37 @@ test_expect_success 'follow redirects (302)' '
 	git clone $HTTPD_URL/smart-redir-temp/repo.git --quiet repo-t
 '
 
+
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
+
+test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	N=50000 &&
+	for ((i=1; i<=$N; i++)); do
+		echo "commit refs/heads/too-many-refs"
+		echo "mark :$i"
+		echo "committer git <git@example.com> $i +0000"
+		echo "data 0"
+		echo "M 644 inline bla.txt"
+		echo "data 4"
+		echo "bla"
+		# make every commit dangling by always
+		# rewinding the branch after each commit
+		echo "reset refs/heads/too-many-refs"
+		echo "from :1"
+	done | git fast-import --export-marks=marks &&
+
+	# now assign tags to all the dangling commits we created above
+	export tag=refs/tags/artificially-long-tag-name-to-more-easily-demonstrate-the-problem &&
+	perl -nle '\''/:(.+) (.+)/; print "$2 $ENV{tag}-$1"'\'' < marks >> packed-refs
+	)
+'
+
+test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command line overflow' '
+	git clone $HTTPD_URL/smart/repo.git too-many-refs 2> too-many-refs.err &&
+	test_line_count = 0 too-many-refs.err
+'
+
 stop_httpd
 test_done
-- 
1.7.9.5.4.g4f508
