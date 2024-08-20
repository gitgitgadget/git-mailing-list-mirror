Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8D13211F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724131105; cv=none; b=L8x5w7aNrvy6JF/uI9VFm3fSztkOLVoK3m78n111EvnHN4/z/djbvrj1wsBi3u7gJca50l/+EhotAnBvmaeYr1eXSBpK6sn7wZrGQYlFRBepxAZK9j7TNNxR9GrFDjNrTrwVx9POPE3QbQd1YEqE6zvQ/x+KQUbmbvqnunYSz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724131105; c=relaxed/simple;
	bh=nnriHNnek+sHV0Tk9bwNAhFb9n1O1tPr4YrvEy0vH3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORrAe54VTYUv+Mk3WeaqOi+6ZoXMTU/oEGLsODyk5T4Ag0IXDUwadPtz0SW8JTXDwUN4AeIPI7O/l7UrphYm6d8KXjgZHzac+dZk3QwThE8OEHbwLFm96ou0xpD6IGrE0+/l6TFESdP7ByeMcSBdWZEARG6Mo4+1/yLG6nmAOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16155 invoked by uid 109); 20 Aug 2024 05:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Aug 2024 05:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29012 invoked by uid 111); 20 Aug 2024 05:18:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Aug 2024 01:18:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 20 Aug 2024 01:18:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2024, #07; Mon, 19)
Message-ID: <20240820051819.GA3020004@coredump.intra.peff.net>
References: <xmqqa5h8c8zu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5h8c8zu.fsf@gitster.g>

On Mon, Aug 19, 2024 at 05:51:01PM -0700, Junio C Hamano wrote:

> * jk/mark-unused-parameters (2024-08-17) 15 commits
>   (merged to 'next' on 2024-08-19 at f85d6096c9)
>  + scalar: mark unused parameters in dummy function
>  + daemon: mark unused parameters in non-posix fallbacks
>  + setup: mark unused parameter in config callback
>  + test-mergesort: mark unused parameters in trivial callback
>  + t-hashmap: mark unused parameters in callback function
>  + reftable: mark unused parameters in virtual functions
>  + reftable: drop obsolete test function declarations
>  + reftable: ignore unused argc/argv in test functions
>  + unit-tests: ignore unused argc/argv
>  + t/helper: mark more unused argv/argc arguments
>  + oss-fuzz: mark unused argv/argc argument
>  + refs: mark unused parameters in do_for_each_reflog_helper()
>  + refs: mark unused parameters in ref_store fsck callbacks
>  + update-ref: mark more unused parameters in parser callbacks
>  + imap-send: mark unused parameter in ssl_socket_connect() fallback
> 
>  Mark unused parameters as UNUSED to squelch -Wunused warnings.
> 
>  Will merge to 'master'.
>  source: <20240817082101.GA6761@coredump.intra.peff.net>

I did have one fixup for this series, based on feedback from Ghanshyam.
Here it is as a separate patch on top.

-- >8 --
Subject: [PATCH] t-hashmap: stop calling setup() for t_intern() test

Commit f24a9b78a9 (t-hashmap: mark unused parameters in callback
function, 2024-08-17) noted that the t_intern() does not need its
hashmap parameter, but we have to keep it to conform to the function
pointer interface of setup().

But since the only thing setup() does is create and tear down the
hashmap, we can just skip calling setup() entirely for this case, and
drop the unused parameters. This simplifies the code a bit.

Helped-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-hashmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
index da102eb541..83b79dff39 100644
--- a/t/unit-tests/t-hashmap.c
+++ b/t/unit-tests/t-hashmap.c
@@ -322,8 +322,7 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
 	free(removed);
 }
 
-static void t_intern(struct hashmap *map UNUSED,
-		     unsigned int ignore_case UNUSED)
+static void t_intern(void)
 {
 	const char *values[] = { "value1", "Value1", "value2", "value2" };
 
@@ -357,6 +356,6 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
 	TEST(setup(t_iterate, 0), "iterate works");
 	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
 	TEST(setup(t_alloc, 0), "grow / shrink works");
-	TEST(setup(t_intern, 0), "string interning works");
+	TEST(t_intern(), "string interning works");
 	return test_done();
 }
-- 
2.46.0.584.ga7429125f1

