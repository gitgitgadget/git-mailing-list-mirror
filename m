Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640F2DF136
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669436; cv=none; b=ayFI0cnkyDtDj16W9jf02T/3XByx/uDAc2u6u3LFUv3k9dcwMk/ss7CPCi1sojcifNkjr2zBSFXDI5LX+rOn0ZJ1c8OaWDC46nxmFYSsVcjIZKk9OogxKaMGRAHliEwAu9+EUgO2YCLuRxkdGx2F4907irEtcgQl0lPHr/WDSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669436; c=relaxed/simple;
	bh=w465xCzNs3lRCEDCCveCOLRQKFruLeBSDBewry3F0iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHJYbXSz2D39FQz1Nb/sbIVpU7AK8OjQ1ftassxoFilomz5y5SS6j2VUcS1v2QreZK/UwvKAgFLuOKRTEXNkc8OEEwJhtIvflQuti5C+JuWOpc5ItSXKrp+WQB+oQJehiAnaJAmE9hijSgVtGH0wZcQOiZzP42zP8MdvWNek8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UwpGcJc8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UwpGcJc8"
Received: (qmail 283961 invoked by uid 106); 8 Apr 2026 17:30:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=w465xCzNs3lRCEDCCveCOLRQKFruLeBSDBewry3F0iU=; b=UwpGcJc8mGZTx/LZsXXx7cUMst7iyHsgwghpB4/HVDk2/n2JQRKNCnqILctDE+iasCesFGHKErkD3oMO6KUzjpi+l31Y3pjeUvLm0zJwiIvv+v817HymtTUkh7JZabWcK9qefrliLEicSvsXzsNCILs4GIPGTDD5lTHeM42HQNWLizrBjydyr8i+Q1yHVFtlBcOAW/4RPbgq/aS9El7OFBcbMaJ9+BzGUS01LLsyeD7NqumvEHQYH5CVBAJjUtlt3HP+vqhU2F4hq5igFx6MoSn6Xc0C2H0WJpvVxA3VN749y/4fzVbi2JhoALk2bwNTTkgePJ2Ln/YoY3zVUMIT2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 17:30:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466363 invoked by uid 111); 8 Apr 2026 17:30:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 13:30:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 13:30:32 -0400
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: [PATCH] t5401: test SIGPIPE with parallel hooks
Message-ID: <20260408173032.GB2293804@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <20260408054347.GA2284358@coredump.intra.peff.net>
 <871pgp3byq.fsf@collabora.com>
 <xmqqcy091jht.fsf@gitster.g>
 <87v7e11j4q.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7e11j4q.fsf@collabora.com>

On Wed, Apr 08, 2026 at 08:01:25PM +0300, Adrian Ratiu wrote:

> > It sounds sensible, but a standalone fix early before 2.54 final, as
> > the problem and the fix shown by Peff here looked correct, without
> > waiting for NonStop may be simpler to work with.  Then, rebuild
> > parallel series on top of the 'master' that has the fix applied,
> > perhaps?
> 
> Yes, that is the path forward now that Randall also confirmed the fix
> works on NonStop (btw thank you Randall). :)
> 
> Just waiting for Peff to tell me if he wants to send it himself.

I just sent out the fix patch, which should be good for 2.54. Here's the
test patch, which I hope you'll include when re-rolling the parallel
series (either as-is, or if you prefer it can be moved to another script
where we're doing other parallel hook tests).

It would be nice to refer to the fix commit using its id, but we won't
know what it is until Junio applies it. :) So once that happens it might
be worth tweaking the commit message.

-- >8 --
Subject: t5401: test SIGPIPE with parallel hooks

We recently fixed a bug where a hook that caused us to get SIGPIPE would
accidentally trigger the run_processes_parallel() cleanup handler,
killing the child processes.

For a single hook, this meant killing the already-exited hook. This case
was triggered by our tests, but was only a problem on some platforms.

But if you have multiple hooks running in parallel, this causes a
problem everywhere, since one hook failing to read its input would take
down all hooks. Now that we have parallel hook support, we can add a
test for this case. It should pass already, due to the existing fix.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5401-update-hooks.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 44ec875aef..f727b5d545 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -139,4 +139,42 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
 
+test_expect_success 'hooks in parallel that do not read input' '
+	# Add this to our $PATH to avoid having to write the whole trash
+	# directory into our config options, which would require quoting.
+	mkdir bin &&
+	PATH=$PWD/bin:$PATH &&
+
+	write_script bin/hook-fast <<-\EOF &&
+	# This hook does not read its input, so the parent process
+	# may see SIGPIPE if it is not ignored. It should happen
+	# relatively quickly.
+	exit 0
+	EOF
+
+	write_script bin/hook-slow <<-\EOF &&
+	# This hook is slow, so we expect it to still be running
+	# when the other hook has exited (and the parent has a pipe error
+	# writing to it).
+	#
+	# So we want to be slow enough that we expect this to happen, but not
+	# so slow that the test takes forever. 1 second is probably enough
+	# in practice (and if it is occasionally not on a loaded system, we
+	# will err on the side of having the test pass).
+	sleep 1
+	exit 0
+	EOF
+
+	git init --bare parallel.git &&
+	git -C parallel.git config hook.fast.command "hook-fast" &&
+	git -C parallel.git config hook.fast.event pre-receive &&
+	git -C parallel.git config hook.fast.parallel true &&
+	git -C parallel.git config hook.slow.command "hook-slow" &&
+	git -C parallel.git config hook.slow.event pre-receive &&
+	git -C parallel.git config hook.slow.parallel true &&
+	git -C parallel.git config hook.jobs 2 &&
+
+	git push ./parallel.git "+refs/heads/*:refs/heads/*"
+'
+
 test_done
-- 
2.54.0.rc1.274.g1f8c576c50

