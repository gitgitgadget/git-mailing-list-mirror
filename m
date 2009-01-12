From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 7/7] mktag: call "check_sha1_signature" with the
 replacement sha1
Date: Mon, 12 Jan 2009 18:51:26 +0100
Message-ID: <20090112185126.a3984b7d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQxL-0002SF-SG
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZALRuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZALRuq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:50:46 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:44009 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbZALRup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:50:45 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id AEE474C8981;
	Mon, 12 Jan 2009 18:50:37 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id AE23F4C8B71;
	Mon, 12 Jan 2009 18:50:34 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105369>

Otherwise we get a "sha1 mismatch" error for replaced objects.

While at it, this patch makes the first argument of "verify_object"
const.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 mktag.c            |    7 ++++---
 t/t6050-replace.sh |   11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

	Note that I am not sure at all that this is a good change.
	It may be that we should just refuse to tag a replaced object. But
	in this case we should probably give a meaningfull error message
	instead of "sha1 mismatch".

	Otherwise I checked the 2 other calls to "check_sha1_signature" and
	they look like they don't need any change.

diff --git a/mktag.c b/mktag.c
index ba3d495..ac812e5 100644
--- a/mktag.c
+++ b/mktag.c
@@ -18,16 +18,17 @@
 /*
  * We refuse to tag something we can't verify. Just because.
  */
-static int verify_object(unsigned char *sha1, const char *expected_type)
+static int verify_object(const unsigned char *sha1, const char *expected_type)
 {
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
+	const unsigned char *repl;
+	void *buffer = read_sha1_file_repl(sha1, &type, &size, &repl);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
-			ret = check_sha1_signature(sha1, buffer, size, expected_type);
+			ret = check_sha1_signature(repl, buffer, size, expected_type);
 		free(buffer);
 	}
 	return ret;
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 0a585ec..697e0f6 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -70,6 +70,17 @@ test_expect_success 'replace the author' '
      git show $HASH2 | grep "O Thor"
 '
 
+cat >tag.sig <<EOF
+object $HASH2
+type commit
+tag mytag
+tagger T A Gger <> 0 +0000
+
+EOF
+
+test_expect_success 'tag replaced commit' \
+    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
 #
 #
 test_done
-- 
1.6.1.83.g16e5
