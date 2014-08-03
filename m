From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] archive: honor tar.umask even for pax headers
Date: Sun,  3 Aug 2014 03:02:03 +0000
Message-ID: <1407034923-120683-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 05:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDm3r-0001LD-Mz
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 05:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbaHCDCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 23:02:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49283 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754651AbaHCDCL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 23:02:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D01742808F
	for <git@vger.kernel.org>; Sun,  3 Aug 2014 03:02:08 +0000 (UTC)
X-Mailer: git-send-email 2.0.1
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254718>

git archive's tar format uses extended pax headers to encode metadata
into the archive.  Most tar implementations correctly treat these as
metadata, but some that do not understand the pax format extract these
as files instead.  Apply the tar.umask setting to these entries to
prevent tampering by other users.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Technically, this is a security issue.  However, the files created are
not very useful[0] and the only implementations I found that write these
files are GNU cpio, Debian/MirBSD/OpenBSD pax, and 7zip, none of which
are commonly used to handle tar archives on Unix.  The latter two also
honor the user's umask by default, making this even less problematic.
Given the unlikely situation, I feel treating this as a regular bug is
fine.

node tar, FreeBSD tar, GNU tar, and Schily tar all handle pax headers
correctly.

[0] Okay, yes, you can exhaust someone else's quota.

 archive-tar.c                   | 4 ++--
 t/t5004-archive-corner-cases.sh | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 719b629..603650f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -192,7 +192,7 @@ static int write_extended_header(struct archiver_args *args,
 	unsigned int mode;
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_EXT_HEADER;
-	mode = 0100666;
+	mode = 0100666 & ~tar_umask;
 	sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	prepare_header(args, &header, mode, size);
 	write_blocked(&header, sizeof(header));
@@ -300,7 +300,7 @@ static int write_global_extended_header(struct archiver_args *args)
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
-	mode = 0100666;
+	mode = 0100666 & ~tar_umask;
 	strcpy(header.name, "pax_global_header");
 	prepare_header(args, &header, mode, ext_header.len);
 	write_blocked(&header, sizeof(header));
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 305bcac..83d20c4 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -113,4 +113,9 @@ test_expect_success 'archive empty subtree by direct pathspec' '
 	check_dir extract sub
 '
 
+test_expect_success 'archive applies umask even for pax headers' '
+	git archive --format=tar HEAD >archive.tar &&
+	! grep 0666 archive.tar
+'
+
 test_done
-- 
2.0.1
