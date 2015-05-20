From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] t5551: factor out tag creation
Date: Wed, 20 May 2015 03:36:43 -0400
Message-ID: <20150520073643.GB9818@peff.net>
References: <20150520073526.GA16784@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, gitster@pobox.com,
	git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed May 20 09:37:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuyYt-0001Q6-VT
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbETHgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:36:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:33041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751774AbbETHgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:36:46 -0400
Received: (qmail 19067 invoked by uid 102); 20 May 2015 07:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 02:36:46 -0500
Received: (qmail 21469 invoked by uid 107); 20 May 2015 07:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 03:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 03:36:43 -0400
Content-Disposition: inline
In-Reply-To: <20150520073526.GA16784@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269444>

One of our tests in t5551 creates a large number of tags,
and jumps through some hoops to do it efficiently. Let's
factor that out into a function so we can make other similar
tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 66439e5..c83cdf4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -224,27 +224,35 @@ test_expect_success 'transfer.hiderefs works over smart-http' '
 	git -C hidden.git rev-parse --verify b
 '
 
-test_expect_success 'create 2,000 tags in the repo' '
-	(
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	for i in $(test_seq 2000)
+# create an arbitrary number of tags, numbered from tag-$1 to tag-$2
+create_tags () {
+	rm -f marks &&
+	for i in $(test_seq "$1" "$2")
 	do
-		echo "commit refs/heads/too-many-refs"
-		echo "mark :$i"
-		echo "committer git <git@example.com> $i +0000"
-		echo "data 0"
-		echo "M 644 inline bla.txt"
-		echo "data 4"
-		echo "bla"
+		# don't use here-doc, because it requires a process
+		# per loop iteration
+		echo "commit refs/heads/too-many-refs-$1" &&
+		echo "mark :$i" &&
+		echo "committer git <git@example.com> $i +0000" &&
+		echo "data 0" &&
+		echo "M 644 inline bla.txt" &&
+		echo "data 4" &&
+		echo "bla" &&
 		# make every commit dangling by always
 		# rewinding the branch after each commit
-		echo "reset refs/heads/too-many-refs"
-		echo "from :1"
+		echo "reset refs/heads/too-many-refs-$1" &&
+		echo "from :$1"
 	done | git fast-import --export-marks=marks &&
 
 	# now assign tags to all the dangling commits we created above
 	tag=$(perl -e "print \"bla\" x 30") &&
 	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
+}
+
+test_expect_success 'create 2,000 tags in the repo' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		create_tags 1 2000
 	)
 '
 
-- 
2.4.1.396.g7ba6d7b
