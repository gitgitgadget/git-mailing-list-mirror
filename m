From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] pack-objects: new option --honor-pack-keep
Date: Thu, 06 Nov 2008 19:52:56 -0600
Message-ID: <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil>
References: <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:54:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyGYQ-0005l5-Ar
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbYKGBxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbYKGBxH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:53:07 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44232 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYKGBxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:53:05 -0500
Received: by mail.nrlssc.navy.mil id mA71qudQ017374; Thu, 6 Nov 2008 19:52:56 -0600
In-Reply-To: <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Nov 2008 01:52:56.0768 (UTC) FILETIME=[8E33BC00:01C9407B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100276>

This adds a new option to pack-objects which will cause it to ignore an
object which appears in a local pack which has a .keep file, even if it
was specified for packing.

This option will be used by the porcelain repack.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This series replaces the previous series starting at
6ee726bc "pack-objects: honor '.keep' files"

It should be applied on top of
f34cf12d "packed_git: convert pack_local flag into a bitfield and add pack_keep"

I created the series on top of f34cf12d rebased on top of master.

Suggestions for a more appropriate name for --honor-pack-keep are very welcome.

-brandon


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
