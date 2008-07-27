From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] fsck: Don't require tmp_obj_ file names are 14 bytes in
	length
Date: Sat, 26 Jul 2008 21:33:00 -0500
Message-ID: <20080727023300.GB17425@spearce.org>
References: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 04:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMw5E-0007m9-2h
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 04:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYG0CdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 22:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754352AbYG0CdB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 22:33:01 -0400
Received: from george.spearce.org ([209.20.77.23]:54417 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbYG0CdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 22:33:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B0AC383A5; Sun, 27 Jul 2008 02:33:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90300>

Not all temporary file creation routines will ensure 14 bytes are
used to generate the temporary file name.  In C Git this may be
true, but alternate implementations such as jgit are not always
able to generate a temporary file name with a specific prefix and
also ensure the file name length is 14 bytes long.

Since temporary files in a directory we are fsck'ing should be
uncommon (as they are short lived only long enough for an active
writer to finish writing the file and rename it) we shouldn't see
these show up very often.  Always using a prefixcmp() call and
ignoring the length opens up room for other implementations to use
different name generation schemes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  Brandon Casey <casey@nrlssc.navy.mil> wrote:
  > Since 5723fe7e, temporary objects are now created in their final destination
  > directories, rather than in .git/objects/. Teach fsck to recognize and
  > ignore the temporary objects it encounters, and teach prune to remove them.

  jgit can't exactly follow the 14 character naming rule.
  This should be a safe way around it.

 builtin-fsck.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7a4a4f1..6eb7da8 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -377,10 +377,6 @@ static void fsck_dir(int i, char *path)
 			if (de->d_name[0] != '.')
 				break;
 			continue;
-		case 14:
-			if (prefixcmp(de->d_name, "tmp_obj_"))
-				break;
-			continue;
 		case 38:
 			sprintf(name, "%02x", i);
 			memcpy(name+2, de->d_name, len+1);
@@ -389,6 +385,8 @@ static void fsck_dir(int i, char *path)
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
+		if (prefixcmp(de->d_name, "tmp_obj_"))
+			continue;
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
 	closedir(dir);
-- 
1.6.0.rc0.182.gb96c7

-- 
Shawn.
