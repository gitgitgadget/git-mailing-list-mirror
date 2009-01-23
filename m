From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] mktag: call "check_sha1_signature" with the replacement
 sha1
Date: Fri, 23 Jan 2009 10:07:26 +0100
Message-ID: <20090123100726.b2d803f2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI1v-0007ur-Fk
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbZAWJHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbZAWJHL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:07:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55750 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbZAWJHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:07:08 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4F4D18181CC;
	Fri, 23 Jan 2009 10:07:00 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 55CB6818080;
	Fri, 23 Jan 2009 10:06:58 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106864>

Otherwise we get a "sha1 mismatch" error for replaced objects.

Note that I am not sure at all that this is a good change.
It may be that we should just refuse to tag a replaced object. But
in this case we should probably give a meaningfull error message
instead of "sha1 mismatch".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 mktag.c            |    7 ++++---
 t/t6050-replace.sh |   12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

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
index 0a585ec..334aed6 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -70,6 +70,18 @@ test_expect_success 'replace the author' '
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
+test_expect_success 'tag replaced commit' '
+     git mktag <tag.sig >.git/refs/tags/mytag 2>message
+'
+
 #
 #
 test_done
-- 
1.6.1.231.g9c286
