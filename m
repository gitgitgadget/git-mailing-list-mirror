From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/5] checkout-index: fix --temp relative path mangling
Date: Wed, 24 Dec 2014 04:43:16 -0500
Message-ID: <1419414196-58587-6-git-send-email-sunshine@sunshineco.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUR-00053S-OT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaLXJoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:11 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:55323 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaLXJoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:09 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so6694788igb.5
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlHe9Mu0GaDFXYm18rahq+J7Glf+OWJRZddj4QwdZcI=;
        b=aycIBYS00GJwEAScryvXAg4wWjH5Yr2lj7W0nz2n6IWap4qTdpnDuQzU7j1KJzDqGA
         xbkSrMzxDBdvBOh6H45JLO0Q7wg/DdFK13EQBxk52LYlre0ik1yj3d21XqmP4WY+Oczc
         YeSxdNcrzHVVtny1JY5ffNrqOIoV4kMffoYgQYqmerMcc3O/YBkz5qLXltZ28x+2HCKo
         gCmk0bgPRwC5+4zQEq4g7ad6yG2gQtJpAD/nHP+mxzg8PEG+9QggAj/6lO40ZUruogAv
         ujqKPtHvOAx00Mh+DkMGF58AskhYZWD2xAI+7IcIW+Weopt3nh6oCWG0l5v2aYyaQumR
         ou0g==
X-Received: by 10.43.33.1 with SMTP id sm1mr25834270icb.43.1419414248457;
        Wed, 24 Dec 2014 01:44:08 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.07
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:07 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
In-Reply-To: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261797>

checkout-index --temp only properly prints relative paths which are
descendants of the current directory. Paths in ancestor or sibling
directories (or their children) are often printed in mangled form. For
example:

    mkdir a bbb &&
    >file &&
    >bbb/file &&
    git update-index --add file bbb/file &&
    cd a &&
    git checkout-index --temp ../file ../bbb/file

prints:

    .merge_file_ooblek  le
    .merge_file_igloo0  b/file

rather than the correct:

    .merge_file_ooblek  ../file
    .merge_file_igloo0  ../bbb/file

Internally, given the above example, checkout-index prefixes each input
argument with the name of the current directory ("a/", in this case),
and then assumes that it can simply skip forward by strlen("a/") bytes
to recover the original name. This works for files in the current
directory or its descendants, but fails for files in ancestors or
siblings (or their children) due to path normalization.

For instance, given "../file", "a/" is appended, giving "a/../file".
Path normalization folds out "a/../", resulting in "file". Attempting
to recover the original name by skipping strlen("a/") bytes gives the
incorrect "le" rather than the desired "../file".

Fix this by taking advantage of write_name_quoted_relative() to recover
the original name properly, rather than assuming that it can be
recovered by skipping strlen(prefix) bytes.

As a bonus, this also fixes a bug in which checkout-index --temp
accessed and printed memory beyond the end-of-string. For instance,
within a subdirectory named "subdirectory", and given argument
"../file", prefixing would give "subdirectory/../file", which would
become "file" after normalization. checkout-index would then attempt to
recover the original name by skipping strlen("subdirectory/") bytes of
"file", which placed it well beyond end-of-string. Despite this error,
it often appeared to give the correct result, but only due to an
accident of implementation which left an apparently correct copy of the
path in memory following the normalized value. In particular, handed
"subdirectory/../file", in-place processing by normalize_path_copy_len()
resulted in "file\0rectory/../file". When checkout-index skipped
strlen("subdirectory/") bytes, it ended up back at "../file" and thus
appeared to give the correct answer, despite being past end-of-string.

Reported-by: Russ Cox <rsc@golang.org>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout-index.c       | 16 ++++++++--------
 t/t2004-checkout-cache-temp.sh |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 383dccf..031780f 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -18,7 +18,7 @@ static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
 
 static struct checkout state;
 
-static void write_tempfile_record(const char *name, int prefix_length)
+static void write_tempfile_record(const char *name, const char *prefix)
 {
 	int i;
 
@@ -35,14 +35,14 @@ static void write_tempfile_record(const char *name, int prefix_length)
 		fputs(topath[checkout_stage], stdout);
 
 	putchar('\t');
-	write_name_quoted(name + prefix_length, stdout, line_termination);
+	write_name_quoted_relative(name, prefix, stdout, line_termination);
 
 	for (i = 0; i < 4; i++) {
 		topath[i][0] = 0;
 	}
 }
 
-static int checkout_file(const char *name, int prefix_length)
+static int checkout_file(const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
 	int pos = cache_name_pos(name, namelen);
@@ -71,7 +71,7 @@ static int checkout_file(const char *name, int prefix_length)
 
 	if (did_checkout) {
 		if (to_tempfile)
-			write_tempfile_record(name, prefix_length);
+			write_tempfile_record(name, prefix);
 		return errs > 0 ? -1 : 0;
 	}
 
@@ -106,7 +106,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 		if (last_ce && to_tempfile) {
 			if (ce_namelen(last_ce) != ce_namelen(ce)
 			    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
-				write_tempfile_record(last_ce->name, prefix_length);
+				write_tempfile_record(last_ce->name, prefix);
 		}
 		if (checkout_entry(ce, &state,
 		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
@@ -114,7 +114,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 		last_ce = ce;
 	}
 	if (last_ce && to_tempfile)
-		write_tempfile_record(last_ce->name, prefix_length);
+		write_tempfile_record(last_ce->name, prefix);
 	if (errs)
 		/* we have already done our error reporting.
 		 * exit with the same code as die().
@@ -248,7 +248,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
-		checkout_file(p, prefix_length);
+		checkout_file(p, prefix);
 		if (p < arg || p > arg + strlen(arg))
 			free((char *)p);
 	}
@@ -268,7 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &nbuf);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			checkout_file(p, prefix_length);
+			checkout_file(p, prefix);
 			if (p < buf.buf || p > buf.buf + buf.len)
 				free((char *)p);
 		}
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 3c2b2b9..a12afe9 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -206,7 +206,7 @@ test_expect_success 'checkout --temp symlink' '
 	test $(cat $p) = path7
 '
 
-test_expect_failure 'emit well-formed relative path' '
+test_expect_success 'emit well-formed relative path' '
 	rm -f path* .merge_* actual .git/index &&
 	>path0123456789 &&
 	git update-index --add path0123456789 &&
-- 
2.2.1.267.g0ad48de
