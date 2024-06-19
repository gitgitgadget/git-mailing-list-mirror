Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9414BFA8
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802180; cv=none; b=EoDlAoFxEAoSg2HQPwgwmRgOeeyY3vu1xfDRToRoxB1Quv4owaFD7ikhKQdlIx7QCwaP6hQwfI1Un0dvZm2Y1/XSHF4okoWEABJhhg0oNS3cK0kB6369XbbR2OOZeHRRjfyqLy7l7UCdjFLMuaM7k9+zYtIwKPM+BQbsQH2IEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802180; c=relaxed/simple;
	bh=iMRcheEAEfE6cFQYJRZjQ+tvwWKJCpvmV4I75fR3A1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN5iQrS4ACid2p5ZZtvVedl16eumo4vBhrg0t/I9YyO/QhgK/PPCeFlQq4r9uXrERZlUHpl5NkbWNazs9igxlvzobvA892PNX1XYRwzXnUeXiJIEBj+yaw3tJaSVzN1KHrXQQOapvfBK7bCnNKSPxoK7UlbM2+/4NbutxF5JVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9212 invoked by uid 109); 19 Jun 2024 13:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 13:02:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21196 invoked by uid 111); 19 Jun 2024 13:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 09:02:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 09:02:56 -0400
From: Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@nexedi.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Tan <jonathantanmy@google.com>,
	Alain Takoudjou <alain.takoudjou@nexedi.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>
Subject: [PATCH] fetch-pack: fix segfault when fscking without --lock-pack
Message-ID: <20240619130256.GA228005@coredump.intra.peff.net>
References: <20240606133605.602276-1-kirr@nexedi.com>
 <ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>

On Wed, Jun 19, 2024 at 05:14:21AM +0000, Kirill Smelkov wrote:

> + newren, peff, calvinwan, ps, avarab

It's fine (and even encouraged) to re-post a topic which didn't get any
attention the first time around. But please don't mass-cc unrelated
people like this. We can all read the list and see your re-post, and if
we don't respond it may be because we have other priorities.

> +test_expect_failure 'fetch with fsckObjects but without --lock-pack does not segfault' '
> +	rm -rf server client &&
> +	git init server &&
> +	test_commit -C server 1 &&
> +
> +	git init client &&
> +	# unpackLimit=1 forces to keep received pack as pack instead of
> +	# unpacking it to loose objects. The code is currently segfaulting when
> +	# trying to index that kept pack.
> +	git -c fetch.fsckObjects=true -c fetch.unpackLimit=1 \
> +	    -C client fetch-pack ../server \
> +		$(git -C server rev-parse refs/heads/main)
> +'

Thanks for providing a reproduction of the problem.

I think we don't want to stick the test right here, as it is breaking up
two related tests (though it is confusing because one uses http and the
other doesn't, so there's some http setup in between them). Though
curiously, putting the "rm -rf server" here revealed a minor bug in
those other tests. Fixed here:

  https://lore.kernel.org/git/20240619125255.GA346466@coredump.intra.peff.net

I think it's a bug that fetch.unpackLimit causes index-pack to create a
lockfile at all, but there's a more direct way to trigger the issue,
which I've used in the patch below. I'll follow up with more details in
a reply to the patch.

-- >8 --
Subject: fetch-pack: fix segfault when fscking without --lock-pack

The fetch-pack internals have multiple options related to creating
".keep" lock-files for the received pack:

  - if args.lock_pack is set, then we tell index-pack to create a .keep
    file. In the fetch-pack plumbing command, this is triggered by
    passing "-k" twice.

  - if the caller passes in a pack_lockfiles string list, then we use it
    to record the path of the keep-file created by index-pack. We get
    that name by reading the stdout of index-pack. In the fetch-pack
    command, this is triggered by passing the (undocumented) --lock-pack
    option; without it, we pass in a NULL string list.

So it's possible to ask index-pack to create the lock-file (using "-k
-k") but not ask to record it (by avoiding "--lock-pack"). This worked
fine until 5476e1efde (fetch-pack: print and use dangling .gitmodules,
2021-02-22), but now it causes a segfault.

Before that commit, if pack_lockfiles was NULL, we wouldn't bother
reading the output from index-pack at all. But since that commit,
index-pack may produce extra output if we asked it to fsck. So even if
nobody cares about the lockfile path, we still need to read it to skip
to the output we do care about.

We correctly check that we didn't get a NULL lockfile path (which can
happen if we did not ask it to create a .keep file at all), but we
missed the case where the lockfile path is not NULL (due to "-k -k") but
the pack_lockfiles string_list is NULL (because nobody passed
"--lock-pack"), and segfault trying to add to the NULL string-list.

We can fix this by skipping the append to the string list when either
the value or the list is NULL. In that case we must also free the
lockfile path to avoid leaking it when it's non-NULL.

Nobody noticed the bug for so long because the transport code used by
"git fetch" always passes in a pack_lockfiles pointer, and remote-curl
(the main user of the fetch-pack plumbing command) always passes
--lock-pack.

Reported-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c          |  4 +++-
 t/t5500-fetch-pack.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..42f48fbc31 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1038,8 +1038,10 @@ static int get_pack(struct fetch_pack_args *args,
 
 		if (!is_well_formed)
 			die(_("fetch-pack: invalid index-pack output"));
-		if (pack_lockfile)
+		if (pack_lockfiles && pack_lockfile)
 			string_list_append_nodup(pack_lockfiles, pack_lockfile);
+		else
+			free(pack_lockfile);
 		parse_gitmodules_oids(cmd.out, gitmodules_oids);
 		close(cmd.out);
 	}
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index b26f367620..585ea0ee16 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -993,6 +993,16 @@ test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
 		       fetch origin server_has both_have_2
 '
 
+test_expect_success 'fetch-pack with fsckObjects and keep-file does not segfault' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -c fetch.fsckObjects=true \
+	    -C client fetch-pack -k -k ../server HEAD
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.45.2.949.g1c649f6aed

