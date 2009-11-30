From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] Detailed diagnostic when parsing an object name fails.
Date: Mon, 30 Nov 2009 18:50:21 +0100
Message-ID: <1259603421-10055-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 18:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFARh-0005ay-Pu
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbZK3Ru0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 12:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbZK3Ru0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 12:50:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46649 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbZK3RuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 12:50:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nAUHmOgC013004
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Nov 2009 18:48:27 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NFAOF-00012I-TM; Mon, 30 Nov 2009 18:50:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NFAOF-0002g8-QI; Mon, 30 Nov 2009 18:50:23 +0100
X-Mailer: git-send-email 1.6.6.rc0.256.g6060
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 Nov 2009 18:48:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAUHmOgC013004
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1260208108.46979@W+ojSIX4pm5GC71nqmL0vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134122>

The previous error message was the same in many situations (unknown
revision or path not in the working tree). We try to help the user as
much as possible to understand the error, especially with the
sha1:filename notation. In this case, we say whether the sha1 or the
filename is problematic, and diagnose the confusion between
relative-to-root and relative-to-$PWD confusion precisely.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

The original motivation is actually to anwser the FAQ of "git show
HEAD:foo.txt" being relative to the root, while some users would
expect it relative to $PWD but the patch ended up being far more
general. At least, 

$ cd git
$ cd t
$ ../git show HEAD:test-lib.sh 
fatal: Path 't/test-lib.sh' exists, but not 'test-lib.sh'.
Did you mean 'HEAD:t/test-lib.sh'?

A few remarks/RFH:

* It's my first time playing with the index API, so my
  diagnose_invalid_index_path may be incorrect/suboptimal/...

* This definitely requires a few test-cases, but I don't have time for
  it right now.

* Is my way of having default arguments for get_sha1_with_mode OK with
  the usual coding style of Git?

 cache.h     |    6 +++-
 setup.c     |   15 +++++++++-
 sha1_name.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 0e69384..5c8cb5f 100644
--- a/cache.h
+++ b/cache.h
@@ -708,7 +708,11 @@ static inline unsigned int hexval(unsigned char c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+{
+	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
+}
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/setup.c b/setup.c
index f67250b..3094e8b 100644
--- a/setup.c
+++ b/setup.c
@@ -74,6 +74,18 @@ int check_filename(const char *prefix, const char *arg)
 	die_errno("failed to stat '%s'", arg);
 }
 
+static void NORETURN die_verify_filename(const char *prefix, const char *arg)
+{
+	unsigned char sha1[20];
+	unsigned mode;
+	/* try a detailed diagnostic ... */
+	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
+	/* ... or fall back the most general message. */
+	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+	    "Use '--' to separate paths from revisions", arg);
+
+}
+
 /*
  * Verify a filename that we got as an argument for a pathspec
  * entry. Note that a filename that begins with "-" never verifies
@@ -87,8 +99,7 @@ void verify_filename(const char *prefix, const char *arg)
 		die("bad flag '%s' used after filename", arg);
 	if (check_filename(prefix, arg))
 		return;
-	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-	    "Use '--' to separate paths from revisions", arg);
+	die_verify_filename(prefix, arg);
 }
 
 /*
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..172c128 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -804,7 +804,69 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_mode(name, sha1, &unused);
 }
 
-int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
+static void diagnose_invalid_sha1_path(const char *prefix,
+				       const char *filename,
+				       const char *tree_sha1,
+				       const char *object_name)
+{
+	struct stat st;
+	unsigned char sha1[20];
+	unsigned mode;
+
+	if (!lstat(filename, &st))
+		die("Path '%s' exists on disk, but not in '%s'.",
+		    filename, object_name);
+	if (errno == ENOENT || errno == ENOTDIR) {
+		char *fullname = malloc(strlen(filename)
+					     + strlen(prefix) + 1);
+		strcpy(fullname, prefix);
+		strcat(fullname, filename);
+
+		if (!get_tree_entry(tree_sha1, fullname,
+				    sha1, &mode)) {
+			die("Path '%s' exists, but not '%s'.\n"
+			    "Did you mean '%s:%s'?",
+			    fullname,
+			    filename,
+			    object_name,
+			    fullname);
+		}
+		die("Path '%s' does not exist in '%s'",
+		    filename, object_name);
+	}
+}
+
+static void diagnose_invalid_index_path(int stage,
+					const char *prefix,
+					const char *filename)
+{
+	struct stat st;
+	if (!lstat(filename, &st))
+		die("Path '%s' exists on disk, but not in the index.", filename);
+	if (errno == ENOENT || errno == ENOTDIR) {
+		struct cache_entry *ce;
+		int pos;
+		int namelen = strlen(filename) + strlen(prefix);
+		char *fullname = malloc(namelen + 1);
+		strcpy(fullname, prefix);
+		strcat(fullname, filename);
+		pos = cache_name_pos(fullname, namelen);
+		if (pos < 0)
+			pos = -pos - 1;
+		ce = active_cache[pos];
+		if (ce_namelen(ce) == namelen &&
+		    !memcmp(ce->name, fullname, namelen))
+			die("Path '%s' is in the index, but not '%s'.\n"
+			    "Did you mean ':%d:%s'?",
+			    fullname, filename,
+			    stage, fullname);
+
+		die("Path '%s' does not exist (either on disk or in the index).", filename);
+	}
+}
+
+
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -850,6 +912,8 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			}
 			pos++;
 		}
+		if (fatal)
+			diagnose_invalid_index_path(stage, prefix, cp);
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
@@ -862,9 +926,24 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		char *object_name;
+		if (fatal) {
+			object_name = malloc(cp-name+1);
+			strncpy(object_name, name, cp-name);
+			object_name[cp-name] = '\0';
+		}
+		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+			const char *filename = cp+1;
+			ret = get_tree_entry(tree_sha1, filename, sha1, mode);
+			if (fatal)
+				diagnose_invalid_sha1_path(prefix, filename,
+							   tree_sha1, object_name);
+
+			return ret;
+		} else {
+			if (fatal)
+				die("Invalid object name '%s'.", object_name);
+		}
 	}
 	return ret;
 }
-- 
1.6.6.rc0.256.g6060
