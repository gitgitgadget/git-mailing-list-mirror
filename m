Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE9C43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DC7616ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhEKSKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:10:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:50886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232244AbhEKSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:09:57 -0400
Received: (qmail 23917 invoked by uid 109); 11 May 2021 18:08:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 18:08:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26106 invoked by uid 111); 11 May 2021 18:08:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 14:08:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 14:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
 <YJrEy8IPi+PFWuzT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJrEy8IPi+PFWuzT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 01:54:19PM -0400, Jeff King wrote:

> > > In any case, this needs to be signed off before it gets carved into
> > > our history.
> > 
> > Done, and also changed the variable name to minimize the size of the
> > diff. A shorter name allowed for less re-flowing of lines.
> 
> It's quite short. I'm OK with it for a static-local function with few
> callers like this, though.

Actually, I just noticed that you did not introduce "e" in the caller.
So it is not even a new name, and you are just following convention.

I also wondered briefly why we needed the out-parameter at all, and not
just letting the caller look at errno. The answer is that we need to
preserve it across the close() call. The more usual thing in our code
base _would_ be to use saved_errno, but not have it as an out-parameter.

I.e.:

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe..bda283e7f4 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -204,15 +204,16 @@ static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
 
 	fd = socket(AF_UNIX, sock_type, 0);
 	if (fd == -1)
-		return errno;
+		return -1;
 
 	sa.sun_family = AF_UNIX;
 	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
-		int e = errno;
+		int saved_errno = errno;
 		close(fd);
-		return e;
+		errno = saved_errno;
+		return -1;
 	}
 
 	*out_fd = fd;
@@ -227,7 +228,6 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 {
 	unsigned int uds_try = 0;
 	int fd;
-	int e;
 	const char *path = NULL;
 
 	/*
@@ -271,23 +271,21 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	}
 
 	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd))
 			goto connected;
-		if (e != EPROTOTYPE)
+		if (errno != EPROTOTYPE)
 			goto error;
 	}
 	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd))
 			goto connected;
 	}
 
 error:
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
 			path, tr2_sysenv_display_name(dst->sysenv_var),
-			strerror(e));
+			strerror(errno));
 
 	tr2_dst_trace_disable(dst);
 	return 0;


I do prefer that approach, since I think it's more idiomatic for our
code base, but for the sake of wrapping up this simple fix which has
been discussed much more than I think it deserves, I am OK with either.
:)

(I also found it interesting that the "error" goto in the caller only
has one source. I think the code would be easier to reason about if it
were inlined, but I'm happy to stop here for now).

-Peff
