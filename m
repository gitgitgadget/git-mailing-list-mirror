Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B7197A92
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118610; cv=none; b=J7/KRM/FA/DlaRT6AwEMNX3MnlvTLl89c9D3/12vbByrv9J00rbtl1JvqwhrGm6G49jDfMlT//HWnwoX9D4XOg0FrN0QPEc77c+F+fweYfQWM0pxG97PuNNg58Hi1nF7y8bp/FPXsM4f/uieRMisjyBm9Yjn72LTA/LgNc/5P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118610; c=relaxed/simple;
	bh=gukDzbMnIbjMbkiE0lj4VjIPoLk8XV0HgUTGc1EXer0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnlFsRY3F3D4XmFVVcdAJlxXaLTnjz3EN62ApOb0QXmupbDKaMEAHyK/2nSJ2C0BJDsbDM0XVxjSn8baGIsQNi+fO3tQlhfxPdkNr2UwCsPFJ7ifiuu2OuiBqOHT2U0ZBQLkbjhIq4PIBWvw50SyL+tGokjz3FJD35EHuMsSVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BHC56SOJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BHC56SOJ"
Received: (qmail 21939 invoked by uid 109); 17 Jan 2025 12:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gukDzbMnIbjMbkiE0lj4VjIPoLk8XV0HgUTGc1EXer0=; b=BHC56SOJY6NWE05dRRmCRNUrnZNpzVyFmKUXp+ECnOSrXgRK8yRrapnFfOov3yqc5oOOWQrb+D1knRUWbuGkcGbmOxCuoExbAW1zkpjyFyWecWf7GeDtXyl8RGsQsmYdBv6in0MKRSq2QG807CWZVfGhR7FHhAdokJWk8UsxHWT7FSmsORgRL+fE00uoxt00zv93tIy08+oiuRDTilZU0jkV/LTbG3/CMb4Op19bP/bAOC32HxWJURn2/IMcuRA5PGH59sLHLKPK3nlxAczafLkLp0/jS6fnqzsiKMZfC3qCkb2MK75v8AGAeyQl4+StUF9ZF+MYCbxn8tJjn6xiOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 12:56:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8136 invoked by uid 111); 17 Jan 2025 12:56:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 07:56:48 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 07:56:47 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 3/3] index-pack, unpack-objects: use skip_prefix to avoid
 magic number
Message-ID: <20250117125647.GC2893666@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117125207.GB2356599@coredump.intra.peff.net>

When parsing --pack_header=, we manually skip 14 bytes to the data.
Let's use skip_prefix() to do this automatically.

Note that we overwrite our pointer to the front of the string, so we
have to add more context to the error message. We could avoid this by
declaring an extra pointer to hold the value, but I think the modified
message is actually preferable. It should give translators a bit more
context.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed in the area. It's possible that I'm overly
annoyed by manual string counting and this is just churn, though. ;)

 builtin/index-pack.c     | 6 +++---
 builtin/unpack-objects.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 75b84f78f4..0561eec00a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1954,11 +1954,11 @@ int cmd_index_pack(int argc,
 					warning(_("no threads support, ignoring %s"), arg);
 					nr_threads = 1;
 				}
-			} else if (starts_with(arg, "--pack_header=")) {
-				if (parse_pack_header_option(arg + 14,
+			} else if (skip_prefix(arg, "--pack_header=", &arg)) {
+				if (parse_pack_header_option(arg,
 							     input_buffer,
 							     &input_len) < 0)
-					die(_("bad %s"), arg);
+					die(_("bad --pack_header: %s"), arg);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "--progress-title")) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index cf2bc5c531..06d517dfb6 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -645,10 +645,10 @@ int cmd_unpack_objects(int argc,
 				fsck_set_msg_types(&fsck_options, arg);
 				continue;
 			}
-			if (starts_with(arg, "--pack_header=")) {
-				if (parse_pack_header_option(arg + 14,
+			if (skip_prefix(arg, "--pack_header=", &arg)) {
+				if (parse_pack_header_option(arg,
 							     buffer, &len) < 0)
-					die(_("bad %s"), arg);
+					die(_("bad --pack_header: %s"), arg);
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
-- 
2.48.1.438.g7fbf7b046e
