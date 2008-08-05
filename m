From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Teach fsck and prune that tmp_obj_ file names may not be
 14 bytes long
Date: Tue, 05 Aug 2008 13:01:50 -0500
Message-ID: <I1vUBkF5DO9PiWvc0SRIfOHigaNX9d2kNHLqpAUceLenX-_BWPAliQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQR7t-0006Kh-GH
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 20:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761509AbYHESSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 14:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbYHESSL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 14:18:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35726 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760225AbYHESSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 14:18:09 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2008 14:18:05 EDT
Received: by mail.nrlssc.navy.mil id m75I1ojG004375; Tue, 5 Aug 2008 13:01:50 -0500
X-OriginalArrivalTime: 05 Aug 2008 18:01:50.0580 (UTC) FILETIME=[55D2FB40:01C8F725]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91452>

As Shawn pointed out, not all temporary file creation routines can
ensure that the generated temporary file is of a certain length.
e.g. Java's createTempFile(prefix, suffix). So just depend on the
prefix 'tmp_obj_' for detection.

Update prune, and fix the "fix" introduced by a08c53a1 :)

Signed-off-by: Brandon "appendixless" Casey <casey@nrlssc.navy.mil>
---
 builtin-fsck.c  |    2 +-
 builtin-prune.c |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6eb7da8..d3f3de9 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -385,7 +385,7 @@ static void fsck_dir(int i, char *path)
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
-		if (prefixcmp(de->d_name, "tmp_obj_"))
+		if (!prefixcmp(de->d_name, "tmp_obj_"))
 			continue;
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
diff --git a/builtin-prune.c b/builtin-prune.c
index 947de8c..c767a0a 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -69,11 +69,6 @@ static int prune_dir(int i, char *path)
 			if (de->d_name[0] != '.')
 				break;
 			continue;
-		case 14:
-			if (prefixcmp(de->d_name, "tmp_obj_"))
-				break;
-			prune_tmp_object(path, de->d_name);
-			continue;
 		case 38:
 			sprintf(name, "%02x", i);
 			memcpy(name+2, de->d_name, len+1);
@@ -90,6 +85,10 @@ static int prune_dir(int i, char *path)
 			prune_object(path, de->d_name, sha1);
 			continue;
 		}
+		if (!prefixcmp(de->d_name, "tmp_obj_")) {
+			prune_tmp_object(path, de->d_name);
+			continue;
+		}
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
 	if (!show_only)
-- 
1.5.6.2
