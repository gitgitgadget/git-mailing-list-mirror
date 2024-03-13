Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFA4A06
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291649; cv=none; b=b4poXihhiIpyoojnUfOKY3yEz47EvKLwjYQKhsqXPLFtGGeY66GFPtdf99lpTSMctzi7/z+MEBx3Z22xq4JFgDnvZ3E9Nj8Lw3amWDH2wty0yytGhp/UwbFCEMyROM76ki2m/6HViylaAETJbfsnlmy4C8Zv9v/EM/OaYlKDUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291649; c=relaxed/simple;
	bh=9WjeBmB1SJDJ7DC0vLGVB8y+1Rg9LCHqkzia8iAyWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qn5tGO+jSDW+qO2wC2tRgJD7pIplWbY8+sKB4XaR4Uir4fxi81rKLmkKD6AtykHvJAvjJm02fPJZ/iDsZeejZW3SoPJ2Dkk5D36CZvtEPexmFt49peF2mQVlTf2GXrQBQjXq8lkBDE9/aCrYOfHkzO5xcJQNSxpxTh1z2f8c7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hudO/KK3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hudO/KK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710291647; x=1741827647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9WjeBmB1SJDJ7DC0vLGVB8y+1Rg9LCHqkzia8iAyWiQ=;
  b=hudO/KK38FOZQiSZPXn2GmK/xvmWnVvcrpmU9RkrAf9M4S0qukUWJqhW
   2YFn1dQeh89E/HP0D+MPdTI78WF49v46KU5D7IKKN+ZeE5htOjqq2tLP1
   2oYmK3sXwIVu4lcOet3ePDL6dVM5n3RUcObZllJkddJp0XsDqbqVc5RMB
   Az/NZ8WTeQF1x7gCNW5JqAEWBduKyR+ZaeGRZObunSDRgTS0i/sUOFqS+
   WiN7ZsVHfSCh2GSvWVhiBKBZPMt1a+VWYaGjSxAfiA+UQSSL/0wmQfT8U
   4IvPjK/y9Cgh1nX81D2yW/8HU5DXR3rCP2RbmS9Rbw5R6/plpwTZPmnA+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5641761"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5641761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11822408"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:00:45 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC PATCH] mailsplit: add option to extract PATCH M/N numbers
Date: Tue, 12 Mar 2024 17:58:48 -0700
Message-ID: <20240313010040.1828970-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.44.0.53.g0f9d4d28b7e6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

git mailsplit splits a mailbox into files, which are then fed into git
mailinfo to extract patch and subject data. This data is used by git am
to apply patches from an email file, whether its a maildir or an mbox
file.

In some cases, the order of emails within an mbox does not reflect the
actual patch order. I often find this the case when I download a
t.mbox.gz file from a public inbox archive.

When this occurs, git am will just try applying patches in whatever
order they appear in the mbox, without any attempt to sort or order
based on the actual patch numbers.

As an initial attempt at enabling such functionality, implement
--extract-patch-from-subject into git mailsplit.

This will cause the mailsplit command to store files in
<total>_<nr>_<count> files instead of just using the mail count as
currently.

This ordering should be generally useful as it sorts nicely when sorting
the files alphanumerically.

The extraction implementation is pretty rough, as I wasn't sure if we
had more robust string matching. I tried to use strchr and some
assumptions about how patch formatting is done. It looks for a block
with "[ .. PATCH .. (sp)M/N]" and tries to copy the M and N out of the
string and then extract the numbers using atoi. If any of this fails, it
falls back to M=0 and N=0 when formatting the file names.

The end result is that files split from the mailbox or maildir have
prefixed 000N_000M_000C rather than just using the count of mail files
within the mailbox.

To allow this to work nicely, I used fgetpos and fsetpos to move through
the file stream while searching for the subject line. This doesn't work
with stdin so this support only works if you are processing a real file
and not processing from stdin.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I'm sending this as an RFC because its pretty ugly and I didn't completely
finish the work to combine this with git-am. The goal is to have all the
mails extracted from mailsplit nicely sort along subject lines so that git
am will apply a series in the order that the subject lines specify rather
than assuming the mails were received and stored in the correct order.

Its frustrating to download an mbox file and then have to manually re-sort
or re-apply patches because it failed to extract things nicely. I don't know
if this approach is the best solution, or whether there's something else we
could do instead. In theory we probably want something more robust for the
M/N extraction over using strchr, memrchr, and whatnot....

 builtin/mailsplit.c | 126 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 10 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 3af9ddb8ae5c..5255f4056e91 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
 
 static const char git_mailsplit_usage[] =
-"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] [--extract-patch-from-subject] -o<directory> [(<mbox>|<Maildir>)...]";
 
 static int is_from_line(const char *line, int len)
 {
@@ -166,8 +166,83 @@ static int maildir_filename_cmp(const char *a, const char *b)
 	return (unsigned char)*a - (unsigned char)*b;
 }
 
+static int extract_patch_subject(FILE *mbox, int *nr, int *total)
+{
+	struct strbuf tmp, n_buf, m_buf;
+	int found = 0;
+	fpos_t pos;
+	int err;
+
+	err = fgetpos(mbox, &pos);
+	if (err) {
+		error_errno("cannot get file position for %s", mbox);
+		return err;
+	}
+
+	strbuf_init(&tmp, 100);
+	strbuf_init(&n_buf, 10);
+	strbuf_init(&m_buf, 10);
+
+	for (;;) {
+		char *start, *patch, *last_space, *slash, *end;
+
+		if (strbuf_getline(&tmp, mbox))
+			break;
+
+		if (!starts_with(tmp.buf, "Subject:"))
+			continue;
+
+		start = strchr(tmp.buf, '[');
+
+		while (start) {
+			patch = strstr(start, "PATCH");
+			slash = strchr(start, '/');
+			end = strchr(start, ']');
+
+			if (patch && slash && end &&
+			    patch < end && slash < end) {
+
+				last_space = memrchr(patch, ' ', end - patch);
+				if (!last_space || last_space >= end)
+					break;
+
+				found = 1;
+
+				strbuf_reset(&n_buf);
+				strbuf_reset(&m_buf);
+
+				strbuf_add(&m_buf, last_space + 1, slash - last_space - 1);
+				strbuf_add(&n_buf, slash + 1, end - slash - 1);
+
+				break;
+			}
+		}
+
+		break;
+	}
+
+	if (found) {
+		*nr = atoi(m_buf.buf);
+		*total = atoi(n_buf.buf);
+	} else {
+		*nr = 0;
+		*total = 0;
+	}
+
+	strbuf_release(&tmp);
+	strbuf_release(&n_buf);
+	strbuf_release(&m_buf);
+
+	err = fsetpos(mbox, &pos);
+	if (err)
+		error_errno("cannot set file position for %s", mbox);
+		return err;
+
+	return 0;
+}
+
 static int split_maildir(const char *maildir, const char *dir,
-	int nr_prec, int skip)
+	int extract_patch, int nr_prec, int skip)
 {
 	char *file = NULL;
 	FILE *f = NULL;
@@ -197,7 +272,17 @@ static int split_maildir(const char *maildir, const char *dir,
 			goto out;
 		}
 
-		name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
+		if (extract_patch) {
+			int nr, total;
+
+			if (extract_patch_subject(f, &nr, &total))
+				goto out;
+
+			name = xstrfmt("%s/%0*d_%0*d_%0*d", dir, nr_prec, total, nr_prec, nr, nr_prec, ++skip);
+		} else {
+			name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
+		}
+
 		split_one(f, name, 1);
 		free(name);
 
@@ -214,7 +299,8 @@ static int split_maildir(const char *maildir, const char *dir,
 	return ret;
 }
 
-static int split_mbox(const char *file, const char *dir, int allow_bare,
+static int split_mbox(const char *file, const char *dir,
+		      int extract_patch, int allow_bare,
 		      int nr_prec, int skip)
 {
 	int ret = -1;
@@ -223,8 +309,13 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
 
-	if (isatty(fileno(f)))
+	if (isatty(fileno(f))) {
+		if (extract_patch) {
+			error("cannot use --extract-patch-from-subject with stdin");
+			return -1;
+		}
 		warning(_("reading patches from stdin/tty..."));
+	}
 
 	if (!f) {
 		error_errno("cannot open mbox %s", file);
@@ -256,7 +347,20 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	}
 
 	while (!file_done) {
-		char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
+		char *name;
+
+		if (extract_patch) {
+			int nr, total;
+
+			if (extract_patch_subject(f, &nr, &total)) {
+				nr = 0;
+				total = 0;
+			}
+
+			name = xstrfmt("%s/%0*d_%0*d_%0*d", dir, nr_prec, total, nr_prec, nr, nr_prec, ++skip);
+		} else {
+			name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
+		}
 		file_done = split_one(f, name, allow_bare);
 		free(name);
 	}
@@ -272,7 +376,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
 	int nr = 0, nr_prec = 4, num = 0;
-	int allow_bare = 0;
+	int allow_bare = 0, extract_patch = 0;
 	const char *dir = NULL;
 	const char **argp;
 	static const char *stdin_only[] = { "-", NULL };
@@ -302,6 +406,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			dir = arg+2;
 		} else if (!strcmp(arg, "--mboxrd")) {
 			mboxrd = 1;
+		} else if (!strcmp(arg, "--extract-patch-from-subject")) {
+			extract_patch = 1;
 		} else if ( arg[1] == '-' && !arg[2] ) {
 			argp++;	/* -- marks end of options */
 			break;
@@ -338,7 +444,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 
 		if (arg[0] == '-' && arg[1] == 0) {
-			ret = split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			ret = split_mbox(arg, dir, extract_patch, allow_bare, nr_prec, nr);
 			if (ret < 0) {
 				error("cannot split patches from stdin");
 				return 1;
@@ -354,9 +460,9 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(argstat.st_mode))
-			ret = split_maildir(arg, dir, nr_prec, nr);
+			ret = split_maildir(arg, dir, extract_patch, nr_prec, nr);
 		else
-			ret = split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			ret = split_mbox(arg, dir, extract_patch, allow_bare, nr_prec, nr);
 
 		if (ret < 0) {
 			error("cannot split patches from %s", arg);
-- 
2.44.0.53.g0f9d4d28b7e6

