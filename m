Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9F3FE36C
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712699; cv=none; b=clb5rx/XV/yZT/jYp9sk+781BQnlp+vZQW1RNyl+AGBVAOYJJ4xQo1vdTlQN+nBj4tBHZ3US9yC/43ev1gFFQ+0oIPGIKAnrMVNQ2Am/twfG4bHfEI1BX1QYZGiYBBxQBVhdt5lYY6bGNOKVC+x4m829M5aSfHng4jC4pz5rv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712699; c=relaxed/simple;
	bh=b4sl+p/D+P2n65+MFVypstKbbv3xdPy7AtMWXLTTRIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXZ73YWmc+cN1Y617QpwsoGYeNJ8tJm3mOOBLnsSTp5oE/7ANVSPmQ4b9wc5QeRFt91a634ZN1s2Jg2l4Uo9KEn11Bpwh/JGDhwxKUvJRBDLil7cK0Vsdd1tO5Xd/+nr7HsURY//QlGcVfSgsiQy01WDOoxp7YGQbM9K0iSD+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y5715Ivh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y5715Ivh"
Received: (qmail 1336 invoked by uid 106); 29 Sep 2026 20:11:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=b4sl+p/D+P2n65+MFVypstKbbv3xdPy7AtMWXLTTRIs=; b=Y5715IvhO0DSKGAMVm8FcAGOQ2hP/6sVH9bqtaro9Xk+fBlqJOJsZ5S5hLWt4s11ivFMkphzAdtTCk6m9V/qr/6Jnyr8sC6HGmoN1BlqlbKakPYWrUmQ9TAVvBTNnCiX1B73hsGXUz2O8FI2Mr+btndM/0PTZ4UcOpkwfXyryT+NZeed8XPdbnG7l7FpfFhPLSKmyO1AbITFjkz6QNpp5VDc71JYqMgZK9pQCJWJ64+6yO2ivrLANX8nZP5bUnzCeXOPJLIogwj6g8mYblH/+9TG8TCPZe/4iPJCZf0wd1YyRM7Ftgz7DcI1OIG03/XgxkPnrtMWWRkKOleBv6NF5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 20:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3329 invoked by uid 111); 29 Sep 2026 20:11:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 16:11:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 16:11:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <20260929201134.GA1713437@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065442.GD1697497@coredump.intra.peff.net>
 <xmqqzewzg8w0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzewzg8w0.fsf@gitster.g>

On Tue, Sep 29, 2026 at 12:22:39PM -0700, Junio C Hamano wrote:

> > +	/* We can ignore errors; result is left NULL/0 in that case. */
> > +	read_mmfile(result, temp[1]);
> > +
> >  	for (i = 0; i < 3; i++)
> >  		unlink_or_warn(temp[i]);
> >  	strbuf_release(&cmd);
> 
> Lets see if I understand why we can safely ignore errors.
> 
> If the external driver claims that it successfully merged (i.e.,
> status = run_command(&child) returns 0), and yet read_mmfile() fails
> (e.g., perhaps the driver unlinks "%A"), read_mmfile() will leave
> result->ptr and result->size as initialized, and we return
> LL_MERGE_OK from this function.  The result is eventually relayed to
> the caller of ll_merge(), like merge-ort.c:merge_3way(), or
> apply.c:three_way_merge().  Both have something like
> 
> 	status = ll_merge(&result, path,
> 			  &base_file, "base",
> 			  &our_file, "ours",
> 			  &their_file, "theirs",
> 			  state->repo->index,
> 			  &merge_opts);
> 	if (status == LL_MERGE_BINARY_CONFLICT)
> 		warning("Cannot merge binary files: %s (%s vs. %s)",
> 			path, "ours", "theirs");
> 	free(base_file.ptr);
> 	free(our_file.ptr);
> 	free(their_file.ptr);
> 	if (status < 0 || !result.ptr) {
> 		free(result.ptr);
> 		return -1;
> 	}
> 
> to treat that result.ptr==NULL is just as bad as any error from
> ll_merge() (i.e., status < 0).

Yeah, exactly. This confused me quite a bit at first, and I thought I'd
found another bug. It feels like we should return LL_MERGE_ERROR for
this case (it is not the external merge driver's error, but rather ours,
but from the caller's perspective does it matter?).

But then I saw that the callers did check for NULL already (which is
what the existing code reliably returned on error). So there's no bug,
but I agree it's subtle. For the purposes of this refactor I tried to
draw the line at retaining the same visible behavior from
ll_ext_merge(), just to keep scope creep to a minimum.

But I'm definitely not opposed to refactoring further on top, and I
think you may have actually found a bug below.

> merge-blobs.c:merge_blobs() does not check the !result.ptr
> condition, and its sole caller builtin/merge-tree.c:result() passes
> the NULL to show_diff(), which uses a <NULL, 0> mmfile_t as one side
> of xdi_diff(), which the callee is prepared to handle, so this is OK.
> 
> rerere.c:try_merge() does not check the !result.ptr condition, and
> its caller rerere.c:merge() ends up calling
> 
> 	fwrite(NULL, (size_t)0, 1, f)
> 
> which may happen to work on most systems, but is not exactly kosher.

Even if it works and sends an empty output, I think it is the wrong
behavior. It's possible the driver actually returned a real output, but
we failed to read it in. And now we're propagating a bogus empty value
instead.

It's hard to test, though, because the easiest way to trigger a read
failure is for the driver to actually _not_ return an output (i.e., to
delete the %A file). And in that case it happens to coincide with the
correct behavior. ;)

I guess a more interesting one is one where the driver changes the mode
on %A so that it cannot be read.

We can trigger that case like this:

-- >8 --
git init

echo base >file
git add file
git commit -am base

git checkout -b one
echo one >file
git commit -am one

git checkout -b two HEAD^
echo two >file
git commit -am two

git config merge.foo.driver 'echo result >%A; chmod 0 %A'
echo 'file merge=foo' >.gitattributes

git merge one
-- 8< --

But I'm not sure how to convince rerere to work on it. The merge command
produces output like:

  error: Could not open /home/peff/tmp/repo/.merge_file_ma1Kcq: Permission denied
  error: failed to execute internal merge for file
  Merge with strategy ort failed.

which is reasonable (probably mentioning the external driver would be
better still, but at least we notice the problem).

I guess to confuse rerere we probably have to do a regular merge, record
the result, and then configure our broken driver, and then try to merge
to run rerere on the result.

So if we amend the end of that script to:

-- >8 --
# merge that records resolution (we abort here, but it
# could just be that we create the same merge elsewhere)
git -c rerere.enabled=true merge one
echo result >file
git rerere
git reset --hard

# now we merge in a way that creates the conflict again
git -c rerere.enabled=false merge one

# but then in the middle we start using the broken driver
git config merge.foo.driver 'echo result >%A; chmod 0 %A'
echo 'file merge=foo' >.gitattributes

# and now rerere gets confused; we claim to use the recorded
# resolution, but it's incorrectly empty
git rerere
-- 8< --

That sequence is quite fishy (changing the attributes mid-merge!?) but
in theory it could trigger racily due to a system error, fread()
failing, and so on.

> Perhaps something like this on top might make it safer?  Not even
> compile tested and I haven't thought through the ramifications to
> rerere.c:merge() code path, that used to take such a bogus merge
> result as successful merge and relied on the fwrite(NULL) becoming
> a no-op to produce an empty file.

This does fix the case above (modulo some s/./->/ in your patch). We end
up with the unresolved contents in "file".

> +	if (!result_buf.ptr && result == LL_MERGE_OK) {
> +		/*
> +		 * Forbid the driver from giving bogus result and claim
> +		 * that the merge succeeded.
> +		 */
> +		result = LL_MERGE_ERROR;
> +		result_buf.size = 0;
> +	}

I had imagined just fixing this in ll_ext_merge(), like:

diff --git a/merge-ll.c b/merge-ll.c
index 7fab7c5438..0e56e303fa 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -241,8 +241,13 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
 
-	/* We can ignore errors; result is left NULL/0 in that case. */
-	read_mmfile(result, temp[1]);
+	/*
+	 * fake a driver error when we can't read the result; a slightly more
+	 * elegant solution is to hoist the status-to-ret conversion from
+	 * below, and then we can directly assign ret = LL_MERGE_ERROR.
+	 */
+	if (read_mmfile(result, temp[1]) < 0)
+		status = 129;
 
 	for (i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);

which reduces the weirdness coming out of that function. But it wouldn't
help with other drivers (which may or may not have similar problems? I'd
guess not, since they are all operating internally).

-Peff
