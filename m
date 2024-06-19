Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9514BF8D
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804127; cv=none; b=kQrPuzJaxEcJX8YWDh8gtgTLmC2ZYrZpx2f4xq1g1dgBM5Y6425y3RGbVyDMQpSpBWoe/XNNsZiaakFq9C/et8NglHZisax+JLPAUBM7P4IsWA6sptJsQ8JNGKtkshSPPKIKHwMgxro3zL7m440gbcVxENW4iNAjLwbxSf+nALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804127; c=relaxed/simple;
	bh=HE5pNnKal+Y922GSmbl10fjdPAllMrLImyFWHW0LAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9RsUCFP4kC42v+dHlV/RCzeLBgHPKmlMHDH/QjQZQYbYa2T2fqyL1n/bX2/jF0sxGLh/b5bhdgLep/hLoRXsWFOAPYdWC+Icfpplna6NTkBvYuyylA5UUuA+0l1gHPpahwj69/jStHrf1DBWE0ThleU2FvbMvEoenP+/3lqmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9313 invoked by uid 109); 19 Jun 2024 13:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 13:35:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21447 invoked by uid 111); 19 Jun 2024 13:35:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 09:35:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 09:35:22 -0400
From: Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@nexedi.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Tan <jonathantanmy@google.com>,
	Alain Takoudjou <alain.takoudjou@nexedi.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>
Subject: Re: [PATCH] fetch-pack: fix segfault when fscking without --lock-pack
Message-ID: <20240619133522.GA942902@coredump.intra.peff.net>
References: <20240606133605.602276-1-kirr@nexedi.com>
 <ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>
 <20240619130256.GA228005@coredump.intra.peff.net>
 <20240619132208.GA895873@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619132208.GA895873@coredump.intra.peff.net>

On Wed, Jun 19, 2024 at 09:22:08AM -0400, Jeff King wrote:

> On Wed, Jun 19, 2024 at 09:02:56AM -0400, Jeff King wrote:
> 
> > I think it's a bug that fetch.unpackLimit causes index-pack to create a
> > lockfile at all, but there's a more direct way to trigger the issue,
> > which I've used in the patch below. I'll follow up with more details in
> > a reply to the patch.
> 
> Your original test used transfer.unpackLimit. By itself that should just
> cause us to avoid calling unpack-objects, keeping the pack we got, but
> _not_ creating a .keep file. Likewise, if you pass one "-k" to
> fetch-pack, it should just keep the pack but without a .keep file
> (that's what the double "-k -k" does).
> 
> But both of these do trigger a .keep file, which seems wrong to me. The
> caller has no idea that the .keep file was created, so it won't clean it
> up, and the pack will be in limbo forever.
> 
> I tried bisecting and came up with fa74052922 (Always obtain fetch-pack
> arguments from struct fetch_pack_args, 2007-09-19). Given the length of
> time it's been this way, that makes me a little afraid to touch it. ;)

Even before that commit, we'd trigger the lock of unpack_limit was set
there. I find all of this code really puzzling (which makes me even more
hesitant to touch it). But I really don't understand why it is not just
this:

diff --git a/fetch-pack.c b/fetch-pack.c
index 42f48fbc31..ed57b0fdac 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -971,7 +971,7 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
+		if ((do_keep || index_pack_args) && args->lock_pack)
 			add_index_pack_keep_option(&cmd.args);
 		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 585ea0ee16..d6d6ea6281 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -1003,6 +1003,28 @@ test_expect_success 'fetch-pack with fsckObjects and keep-file does not segfault
 	    -C client fetch-pack -k -k ../server HEAD
 '
 
+test_expect_success 'fetch-pack -k does not create .keep file' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -C client fetch-pack -k ../server HEAD &&
+	find client/.git/objects/pack -name "*.keep" >keep &&
+	test_must_be_empty keep
+'
+
+test_expect_success 'fetch-pack with unpackLimit does not create .keep file' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -c fetch.unpackLimit=1 -C client fetch-pack ../server HEAD &&
+	find client/.git/objects/pack -name "*.keep" >keep &&
+	test_must_be_empty keep
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&
