From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 16:45:11 +0200
Message-ID: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBQe-0004Yh-Pq
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYHUOpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYHUOpT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:45:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21912 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYHUOpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:45:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KWBPU-0003ZX-Bd; Thu, 21 Aug 2008 16:45:14 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0D7B86B7; Thu, 21 Aug 2008 16:45:12 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id B4768FA48; Thu, 21 Aug 2008 16:45:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.137.g19b5f8c
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93159>

The tag rewriting code used a 'sed' expression to substitute the new tag
name into the corresponding field of the annotated tag object. But this is
problematic if the tag name contains special characters. In particular,
if the tag name contained a slash, then the 'sed' expression had a syntax
error. We now protect against this by using 'printf' to assemble the
tag header.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh     |   12 +++++++-----
 t/t7003-filter-branch.sh |    8 ++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 2688254..81392ad 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -412,15 +412,17 @@ if [ "$filter_tag_name" ]; then
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
 		if [ "$type" = "tag" ]; then
-			new_sha1=$(git cat-file tag "$ref" |
+			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
+						"$new_sha1" "$new_ref"
+				git cat-file tag "$ref" |
 				sed -n \
 				    -e "1,/^$/{
-					  s/^object .*/object $new_sha1/
-					  s/^type .*/type commit/
-					  s/^tag .*/tag $new_ref/
+					  /^object /d
+					  /^type /d
+					  /^tag /d
 					}" \
 				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
-				    -e 'p' |
+				    -e 'p' ) |
 				git mktag) ||
 				die "Could not create new tag object for $ref"
 			if git cat-file tag "$ref" | \
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 233254f..95f13a8 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -254,4 +254,12 @@ test_expect_success 'Tag name filtering strips gpg signature' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Tag name filtering allows slashes in tag names' '
+	git tag -m tag-with-slash X/1 &&
+	git cat-file tag X/1 | sed -e s,X/1,X/2, > expect &&
+	git filter-branch -f --tag-name-filter "echo X/2" &&
+	git cat-file tag X/2 > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.0.137.g19b5f8c
