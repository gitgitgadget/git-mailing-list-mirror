Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3B3209
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489730; cv=none; b=Xd3WmOMJnp90CRYIAGuXupIl7gbsyY8t8VB0k/bnH7HyDKXD57tawqJdpz5+A45c/WQTvZZQ7dnLBmtL7++rZzOY9YnMV+/iMPLGbdF2kr06yDRd6/oLQwWsswKyhb4AD52jL8erraapYwzBN8ZlUtQ0LNVW9wJUNngSN5hnXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489730; c=relaxed/simple;
	bh=hK9QnUOQ4a9I862iyrZNezxh/8O/gzZwhJkqiOdAz7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXerhbVNkO5ycfwGrBLE47h+AEgzdgW2gpoW8/XzC6ZGWPtHjDhmYTjvbyYGQm1X1VVoZ0uKCtCeXbfa2qLMblLraQwumr03jXydYb9lxf0Ndnno66MisXEdYNsO3u1ThxkQy1iwfKszCLPz/MFp45snzJo6QanqOMgcz+l4vLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lxdw0yFU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lxdw0yFU"
Received: (qmail 4778 invoked by uid 109); 9 Mar 2025 03:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hK9QnUOQ4a9I862iyrZNezxh/8O/gzZwhJkqiOdAz7o=; b=Lxdw0yFU5NjOCWJp8KqDrUJY85pyoDmnkeSLAQafUGnV0x6d7iQLpn7ed4DVMitRrYFciJPBl4oZ1IpSWzfs3ynjTwvtT3zzY7H7gaBTWr4vjM+blL1EUnT2tmiVAcQnL7Rsa+8VggjORUP0NnoBR2+6qeab1grXeGfasWpgZdzviBC4G98CxOnDvgbIRyKKTWhXkkAHyrnRv2h9EKcNYBX7SwvWfZD4/oe/a0C6MApdDMKWCo1qqswHpBdpcv9ZUxZNaEy58c47qVfom0R0KZZZLg0uHmlFtf9YF4OIG7cbLnl4yVS++3GireuwxbAQFF2R2xXjE5Q1FryAExWEhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:08:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4939 invoked by uid 111); 9 Mar 2025 03:08:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:08:47 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:08:47 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 6/9] fetch: ask server to advertise HEAD for config-less fetch
Message-ID: <20250309030847.GF2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

If we're not given any refspecs (either on the command line or via
config) and we have no branch merge config, then we fetch the remote
HEAD into our local FETCH_HEAD. In that case we do not send any
ref-prefix option to the server at all, and we see the full
advertisement.

But this is sub-optimal. We only care about HEAD, so we can just ask
for that, and ignore all of the other refs.

The new test demonstrates a case where we see fewer refs (in this case
only one less, but in theory we could be ignoring millions of them).

This also removes the only case where we care about seeing some refs
from the other side, but don't add anything to the ref_prefixes list.
Cleaning this up means one less maintenance burden. Before this patch,
any code which wanted to add to the list had to make sure the list was
not empty, since an empty list meant "ask for everything". Now it really
means "we are not interested in any refs".

This should let us optimize a few more cases in subsequent patches.

Note that we'll add "HEAD" to the list of prefixes, and later code for
updating "refs/remotes/<remote>/HEAD" may likewise do so. In theory this
could cause duplicates in the list, but in practice these can't both
trigger. We hit our new case only if there are no refspecs, and the
"<remote>/HEAD" feature is enabled only when we are fetching from a
remote with configured refspecs. We could be defensive with a flag, but
it didn't seem worth it to me (the absolute worse case is a useless
redundant ref-prefix line sent to the server).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c        |  8 ++++++++
 t/t5702-protocol-v2.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b9..f142756441 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1766,6 +1766,14 @@ static int do_fetch(struct transport *transport,
 					    branch->merge[i]->src);
 			}
 		}
+
+		/*
+		 * If there are no refs specified to fetch, then we just
+		 * fetch HEAD; mention that to narrow the advertisement.
+		 */
+		if (!transport_ls_refs_options.ref_prefixes.nr)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    "HEAD");
 	}
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index cea8f92a3d..2f0a52a72d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -679,6 +679,21 @@ test_expect_success 'default refspec is used to filter ref when fetching' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'set up parent for prefix tests' '
+	git init prefix-parent &&
+	git -C prefix-parent commit --allow-empty -m foo &&
+	git -C prefix-parent branch unrelated-branch
+'
+
+test_expect_success 'empty refspec filters refs when fetching' '
+	git init configless-child &&
+
+	test_when_finished "rm -f log" &&
+	GIT_TRACE_PACKET="$(pwd)/log" \
+		git -C configless-child fetch ../prefix-parent &&
+	test_grep ! unrelated-branch log
+'
+
 test_expect_success 'fetch supports various ways of have lines' '
 	rm -rf server client trace &&
 	git init server &&
-- 
2.49.0.rc1.381.gc60f5426ff

