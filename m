Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878CD27A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29222 invoked by uid 109); 11 Jan 2024 07:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 07:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3539 invoked by uid 111); 11 Jan 2024 07:28:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 02:28:30 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 02:28:28 -0500
From: Jeff King <peff@peff.net>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/2] t5541: generalize reference locking
Message-ID: <20240111072828.GD48154@coredump.intra.peff.net>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <11fd5091d61b54d8862ab2e316bbd25fff63ce0f.1704912750.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11fd5091d61b54d8862ab2e316bbd25fff63ce0f.1704912750.git.gitgitgadget@gmail.com>

On Wed, Jan 10, 2024 at 06:52:30PM +0000, Justin Tobler via GitGitGadget wrote:

> From: Justin Tobler <jltobler@gmail.com>
> 
> Some tests set up reference locks by directly creating the lockfile.
> While this works for the files reference backend, reftable reference
> locks operate differently and are incompatible with this approach.
> Generalize reference locking by preparing a reference transaction.

As with the first patch, I think we could use d/f conflicts to get the
same effect. Perhaps something like this:

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index df758e187d..7eb0e887e1 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -233,7 +233,8 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	up="$HTTPD_URL"/smart/atomic-branches.git &&
 
 	# break ref updates for other on the remote site
-	mkdir "$d/refs/heads/other.lock" &&
+	git -C "$d" update-ref -d refs/heads/other &&
+	git -C "$d" update-ref refs/heads/other/block-me HEAD &&
 
 	# add the new commit to other
 	git branch -f other collateral &&
@@ -244,12 +245,8 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	# the new branch should not have been created upstream
 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
 
-	# upstream should still reflect atomic2, the last thing we pushed
-	# successfully
-	git rev-parse atomic2 >expected &&
-	# ...to other.
-	git -C "$d" rev-parse refs/heads/other >actual &&
-	test_cmp expected actual &&
+	# upstream should not have updated, as it cannot be written at all.
+	test_must_fail git -C "$d" rev-parse --verify refs/heads/other &&
 
 	# the new branch should not have been created upstream
 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&

I do think that the original was slightly more interesting (since we
could check that "other" still existed but was not updated), but I think
the main point of the test is that "atomic" was not pushed at all.

-Peff
