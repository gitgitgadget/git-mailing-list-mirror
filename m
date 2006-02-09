From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 08:35:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 17:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7ElF-0001Xi-1s
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 17:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWBIQfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWBIQfI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 11:35:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422728AbWBIQfH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 11:35:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19GZ3DZ003114
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 08:35:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19GZ2Yg031855;
	Thu, 9 Feb 2006 08:35:02 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15813>



On Wed, 8 Feb 2006, Junio C Hamano wrote:
> 
> True.  There was a discussion to come up with a sensible
> semantics for -c without -p (currently --cc and -c implies -p),
> but I haven't got around to it, since --cc was more useful in
> general.
> 
> Volunteers?

This is a first try at it.

NOTE! This makes "-c" be the default, which effectively means that merges 
are never ignored any more, and "-m" is a no-op. So it changes semantics.

I would also like to make "--cc" the default if you do patches, but didn't 
actually do that.

The raw output format is not wonderfully pretty, but it's distinguishable 
from a "normal patch" in that a normal patch with just one parent has just 
one colon at the beginning, while a multi-parent raw diff has <n> colons 
for <n> parents.

So now, in the kernel, when you do

	git-diff-tree cce0cac125623f9b68f25dd1350f6d616220a8dd

(to see the manual ARM merge that had a conflict in arch/arm/Kconfig), you 
get

	cce0cac125623f9b68f25dd1350f6d616220a8dd
	::100644 100644 100644 4a63a8e2e45247a11c068c6ed66c6e7aba29ddd9 77eee38762d69d3de95ae45dd9278df9b8225e2c 2f61726d2f4b636f6e66696700dbf71a59dad287       arch/arm/Kconfig

ie you see two colons (two parents), then three modes (parent modes 
followed by result mode), then three sha1s (parent sha1s followed by
result sha1).

Which is pretty close to the normal raw diff output.

NOTE! There are a few known issues:

 - a normal raw output will also do the "what happened" status character. 
   I didn't. I'm stupid and lazy. It's not strictly needed (since it's 
   obvious from the multiple colons), but I suspect we should do 
   something to perhaps clarify what it is. Or just put "M" for "modified 
   in merge")

 - It doesn't honor the "EOL" character, so "git-diff-tree -z" does the 
   wrong thing. Gaah. I should have just passed down the whole 
   "diff_options" instead of just the format. I'm a retard.

but it's a beginning..

		Linus

---
diff --git a/combine-diff.c b/combine-diff.c
index 6a9f368..935ba2a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -776,8 +776,35 @@ int show_combined_diff(struct combine_di
 	return shown_header;
 }
 
+#define COLONS "::::::::::::::::::::::::::::::::"
+
+static void show_raw_diff(struct combine_diff_path *p, int num_parent, const char *header)
+{
+	int i, offset;
+	const char *prefix;
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
+		printf("%s%06o", prefix, p->parent[i].mode);
+		prefix = " ";
+	}
+	printf("%s%06o", prefix, p->mode);
+	for (i = 0; i < num_parent; i++) {
+		printf("%s%s", prefix, sha1_to_hex(p->parent[i].sha1));
+		prefix = " ";
+	}
+	printf("%s%s\t%s\n", prefix, sha1_to_hex(p->parent[i].sha1), p->path);
+}
+
 int diff_tree_combined_merge(const unsigned char *sha1,
-			     const char *header, int dense)
+			     const char *header, int dense, int format)
 {
 	struct commit *commit = lookup_commit(sha1);
 	struct diff_options diffopts;
@@ -815,6 +842,11 @@ int diff_tree_combined_merge(const unsig
 		for (p = paths; p; p = p->next) {
 			if (!p->len)
 				continue;
+			if (format == DIFF_FORMAT_RAW) {
+				show_raw_diff(p, num_parent, header);
+				header = NULL;
+				continue;
+			}
 			if (show_combined_diff(p, num_parent, dense, header))
 				header = NULL;
 		}
diff --git a/diff-tree.c b/diff-tree.c
index 7148323..78bce06 100644
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
@@ -118,7 +118,8 @@ static int diff_tree_commit(struct commi
 		else if (combine_merges) {
 			header = generate_header(sha1, sha1, commit);
 			return diff_tree_combined_merge(sha1, header,
-							dense_combined_merges);
+							dense_combined_merges,
+							diff_options.output_format);
 		}
 	}
 
@@ -285,10 +286,12 @@ int main(int argc, const char **argv)
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
index 5c5e7fa..f7b3d2a 100644
--- a/diff.h
+++ b/diff.h
@@ -77,7 +77,7 @@ struct combine_diff_path {
 int show_combined_diff(struct combine_diff_path *elem, int num_parent,
 		       int dense, const char *header);
 
-extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int);
+extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int, int);
 
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
