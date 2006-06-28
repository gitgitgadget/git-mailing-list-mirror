From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Prepare "git-merge-tree" for future work
Date: Wed, 28 Jun 2006 14:09:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606281401540.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jun 28 23:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvhIS-0007jM-3M
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 23:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWF1VJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 17:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWF1VJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 17:09:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751529AbWF1VJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 17:09:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5SL9tnW010493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Jun 2006 14:09:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5SL9sTR027761;
	Wed, 28 Jun 2006 14:09:54 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22824>



On Wed, 28 Jun 2006, Linus Torvalds wrote:
> 
> This changes how "git-merge-tree" works in two ways:

Ok, and here is a totally bogus (but hopefully instructive) patch on how 
to actually use this to prepare a diff.

I punted on trying to use the proper git diff interfaces (they are very 
tightly tied into the "diff_filespec" model - Junio, it might be nice if 
there was some way to use them in a setting where that isn't necessarily 
as natural). So the "diff" is actually just the raw output from xlib, but 
that wasn't really the point of this. 

It was more meant to do part of the the the "git-merge-one-file" logic, 
and use that logic together with the git-merge-tree logic to do a "merge" 
to diff against.

As an example, with this you can now do

	git-merge-tree $(git-merge-base HEAD next) HEAD next

to generate a "kind of" diff between the current HEAD and what would 
happen if it got merged with "next".

What (a properly done version of) this would be actually useful for is 
when you want to see what the merge results would be. For example, that's 
an integral part of sending a "please pull" request: telling the receiver 
what the diffstat should be after the pull (even though we don't _locally_ 
want to actually execute that merge - we expect the remote side to do so).

Anybody want to actually make this useful for something like that?

		Linus

----
diff --git a/Makefile b/Makefile
index cde619c..e880457 100644
--- a/Makefile
+++ b/Makefile
@@ -217,7 +217,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o $(DIFF_OBJS)
+	alloc.o merge-file.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
diff --git a/merge-file.c b/merge-file.c
new file mode 100644
index 0000000..4fedd6b
--- /dev/null
+++ b/merge-file.c
@@ -0,0 +1,107 @@
+#include "cache.h"
+#include "run-command.h"
+#include "blob.h"
+
+static void rm_temp_file(const char *filename)
+{
+	unlink(filename);
+}
+
+static const char *write_temp_file(struct blob *blob)
+{
+	int fd;
+	const char *tmp = getenv("TMPDIR");
+	unsigned long size;
+	char *filename, type[20];
+	void *buf;
+
+	if (!tmp)
+		tmp = "/tmp";
+	filename = mkpath("%s/%s", tmp, "git-tmp-XXXXXX");
+	fd = mkstemp(filename);
+	if (fd < 0)
+		return NULL;
+	filename = strdup(filename);
+	buf = read_sha1_file(blob->object.sha1, type, &size);
+	if (buf) {
+		if (size != xwrite(fd, buf, size)) {
+			rm_temp_file(filename);
+			return NULL;
+		}
+		free(buf);
+	}
+	close(fd);
+	return filename;
+}
+
+static void *read_temp_file(const char *filename, unsigned long *size)
+{
+	struct stat st;
+	char *buf = NULL;
+	int fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+	if (!fstat(fd, &st)) {
+		*size = st.st_size;
+		buf = xmalloc(st.st_size);
+		if (st.st_size != xread(fd, buf, st.st_size)) {
+			free(buf);
+			buf = NULL;
+		}
+	}
+	close(fd);
+	return buf;
+}
+
+void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+{
+	const char *t1, *t2, *t3;
+	char type[20];
+
+	if (base) {
+		int code;
+		void *res;
+
+		/*
+		 * Removed in either branch?
+		 *
+		 * NOTE! This depends on the caller having done the
+		 * proper warning about removing a file that got
+		 * modified in the other branch!
+		 */
+		if (!our || !their)
+			return NULL;
+		t1 = write_temp_file(base);
+		t2 = write_temp_file(our);
+		t3 = write_temp_file(their);
+		res = NULL;
+		if (t1 && t2 && t3) {
+			code = run_command("merge", t2, t1, t3, NULL);
+			if (!code || code == -1)
+				res = read_temp_file(t2, size);
+		}
+		rm_temp_file(t1);
+		rm_temp_file(t2);
+		rm_temp_file(t3);
+		return res;
+	}
+
+	if (!our)
+		return read_sha1_file(their->object.sha1, type, size);
+	if (!their)
+		return read_sha1_file(our->object.sha1, type, size);
+
+	/*
+	 * Added in both!
+	 *
+	 * This is nasty.
+	 *
+	 * We should do something like 
+	 *
+	 *	git diff our their | git-apply --no-add
+	 *
+	 * to generate a "minimal common file" to be used
+	 * as a base. Right now we punt.
+	 */
+	return NULL;
+}
diff --git a/merge-tree.c b/merge-tree.c
index fd0c211..7cf00be 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "xdiff-interface.h"
 #include "blob.h"
 
 static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
@@ -52,6 +53,77 @@ static const char *explanation(struct me
 	return "removed in remote";
 }
 
+extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *);
+
+static void *result(struct merge_list *entry, unsigned long *size)
+{
+	char type[20];
+	struct blob *base, *our, *their;
+
+	if (!entry->stage)
+		return read_sha1_file(entry->blob->object.sha1, type, size);
+	base = NULL;
+	if (entry->stage == 1) {
+		base = entry->blob;
+		entry = entry->link;
+	}
+	our = NULL;
+	if (entry && entry->stage == 2) {
+		our = entry->blob;
+		entry = entry->link;
+	}
+	their = NULL;
+	if (entry)
+		their = entry->blob;
+	return merge_file(base, our, their, size);
+}
+
+static void *origin(struct merge_list *entry, unsigned long *size)
+{
+	char type[20];
+	while (entry) {
+		if (entry->stage == 2)
+			return read_sha1_file(entry->blob->object.sha1, type, size);
+		entry = entry->link;
+	}
+	return NULL;
+}
+
+static int show_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+{
+	int i;
+	for (i = 0; i < nbuf; i++)
+		printf("%.*s", (int) mb[i].size, mb[i].ptr);
+	return 0;
+}
+
+static void show_diff(struct merge_list *entry)
+{
+	unsigned long size;
+	mmfile_t src, dst;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = 3;
+	xecfg.flags = 0;
+	ecb.outf = show_outf;
+	ecb.priv = NULL;
+
+	src.ptr = origin(entry, &size);
+	if (!src.ptr)
+		size = 0;
+	src.size = size;
+	dst.ptr = result(entry, &size);
+	if (!dst.ptr)
+		size = 0;
+	dst.size = size;
+	xdl_diff(&src, &dst, &xpp, &xecfg, &ecb);
+	free(src.ptr);
+	free(dst.ptr);
+}
+
 static void show_result_list(struct merge_list *entry)
 {
 	printf("%s\n", explanation(entry));
@@ -70,6 +142,7 @@ static void show_result(void)
 	walk = merge_result;
 	while (walk) {
 		show_result_list(walk);
+		show_diff(walk);
 		walk = walk->next;
 	}
 }
