From: "George Spelvin" <linux@horizon.com>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Thu, 15 Jan 2009 23:24:32 -0500
Message-ID: <20090116042432.11434.qmail@science.horizon.com>
References: <20090115222905.8157.qmail@science.horizon.com>
 <alpine.DEB.1.00.0901160307290.3586@pacific.mpi-cbg.de>
 <7vhc40ov78.fsf@gitster.siamese.dyndns.org>
 <20090116032708.21156.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 16 05:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNgHa-0004gA-R3
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 05:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbZAPEYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 23:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZAPEYf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 23:24:35 -0500
Received: from science.horizon.com ([192.35.100.1]:12880 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754124AbZAPEYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 23:24:33 -0500
Received: (qmail 11435 invoked by uid 1000); 15 Jan 2009 23:24:32 -0500
In-Reply-To: <20090116032708.21156.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105920>

> I don't mind doing the coding, but can someone who groks the
> code more fully tell me if I'm missing something major?

Here's a first draft, that Works For Me(tm).  Does anyone see anything
broken about it?

(This code released into the public domain, copyright abandoned.  You may
do anything you like with it, including evil things, as long as you
don't bother me asking for additional permissions.)

diff --git a/builtin-grep.c b/builtin-grep.c
index bebf15c..5727a8b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -90,12 +90,74 @@ static int pathspec_matches(const char **paths, const char *name)
 	return 0;
 }
 
+/*
+ * Write a filename like "/usr/src/linux/include/linux/zlib.h" as
+ * a path relative to some prefix like "/usr/src/linux/kernel/"
+ * (The prefix always includes a trailing slash.)
+ * label_len, if non-zero, describes a leading portion on the name
+ * (typically of the form "HEAD^^:") which should not be stripped off.
+ * 
+ * The result is in one of three places:
+ * - It may be a pointer into the supplied name in the simplest case,
+ * - It may be returned in a static buffer if it is of reaonable size, or
+ * - It may be in a malloced buffer if it is large.
+ * A pointer to be passed to free() is returned in *to_free, which
+ * is set to NULL if the return value is not to be freed, or is equal
+ * to the return value if it is.  (It could be simply a boolean, but doing
+ * it this way eliminates a test in the caller.)
+ */
+static const char *make_relative(unsigned label_len, const char *prefix, unsigned prefix_len, const char *name, void **to_free)
+{
+	static char name_buf[PATH_MAX];
+	char *cp;
+	unsigned n, match_len = 0, slashes = 0;
+	unsigned name_len;
+
+	for (n = 0; n < prefix_len; n++) {
+		if (prefix[n] != name[label_len+n]) {
+			for (; n < prefix_len; n++)
+				slashes += (prefix[n] == '/');
+			break;
+		}
+		if (prefix[n] == '/')
+			match_len = n+1;
+	}
+
+	/* Can we return a substring of the input string? */
+	if (!slashes && (!label_len || !match_len)) {
+		*to_free = NULL;
+		return name + match_len;
+	}
+
+	/* Nope, assemble the full response */
+
+	/* Output buffer will be tag + "../"*slashes + name + '\0' */
+	name_len = strlen(name + label_len + match_len) + 1;
+	n = label_len + 3*slashes + name_len + 1;
+	if (n <= ARRAY_SIZE(name_buf)) {
+		cp = name_buf;
+		*to_free = NULL;
+	} else {
+		*to_free = cp = xmalloc(n);
+	}
+
+	/* Now fill in the buffer */
+	memcpy(cp, name, label_len);
+	n = label_len;
+	while (slashes--) {
+		memcpy(cp+n, "../", 3);
+		n += 3;
+	}
+	memcpy(cp+n, name+label_len+match_len, name_len);
+	return cp;
+}
+
 static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name, int tree_name_len)
 {
 	unsigned long size;
 	char *data;
 	enum object_type type;
-	char *to_free = NULL;
+	void *to_free = NULL;
 	int hit;
 
 	data = read_sha1_file(sha1, &type, &size);
@@ -103,24 +165,9 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
 		return 0;
 	}
-	if (opt->relative && opt->prefix_length) {
-		static char name_buf[PATH_MAX];
-		char *cp;
-		int name_len = strlen(name) - opt->prefix_length + 1;
-
-		if (!tree_name_len)
-			name += opt->prefix_length;
-		else {
-			if (ARRAY_SIZE(name_buf) <= name_len)
-				cp = to_free = xmalloc(name_len);
-			else
-				cp = name_buf;
-			memcpy(cp, name, tree_name_len);
-			strcpy(cp + tree_name_len,
-			       name + tree_name_len + opt->prefix_length);
-			name = cp;
-		}
-	}
+	if (opt->relative)
+		name = make_relative(tree_name_len, opt->prefix,
+		                     opt->prefix_length, name, &to_free);
 	hit = grep_buffer(opt, name, data, size);
 	free(data);
 	free(to_free);
@@ -132,6 +179,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct stat st;
 	int i;
 	char *data;
+	void *to_free = NULL;
 	size_t sz;
 
 	if (lstat(filename, &st) < 0) {
@@ -156,10 +204,12 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		return 0;
 	}
 	close(i);
-	if (opt->relative && opt->prefix_length)
-		filename += opt->prefix_length;
+	if (opt->relative)
+		filename = make_relative(0, opt->prefix, opt->prefix_length,
+		                         filename, &to_free);
 	i = grep_buffer(opt, filename, data, sz);
 	free(data);
+	free(to_free);
 	return i;
 }
 
@@ -528,7 +578,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
+	opt.prefix = prefix;
+	opt.prefix_length = prefix ? strlen(prefix) : 0;
 	opt.relative = 1;
 	opt.pathname = 1;
 	opt.pattern_tail = &opt.pattern_list;
@@ -787,17 +838,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[j]);
 	}
 
-	if (i < argc) {
+	if (i < argc)
 		paths = get_pathspec(prefix, argv + i);
-		if (opt.prefix_length && opt.relative) {
-			/* Make sure we do not get outside of paths */
-			for (i = 0; paths[i]; i++)
-				if (strncmp(prefix, paths[i], opt.prefix_length))
-					die("git grep: cannot generate relative filenames containing '..'");
-		}
-	}
 	else if (prefix) {
-		paths = xcalloc(2, sizeof(const char *));
+		paths = xmalloc(2 * sizeof *paths);
 		paths[0] = prefix;
 		paths[1] = NULL;
 	}
diff --git a/grep.h b/grep.h
index 45a222d..a02dccf 100644
--- a/grep.h
+++ b/grep.h
@@ -56,6 +56,7 @@ struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;
 	struct grep_expr *pattern_expression;
+	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
 	unsigned linenum:1;
