Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101344E046
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249452; cv=none; b=acDQcsgoqi0RKykX4ayV/9IMbxuTkunTbB0Fxx5Iy7NguA1mkk6U9qsxdsZzRvoKTnmJXlHeMHOPZivtyd1WE28VBxT9Orn2o4DkewQsoWIp5iTEg8xLimLqN+LHVD1Mpaf5B/JoR0Kdz5FsFcPC/MMAu/1bAtMBMuB1OGvFCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249452; c=relaxed/simple;
	bh=54aHdj8H8zQwiIiOoJqbnuAW8XUCQGHBUiggi8gRBw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0rWaJ9hBRWOLuGxNeDV6gexyAzBoBaJ7Avw0ZZU190+wg1GCJEQYdGVkZe99az1T+2eWKtxivFutwvSy2h/dMUUsV/MZ92X0mDsxWfGMaoU/ItBajMCu9tkqej8QakzkXZBEgq4ub1iXnncla16OAVzfolsTtKpLQBVUqPSimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hS05IR+o; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hS05IR+o"
Received: (qmail 80760 invoked by uid 106); 28 Jul 2026 14:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=54aHdj8H8zQwiIiOoJqbnuAW8XUCQGHBUiggi8gRBw8=; b=hS05IR+o1YC7Ym1bm1bIlHU3UPXiZ2LnvnxLhJcIbrJwvu3le5vuoNia3pCqbMgXTnp89StLHsResONHbs1T9nSkCUIkxwxjwcWyyIJDKrtG69DmWcLcBpv1QCFk1AFK1vEboE4YNmlfRTYklEvsj4tqxT0ofF8pexVJTtU9LQkJpGIeXVqyOGsy3F4LWTfVlnutlAfoGOasQQgCjwAheo84f3paVV1QtEIwPnwzVtM0jcqp/nIKq0qKoqA9rPeFZumRMk5ZEG5GTZzQvNWbZsQp9q+Xp0luMrzhVwZK6KOwWGy07m89jMlvF0n+kMuWsMu3y0yShRn+xHwmJEEeFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 14:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99691 invoked by uid 111); 28 Jul 2026 14:37:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 10:37:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 10:37:26 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 1/2] t0014: factor out choice of deprecated commands
Message-ID: <20260728143726.GA41686@coredump.intra.peff.net>
References: <20260728143653.GB11894@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728143653.GB11894@coredump.intra.peff.net>

We have a few tests related to aliasing deprecated commands which use
"whatchanged" and "pack-redundant", as these are the only two deprecated
commands we have. Let's pull those names into variables so that we can
refactor the tests without relying on the specific names.

Signed-off-by: Jeff King <peff@peff.net>
---
I pulled this into its own patch because it's so noisy, but it could be
squashed with the subsequent one.

 t/t0014-alias.sh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 5144b0effd..9d7c737355 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,17 +27,20 @@ test_expect_success 'looping aliases - internal execution' '
 	test_grep "^fatal: alias loop detected: expansion of" output
 '
 
+deprecated1=whatchanged
+deprecated2=pack-redundant
+
 test_expect_success 'looping aliases - deprecated builtins' '
-	test_config alias.whatchanged pack-redundant &&
-	test_config alias.pack-redundant whatchanged &&
+	test_config alias.$deprecated1 $deprecated2 &&
+	test_config alias.$deprecated2 $deprecated1 &&
 	cat >expect <<-EOF &&
-	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
-	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
-	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
-	  whatchanged <==
-	  pack-redundant ==>
+	${SQ}$deprecated1${SQ} is aliased to ${SQ}$deprecated2${SQ}
+	${SQ}$deprecated2${SQ} is aliased to ${SQ}$deprecated1${SQ}
+	fatal: alias loop detected: expansion of ${SQ}$deprecated1${SQ} does not terminate:
+	  $deprecated1 <==
+	  $deprecated2 ==>
 	EOF
-	test_must_fail git whatchanged -h 2>actual &&
+	test_must_fail git $deprecated1 -h 2>actual &&
 	test_cmp expect actual
 '
 
@@ -90,8 +93,8 @@ test_expect_success 'can alias-shadow via two deprecated builtins' '
 	# some git(1) commands will fail... (see above)
 	test_might_fail git status -h >expect &&
 	test_file_not_empty expect &&
-	test_might_fail git -c alias.whatchanged=pack-redundant \
-		-c alias.pack-redundant=status whatchanged -h >actual &&
+	test_might_fail git -c alias.$deprecated1=$deprecated2 \
+		-c alias.$deprecated2=status $deprecated1 -h >actual &&
 	test_cmp expect actual
 '
 
-- 
2.55.0.749.g30c495c7a6

