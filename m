Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443418755B
	for <git@vger.kernel.org>; Thu, 30 May 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086654; cv=none; b=qZAFDxdkHer4YeW3VhLk+Z+sbFaY4/9R8HEc6rZbEiFyfvgrNK0x6nC0qUx5wQr1hJflaUtDRpuFHS3X/me1ehTDC2ZO3UDTegdZNsswefc/rbO8Aimm/NdnKF7DyHf11VGvE6OpT6/S3DupGoeW527HhtfWLT+ITP/rqKBqmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086654; c=relaxed/simple;
	bh=6QbnU/6TWMi5FyI+5vvcyFYR4m142hA42FyJG0R3DME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qX4K0Hw6qmyW50ghltWog3qZSNx8Zs6/vq9ys4RGarGFdcc4+em4g/sMAuJJsjzsVW8Ojnmqj7MYnT2vRmu83EyAOjRO7CUoi5OLvbDhz52adR2d6wV82sF24uDcP3ouBwxlFoh5qDk0DbUxjE7qohf/axZnVbTA9MDTkgSNxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OZ5wgeHb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OZ5wgeHb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EF4BC33434;
	Thu, 30 May 2024 12:30:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6QbnU/6TWMi5FyI+5vvcyFYR4m142hA42FyJG0
	R3DME=; b=OZ5wgeHbbEaNUORFCwKM/tcIQ8NMZrp/q3ix9zM+ztbh24sWjgwcZY
	e6gHYT1zTDIFuDnEAIkKKgtFBIvLwjd7nhgApm7zayN9wShcLXxNHRjtP5qAmnL+
	YwgRXq4JjfPZWsACzZSbOqmyERNRffQJohY+R29gjtR1cCS0qLIlc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E738633433;
	Thu, 30 May 2024 12:30:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AF2133432;
	Thu, 30 May 2024 12:30:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/19] imap-send: fix leaking memory in `imap_server_conf`
In-Reply-To: <ZlhjdPkEEwg7Wog7@tanuki> (Patrick Steinhardt's message of "Thu,
	30 May 2024 13:31:00 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<357d69fa8b538baba23cd110b8d16174234a58dc.1716983704.git.ps@pks.im>
	<xmqqle3suymm.fsf@gitster.g> <ZlhjdPkEEwg7Wog7@tanuki>
Date: Thu, 30 May 2024 09:30:47 -0700
Message-ID: <xmqqr0djp8i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F92A01F2-1EA1-11EF-94A8-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Oh, I wasn't aware that the parameter being `NULL` actually causes a
> change in behaviour. Which nicely demonstrates that we have some missing
> test coverage for git-imap-send(1).
>
> In fact, it's not only "some". We don't have any test coverage at all
> for git-imap-send(1) as far as I can see. Which does make me rest a bit
> uneasy. And I suspect that it wouldn't be trivial to add given that it
> kind of requires something that talks IMAP on the receiving end.

Quite honestly, there is absolutely nothing that makes imap-send
necessary to be part of Git suite.  It does depend on Git as it uses
our configuration files to store its knobs, but if it were written
outside the context of the Git project as a handy way to move a draft
message to your imap draft folder, it would have been perfectly fine
as a standalone tool (and it would have used its own simple
configuration file format).

Other than its use of .gitconfig, it does not even know what a
commit is, unlike, say send-email [*], which is also fairly
unrelated to Git proper.

    Side note: send-email is only marginally closer to Git than
    imap-send, as it optionally can run format-patch as a part of
    its operation.  Without the format-patch integration, it is just
    a MUA whose primary purpose is not to munge its payload.

So I do not find it surprising at all that we have no tests for it.
We could do something like this at least, perhaps on top of the
recent topic that added a test to ensure commands that ought to be
operable without any repository?

 t/t1517-outside-repo.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/t/t1517-outside-repo.sh w/t/t1517-outside-repo.sh
index 557808ffa7..6d5f07df93 100755
--- c/t/t1517-outside-repo.sh
+++ w/t/t1517-outside-repo.sh
@@ -56,4 +56,19 @@ test_expect_success 'grep outside repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'imap-send outside repository' '
+	test_config_global imap.host imaps://localhost &&
+	test_config_global imap.folder Drafts &&
+
+	echo nothing to send >expect &&
+	test_must_fail git imap-send -v </dev/null 2>actual &&
+	test_cmp expect actual &&
+
+	(
+		cd non-repo &&
+		test_must_fail git imap-send -v </dev/null 2>../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
