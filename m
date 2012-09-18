From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] archive-zip: declare creator to be Unix for UTF-8 paths
Date: Tue, 18 Sep 2012 21:53:32 +0200
Message-ID: <5058D13C.8050203@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Sep 18 21:53:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3rn-00031v-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab2IRTxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:53:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:42882 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab2IRTxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:53:45 -0400
Received: from [192.168.2.105] (p579BE98C.dip.t-dialin.net [87.155.233.140])
	by india601.server4you.de (Postfix) with ESMTPSA id 8843EB1;
	Tue, 18 Sep 2012 21:53:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <5058CE49.3070108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205862>

The UTF-8 flag seems to be ignored by unzip unless we also mark the
archive entry as coming from a Unix system.  This is done by setting the
field creator_version ("version made by" in the standard[1]) to 0x03NN.

The NN part represents the version of the standard supported by us, and
this patch sets it to 3f (for version 6.3) for Unix paths.  We keep
creator_version set to 0 (FAT filesystem, standard version 0) in the
non-special cases, as before.

But when we declare a file to have a Unix path, then we have to set the
file mode as well, or unzip will extract the files with the permission
set 0000, i.e. inaccessible by all.

[1] http://www.pkware.com/documents/casestudies/APPNOTE.TXT
---
No sign-off for this, yet.  Perhaps there is a better way to convince
unzip to respect the flag?  And if not, do we need to offer umask
settings for ZIP as well as we have for tar?  And perhaps declare all
files as being from a Unix filesystem, for consistency?

 archive-zip.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 0f763e8..e9b3dc9 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -186,7 +186,8 @@ static int write_zip_entry(struct archiver_args *args,
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
-	unsigned long attr2;
+	unsigned int creator_version = 0;
+	unsigned long attr2 = 0;
 	unsigned long compressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
@@ -224,10 +225,15 @@ static int write_zip_entry(struct archiver_args *args,
 		enum object_type type = sha1_object_info(sha1, &size);
 
 		method = 0;
-		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
-			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
+		if (S_ISLNK(mode) || (mode & 0111) || (flags & ZIP_UTF8)) {
+			creator_version = 0x033f;
+			attr2 = mode;
+			if (S_ISLNK(mode))
+				attr2 |= 0777;
+			attr2 <<= 16;
+		}
 		compressed_size = size;
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
@@ -274,8 +280,7 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version,
-		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
+	copy_le16(dirent.creator_version, creator_version);
 	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, flags);
 	copy_le16(dirent.compression_method, method);
-- 
1.7.12
