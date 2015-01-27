From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Add failing test for fetching from multiple packs over dumb httpd
Date: Tue, 27 Jan 2015 15:20:41 +0000
Message-ID: <1422372041-16474-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:28:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG841-0007FZ-2u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 16:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066AbbA0P2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 10:28:21 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42162 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbbA0P2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 10:28:20 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jan 2015 10:28:20 EST
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id l3Li1p0022iA9hg013LjVe; Tue, 27 Jan 2015 15:20:43 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K8ysHkmI c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=BHUvooL90DcA:10 a=Ew9TdX-QAAAA:8 a=YNv0rlydsVwA:10
 a=BNFp--SqAAAA:8 a=qIh2a4dgYqQJT2lYG_QA:9
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1YG7wX-0004Iw-Vz; Tue, 27 Jan 2015 15:20:41 +0000
X-Mailer: git-send-email 2.0.2.611.g8c85416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263068>

From: Charles Bailey <cbailey32@bloomberg.net>

When objects are spread across multiple packs, if an initial fetch does
require all pack files, a subsequent fetch for objects in packs not
retrieved in the initial fetch will fail.
---

I'm not very familiar with the http client code so this analysis is based
purely on observed behaviour.

When fetching only some refs from a repository served over dumb httpd Git
appears to download all of the index files for the available packs but then
only chooses the pack files that help it resolve the objects which we need.

If we then later try to fetch an object which is in a pack file for
which Git has previously downloaded an index file, it seems to trip because it
believes it already has the object locally due to the presence of the index
file but doesn't actually have it because it never retrieved the corresponding
pack file. It reports an error of the form "Cannot obtain needed object ...".

Manually deleting index files which have no corresponding local pack
file will allow a repeat of the failed fetch to succeed.

 t/t5550-http-fetch-dumb.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ac71418..cf2362a 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -165,6 +165,24 @@ test_expect_success 'fetch notices corrupt idx' '
 	)
 '
 
+test_expect_failure 'fetch packed branches' '
+	git checkout --orphan branch1 &&
+	echo base >file &&
+	git add file &&
+	git commit -m base &&
+	git --bare init "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git branch1 &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git repack -d &&
+	git checkout -b branch2 branch1 &&
+	echo b2 >>file &&
+	git commit -a -m b2 &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git branch2 &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH"/repo_packed_branches.git repack -d &&
+	git --bare init clone_packed_branches.git &&
+	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch1:branch1 &&
+	git --git-dir=clone_packed_branches.git fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2
+'
+
 test_expect_success 'did not use upload-pack service' '
 	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
 	: >exp
-- 
2.0.2.611.g8c85416
