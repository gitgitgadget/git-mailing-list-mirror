Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725D83CD5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214997; cv=none; b=LiH8ROD8YUeZc5y2KTiIX+riqBm5G4U9BrxO4SzVBb1TTf+6b55+VVKwc7yF6GgU14T4pzrniKgg9chaVieGukxLKgcar9MzSiVkrcPajFooCVxlBmdhChdJtahruuhgFovL5uyccykTSfX9cPllgZT1jq8QrYvGhyuMl62XSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214997; c=relaxed/simple;
	bh=LknClnxUvpET7D+IKSBbInI+BKE6rSt+hxWgqroEMJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSOQuj4Beoa/9AVpbBunDXuqOaF4zPIfQZRqnPvLC/tiwmen400yLeDKsm2VSZt9WMnX1D6TG76/5327TkUOozJOZ5Tkiny76kVn4rlBmk/6IspH/Oweo59xIz4S3AwBm/tDbagIh2C33Vn0OZA2nq2oHOhMmA+fxs0zfGivrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15465 invoked by uid 109); 24 Sep 2024 21:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:56:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18592 invoked by uid 111); 24 Sep 2024 21:56:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:56:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:56:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/28] transport-helper: fix strbuf leak in
 push_refs_with_push()
Message-ID: <20240924215634.GI1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

We loop over the refs to push, building up a strbuf with the set of
"push" directives to send to the remote helper. But if the atomic-push
flag is set and we hit a rejected ref, we'll bail from the function
early. We clean up most things, but forgot to release the strbuf.

Fixing this lets us mark t5541 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this whole function could benefit from a cleanup goto, but it's
a little non-trivial. So I stuck with simple-and-stupid.

 t/t5541-http-push-smart.sh | 1 +
 transport-helper.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 71428f3d5c..3ad514bbd4 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -7,6 +7,7 @@ test_description='test smart pushing over http via http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
diff --git a/transport-helper.c b/transport-helper.c
index c688967b8c..9c8abd8eca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1023,6 +1023,7 @@ static int push_refs_with_push(struct transport *transport,
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
+				strbuf_release(&buf);
 				return 0;
 			} else
 				continue;
-- 
2.46.2.1011.gf1f9323e02

