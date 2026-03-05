Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBB361DC3
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748139; cv=none; b=QrfmWRoJJJ/kGyR5SLwehPriS/rC43kvmEInetqfhiVzFOTDVmOe8FXI/S9X88SNGlXnHY8MiCWCWnlA0Yca+MC+5fR2A8816uBVZs5TqXgFLEvGRPqqkpIGaj1UDhLQHnA4ImByHBOFrTAjES8vtkIgRQt524iLbAgsqFrqEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748139; c=relaxed/simple;
	bh=Oa/mJq5EJKEu2XYt+Yt1iDpg+JmqNUPi9LvHBAJ9fVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKQTNMRlv86Dt9dy69pYv2tgRg6JF1LzZSL+Nq5EgCTTyNc6R2wXGGP6lrJ5Z+dYVxhBPVFN+WIosSToRvhsVFO+Z0zxwqH6m2JtW2T55GYLniXwkCjuasL5acpYHtxcGm7/XDG6vKjkxV5VNxfzh59B+JixGdh+86+AWOG3aKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LNddzo4x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LNddzo4x"
Received: (qmail 2400 invoked by uid 106); 5 Mar 2026 22:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Oa/mJq5EJKEu2XYt+Yt1iDpg+JmqNUPi9LvHBAJ9fVQ=; b=LNddzo4x6RvNGQn6F8f6ZWw9jKnb9ittIGDckJWnFBfTNJRzTfoYe7dA4rcpt3wTM3Z7Tu1iYGdBrwZcMLRNFtKNE/ZLlO1rrya6dgptjWvJKJPoY9Zbbow5yrIL8TV8DJM3Crde5+Uzb2C6IRfYOodiA94j58ePxTKIF4Cb6w1eZ4sjXDMn/F6y0HagvG+ZyrB1LKyAcUE041rQ+DNkGuVEv4KD0+krDYiJYCx3B9xHQZ76x+CkQfJs7YjUQ+1EH2JgE3s8P79ExJ6JVVmhg4NDV8RJTpXbIkV1B0WbJLbIe+vmwRtCiZz/Y2kM2b6CvnfA6jvKLyjvzwvlwvIayw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 22:02:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 392554 invoked by uid 111); 5 Mar 2026 22:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 17:02:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 17:02:14 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: Re: memory leak when cloning a repository
Message-ID: <20260305220214.GB736322@coredump.intra.peff.net>
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>

On Thu, Mar 05, 2026 at 12:51:17PM -0800, Jacob Keller wrote:

> I tried digging into why this leak occurs but so far I don't have a good idea.
> 
> This happens when running on next: 7842e34a6654 ("Sync with 'master'")

I can reproduce it on master. This seems to fix it:

diff --git a/connected.c b/connected.c
index 79403108dd..e0f8ff38cb 100644
--- a/connected.c
+++ b/connected.c
@@ -90,6 +90,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
+		close_pack(new_pack);
 		free(new_pack);
 		return 0;
 	}
@@ -128,6 +129,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		rev_list.no_stderr = opt->quiet;
 
 	if (start_command(&rev_list)) {
+		close_pack(new_pack);
 		free(new_pack);
 		return error(_("Could not run 'git rev-list'"));
 	}
@@ -162,6 +164,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
+	close_pack(new_pack);
 	free(new_pack);
 	return finish_command(&rev_list) || err;
 }


I think this has been leaky forever, but it's usually leaking a single
mmap, so nobody notices. But I noticed something odd about your trace:

> Direct leak of 27168 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0e100e6f2b in malloc (/lib64/libasan.so.8+0xe6f2b) (BuildId: 25975f766867e9e604dc5a71a8befeaed3301942)
>     #1 0x00000122ab77 in git_mmap ../compat/mmap.c:15
>     #2 0x000001169466 in xmmap_gently ../wrapper.c:884
>     #3 0x00000116959b in xmmap ../wrapper.c:907
>     #4 0x000000d168fd in check_packed_git_idx ../packfile.c:179
>     #5 0x000000d16cce in open_pack_index ../packfile.c:282
>     #6 0x000000d25273 in find_pack_entry_one ../packfile.c:2078
>     #7 0x00000099f969 in check_connected ../connected.c:148

We're in the compat git_mmap, which implies you're building with
NO_MMAP. We turn that on automatically when building with ASan (so that
we can detect single-byte overflows even when mmap would round up to a
page boundary). But as a side effect, the "mmap" for index and pack data
is done with a heap-allocated buffer. So now ASan/LSan will notice and
complain about it.

We usually disable leak-checking for our ASan builds, so we wouldn't run
the tests with the compat mmap. And our leak-checking builds use LSan,
which doesn't set NO_MMAP. But if you combine them with:

  make SANITIZE=address,leak

or even just build with:

  make NO_MMAP=MallocHarder SANITIZE=leak

then the leak will be reported. I guess maybe you're building with
SANITIZE=address, but then running the result independently, without
setting ASAN_OPTIONS=detect_leaks=0.

Anyway, I think the solution is probably something like the patch above,
though probably it needs to cover the case where new_pack is NULL.

-Peff
