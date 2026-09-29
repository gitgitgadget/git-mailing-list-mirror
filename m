Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693343BE632
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658796; cv=none; b=bi0KkHH5YTwzh4/ofjhUlnAyc+8BPUR4pWRmcvrQSqj4TPItog5b/Vk2VXmQwDKMgDqhSpAMLGQwox4aRMbWUi/cqSTGrrYPYIzjIqIezwecCTW1rRkxZkPag3SSiAr5YuyDA24MnEKJenkqYCGJXwO/vj+Vb7k9yNxdGcU8HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658796; c=relaxed/simple;
	bh=ht+m9HHkYJuKdc1sGOrfMwtZlFKzbLy9Ewgu2+XeFn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmw3y9Il1FOf1Xrtu7eYUd29Uf5x1zPhDR17U36u5CvPshcOo2ejUI1vuLxow8UGAWSXI33Gk+Npo9kc/i7pi9zhh5dlUcinp3M6OXgK2qR/plOZstLPIZIuBQqidiD5bJfr33szp6A9cHvlv7Errh+5d81MG67+P4YSm4At/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FxUOPI7m; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FxUOPI7m"
Received: (qmail 69160 invoked by uid 106); 29 Sep 2026 05:13:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ht+m9HHkYJuKdc1sGOrfMwtZlFKzbLy9Ewgu2+XeFn0=; b=FxUOPI7mYX/FTOy87qdb6ibL3oCSk9GKDMCLUw9vyR0QShrpTZOaAtWl80Py6fUoIoDJHc0x8yUB5pDwHJ8NMfNw8bhPEUbp0W+jmOhWxZdDVWsKmesi4tHBEaOLAxmSHAyQ9S9I9TAUoGXi569qjIVbWzZLdPgZKLBGdOFZV/bd/MMvhDaiBqZmBBCtG2ea45AfRwddxe19xVC7giipUR21XZFEHolLWKDj8JGkM6s7YkbiR6QSBydqtfUaOGc6jqjzg9i545YWfgF+UDyh64O2tGVhdRIAOaHAcHt6EPvyR6gFRLVWfNa3CbUBbwdfrFwbSPqnrhhmo1g/4fRWSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 05:13:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 288279 invoked by uid 111); 29 Sep 2026 05:13:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 01:13:13 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 01:13:12 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 2/2] merge-ll: use tempfile API for external driver files
Message-ID: <20260929051312.GB1100669@coredump.intra.peff.net>
References: <20260929051200.GA1100000@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929051200.GA1100000@coredump.intra.peff.net>

When there's a long(er) running merge driver helper, the user may just
decide to terminate it with Ctrl+C. That sends a signal to the driver
program and to the whole process group as well, including the git merge
command proper. Hence the cleanup code would not run and .merge_file_*
files are left behind.

We can fix this by using the tempfile API, which auto-cleans files on
signal or other error. That covers the Ctrl+C case above, as well as any
other incidental death (e.g., allocation error due to a gigantic
output).

Note that there is one gotcha here. The current code uses short,
relative filenames for the tempfiles (like ".merge_file_abc123"). But
the tempfile API stores and returns absolute paths. Because we run the
merge driver as a shell command, this can result in problems if the
leading directories contain shell metacharacters (like our tests, which
put a space in the trash directory name for exactly this purpose).

If we were starting from scratch, I'd say the correct solution here is
to shell-quote the filenames we put in the command. But doing so isn't
strictly backwards compatible, because users might have their own shell
characters. For example, if I configure a driver like this:

  [merge "foo"]
  driver = "my-driver '%O' '%A' '%B'"

then adding extra quoting will screw things up! Strictly speaking, this
kind of quoting is wrong (it would fail if %A expanded to something with
a single-quote in it), but it is entirely harmless with the current
vanilla relative paths. It doesn't seem worth breaking it.

So let's take the most conservative route, and just continue reporting
the relative paths.

Reported-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 62d402199d..0eadbfba23 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -17,6 +17,7 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "tempfile.h"
 
 struct ll_merge_driver;
 
@@ -174,16 +175,28 @@ static struct ll_merge_driver ll_merge_drv[] = {
 	{ "union", "built-in union merge", ll_union_merge },
 };
 
-static void create_temp(mmfile_t *src, char *path, size_t len)
+static struct tempfile *create_temp(mmfile_t *src)
 {
-	int fd;
-
-	xsnprintf(path, len, ".merge_file_XXXXXX");
-	fd = xmkstemp(path);
-	if (write_in_full(fd, src->ptr, src->size) < 0)
-		die_errno(_("unable to write %s"), path);
-	if (close(fd) < 0)
-		die_errno(_("unable to close %s"), path);
+	struct tempfile *t = xmks_tempfile(".merge_file_XXXXXX");
+	if (write_in_full(t->fd, src->ptr, src->size) < 0)
+		die_errno(_("unable to write %s"), get_tempfile_path(t));
+	if (close_tempfile_gently(t) < 0)
+		die_errno(_("unable to close %s"), get_tempfile_path(t));
+	return t;
+}
+
+static const char *temp_path_basename(struct tempfile *t)
+{
+	/*
+	 * basename() takes a non-const pointer because it can
+	 * modify the input string to remove trailing directory
+	 * separators. We know that we don't have any because
+	 * this is a clean path generated from our vanilla
+	 * tempfile template.
+	 *
+	 * So casting away the const here is safe, albeit gross.
+	 */
+	return basename((char *)get_tempfile_path(t));
 }
 
 /*
@@ -198,11 +211,11 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
-	char temp[3][50];
+	struct tempfile *tmp_o, *tmp_a, *tmp_b;
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
+	int status, fd;
 	struct stat st;
 	enum ll_merge_result ret;
 	assert(opts);
@@ -212,19 +225,19 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 
 	result->ptr = NULL;
 	result->size = 0;
-	create_temp(orig, temp[0], sizeof(temp[0]));
-	create_temp(src1, temp[1], sizeof(temp[1]));
-	create_temp(src2, temp[2], sizeof(temp[2]));
+	tmp_o = create_temp(orig);
+	tmp_a = create_temp(src1);
+	tmp_b = create_temp(src2);
 
 	while (strbuf_expand_step(&cmd, &format)) {
 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(&cmd, '%');
 		else if (skip_prefix(format, "O", &format))
-			strbuf_addstr(&cmd, temp[0]);
+			strbuf_addstr(&cmd, temp_path_basename(tmp_o));
 		else if (skip_prefix(format, "A", &format))
-			strbuf_addstr(&cmd, temp[1]);
+			strbuf_addstr(&cmd, temp_path_basename(tmp_a));
 		else if (skip_prefix(format, "B", &format))
-			strbuf_addstr(&cmd, temp[2]);
+			strbuf_addstr(&cmd, temp_path_basename(tmp_b));
 		else if (skip_prefix(format, "L", &format))
 			strbuf_addf(&cmd, "%d", marker_size);
 		else if (skip_prefix(format, "P", &format))
@@ -242,7 +255,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	child.use_shell = 1;
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
-	fd = open(temp[1], O_RDONLY);
+	fd = open(get_tempfile_path(tmp_a), O_RDONLY);
 	if (fd < 0)
 		goto bad;
 	if (fstat(fd, &st))
@@ -256,8 +269,9 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
  close_bad:
 	close(fd);
  bad:
-	for (i = 0; i < 3; i++)
-		unlink_or_warn(temp[i]);
+	delete_tempfile(&tmp_o);
+	delete_tempfile(&tmp_a);
+	delete_tempfile(&tmp_b);
 	strbuf_release(&cmd);
 	if (!status)
 		ret = LL_MERGE_OK;
-- 
2.56.0.rc2.338.gcaacf6bdf7
