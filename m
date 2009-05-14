From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 2/3] added --batch option to mktree
Date: Thu, 14 May 2009 12:51:15 -0700
Message-ID: <a644352c0905141251n168508eexa8f6ebf4d84c65bb@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org>
	 <loom.20090514T051004-665@post.gmane.org>
	 <7vhbzoxl5k.fsf@alter.siamese.dyndns.org>
	 <a644352c0905140224g41f645c1l734bee791656ea1d@mail.gmail.com>
	 <fabb9a1e0905140325g2f376cf1lcaf206278a942c47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Micich <josh.micich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 21:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gxg-0006r7-Fs
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbZENTvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 15:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZENTvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:51:16 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:23577 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZENTvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 15:51:15 -0400
Received: by an-out-0708.google.com with SMTP id d40so3089768and.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LBLZfO7xFA/VJsqYqKYq1hQVCJ17f+Vc018hWKevyyw=;
        b=hvq1sQvhlK59jdoyN6LRHKZvvRXUxiMY3+DrCi1/dIPz72daZwSF5kjO37wocJmD61
         Fi+EfUDzgLVSAYmfXi180OGvco6HuVZPDvI4Ra0t/rnzApPz5mEWg7HsSFYUOqMTLStn
         kAiq9N+rujVzliZzrxCFBCikcGely6tXSL9ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m4GXfhd5WvLc5R2a0tpAMMtpXfrPsgunfxwgxGyoGr3cKj0f9b0/e77fz72OiZfDyO
         ppsg2okJZSNhzv0QPBAI1Vz4Hl33UznsHZqKIYbysfiU3SiHjm5XeR4RsRadR6To+00r
         fi4+Gcclyce6NYCbPUZ+H9xDuktx8AFOGu5Kk=
Received: by 10.100.240.9 with SMTP id n9mr3587222anh.135.1242330675685; Thu, 
	14 May 2009 12:51:15 -0700 (PDT)
In-Reply-To: <fabb9a1e0905140325g2f376cf1lcaf206278a942c47@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119217>

This option works in a similar way to the '--batch' option of 'git cat-file'.
It enables creation of many tree objects with a single process.

The change was motivated by performance considerations in applications that
need to create many tree objects. A non-rigorous test showed tree creation
times improved from (roughly) 200ms to 50ms.

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 Documentation/git-mktree.txt |    8 +++++++-
 builtin-mktree.c             |   40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 7336f48..81e3326 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,7 +8,7 @@ git-mktree - Build a tree-object from ls-tree formatted text

 SYNOPSIS
 --------
-'git mktree' [-z] [--missing]
+'git mktree' [-z] [--missing] [--batch]

 DESCRIPTION
 -----------
@@ -28,6 +28,12 @@ OPTIONS
 	object.  This option has no effect on the treatment of gitlink entries
 	(aka "submodules") which are always allowed to be missing.

+--batch::
+	Allow building of more than one tree object before exiting.  Each
+	tree is separated by as single blank line. The final new-line is
+	optional.  Note - if the '-z' option is used, lines are terminated
+	with NUL.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/builtin-mktree.c b/builtin-mktree.c
index 5ff0475..73b0abb 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -63,7 +63,7 @@ static void write_tree(unsigned char *sha1)
 }

 static const char *mktree_usage[] = {
-	"git mktree [-z] [--missing]",
+	"git mktree [-z] [--missing] [--batch]",
 	NULL
 };

@@ -122,20 +122,46 @@ int cmd_mktree(int ac, const char **av, const
char *prefix)
 	unsigned char sha1[20];
 	int line_termination = '\n';
 	int allow_missing = 0;
+	int is_batch_mode = 0;
+	int got_eof = 0;
+
 	const struct option option[] = {
 		OPT_SET_INT('z', NULL, &line_termination, "input is NUL terminated", '\0'),
 		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing objects", 1),
+		OPT_SET_INT( 0 , "batch", &is_batch_mode, "allow creation of more
than one tree", 1),
 		OPT_END()
 	};

 	ac = parse_options(ac, av, option, mktree_usage, 0);

-	while (strbuf_getline(&sb, stdin, line_termination) != EOF)
-		mktree_line(sb.buf, sb.len, line_termination, allow_missing);
-
+	while (!got_eof) {
+		while (1) {
+			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
+				got_eof = 1;
+				break;
+			}
+			if (sb.buf[0] == '\0') {
+				/* empty lines denote tree boundaries in batch mode */
+				if (is_batch_mode)
+					break;
+				die("input format error: (blank line only valid in batch mode)");
+			}
+			mktree_line(sb.buf, sb.len, line_termination, allow_missing);
+		}
+		if (is_batch_mode && got_eof && used < 1) {
+			/*
+			 * Execution gets here if the last tree entry is terminated with a
+			 * new-line.  The final new-line has been made optional to be
+			 * consistent with the original non-batch behaviour of mktree.
+			 */
+			; /* skip creating an empty tree */
+		} else {
+			write_tree(sha1);
+			puts(sha1_to_hex(sha1));
+			fflush(stdout);
+		}
+		used=0; /* reset tree entry buffer for re-use in batch mode */
+	}
 	strbuf_release(&sb);
-
-	write_tree(sha1);
-	puts(sha1_to_hex(sha1));
 	exit(0);
 }
-- 
1.6.3.1.181.gfc9b3
