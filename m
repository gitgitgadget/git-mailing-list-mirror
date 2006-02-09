From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 10:30:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 19:30:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7GYv-0006LP-7x
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 19:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWBISae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 13:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWBISae
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 13:30:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965250AbWBISad (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 13:30:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19IUTDZ010267
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 10:30:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19IUS8w005009;
	Thu, 9 Feb 2006 10:30:28 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15816>


[ Apologies if this comes several times. I had a few failed attempts ]

On Thu, 9 Feb 2006, Linus Torvalds wrote:
> 
> NOTE! There are a few known issues:
> 
>  - a normal raw output will also do the "what happened" status character. 
>    I didn't. I'm stupid and lazy. It's not strictly needed (since it's 
>    obvious from the multiple colons), but I suspect we should do 
>    something to perhaps clarify what it is. Or just put "M" for "modified 
>    in merge")
> 
>  - It doesn't honor the "EOL" character, so "git-diff-tree -z" does the 
>    wrong thing. Gaah. I should have just passed down the whole 
>    "diff_options" instead of just the format. I'm a retard.

A few more:

 - it doesn't honor "--abbrev", which it really should

 - git-diff-tree doesn't do the right thing for "header_prefix".

Anyway, this updated patch (throw the old one away) should fix all these 
issues.

Cool/stupid exercise:

	git-whatchanged | grep '^::' | cut -f2- | sort | uniq -c | sort -n | less -S

will show which files have needed the most file-level merge conflict 
resolution. Useful? Probably not. But kind of interesting (for the kernel, 
it's 

     ....
     10 arch/ia64/Kconfig
     11 drivers/scsi/Kconfig
     12 drivers/net/Makefile
     17 include/linux/libata.h
     18 include/linux/pci_ids.h
     23 drivers/net/Kconfig
     24 drivers/scsi/libata-scsi.c
     28 drivers/scsi/libata-core.c
     43 MAINTAINERS

in case anybody cares).

		Linus

---
diff --git a/combine-diff.c b/combine-diff.c
index 6a9f368..15f369e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -776,8 +776,52 @@ int show_combined_diff(struct combine_di
 	return shown_header;
 }
 
-int diff_tree_combined_merge(const unsigned char *sha1,
-			     const char *header, int dense)
+#define COLONS "::::::::::::::::::::::::::::::::"
+
+static void show_raw_diff(struct combine_diff_path *p, int num_parent, const char *header, struct diff_options *opt)
+{
+	int i, offset, mod_type = 'A';
+	const char *prefix;
+	int line_termination, inter_name_termination;
+
+	line_termination = opt->line_termination;
+	inter_name_termination = '\t';
+	if (!line_termination)
+		inter_name_termination = 0;
+
+	if (header)
+		puts(header);
+	offset = strlen(COLONS) - num_parent;
+	if (offset < 0)
+		offset = 0;
+	prefix = COLONS + offset;
+
+	/* Show the modes */
+	for (i = 0; i < num_parent; i++) {
+		int mode = p->parent[i].mode;
+		if (mode)
+			mod_type = 'M';
+		printf("%s%06o", prefix, mode);
+		prefix = " ";
+	}
+	printf("%s%06o", prefix, p->mode);
+	if (!p->mode)
+		mod_type = 'D';
+
+	/* Show sha1's */
+	for (i = 0; i < num_parent; i++) {
+		printf("%s%s", prefix, diff_unique_abbrev(p->parent[i].sha1, opt->abbrev));
+		prefix = " ";
+	}
+	printf("%s%s", prefix, diff_unique_abbrev(p->sha1, opt->abbrev));
+
+	/* Modification type, terminations, filename */
+	printf(" %c%c%s%c", mod_type, inter_name_termination, p->path, line_termination);
+}
+
+const char *diff_tree_combined_merge(const unsigned char *sha1,
+			     const char *header, int dense,
+			     struct diff_options *opt)
 {
 	struct commit *commit = lookup_commit(sha1);
 	struct diff_options diffopts;
@@ -815,6 +859,11 @@ int diff_tree_combined_merge(const unsig
 		for (p = paths; p; p = p->next) {
 			if (!p->len)
 				continue;
+			if (opt->output_format == DIFF_FORMAT_RAW) {
+				show_raw_diff(p, num_parent, header, opt);
+				header = NULL;
+				continue;
+			}
 			if (show_combined_diff(p, num_parent, dense, header))
 				header = NULL;
 		}
@@ -826,5 +875,5 @@ int diff_tree_combined_merge(const unsig
 		paths = paths->next;
 		free(tmp);
 	}
-	return 0;
+	return header;
 }
diff --git a/diff-tree.c b/diff-tree.c
index 7148323..df6fd97 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -6,7 +6,7 @@ static int show_root_diff = 0;
 static int no_commit_id = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
-static int combine_merges = 0;
+static int combine_merges = 1;
 static int dense_combined_merges = 0;
 static int read_stdin = 0;
 static int always_show_header = 0;
@@ -117,8 +117,12 @@ static int diff_tree_commit(struct commi
 			return 0;
 		else if (combine_merges) {
 			header = generate_header(sha1, sha1, commit);
-			return diff_tree_combined_merge(sha1, header,
-							dense_combined_merges);
+			header = diff_tree_combined_merge(sha1, header,
+							dense_combined_merges,
+							&diff_options);
+			if (!header && verbose_header)
+				header_prefix = "\ndiff-tree ";
+			return 0;
 		}
 	}
 
@@ -285,10 +289,12 @@ int main(int argc, const char **argv)
 		usage(diff_tree_usage);
 	}
 
-	if (combine_merges) {
-		diff_options.output_format = DIFF_FORMAT_PATCH;
+	if (combine_merges)
 		ignore_merges = 0;
-	}
+
+	/* We can only do dense combined merges with diff output */
+	if (dense_combined_merges)
+		diff_options.output_format = DIFF_FORMAT_PATCH;
 
 	if (diff_options.output_format == DIFF_FORMAT_PATCH)
 		diff_options.recursive = 1;
diff --git a/diff.h b/diff.h
index 5c5e7fa..9088519 100644
--- a/diff.h
+++ b/diff.h
@@ -74,10 +74,10 @@ struct combine_diff_path {
 	(sizeof(struct combine_diff_path) + \
 	 sizeof(struct combine_diff_parent) * (n) + (l) + 1)
 
-int show_combined_diff(struct combine_diff_path *elem, int num_parent,
-		       int dense, const char *header);
+extern int show_combined_diff(struct combine_diff_path *elem, int num_parent,
+			      int dense, const char *header);
 
-extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int);
+extern const char *diff_tree_combined_merge(const unsigned char *sha1, const char *, int, struct diff_options *opt);
 
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
