Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB25C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbjD0FaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjD0FaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:30:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F126BB
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:30:18 -0700 (PDT)
Received: (qmail 19504 invoked by uid 109); 27 Apr 2023 05:30:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 05:30:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16314 invoked by uid 111); 27 Apr 2023 05:30:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 01:30:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 01:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 1/2] http: advertise capabilities when cloning empty repos
Message-ID: <20230427053016.GD982277@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426205324.326501-2-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 08:53:23PM +0000, brian m. carlson wrote:

> From: "brian m. carlson" <bk2204@github.com>
> 
> When cloning an empty repository, the HTTP protocol version 0 currently
> offers nothing but the header and flush packets for the /info/refs
> endpoint. This means that no capabilities are provided, so the client
> side doesn't know what capabilities are present.

Is this really an HTTP problem?

If I do:

  git init --bare --object-format=sha256 remote.git
  git -c protocol.version=0 clone --bare remote.git local.git
  git -C local.git rev-parse --show-object-format

I will get sha1, which is wrong. Likewise with GIT_DEFAULT_HASH=sha256
on the clone (after Junio's recent patch), regardless of what the server
claims. This is really a git-protocol issue that affects all transports.

So I think in this hunk:

> @@ -1379,6 +1381,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
>  			data.no_done = 1;
>  		head_ref_namespaced(send_ref, &data);
>  		for_each_namespaced_ref(send_ref, &data);
> +		if (!data.sent_capabilities && advertise_refs)
> +			send_ref("capabilities^{}", null_oid(), 0, &data);
>  		/*
>  		 * fflush stdout before calling advertise_shallow_grafts because send_ref
>  		 * uses stdio.

you would want to drop the "&& advertise_refs" bit, after which both of
the cases above would yield a sha256 repository.

There is one other catch, though. Doing as I suggest results in a
failure in t5509, because the new code does not interact correctly with
namespaces. That is true of your version, as well; it's just that the
test suite does not cover the combination of namespaces, http, and empty
repos.

The issue is that send_ref() will try to strip the namespace, and end up
with NULL (which on my glibc system ends up with a ref named "(null)",
but obviously could segfault, too).

Something like this fixes it:

diff --git a/environment.c b/environment.c
index 8a96997539..37cd66b295 100644
--- a/environment.c
+++ b/environment.c
@@ -234,6 +234,8 @@ const char *get_git_namespace(void)
 const char *strip_namespace(const char *namespaced_ref)
 {
 	const char *out;
+	if (!strcmp(namespaced_ref, "capabilities^{}"))
+		return namespaced_ref; /* magic ref */
 	if (skip_prefix(namespaced_ref, get_git_namespace(), &out))
 		return out;
 	return NULL;

but I suspect it would be cleaner to refactor send_ref() to allow
sending a name more directly.

(As an aside, it feels like send_ref() is also wrong not to check for
NULL from strip_namespace(), but I guess in practice we do not feed
it names outside of the namespace. Might be a good candidate for a BUG()
check or other assertion).

> +test_expect_success 'clone empty SHA-256 repository with protocol v0' '
> +	rm -fr sha256 &&
> +	echo sha256 >expected &&
> +	GIT_TRACE=1 GIT_TRACE_PACKET=1 git -c protocol.version=0 clone "$HTTPD_URL/smart/sha256.git" &&
> +	git -C sha256 rev-parse --show-object-format >actual &&
> +	test_cmp actual expected &&
> +	git ls-remote "$HTTPD_URL/smart/sha256.git" >actual &&
> +	test_must_be_empty actual
> +'

This looks reasonable, though I think if we do not need HTTP to
demonstrate the issue (and I don't think we do), then we should probably
avoid it, just to get test coverage on platforms that don't support
HTTP.

-Peff
