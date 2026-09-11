Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963038F25A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146823; cv=none; b=Nl0Wivpn1f25z3p6okj5415TO9i54TJl8G13Poy8uJ+DHGx4+FWKfvUmXmJRxIPqLFC+iqdsGt2t4Xy8pWhLy/Zi3ypUFM5bipXP6Ac31m1amb4mAa3GSuWm3ILHjH1A95HVVlNS0Rm7T1oXA4zQ3nyEHOq4dXDGvMi0SMtcAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146823; c=relaxed/simple;
	bh=vJZw2V+dK8uMr29c5aVAPCvxTK4wFhvw3INUtKYWieA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg84FUb1CZRLBiEGcARqmx3szZrtGGDWREfr7Rai44SgLndcrVo8DJhB8CknmHLEAouAYd5jyaq0brItoUmMMmm4gpbwo5RFA2hsYPnFkde/ecKWoT8uUNL/LGQVvyUFbw/QRXKPvckKnV+LWi/0wxDH0HetTPkU1z+O2l5PHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=StpRBFZL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="StpRBFZL"
Received: (qmail 34699 invoked by uid 106); 11 Sep 2026 17:13:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=vJZw2V+dK8uMr29c5aVAPCvxTK4wFhvw3INUtKYWieA=; b=StpRBFZLnkbBkn4TC+WmBnE8n2LNxnuGMlWBHcFDWDwC1t716lo4imeMK5ihdt9dHmoVLXw9RZJnNQBK50LF6ojlD3VxiWWZqN07XeS192kwvWcjTcukOFuaCH5/4L8zljVYSLMH0w3pd3ZjcssTkEOcTQLNuln/vWSCDrlJsFF+/eVjv/S4HJ/CON847zAc4ocrn3i+e0Dj+igvY9DUuP625uFVGRNcnv8y8k6snyiXF2xckL/3ucn0XGGuca0MCOWFcon5SzCx7iuYwBxYI3PC95DDYzkY9SoG0zBuGesxVqsiWUjfLp5pfW6+chyCaN1nevSBpdYsJqIMxUtIVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 17:13:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 173850 invoked by uid 111); 11 Sep 2026 17:13:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 13:13:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 13:13:39 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 3/3] merge-ll: use tempfile API for external driver files
Message-ID: <20260911171339.GC1610200@coredump.intra.peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911171044.GA1609692@coredump.intra.peff.net>

When there's a long(er) running merge driver helper, the user may just
decide to terminate it with Ctrl+C. That sends a signal to the driver
prog and to the whole process group as well, including the git merge
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

Commit-message-stolen-from: Michal Koutný <mkoutny@suse.com>
Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 5a11a9613b..ec0f012b4f 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -17,6 +17,7 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "tempfile.h"
 
 struct ll_merge_driver;
 
@@ -174,15 +175,27 @@ static struct ll_merge_driver ll_merge_drv[] = {
 	{ "union", "built-in union merge", ll_union_merge },
 };
 
-static void create_temp(mmfile_t *src, char *path, size_t len)
+static struct tempfile *create_temp(mmfile_t *src)
 {
-	int fd;
-
-	xsnprintf(path, len, ".merge_file_XXXXXX");
-	fd = xmkstemp(path);
-	if (write_in_full(fd, src->ptr, src->size) < 0 ||
-	    close(fd) < 0)
+	struct tempfile *t = xmks_tempfile(".merge_file_XXXXXX");
+	if (write_in_full(t->fd, src->ptr, src->size) < 0 ||
+	    close_tempfile_gently(t) < 0)
 		die_errno("unable to write temp-file");
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
@@ -197,11 +210,11 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
-	char temp[3][50];
+	struct tempfile *tmp_o, *tmp_a, *tmp_b;
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, i;
+	int status;
 	struct strbuf result_buf = STRBUF_INIT;
 	enum ll_merge_result ret;
 	assert(opts);
@@ -211,19 +224,19 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 
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
@@ -242,13 +255,14 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
 
-	if (strbuf_read_file(&result_buf, temp[1], 0) >= 0) {
+	if (strbuf_read_file(&result_buf, get_tempfile_path(tmp_a), 0) >= 0) {
 		result->size = result_buf.len;
 		result->ptr = strbuf_detach(&result_buf, NULL);
 	}
 
-	for (i = 0; i < 3; i++)
-		unlink_or_warn(temp[i]);
+	delete_tempfile(&tmp_o);
+	delete_tempfile(&tmp_a);
+	delete_tempfile(&tmp_b);
 	strbuf_release(&cmd);
 	if (!status)
 		ret = LL_MERGE_OK;
-- 
2.56.0.rc0.314.g7a874b6915
