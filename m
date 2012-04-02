From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH v3 4/4] remote-curl: main test case for the OS command line
 overflow
Date: Mon, 02 Apr 2012 17:17:03 +0200
Message-ID: <4F79C2EF.2050401@gmx.net>
References: <4F79C195.6090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEizq-00077i-SP
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2DBPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:16:35 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:51028 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751333Ab2DBPQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:16:34 -0400
Received: (qmail invoked by alias); 02 Apr 2012 15:16:33 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.38]
  by mail.gmx.net (mp002) with SMTP; 02 Apr 2012 17:16:33 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX185A5ltpGE54zHhLXAB3165McX4Z/FDohyVTwPMBY
	+U1xuy/ZsjTHkQ
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F79C195.6090905@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194520>

This is main test case for the original problem that triggered this
patch series. We create a repo with 50k tags and then test whether
git-clone over the smart HTTP protocol succeeds.

Note that we construct the repo in a slightly different way than the
original script used to reproduce the problem. This is because the
original script just created 50k tags all pointing to the same commit,
so if there was a bug where remote-curl.c was not passing all the refs
to fetch-pack we wouldn't know. The clone would succeed even if only one
tag was passed, because all the other tags were pointing at the same SHA
and would be considered present.

Instead we create a repo with 50k independent (dangling) commits and
then tag each of those commits with a unique tag. This way if one of the
tags is not given to fetch-pack, later stages of the clone would
complain about it.

This allows us to test both that the command line overflow was fixed, as
well as that it was fixed in a way that doesn't leave out any of the
refs.

Signed-off-by: Ivan Todoroski <grnch@gmx.net>
---
 t/t5551-http-fetch.sh |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 26d355725f..be6094be77 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -109,5 +109,36 @@ test_expect_success 'follow redirects (302)' '
 	git clone $HTTPD_URL/smart-redir-temp/repo.git --quiet repo-t
 '
 
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
+
+test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	for i in `seq 50000`
+	do
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
+	tag=$(perl -e "print \"bla\" x 30") &&
+	sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>packed-refs
+	)
+'
+
+test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command line overflow' '
+	git clone $HTTPD_URL/smart/repo.git too-many-refs 2>err &&
+	test_line_count = 0 err
+'
+
 stop_httpd
 test_done
-- 
1.7.9.5.4.g4f508
