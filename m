Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0B233721
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658730; cv=none; b=qAWDhn3fUattJ6xC+RXK2VTCtWgQY/IRkMPv3DHtjUNiIvbkRqTHG0xhUG9C2sygQ/uz7zED3B50vJbgyI4jRH1WZHq+yWrZFfOSTjHcxQbU/HzEHwNrIKrL9RXwb18Hqrw5SZoVeXsLDTswuA5m2qRxBtnVVoJUrRs05oabD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658730; c=relaxed/simple;
	bh=ETKzpQY6HaDDybrpY1Hpuv50ExdYGXREYh8jkYJTor0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxIp6HYql028SGVKu5+PA1UA8udpEym8jWA/bgM2UYp+PjIW1vI+snALyFfXHzL2qt5znvebzl28LtBoiW3U40T5K8YnrALpIrtCUsl0hWCMzwCMlYS6a/sQm4VKEBrQ1oe/K0n6FU7EYU6f+rXsCwEHBKJCdeKQI5BdZz2Kgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h9zckard; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h9zckard"
Received: (qmail 69110 invoked by uid 106); 29 Sep 2026 05:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ETKzpQY6HaDDybrpY1Hpuv50ExdYGXREYh8jkYJTor0=; b=h9zckardk/RHji9bDks7y8usOqBixrRnU8VPMnB4FCLLlQOdVJ47IO/ojD5Ni4QCl16/1rafO50DnhTVDs89iyIDB3QGHl2zSEbJbx/DequQ1FrFH9gwCbtlhe946hUzgUKvmM8g9Hpy1l8ybr7TUGcBXY1k1CzgzABYxJhW1pZDgZJVUKHImiXCT4SPOoi6LwHCO/soAUEZfSRLfS9hUjJ4bSYZ7gtY5zltxMUGWd/slzmNh8JetYRT0xyiFxKQb0vSu+hh1ySpnYd8WxbQSR2ZWqHJmNWD8pPVuvaD2UcQ2oSMUri0dV2mI5uoGRD1EW0fJnhwsqOjkV99TZ5p0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 05:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 288241 invoked by uid 111); 29 Sep 2026 05:12:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 01:12:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 01:12:00 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 0/2] merge-ll: Cleanup merge driver temporaries after
 signal
Message-ID: <20260929051200.GA1100000@coredump.intra.peff.net>
References: <20260910150608.1867930-1-mkoutny@suse.com>
 <20260910162242.GC251185@coredump.intra.peff.net>
 <aqQN_Q6ZAeyTy7WA@localhost.localdomain>
 <20260911171044.GA1609692@coredump.intra.peff.net>
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

Here's a revised version of the series to switch merge-ll to use
tempfile structs. Sorry, I got derailed a bit by travel.

I dropped the v2 cleanup patch to use strbuf_read() for now. It was not
strictly related and I think there's a bit of a rabbit hole that extends
even beyond this function. That might become its own series later.

Beyond that, this is mostly the same as v2. I tweaked the error-checking
for close() in the first patch so that it's more obviously correct (and
can produce a slightly more informative message).

The range diff is below, though it's IMHO not very informative. The
drop of the cleanup patch a lot of uninteresting textual ripples.

  [1/2]: merge-ll: catch close() errors when writing external tempfiles
  [2/2]: merge-ll: use tempfile API for external driver files

 merge-ll.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

1:  62b4ac5ae0 < -:  ---------- merge-ll: use strbuf to read back external merge result
2:  020e3bfcbd < -:  ---------- merge-ll: catch close() errors when writing external tempfiles
-:  ---------- > 1:  c6a4b3146d merge-ll: catch close() errors when writing external tempfiles
3:  914fafcd88 ! 2:  b85e169cb3 merge-ll: use tempfile API for external driver files
    @@ Commit message
     
         When there's a long(er) running merge driver helper, the user may just
         decide to terminate it with Ctrl+C. That sends a signal to the driver
    -    prog and to the whole process group as well, including the git merge
    +    program and to the whole process group as well, including the git merge
         command proper. Hence the cleanup code would not run and .merge_file_*
         files are left behind.
     
    @@ Commit message
         So let's take the most conservative route, and just continue reporting
         the relative paths.
     
    -    Commit-message-stolen-from: Michal Koutný <mkoutny@suse.com>
         Reported-by: Jean Delvare <jdelvare@suse.de>
    +    Reported-by: Michal Koutný <mkoutny@suse.com>
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## merge-ll.c ##
    @@ merge-ll.c: static struct ll_merge_driver ll_merge_drv[] = {
     -
     -	xsnprintf(path, len, ".merge_file_XXXXXX");
     -	fd = xmkstemp(path);
    --	if (write_in_full(fd, src->ptr, src->size) < 0 ||
    --	    close(fd) < 0)
    +-	if (write_in_full(fd, src->ptr, src->size) < 0)
    +-		die_errno(_("unable to write %s"), path);
    +-	if (close(fd) < 0)
    +-		die_errno(_("unable to close %s"), path);
     +	struct tempfile *t = xmks_tempfile(".merge_file_XXXXXX");
    -+	if (write_in_full(t->fd, src->ptr, src->size) < 0 ||
    -+	    close_tempfile_gently(t) < 0)
    - 		die_errno("unable to write temp-file");
    ++	if (write_in_full(t->fd, src->ptr, src->size) < 0)
    ++		die_errno(_("unable to write %s"), get_tempfile_path(t));
    ++	if (close_tempfile_gently(t) < 0)
    ++		die_errno(_("unable to close %s"), get_tempfile_path(t));
     +	return t;
     +}
     +
    @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_drive
      	struct strbuf cmd = STRBUF_INIT;
      	const char *format = fn->cmdline;
      	struct child_process child = CHILD_PROCESS_INIT;
    --	int status, i;
    -+	int status;
    - 	struct strbuf result_buf = STRBUF_INIT;
    +-	int status, fd, i;
    ++	int status, fd;
    + 	struct stat st;
      	enum ll_merge_result ret;
      	assert(opts);
     @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
    @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_drive
      			strbuf_addf(&cmd, "%d", marker_size);
      		else if (skip_prefix(format, "P", &format))
     @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
    + 	child.use_shell = 1;
      	strvec_push(&child.args, cmd.buf);
      	status = run_command(&child);
    - 
    --	if (strbuf_read_file(&result_buf, temp[1], 0) >= 0) {
    -+	if (strbuf_read_file(&result_buf, get_tempfile_path(tmp_a), 0) >= 0) {
    - 		result->size = result_buf.len;
    - 		result->ptr = strbuf_detach(&result_buf, NULL);
    - 	}
    - 
    +-	fd = open(temp[1], O_RDONLY);
    ++	fd = open(get_tempfile_path(tmp_a), O_RDONLY);
    + 	if (fd < 0)
    + 		goto bad;
    + 	if (fstat(fd, &st))
    +@@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
    +  close_bad:
    + 	close(fd);
    +  bad:
     -	for (i = 0; i < 3; i++)
     -		unlink_or_warn(temp[i]);
     +	delete_tempfile(&tmp_o);
