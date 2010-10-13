From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/11] vcs-svn: Skeleton of an svn delta parser
Date: Wed, 13 Oct 2010 04:21:43 -0500
Message-ID: <20101013092143.GC32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xaE-0005hz-S4
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0JMJZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:25:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55486 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab0JMJZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:25:05 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so968041yxm.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VlbeN2wX9DKv2nQOeibPxKcDYdeQLdEo7id5F1rz+GI=;
        b=UnhlcjIei1WyRgaotGeDzWXTfPr98Qo5gm4z+LFyJ+y1yDD1qKAYxQjusDy+FYIEPX
         xQ1suXeveGidocoUhWujIrJEImByfaYsRZ7Y6TLS6RSmUP4JuueA9BJmmGrrT6J0Lcu4
         wVrBP+abY2Rcc+zjw9fgk8hFi6zTgeuZhBqbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LFKaJDcGx4ZJjfBDu6MIZLTyuw337OJ3lGikqeEiWJFGOO2/UKE5cR+ziVcBV8jiEN
         Fzqpxwrr3+ky216kvApjY/hL5cRtGi1lM6+iv9mHRUqg6eVrywAHYTL2IscJnkCOYrwT
         Gv7LDHI/yXONWSp2q2jMkzOlJ8Nb/6r0NHl8Y=
Received: by 10.151.49.19 with SMTP id b19mr667058ybk.194.1286961905291;
        Wed, 13 Oct 2010 02:25:05 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id v34sm4841456yba.19.2010.10.13.02.25.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:25:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158915>

A delta in the subversion delta (svndiff0) format consists of the
magic bytes SVN\0 followed by a sequence of windows, each beginning
with a window header consisting of five integers (with variable-length
representation):

	source view offset
	source view length
	output length
	instructions length
	auxiliary data length

Add an svndiff0_apply() function and test-svn-fe -d commandline tool
to parse such a delta in the special case of not including any
instructions or auxiliary data.

Later patches will add features to turn this into a fully functional
delta applier, for use by svn-fe in parsing the streams produced by
"svnrdump dump" and "svnadmin dump --deltas".

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile          |    4 +-
 t/t9011-svn-da.sh |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-svn-fe.c     |   39 ++++++++++++++++++++----
 vcs-svn/svndiff.c |   64 +++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h |    9 ++++++
 5 files changed, 189 insertions(+), 9 deletions(-)
 create mode 100755 t/t9011-svn-da.sh
 create mode 100644 vcs-svn/svndiff.h

diff --git a/Makefile b/Makefile
index d99da33..966f5c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1766,7 +1766,7 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o \
-	vcs-svn/sliding_window.o
+	vcs-svn/sliding_window.o vcs-svn/svndiff.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1893,7 +1893,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/svndump.h vcs-svn/sliding_window.h
+	vcs-svn/sliding_window.h vcs-svn/svndump.h vcs-svn/svndiff.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
new file mode 100755
index 0000000..8dccd16
--- /dev/null
+++ b/t/t9011-svn-da.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='test handling of deltas by dumpfile importer'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	>empty &&
+	printf foo >preimage
+'
+
+test_expect_success 'reject empty delta' '
+	test_must_fail test-svn-fe -d preimage empty 0
+'
+
+test_expect_success 'delta can empty file' '
+	printf "SVNQ" | q_to_nul >clear.delta &&
+	test-svn-fe -d preimage clear.delta 4 >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'one-window empty delta' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	test-svn-fe -d preimage clear.onewindow 9 >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'incomplete window header' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	printf "SVNQ%s" "QQ" | q_to_nul >clear.partialwindow &&
+	test_must_fail test-svn-fe -d preimage clear.onewindow 6 &&
+	test_must_fail test-svn-fe -d preimage clear.partialwindow 6
+'
+
+test_expect_success 'declared delta longer than actual delta' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	printf "SVNQ%s" "QQ" | q_to_nul >clear.partialwindow &&
+	test_must_fail test-svn-fe -d preimage clear.onewindow 14 &&
+	test_must_fail test-svn-fe -d preimage clear.partialwindow 9
+'
+
+test_expect_success 'two-window empty delta' '
+	printf "SVNQ%s%s" "QQQQQ" "QQQQQ" | q_to_nul >clear.twowindow &&
+	test-svn-fe -d preimage clear.twowindow 14 >actual &&
+	test_must_fail test-svn-fe -d preimage clear.twowindow 13 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'noisy zeroes' '
+	printf "SVNQ%s" \
+		"RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRQQQQQ" |
+		tr R "\200" |
+		q_to_nul >clear.noisy &&
+	len=$(wc -c <clear.noisy) &&
+	test-svn-fe -d preimage clear.noisy $len &&
+	test_cmp empty actual
+'
+
+test_expect_success 'reject variable-length int in magic' '
+	printf "SVNRQ" | tr R "\200" | q_to_nul >clear.badmagic &&
+	test_must_fail test-svn-fe -d preimage clear.badmagic 5
+'
+
+test_expect_success 'truncated integer' '
+	printf "SVNQ%s%s" "QQQQQ" "QQQQRRQ" |
+		tr R "\200" |
+		q_to_nul >clear.fullint &&
+	printf "SVNQ%s%s" "QQQQQ" "QQQQRR" |
+		tr RT "\201" |
+		q_to_nul >clear.partialint &&
+	test_must_fail test-svn-fe -d preimage clear.fullint 15 &&
+	test-svn-fe -d preimage clear.fullint 16 &&
+	test_must_fail test-svn-fe -d preimage clear.partialint 15
+'
+
+test_expect_success 'nonempty (but unused) preimage view' '
+	printf "SVNQ%b" "Q\003QQQ" | q_to_nul >clear.readpreimage &&
+	test-svn-fe -d preimage clear.readpreimage 9 >actual &&
+	test_cmp empty actual
+'
+
+test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 77cf78a..197a2c3 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -4,14 +4,39 @@
 
 #include "git-compat-util.h"
 #include "vcs-svn/svndump.h"
+#include "vcs-svn/svndiff.h"
+#include "vcs-svn/line_buffer.h"
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2)
-		usage("test-svn-fe <file>");
-	svndump_init(argv[1]);
-	svndump_read(NULL);
-	svndump_deinit();
-	svndump_reset();
-	return 0;
+	static const char test_svnfe_usage[] =
+		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+	if (argc < 2)
+		usage(test_svnfe_usage);
+	if (argc == 2) {
+		svndump_init(argv[1]);
+		svndump_read(NULL);
+		svndump_deinit();
+		svndump_reset();
+		return 0;
+	}
+	if (argc == 5 && !strcmp(argv[1], "-d")) {
+		struct line_buffer preimage = LINE_BUFFER_INIT;
+		struct line_buffer delta = LINE_BUFFER_INIT;
+		if (buffer_init(&preimage, argv[2]))
+			die_errno("cannot open preimage");
+		if (buffer_init(&delta, argv[3]))
+			die_errno("cannot open delta");
+		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+				   &preimage, stdout))
+			return 1;
+		if (buffer_deinit(&preimage))
+			die_errno("cannot close preimage");
+		if (buffer_deinit(&delta))
+			die_errno("cannot close delta");
+		buffer_reset(&preimage);
+		buffer_reset(&delta);
+		return 0;
+	}
+	usage(test_svnfe_usage);
 }
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 36d2b30..e572a93 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -12,6 +12,7 @@
  * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
  *
  * svndiff0 ::= 'SVN\0' window window*;
+ * window ::= int int int int int instructions inline_data;
  * int ::= highdigit* lowdigit;
  * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
  * lowdigit ::= # 7 bit value;
@@ -76,3 +77,66 @@ static int parse_int(const char **buf, size_t *result, const char *end)
 	return error("Invalid instruction: incomplete integer %"PRIu64,
 		     (uint64_t) rv);
 }
+
+static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > maximum_signed_value_of_type(off_t))
+		return error("Unrepresentable offset: %"PRIuMAX, val);
+	*result = val;
+	return 0;
+}
+
+static int read_length(struct line_buffer *in, size_t *result, off_t *len)
+{
+	uintmax_t val;
+	if (read_int(in, &val, len))
+		return -1;
+	if (val > SIZE_MAX)
+		return error("Unrepresentable length: %"PRIuMAX, val);
+	*result = val;
+	return 0;
+}
+
+static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
+{
+	size_t out_len;
+	size_t instructions_len;
+	size_t data_len;
+	assert(delta_len);
+
+	/* "source view" offset and length already handled; */
+	if (read_length(delta, &out_len, delta_len) ||
+	    read_length(delta, &instructions_len, delta_len) ||
+	    read_length(delta, &data_len, delta_len))
+		return -1;
+	if (instructions_len > 0)
+		return error("What do you think I am?  A delta applier?");
+	if (data_len > 0)
+		return error("No support for inline data yet");
+	return 0;
+}
+
+int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+		   struct line_buffer *preimage, FILE *postimage)
+{
+	assert(delta && preimage && postimage);
+
+	if (read_magic(delta, &delta_len))
+		return -1;
+	while (delta_len > 0) {	/* For each window: */
+		off_t pre_off;
+		size_t pre_len;
+		if (read_offset(delta, &pre_off, &delta_len) ||
+		    read_length(delta, &pre_len, &delta_len) ||
+		    apply_one_window(delta, &delta_len))
+			return -1;
+		if (delta_len && buffer_at_eof(delta))
+			return error("Delta ends early! "
+				     "(%"PRIu64" bytes remaining)",
+				     (uint64_t) delta_len);
+	}
+	return 0;
+}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
new file mode 100644
index 0000000..a986099
--- /dev/null
+++ b/vcs-svn/svndiff.h
@@ -0,0 +1,9 @@
+#ifndef SVNDIFF_H_
+#define SVNDIFF_H_
+
+#include "line_buffer.h"
+
+extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+			  struct line_buffer *preimage, FILE *postimage);
+
+#endif
-- 
1.7.2.3
