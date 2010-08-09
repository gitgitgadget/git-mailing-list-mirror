From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] Add string-specific memory pool
Date: Mon, 9 Aug 2010 17:34:42 -0500
Message-ID: <20100809223442.GA4429@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiaxK-0004ij-Cz
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0HIWgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:36:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57885 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab0HIWgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:36:13 -0400
Received: by qwh6 with SMTP id 6so7691053qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4IiNst0qBmg0Cm2schgpzKLSiukihllhRR/bEPOl7sw=;
        b=Gpp9+mtkq2zNphsRIPU73W+fIM+o+xTQbbsN2EJTfwAhFDlN3GDW5fkW8dfzrAmPkM
         9o6JfyqcyotkYaEFfKRfzlQxLcE4nLMZh0f6mkqei5Dmi0OKzWdIApsTmYBOnmlN298/
         feL4o4bRsjOlpISTUYY4wzN2/PCIk6XMGvtBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U85Pbys2ovb60/Cb71oHXPJ1uLUb+8sB6+0uni5OIKDpXll5IMTXfK+AER6LAwC28O
         JTfNX3l7aA1hRvAjHpILqP6DGDS0MMpDJAr3zlcfFCJHyHdoCR56Z8tGW9PqPIPrwzlc
         nQRmFo6ySwKfiaLT+e8LWVhD+k1/rq5XmIO6M=
Received: by 10.220.124.129 with SMTP id u1mr9947890vcr.47.1281393371853;
        Mon, 09 Aug 2010 15:36:11 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id e5sm2523634vbe.7.2010.08.09.15.36.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:36:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153041>

From: David Barr <david.barr@cordelta.com>

Intern strings so they can be compared by address and stored without
wasting space.

This library uses the macros in the obj_pool.h and trp.h to create a
memory pool for strings and expose an API for handling them.

[rr: added API docs]
[jn: with some API simplifications, new documentation and tests]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New test.  The return value from pool_tok_seq is not checked by
the vcs-svn lib but trying to use it in tests revealed it was not
so intuitive.  pool_tok_seq() was behaving strangely when passed
an array of size 0; I think there is nothing sane to do in that
case --- maybe it should abort().  The API was passing around
char * that cannot be modified; changed to const char *.

Another set of eyes on this would be welcome.

 .gitignore              |    1 +
 Makefile                |    9 +++-
 t/t0080-vcs-svn.sh      |   16 +++++++
 test-string-pool.c      |   31 ++++++++++++++
 vcs-svn/string_pool.c   |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/string_pool.h   |   11 +++++
 vcs-svn/string_pool.txt |   43 ++++++++++++++++++++
 7 files changed, 210 insertions(+), 3 deletions(-)
 create mode 100644 test-string-pool.c
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/string_pool.txt

diff --git a/.gitignore b/.gitignore
index af47653..9f109db 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,6 +173,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-string-pool
 /test-treap
 /common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index e7c33ec..24103c9 100644
--- a/Makefile
+++ b/Makefile
@@ -415,6 +415,7 @@ TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
 
@@ -1742,7 +1743,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS =
+VCSSVN_OBJS = vcs-svn/string_pool.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1866,7 +1867,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h vcs-svn/trp.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -2017,10 +2018,12 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
+test-string-pool$X: vcs-svn/lib.a
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index ce02c58..99a314b 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,6 +76,22 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
 
+test_expect_success 'string pool' '
+	echo a does not equal b >expected.differ &&
+	echo a equals a >expected.match &&
+	echo equals equals equals >expected.matchmore &&
+
+	test-string-pool "a,--b" >actual.differ &&
+	test-string-pool "a,a" >actual.match &&
+	test-string-pool "equals-equals" >actual.matchmore &&
+	test_must_fail test-string-pool a,a,a &&
+	test_must_fail test-string-pool a &&
+
+	test_cmp expected.differ actual.differ &&
+	test_cmp expected.match actual.match &&
+	test_cmp expected.matchmore actual.matchmore
+'
+
 test_expect_success 'treap sort' '
 	cat <<-\EOF >unsorted &&
 	68
diff --git a/test-string-pool.c b/test-string-pool.c
new file mode 100644
index 0000000..2adf84b
--- /dev/null
+++ b/test-string-pool.c
@@ -0,0 +1,31 @@
+/*
+ * test-string-pool.c: code to exercise the svn importer's string pool
+ */
+
+#include "git-compat-util.h"
+#include "vcs-svn/string_pool.h"
+
+int main(int argc, char *argv[])
+{
+	const uint32_t unequal = pool_intern("does not equal");
+	const uint32_t equal = pool_intern("equals");
+	uint32_t buf[3];
+	uint32_t n;
+
+	if (argc != 2)
+		usage("test-string-pool <string>,<string>");
+
+	n = pool_tok_seq(3, buf, ",-", argv[1]);
+	if (n >= 3)
+		die("too many strings");
+	if (n <= 1)
+		die("too few strings");
+
+	buf[2] = buf[1];
+	buf[1] = (buf[0] == buf[2]) ? equal : unequal;
+	pool_print_seq(3, buf, ' ', stdout);
+	fputc('\n', stdout);
+
+	pool_reset();
+	return 0;
+}
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
new file mode 100644
index 0000000..550f0e5
--- /dev/null
+++ b/vcs-svn/string_pool.c
@@ -0,0 +1,102 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "trp.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+static struct trp_root tree = { ~0 };
+
+struct node {
+	uint32_t offset;
+	struct trp_node children;
+};
+
+/* Two memory pools: one for struct node, and another for strings */
+obj_pool_gen(node, struct node, 4096)
+obj_pool_gen(string, char, 4096)
+
+static char *node_value(struct node *node)
+{
+	return node ? string_pointer(node->offset) : NULL;
+}
+
+static int node_cmp(struct node *a, struct node *b)
+{
+	return strcmp(node_value(a), node_value(b));
+}
+
+/* Build a Treap from the node structure (a trp_node w/ offset) */
+trp_gen(static, tree_, struct node, children, node, node_cmp);
+
+const char *pool_fetch(uint32_t entry)
+{
+	return node_value(node_pointer(entry));
+}
+
+uint32_t pool_intern(const char *key)
+{
+	/* Canonicalize key */
+	struct node *match = NULL;
+	uint32_t key_len;
+	if (key == NULL)
+		return ~0;
+	key_len = strlen(key) + 1;
+	struct node *node = node_pointer(node_alloc(1));
+	node->offset = string_alloc(key_len);
+	strcpy(node_value(node), key);
+	match = tree_search(&tree, node);
+	if (!match) {
+		tree_insert(&tree, node);
+	} else {
+		node_free(1);
+		string_free(key_len);
+		node = match;
+	}
+	return node_offset(node);
+}
+
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
+{
+	char *token = strtok_r(str, delim, saveptr);
+	return token ? pool_intern(token) : ~0;
+}
+
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream)
+{
+	uint32_t i;
+	for (i = 0; i < len && ~seq[i]; i++) {
+		fputs(pool_fetch(seq[i]), stream);
+		if (i < len - 1 && ~seq[i + 1])
+			fputc(delim, stream);
+	}
+}
+
+uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str)
+{
+	char *context = NULL;
+	uint32_t token = ~0;
+	uint32_t length;
+
+	if (sz == 0)
+		return ~0;
+	if (str)
+		token = pool_tok_r(str, delim, &context);
+	for (length = 0; length < sz; length++) {
+		seq[length] = token;
+		if (token == ~0)
+			return length;
+		token = pool_tok_r(NULL, delim, &context);
+	}
+	seq[sz - 1] = ~0;
+	return sz;
+}
+
+void pool_reset(void)
+{
+	node_reset();
+	string_reset();
+}
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
new file mode 100644
index 0000000..222fb66
--- /dev/null
+++ b/vcs-svn/string_pool.h
@@ -0,0 +1,11 @@
+#ifndef STRING_POOL_H_
+#define STRING_POOL_H_
+
+uint32_t pool_intern(const char *key);
+const char *pool_fetch(uint32_t entry);
+uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
+void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
+void pool_reset(void);
+
+#endif
diff --git a/vcs-svn/string_pool.txt b/vcs-svn/string_pool.txt
new file mode 100644
index 0000000..1b41f15
--- /dev/null
+++ b/vcs-svn/string_pool.txt
@@ -0,0 +1,43 @@
+string_pool API
+===============
+
+The string_pool API provides facilities for replacing strings
+with integer keys that can be more easily compared and stored.
+The facilities are designed so that one could teach Git without
+too much trouble to store the information needed for these keys to
+remain valid over multiple executions.
+
+Functions
+---------
+
+pool_intern::
+	Include a string in the string pool and get its key.
+	If that string is already in the pool, retrieves its
+	existing key.
+
+pool_fetch::
+	Retrieve the string associated to a given key.
+
+pool_tok_r::
+	Extract the key of the next token from a string.
+	Interface mimics strtok_r.
+
+pool_print_seq::
+	Print a sequence of strings named by key to a file, using the
+	specified delimiter to separate them.
+
+	If NULL (key ~0) appears in the sequence, the sequence ends
+	early.
+
+pool_tok_seq::
+	Split a string into tokens, storing the keys of segments
+	into a caller-provided array.
+
+	Unless sz is 0, the array will always be ~0-terminated.
+	If there is not enough room for all the tokens, the
+	array holds as many tokens as fit in the entries before
+	the terminating ~0.  Return value is the index after the
+	last token, or sz if the tokens did not fit.
+
+pool_reset::
+	Deallocate storage for the string pool.
-- 
1.7.2.1.544.ga752d.dirty
