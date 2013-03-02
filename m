From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Allow combined diff to ignore white-spaces
Date: Sat,  2 Mar 2013 16:04:18 +0100
Message-ID: <1362236658-17200-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 16:05:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBnzn-000169-8C
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 16:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3CBPEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 10:04:39 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:61191 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab3CBPEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 10:04:38 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so3274983wer.36
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4j3TlbPjn81PiuXpqxfQk3cJ43D5JkypGgxe4Hss/T4=;
        b=Kf7SO1msqp/xR94RN2z8MaXvmKJGLAQqN5iDFcvfRLOUhXdrEYi2NTnO+4ye/2VX0t
         JXVyyTmY26GYcPzyP3gnb0aAiOG/vvRVVGjstyjCC8mXadqge2TrrH7nY36m94/7TDLm
         ZCjRPVMg44Vu+5Ti3f/DqpyGPGel8b+zIauogyYVHz65EtQBK7Ied/B6MIIll9Nf0PGW
         ZoYhkVwhUgCqBX2xvw4wbRHLYhP2fTgpjZf1GRFgYLGsWuTTTBdrW/qykWJzy2wCc7dJ
         0q1dBDCFnxPBNsoK5vyd2KvhvLbTgkQWeAKk/d8m1xojKW7LEmFY5gH/FW0ZklqIVGIK
         bJjA==
X-Received: by 10.194.5.4 with SMTP id o4mr23119053wjo.40.1362236677631;
        Sat, 02 Mar 2013 07:04:37 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id fx5sm4003569wib.11.2013.03.02.07.04.35
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Mar 2013 07:04:36 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217331>

Currently, it's not possible to use the space-ignoring options (-b, -w,
--ignore-space-at-eol) with combined diff. It makes it pretty impossible
to read a merge between a branch that changed all tabs to spaces, and a
branch with functional changes.

Pass diff flags to diff engine, so that combined diff behaves as normal
diff does with spaces.

It also means that a conflict-less merge done using a ignore-* strategy
option will not show any conflict if shown in combined-diff using the
same option.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
That should be reviewed carefully as I'm not exactly sure that does make
sense with the way combined-diff works.
Still it seems natural to me to be able to remove the space in combined
diff as we do with normal diff. Especially as I unfortunately have to
deal with many space + feature merges that are very hard to analyze/handle
if space differences can't be hidden.

Cheers,
Antoine

 combine-diff.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 35d41cd..7ca0a72 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -215,7 +215,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
 			 struct userdiff_driver *textconv,
-			 const char *path)
+			 const char *path, long flags)
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask = (1UL << n);
@@ -231,7 +231,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = 0;
+	xpp.flags = flags;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
 	state.nmask = nmask;
@@ -962,7 +962,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
-				     textconv, elem->path);
+				     textconv, elem->path, opt->xdl_opts);
 	}

 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
--
1.7.9.5
