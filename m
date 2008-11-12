From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/6] pack-objects: new option --honor-pack-keep
Date: Wed, 12 Nov 2008 11:59:04 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59Ll3-y-Spr-gg7enTTiJoZ2xRB8K4w13wAlZBhI9MXJqCLarfq3OODE@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1p-0002fL-6d
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbYKLR7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYKLR7x
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:53 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50134 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYKLR7l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:41 -0500
Received: by mail.nrlssc.navy.mil id mACHxHgm019943; Wed, 12 Nov 2008 11:59:17 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0403 (UTC) FILETIME=[616B46B0:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100792>

This adds a new option to pack-objects which will cause it to ignore an
object which appears in a local pack which has a .keep file, even if it
was specified for packing.

This option will be used by the porcelain repack.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-pack-objects.txt |    5 +++++
 builtin-pack-objects.c             |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8c354bd..f9fac2c 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -109,6 +109,11 @@ base-name::
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
+--honor-pack-keep::
+	This flag causes an object already in a local pack that
+	has a .keep file to be ignored, even if it appears in the
+	standard input.
+
 --incremental::
 	This flag causes an object already in a pack ignored
 	even if it appears in the standard input.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 15b80db..ddec341 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -71,6 +71,7 @@ static int reuse_delta = 1, reuse_object = 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
 static int local;
 static int incremental;
+static int ignore_packed_keep;
 static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
@@ -703,6 +704,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 				return 0;
 			if (local && !p->pack_local)
 				return 0;
+			if (ignore_packed_keep && p->pack_local && p->pack_keep)
+				return 0;
 		}
 	}
 
@@ -2048,6 +2051,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!strcmp("--honor-pack-keep", arg)) {
+			ignore_packed_keep = 1;
+			continue;
+		}
 		if (!prefixcmp(arg, "--compression=")) {
 			char *end;
 			int level = strtoul(arg+14, &end, 0);
-- 
1.6.0.3.552.g12334
