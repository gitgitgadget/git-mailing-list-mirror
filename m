Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D64199FAB
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775371615; cv=none; b=m+lOhA2kvpKMSLnqasbhlP0cCIvLWargzl7fY2uN/berzJA5FCOzUebehEiJDuWT8kW6eEWazA2t+Kb+4JRlS754vUBK8hPQlmyMGzNCFxswUqVyi08E220ToNVCEMFmijcI9xN65whbsv7OUnwrHDp+Z7jXzI7WjWKWn0tc+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775371615; c=relaxed/simple;
	bh=r1ZtfHjHGVH3+gm6860ukDqVf8VFFfwutcOVkAh4LrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApbDGxZ8zxx22TeFmeBDibq3oNfdaEYa/UJqIHxr55QixTpAtmo7AbNNRQY10ntvw9Msr7rblQGGMtRN2POwc4bdWXiJdGAIWuOiK22ZBpJCv5iWLSOwukutVhs6nvXtU9o8yIlbljasFDUWhiebo/JtG2sqK3SsEYSebPA8OTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NbQQgvoG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NbQQgvoG"
Received: (qmail 251037 invoked by uid 106); 5 Apr 2026 06:46:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=r1ZtfHjHGVH3+gm6860ukDqVf8VFFfwutcOVkAh4LrU=; b=NbQQgvoGKVrcputfvg/hCJktbuuo6j4jxG3PvV89B2wUXjIffS8cWotuNGAOMCvnD2PJBInFwOH3wPQNBGmxYwCG0r7pOgPtpWQt619I5G1EbsqutmYP8c8aSpPHeN4gB/7hRAJ2p+9HBwpVLvmU2uxWgkvPs38DjVTuLzyGMwZf4C6qeTElThMdn0sl+peQS+6cLqeg/L2rMb9c1Zgnq9uyNyNc9/8KlN79UEai5AT339QYu344+/0SSfOJFyvu6Hsr8M80D2ZWmNqJnA4uuiU1rTJIB3GN3Fw8bRW6v4Q2F53bCCW2c716DWH9HlKGvYFxLh+2NC+mbdV8nJz6Uw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Apr 2026 06:46:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 403136 invoked by uid 111); 5 Apr 2026 06:46:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2026 02:46:52 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Apr 2026 02:46:51 -0400
From: Jeff King <peff@peff.net>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: git@vger.kernel.org, cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <20260405064651.GA1452907@coredump.intra.peff.net>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>

On Sat, Apr 04, 2026 at 07:28:17PM +0200, Luca Stefani wrote:

> When running `git diff -- $file1 $file2' on large enough files,
> index_fd() attempts to use 'the_repository->objects', assuming it
> is initialized, but that's not the case for non-repository usecases.
> 
> When git diff is invoked without a backing repository,
> INDEX_WRITE_OBJECT is never set in flags, meaning only the hash is
> needed and nothing should be written to the object store.
> 
> Enforce the use of index_core() in this case.

I don't think we want to use index_core() for a large file, though. A
test like this:

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 15076dfe0d..7ef5604430 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -413,4 +413,10 @@ test_expect_success 'diff --no-index with pathspec glob and exclude' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index on a huge file' '
+	dd if=/dev/zero bs=1M count=4000 >big.file &&
+	echo whatever >small.file &&
+	test_expect_code 1 git diff --no-index big.file small.file
+'
+
 test_done


will now fail on a 32-bit system, because we try to mmap the whole file,
which will fail.  We really do want to follow the streaming code path
(which knows to respect the lack of a WRITE_OBJECT flag and works
without an odb in that case).

It's kind of an expensive test, though, so we probably don't want to
actually include it in the test suite.

-Peff

PS I'd expect a 4GB+ file to work, too, but it looks like the diff code
   barfs when trying to stuff the file into a diff_filespec. A simpler
   example is:

     dd if=/dev/zero bs=1G count=5 >big.file
     git hash-object big.file

   but that dies, too! It looks like the streaming helper uses a size_t
   to take the size, which is wrong. It really should be an off_t. So I
   dunno, maybe nobody cares about ever working with 4GB files on 32-bit
   systems these days. It still feels like we should avoid a large mmap,
   though.
