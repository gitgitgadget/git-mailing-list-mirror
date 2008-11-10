From: drafnel@gmail.com
Subject: [PATCH 3/3] pack-objects: extend --local to mean ignore non-local loose objects too
Date: Sun,  9 Nov 2008 23:59:58 -0600
Message-ID: <11455241.1226296713899.JavaMail.teamon@b307.teamon.com>
References: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
 <1226296798-31522-1-git-send-email-foo@foo.com>
 <1226296798-31522-2-git-send-email-foo@foo.com>
 <1226296798-31522-3-git-send-email-foo@foo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, nico@cam.org, ae@op5.se,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Mon Nov 10 07:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzPoi-00018Z-Cj
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 07:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYKJF6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 00:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbYKJF6k
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 00:58:40 -0500
Received: from www.teamon.com ([216.34.91.250]:4904 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752109AbYKJF6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 00:58:39 -0500
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mAA5wXo28437;
	Mon, 10 Nov 2008 05:58:33 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <1226296798-31522-3-git-send-email-foo@foo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100492>

From: Brandon Casey <drafnel@gmail.com>

With this patch, --local means pack only local objects that are not already
packed.

Additionally, this fixes t7700 testing whether loose objects in an alternate
object database are repacked.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Documentation/git-pack-objects.txt |    2 +-
 builtin-pack-objects.c             |    3 +++
 t/t7700-repack.sh                  |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index f9fac2c..7d4c1a7 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -121,7 +121,7 @@ base-name::
 --local::
 	This flag is similar to `--incremental`; instead of
 	ignoring all packed objects, it only ignores objects
-	that are packed and not in the local object store
+	that are packed and/or not in the local object store
 	(i.e. borrowed from an alternate).
 
 --non-empty::
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ddec341..69f351a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -691,6 +691,9 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 	}
 
+	if (!exclude && local && has_loose_object_nonlocal(sha1))
+		return 0;
+
 	for (p = packed_git; p; p = p->next) {
 		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 43c9cf9..960bff4 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -34,7 +34,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
-test_expect_failure 'loose objects in alternate ODB are not repacked' '
+test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo `pwd`/alt_objects > .git/objects/info/alternates &&
 	echo content3 > file3 &&
-- 
1.6.0.2.588.g3102
