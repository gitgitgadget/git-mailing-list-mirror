Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199114372E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491130; cv=none; b=HZ9s4VXltWM0uAmrIVbVomVaHFcV2asly5P2ny+uz11RNTyqoWoJLtQe1t7VCb30u4gVTXI229ebOHd26XKSWGZKJY/+qJ27uG81g6l118/q4id4dYGUYu2FYHU/DsyfPXii0JgxYfqJRDVIAp1QnZp0zDvwBWQAqsrqlSxAeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491130; c=relaxed/simple;
	bh=RGHkn0+9z3J4Gq6naXMTAxLMgWmeohQ0fWxVg7rInOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlGT3lLUzTj8dUnrKdCA+jvYsRdBGRCpFQQWGo15D3Nhsvw4O4EFlKjCMDVhssVgmKWMRvJRsgpM523o0m3DCWI6CEeUHJCuA1MQGjsNpUXYFEu/lbMUchRheOdauKOSaPqLedjrLUcQFlzH3ExUmFKMMv8tzgnQXGe2ChTQzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20719 invoked by uid 109); 4 Jun 2024 08:52:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 08:52:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17833 invoked by uid 111); 4 Jun 2024 08:51:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 04:51:59 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 04:52:00 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
Message-ID: <20240604085200.GA1147131@coredump.intra.peff.net>
References: <xmqqo78h1bdg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo78h1bdg.fsf@gitster.g>

On Mon, Jun 03, 2024 at 11:16:11PM -0700, Junio C Hamano wrote:

> * jc/t1517-more (2024-05-31) 1 commit
>   (merged to 'next' on 2024-06-03 at 10b71e2a60)
>  + t1517: more coverage for commands that work without repository
> 
>  "smoke tests" to ensure git commands that are designed to run
>  outside repositories do work.
> 
>  Will merge to 'master'.
>  source: <xmqqwmnajrrk.fsf@gitster.g>

This one seems to fail the CI leak jobs (I noticed it on next, but I
think even the tip of the feature branch fails).

One possible fix is this:

	diff --git a/imap-send.c b/imap-send.c
	index a5d1510180..26d5909e79 100644
	--- a/imap-send.c
	+++ b/imap-send.c
	@@ -1539,16 +1539,17 @@ int cmd_main(int argc, const char **argv)
	 	/* read the messages */
	 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
	 		error_errno(_("could not read from stdin"));
	 		return 1;
	 	}
	 
	 	if (all_msgs.len == 0) {
	 		fprintf(stderr, "nothing to send\n");
	+		strbuf_release(&all_msgs);
	 		return 1;
	 	}
	 
	 	total = count_messages(&all_msgs);
	 	if (!total) {
	 		fprintf(stderr, "no messages to send\n");
	 		return 1;
	 	}

But I wonder if strbuf_read() should handle the allocation itself when
it does a 0-byte read. We already do so for an error return (so the
"could not read from stdin" path above is actually OK).

Maybe a moot point, though. I think we _always_ leak the all_msgs
strbuf, so probably the whole function needs more unified cleanup. It
looks like Patrick's 11637fc740 (imap-send: fix leaking memory in
`imap_server_conf`, 2024-06-03) does that refactoring (but isn't yet in
'next'). Once ps/no-writable-strings is merged, we should be able to
just do:

diff --git a/imap-send.c b/imap-send.c
index da3e7ec17e..01404e5047 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1585,5 +1585,6 @@ int cmd_main(int argc, const char **argv)
 	free(server.user);
 	free(server.pass);
 	free(server.auth_method);
+	strbuf_release(&all_msgs);
 	return ret;
 }

on top. Weirdly, with ps/no-writable-strings merged (but without the fix
above applied yet), SANITIZE=leak does not seem to find the leak
anymore! Even though I can confirm in a debugger or by printing the
strbuf's fields that it is still there. So that's...odd. But whatever is
going on with LSan, the fix above is the right thing.

-Peff
