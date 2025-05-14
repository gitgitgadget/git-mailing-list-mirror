Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15F156C6F
	for <git@vger.kernel.org>; Wed, 14 May 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255224; cv=none; b=ErjBvX12GYtV02C5tuF/0JjusIw3kyU5un2oUoQ4OnFP6bh/KbwbgpilJhdPpIjOiGFeu3lckeXKwOlhOpGIw//EE3hLeqfr/2u9IYDu2rWbo/FbzF2Fl0SotSrhCg/k+EypGiZqp5LVIeHgnyiG7N+VDFDIKgGcoKO5jrKbPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255224; c=relaxed/simple;
	bh=UYftt6klg6tJ2Mba+Oul0erP3BBiP/cC/dx8xjBfh6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+P4LCJeggZsG88YAwQi98xDQNLYJVL/ejtAkH8cHDa4Z49a4J1agQFQ1rRwFuBq/vKvdMoOWOLcy4bHKWWT8xBgtJDcGq3ZsASSdM/CN36bpCgjhNkgNcvntHDaG6KUKVboiRhiAZ255wBy6+pqxNYCwDzID395z9tHGshFCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XP6H+e0J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XP6H+e0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747255222; x=1778791222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UYftt6klg6tJ2Mba+Oul0erP3BBiP/cC/dx8xjBfh6g=;
  b=XP6H+e0JBC7euaJGLSIKKu6BXr0YSSDY+xsWpBX9cAqhEYreDw5b+KKM
   pfGpyp3hcNdA9eguII2+DD9jkAS+8dziMMDtJoIJ2mxg0wX9/0F0FPrBn
   Oen+R+kTLqKdmZqwh4dMQGOL3gVgKbzv2b9nJ88riF1Knds+Gtlt6qfJo
   4iPciR2dLYxvNFcjfMf6/MFvxDClk4oVR7Ws/ElRq6CyhCke/Ei/qBepg
   SnlfJCgIi1458dwQq7ATvUtANB46ilukE9QTeo6tx4hJb8epD2HiuOABT
   5yBqWydgyBNoAUqyVhItmOh+b3DbIl/ae+fIS044h1oNTMROySHx14T/8
   g==;
X-CSE-ConnectionGUID: uWVx+AvwSjy32tI7lYZqRQ==
X-CSE-MsgGUID: GZfYaIX2Qh+MsmXwSpTHCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52984317"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="52984317"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 13:40:21 -0700
X-CSE-ConnectionGUID: ZUGW11ztQ1iD0Ombvus92g==
X-CSE-MsgGUID: Di7pGTqCQHKzr+C9doKapg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="161433544"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 13:40:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH RFC] diff --no-index: teach option to exclude files by pattern
Date: Wed, 14 May 2025 13:40:14 -0700
Message-ID: <20250514204014.3106177-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

The --no-index option of git-diff enables using the diff machinery when
operating outside a repository. This mode of git diff is able to compare
directories and produce a diff of their contents. In certain cases, it
may be helpful to ignore certain portions of a directory.

In particular, git diff --no-index does not ignore '.git' or other VCS
'hidden' folders. If you pass a path which happens to be a git
repository, it will attempt to diff the entire repository folder.
Standard diff utilities often include options to exclude files by path.
For example, the GNU diffutils program has the '-x' option to exclude
files by a pattern match.

Teach git diff --no-index the ability to exclude files by wildmatch
pattern when recursing through directories. The '--exclude' option
builds up a string list containing the patterns. These are checked with
wildmatch() in the read_directory_contents function. If any pattern
matches, then the file is not included in the directory contents.

The --exclude option is only supported by the --no-index mode. Standard
diff modes support negative pathspecs which is more powerful. I tried to
see if there was a way to add support for negative pathspecs themselves,
but haven't yet figured out if this is possible.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I came across an issue when attempting to use git diff --no-index as a diff
replacement. I wanted to compare two folders, and one of them happened to be
a git repository. This caused the diff to recursively go into the .git
folder and try to compare all the paths.

Other diff tools such as the diff from GNU difftools have options to exclude
files by pattern match such as '-x'.

Git has negative pathspecs, but this doesn't work with git diff --no-index,
and making them work seems tricky, so I thought it wouldn't be too hard to
implement an exclude feature for git diff --no-index.

Is something like this worthwhile? I guess I could always try to use a
regular diff tool in cases where I'm operating on a potential repository..
But I like the colorization and other options of git diff and it would be
convenient to be able to still use git diff in this case.

Thoughts? What about trying to extend the tool to read in negative
pathspecs? That seems like its significantly more difficult, but might feel
more natural than the --exclude option.

Sent as RFC since this lacks tests and documentation.

 diff-no-index.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 6f277892d3ae..913b2f3f7869 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -17,8 +17,10 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "dir.h"
+#include "wildmatch.h"
 
-static int read_directory_contents(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list,
+				   struct string_list *exclude_patterns)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -26,8 +28,20 @@ static int read_directory_contents(const char *path, struct string_list *list)
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	while ((e = readdir_skip_dot_and_dotdot(dir)))
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
+		int skip = 0;
+
+		for (int i = 0; i < exclude_patterns->nr; i++) {
+			if (!wildmatch(exclude_patterns->items[i].string, e->d_name, 0)) {
+				skip = 1;
+				break;
+			}
+		}
+		if (skip)
+			continue;
+
 		string_list_insert(list, e->d_name);
+	}
 
 	closedir(dir);
 	return 0;
@@ -130,7 +144,8 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode,
 }
 
 static int queue_diff(struct diff_options *o,
-		      const char *name1, const char *name2, int recursing)
+		      const char *name1, const char *name2, int recursing,
+		      struct string_list *exclude_patterns)
 {
 	int mode1 = 0, mode2 = 0;
 	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
@@ -170,9 +185,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory_contents(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1, exclude_patterns))
 			return -1;
-		if (name2 && read_directory_contents(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2, exclude_patterns)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -217,7 +232,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, n1, n2, 1);
+			ret = queue_diff(o, n1, n2, 1, exclude_patterns);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -306,10 +321,13 @@ int diff_no_index(struct rev_info *revs,
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
 	struct strbuf replacement = STRBUF_INIT;
+	struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 	const char *prefix = revs->prefix;
 	struct option no_index_options[] = {
 		OPT_BOOL_F(0, "no-index", &no_index, "",
 			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
+		OPT_STRING_LIST(0, "exclude", &exclude_patterns, N_("pattern"),
+				N_("exclude files matching pattern when recursing a directory")),
 		OPT_END(),
 	};
 	struct option *options;
@@ -354,7 +372,7 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, paths[0], paths[1], 0))
+	if (queue_diff(&revs->diffopt, paths[0], paths[1], 0, &exclude_patterns))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
-- 
2.48.1.397.gec9d649cc640

