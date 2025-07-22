Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574621CFF6
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173663; cv=none; b=mPYo+5p/0utmvfp8pP3g6boVKS93hlxQ+hDXImnxv+ycrGsbOQWk6db9o08YdJX5O454KMH4vFSOB9QAzx3gFxxArTxMZvOJAO/rG/Q26BZDx97VeGHTOzl5xf4/f+eKaBBTT5otcBDf+jF1TiAIz913V/bG9r3XxQ1dJysqAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173663; c=relaxed/simple;
	bh=Pf/uHwC4xqTcr7ysh3CI3tpu2/MGww4SkfKYBsA0CY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6EOzWKXBvJl1hndxFUYyPXmOnJJ77wDPkUQANKB5GxDr7WuEfMjdlGEK/R3nfs62uk+PMf1ZWJIp0AwXCNMdfy2YjTmffadkh6LkuY7BxSFP5XE5sABG53w8CivFYALBspMJCtqKA6oTCahC66IMa4VWGx6DHwgdryVBb5iHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aRJt5ZnC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aRJt5ZnC"
Received: (qmail 26973 invoked by uid 109); 22 Jul 2025 08:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Pf/uHwC4xqTcr7ysh3CI3tpu2/MGww4SkfKYBsA0CY4=; b=aRJt5ZnCT+VHIlgbMTEcAzitGCxEA7wL2aLkmg/ETQ5Wu2rho76FA01+y5pZm/zfjFmMkqAn5C5Q98sfTpvIWTnwWy7CaQ1Q32ecRo0VsxrQGJllbZQ23ELdhaDYbA/T5XWDDHPNJF4Iu0WjpOb6ZtLTKcQKL589iowwnTK0mTn9ImU2cxge1vJI4HLbmKYzd893P9tRQJZCcBr5TZ1Ibq6AaHoSyYZlxGSwNj5aHBJAHmlLs6ez85oHcVWwAZplXFEnH6mrbhwVc4I0JaZlBuJc4XqQjjNZhtzyQ6q+0TC8tsEGmsKuJ9omFIwlyjLbyzlkOlKIxHo6j3WoffD4/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:41:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26794 invoked by uid 111); 22 Jul 2025 08:41:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:41:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:40:59 -0400
From: Jeff King <peff@peff.net>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] t/helper/test-delta: close fd if fstat() fails
 after open()
Message-ID: <20250722084059.GA863857@coredump.intra.peff.net>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
 <20250722081219.1086866-4-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722081219.1086866-4-lhywkd22@gmail.com>

On Tue, Jul 22, 2025 at 08:12:18AM +0000, Hoyoung Lee wrote:

> If open() succeeds but fstat() fails, the file descriptor is not
> closed, causing a resource leak. This patch adds a close(fd) call
> in the failure path after fstat() to ensure proper resource cleanup.
> 
> Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
> ---
>  t/helper/test-delta.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
> index 6bc787a474..103bf7f3e9 100644
> --- a/t/helper/test-delta.c
> +++ b/t/helper/test-delta.c
> @@ -31,6 +31,7 @@ int cmd__delta(int argc, const char **argv)
>  	fd = open(argv[2], O_RDONLY);
>  	if (fd < 0 || fstat(fd, &st)) {
>  		perror(argv[2]);
> +		close(fd);
>  		return 1;

This will result in close(-1) if the open() call failed (rather than the
fstat() call). Not the end of the world, but you do the correct check in
the same function for patch 4.

Since there are two spots here (and it looks like a third for argv[4]
later in the function!), perhaps it would make more sense to attach the
close to the cleanup label, like this:

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..d291d6f02d 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -31,13 +31,12 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[2]);
-		return 1;
+		goto cleanup;
 	}
 	from_size = st.st_size;
 	from_buf = xmalloc(from_size);
 	if (read_in_full(fd, from_buf, from_size) < 0) {
 		perror(argv[2]);
-		close(fd);
 		goto cleanup;
 	}
 	close(fd);
@@ -51,7 +50,6 @@ int cmd__delta(int argc, const char **argv)
 	data_buf = xmalloc(data_size);
 	if (read_in_full(fd, data_buf, data_size) < 0) {
 		perror(argv[3]);
-		close(fd);
 		goto cleanup;
 	}
 	close(fd);
@@ -81,5 +79,8 @@ int cmd__delta(int argc, const char **argv)
 	free(data_buf);
 	free(out_buf);
 
+	if (fd >= 0)
+		close(fd);
+
 	return ret;
 }

It is a little hard to see from just the diff that this always does the
right thing, since we reuse "fd" over and over. But it is OK because we
always close() it right before calling open() again (and never jump to
cleanup in between).

Probably the whole thing would be more readable with three separate
descriptors initialized to -1, but I'm not sure how much effort it is
worth putting into polishing this test helper.

-Peff
