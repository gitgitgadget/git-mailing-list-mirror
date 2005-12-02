From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-tree: add "-t" option to always show the tree entries
Date: Fri, 2 Dec 2005 15:11:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512021459380.3099@g5.osdl.org>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
 <20051201085433.GA7866@c165.ib.student.liu.se> <Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
 <7vlkz4friv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512011354500.3099@g5.osdl.org>
 <loom.20051202T231110-711@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 00:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiK4J-0001H0-0d
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVLBXLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVLBXLw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:11:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbVLBXLw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 18:11:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB2NBhe0009598
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Dec 2005 15:11:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB2NBcrD007851;
	Fri, 2 Dec 2005 15:11:42 -0800
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20051202T231110-711@post.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13135>



On Fri, 2 Dec 2005, Junio C Hamano wrote:
> 
> This brings up another issue.  When git-ls-tree works from subdirectory,
> do we want to see repository-relative paths, or cwd relative paths?
> Currently we do the latter.

Umm, I'd not say that we do the latter, but yeah, that's broken. We 
actually do _filter_ based on the cwd, but then we show the whole path, 
which makes no sense.

Something like this?

		Linus

---
diff --git a/ls-tree.c b/ls-tree.c
index dae377d..09dc34d 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -14,6 +14,7 @@ static int line_termination = '\n';
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
 static int ls_options = 0;
+static int skip_chars = 0;
 const char **pathspec;
 
 static const char ls_tree_usage[] =
@@ -65,6 +66,12 @@ static int show_tree(unsigned char *sha1
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
+	/* Normalize to cwd */
+	if (baselen < skip_chars)
+		return retval;
+	base += skip_chars;
+	baselen -= skip_chars;
+
 	if (!(ls_options & LS_NAME_ONLY))
 		printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
 	write_name_quoted(base, baselen, pathname, line_termination, stdout);
@@ -116,6 +123,9 @@ int main(int argc, const char **argv)
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
 
+
+	if (prefix)
+		skip_chars = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv + 2);
 	buf = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buf)
