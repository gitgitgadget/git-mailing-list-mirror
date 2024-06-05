Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83D1946AA
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576531; cv=none; b=GoZHV/DZR/ZXJ8+FOiSMxXaWjgjoUWB12HTDtWW7Nc/PckwCidSOhIgc6Qn++f5CF6uToXwtMyno1H+p+kXpDSdg79Kj36YUYXvoKMyZZ7PYSKOgslyEaBZ/Q/r1NRzDQhH++9j1KDtsUwLyJ79zwdgQPzmkgjrS0AL9rU08ol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576531; c=relaxed/simple;
	bh=PCn73QDaIYLPFftnnleS4oMgT4PrOmts0iSgAllsP1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pam1APEinqSHFOhOu1/SNXjZ11OcpL7NTBfR54HPte1/UhsEpa2opqoP6bG0KBkKawERT4BZlTU/cAxbvKE6fsobwdFhi7Sg4iOJH7xa1voiZwhSWSejQNClaJtQKFcg0SI5m7J3vrqrfDE7Xf9OLL+BC4/Y1FAxDJh3UtBNvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24053 invoked by uid 109); 5 Jun 2024 08:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 08:35:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27904 invoked by uid 111); 5 Jun 2024 08:35:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 04:35:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 04:35:26 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
Message-ID: <20240605083526.GB2345232@coredump.intra.peff.net>
References: <xmqqo78h1bdg.fsf@gitster.g>
 <20240604085200.GA1147131@coredump.intra.peff.net>
 <xmqqzfs0tv0b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfs0tv0b.fsf@gitster.g>

On Tue, Jun 04, 2024 at 11:36:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Weirdly, with ps/no-writable-strings merged (but without the fix
> > above applied yet), SANITIZE=leak does not seem to find the leak
> > anymore! Even though I can confirm in a debugger or by printing the
> > strbuf's fields that it is still there. So that's...odd.
> 
> Yeah, that is what had me puzzled ;-)

Interestingly, SANITIZE=address does find the leak. We usually disable
its leak-checking because the leaks get in the way of seeing the more
important output.

It's a little concerning that SANITIZE=leak doesn't catch this case.
Just a wild guess, but I can imagine it might have to do with how LSan
starts its reachability analysis, and that ASan is a bit more careful
about invalidating the now-bogus stack memory. I dunno.

At any rate, in the long run I hope we'll be able to ditch LSan
entirely, once the test suite is leak free. Then we can just let the
regular ASan job report the leaks it finds and a leak gets the same
severity as any other sanitizer error (from the perspective of CI).

> > 	 	if (all_msgs.len == 0) {
> > 	 		fprintf(stderr, "nothing to send\n");
> > 	+		strbuf_release(&all_msgs);
> > 	 		return 1;
> > 	 	}
> > 	 
> > 	 	total = count_messages(&all_msgs);
> > 	 	if (!total) {
> > 	 		fprintf(stderr, "no messages to send\n");
> > 	 		return 1;
> > 	 	}
> >
> > But I wonder if strbuf_read() should handle the allocation itself when
> > it does a 0-byte read. We already do so for an error return (so the
> > "could not read from stdin" path above is actually OK).
> 
> Thanks.

I see you applied this on top of t1517 to fix the broken CI. That makes
sense (though did give me a moment of head-scratching when I tried to
reproduce my ASan findings using next!).

I do think it's the wrong fix in the long term, and we'd want a patch
like this on top of the merge of jc/t1517-more and ps/no-writable-strings.

-- >8 --
Subject: [PATCH] imap-send: free all_msgs strbuf in "out" label

We read stdin into a strbuf, but most code paths never release it,
causing a leak (albeit a minor one, as we leak only when exiting from
the main function of the program).

Commit 56f4f4a29d (imap-send: minimum leakfix, 2024-06-04) did the
minimum to plug the one instance we see in the test suite, when we read
an empty input. But it was sufficient only because aside from this noop
invocation, we don't test imap-send at all!

The right spot to free is in the "out" label, which is hit by all code
paths before leaving the function. We couldn't do that in 56f4f4a29d
because there was no unified exit path. That came separately in
3aca5f7fb0 (imap-send: fix leaking memory in `imap_server_conf`,
2024-06-04), which cleaned up many other leaks (but not this one).

Signed-off-by: Jeff King <peff@peff.net>
---
An alternative universe version of this one just fixes the leak in the
"out" label without removing the call added by jc/t1517-more, and could
be applied directly onto ps/no-writable-strings. But then we'd want to
remember to remove the redundant one once the two topics are merged.

This one is a little hassle to apply, but it feels worth it to capture
the right fix while we're thinking about it (though of course I still
dream of nuking imap-send.c from orbit).

 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index e602edc4be..01404e5047 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1555,7 +1555,6 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (all_msgs.len == 0) {
-		strbuf_release(&all_msgs);
 		fprintf(stderr, "nothing to send\n");
 		ret = 1;
 		goto out;
@@ -1586,5 +1585,6 @@ int cmd_main(int argc, const char **argv)
 	free(server.user);
 	free(server.pass);
 	free(server.auth_method);
+	strbuf_release(&all_msgs);
 	return ret;
 }
-- 
2.45.2.807.g3b5fadc4da

