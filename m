Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C44DC552
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057366; cv=none; b=Z660J43iLLuoubhgLSyRO6v1eqEAqDKme0Rsk1uQAdnrOeKMZatkfLEIL/m0PcN5JAcX3SI2imAE3oq8hjhweUM0GZZoW1oIBEBRVJRI8ynSD5GdeuxJpXoQd58zsyHjaLKTUChjJNON5DBOxoK5wso1eDS/f85JDSMLDWw0FBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057366; c=relaxed/simple;
	bh=JKeonpLQWKdbBtoky8uQB5f7Jsjx21F26E4iIgki9EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoUALZSByucoyV1+RruU5lC8DQKHTWI+1sVRRHXEoU0tCGYrGGZaGW4ZU5U41iDFFnlK7G8E6wImXL0gcQ9+b82gENpyLgY6I7Uy3y9Rr0meUY8EDpcuWI2OLp5dbnv098gXL+iMpQUQaoMK++D2a+ukZ6ND6gc3tSNZJ+h8fcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=goQGho5+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="goQGho5+"
Received: (qmail 31206 invoked by uid 106); 10 Sep 2026 16:22:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=JKeonpLQWKdbBtoky8uQB5f7Jsjx21F26E4iIgki9EA=; b=goQGho5+0D++HJFzqSpCVmkJrrWWpfr8BpOxQ66g48XpluEJJO4eQ+HwRTS+V6B90VkPl0I/DZabtHcfApgOk56NO7Ifr+mhlcu4sxu9Mw5wmRjkKVGSEpdicuYfq7PR0NcwQHSL0WeYKXT1X2H5oSiNV3Ex+trB0NnFjc0lxRlBEI55xkLSFMZbeezAyhmqIYerPvhmG51ZttOvk+bcOLwnexP3LY58PiQn61CLaTuJQ3pyodGmOEb8FIXlsUy+4TBIZXNE/0iLqXOKeYxSR6KPxENEA2myeMa3ujk9iUkAZ2b4ARMY4Fg/MG6HDAKprxc7fh01kIeo/veO0YFhYA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 16:22:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157407 invoked by uid 111); 10 Sep 2026 16:22:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 12:22:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 12:22:42 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] merge-ll: Cleanup merge driver temporaries after
 interrupt
Message-ID: <20260910162242.GC251185@coredump.intra.peff.net>
References: <20260910150608.1867930-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910150608.1867930-1-mkoutny@suse.com>

On Thu, Sep 10, 2026 at 05:06:07PM +0200, Michal Koutný wrote:

> When there's a long(er) running merge driver helper, the user may just
> decide to terminate it with Ctrl+C. That sends a signal to the driver
> prog and to the whole process group as well, including the git merge
> command proper. Hence the cleanup code would not run and .merge_file_*
> files are left behind.
> 
> Transfer the idiom [1] from editor.c where the (process group) signal
> delivery is approximated from the return code of the child process and
> do the cleanup before going for good.

We have a temporary-file cleanup handler that we install already, which
handles signal propagation, atomicity, etc. It seems like it would be
simpler to just use that.

In the worst case we can just call register_tempfile() on each path, but
I think this code could be taught to use the actual creation. Something
like the patch below (only lightly tested).

---
diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..d53f0fe4a6 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -17,6 +17,7 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "tempfile.h"
 
 struct ll_merge_driver;
 
@@ -174,15 +175,30 @@ static struct ll_merge_driver ll_merge_drv[] = {
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
+	struct tempfile *t = xmks_tempfile(".merge_file_XXXXXX");
+	if (write_in_full(t->fd, src->ptr, src->size) < 0)
 		die_errno("unable to write temp-file");
-	close(fd);
+	close(t->fd);
+	return t;
+}
+
+static const char *get_temp_path(struct tempfile *t)
+{
+	/*
+	 * Tempfiles store the absolute path of the file, but
+	 * we don't do any quoting against the shell, which
+	 * can lead to problems if your path has spaces, etc, in it.
+	 * Historically this was OK since we only provided relative
+	 * paths which were fairly vanilla.
+	 *
+	 * We can work around it by going back to the relative path (since we
+	 * know we created a tempfile in the cwd via create_temp() above).
+	 * In the long run I think we ought to consider providing
+	 * the absolute paths but correctly shell-quoting them.
+	 */
+	return basename(get_tempfile_path(t));
 }
 
 /*
@@ -197,11 +213,11 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
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
@@ -211,19 +227,19 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 
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
+			strbuf_addstr(&cmd, get_temp_path(tmp_o));
 		else if (skip_prefix(format, "A", &format))
-			strbuf_addstr(&cmd, temp[1]);
+			strbuf_addstr(&cmd, get_temp_path(tmp_a));
 		else if (skip_prefix(format, "B", &format))
-			strbuf_addstr(&cmd, temp[2]);
+			strbuf_addstr(&cmd, get_temp_path(tmp_b));
 		else if (skip_prefix(format, "L", &format))
 			strbuf_addf(&cmd, "%d", marker_size);
 		else if (skip_prefix(format, "P", &format))
@@ -241,7 +257,8 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	child.use_shell = 1;
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
-	fd = open(temp[1], O_RDONLY);
+	/* really feels like we could just use strbuf_read_file() here? */
+	fd = open(get_tempfile_path(tmp_a), O_RDONLY);
 	if (fd < 0)
 		goto bad;
 	if (fstat(fd, &st))
@@ -255,8 +272,9 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
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
