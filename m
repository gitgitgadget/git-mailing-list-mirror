From: Linus Torvalds <torvalds@osdl.org>
Subject: Fixes for option parsing
Date: Sun, 16 Apr 2006 15:17:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 17 00:17:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVFYo-0005vC-K2
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 00:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDPWR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 18:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDPWR3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 18:17:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbWDPWR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 18:17:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GMHOtH015204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 15:17:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GMHNR0017424;
	Sun, 16 Apr 2006 15:17:23 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18807>


Make sure "git show" always show the header, regardless of whether there 
is a diff or not.

Also, make sure "always_show_header" actually works, since generate_header 
only tested it in one out of three return paths.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git.c b/git.c
index c5de8d3..fc4e429 100644
--- a/git.c
+++ b/git.c
@@ -373,6 +373,7 @@ static int cmd_show(int argc, const char
 	rev.diffopt.recursive = 1;
 	rev.combine_merges = 1;
 	rev.dense_combined_merges = 1;
+	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
 	return cmd_log_wc(argc, argv, envp, &rev);
diff --git a/log-tree.c b/log-tree.c
index 7d9f41e..81dff8f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -43,7 +43,7 @@ static int diff_root_tree(struct rev_inf
 	return retval;
 }
 
-static const char *generate_header(struct rev_info *opt,
+static const char *get_header(struct rev_info *opt,
 				   const unsigned char *commit_sha1,
 				   const unsigned char *parent_sha1,
 				   const struct commit *commit)
@@ -75,11 +75,21 @@ static const char *generate_header(struc
 	offset += pretty_print_commit(opt->commit_format, commit, len,
 				      this_header + offset,
 				      sizeof(this_header) - offset, abbrev);
+	return this_header;
+}
+
+static const char *generate_header(struct rev_info *opt,     
+					const unsigned char *commit_sha1,
+					const unsigned char *parent_sha1,
+					const struct commit *commit)
+{
+	const char *header = get_header(opt, commit_sha1, parent_sha1, commit);
+
 	if (opt->always_show_header) {
-		puts(this_header);
-		return NULL;
+		puts(header);
+		header = NULL;
 	}
-	return this_header;
+	return header;
 }
 
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
