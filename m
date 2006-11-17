X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: "git fmt-merge-msg" SIGSEGV
Date: Thu, 16 Nov 2006 22:57:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611162249540.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 06:57:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31671>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkxfD-0000Cr-RH for gcvg-git@gmane.org; Fri, 17 Nov
 2006 07:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755510AbWKQG5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 01:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbWKQG5Z
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 01:57:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41364 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755510AbWKQG5Y (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 01:57:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAH6vKoZ007971
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 22:57:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAH6vKxW023677; Thu, 16 Nov
 2006 22:57:20 -0800
To: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org


Ok, this is a _really_ stupid case, and I don't think it matters, but hey, 
we should never SIGSEGV.

Steps to reproduce:

	mkdir duh
	cd duh
	git init-db
	git-fmt-merge-msg < /dev/null

will cause a SIGSEGV in cmd_fmt_merge_msg(), because we're doing a 
strncmp() with a NULL current_branch.

And yeah, it's an insane schenario, and no, it doesn't really matter. The 
only reason I noticed was that a broken version of my "git pull" into an 
empty directory would cause this.

This silly patch just replaces the SIGSEGV with a controlled exit with an 
error message.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 3d3097d..87d3d63 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -278,6 +278,8 @@ int cmd_fmt_merge_msg(int argc, const ch
 
 	/* get current branch */
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
+	if (!current_branch)
+		die("No current branch");
 	if (!strncmp(current_branch, "refs/heads/", 11))
 		current_branch += 11;
