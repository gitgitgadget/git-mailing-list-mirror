Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6135F8B7
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103306; cv=none; b=utZXOcoS+tOECJdlz1GEpGKyLd2iOJYBtxsvtdprq0iOUQn9nZSaB4QdGOKc6wEJldy72aLzpO0qqfv7WN4HGWGCUI3tYKe2F0Sp9tRpVCe0fpeeGq8/GBaU0brCZUXDl1imAop8VMptCox9Fscrjr1jlNbtzwZ7MVno1uzXuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103306; c=relaxed/simple;
	bh=HeRdz7fKMtv1Iux6Jxys+E7QAFe81FAG+fFzmMKlwjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3ZGcKBl66MdB16O8msieEtM9yLlYBoYXWqqepAag+fWuWsXutLtrzM1IdrEXI71mya8IlUFM8+eDtWZ6WQNYp9C5cbZO82B/yw7efgAvvCqDXJrDLI0NUIi2r0iLkfWZgRYnK/UOditFKIDZzclNhf1xhm2UE6pzbrzKZTrV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WXErhk10; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WXErhk10"
Received: (qmail 218849 invoked by uid 106); 2 Apr 2026 04:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HeRdz7fKMtv1Iux6Jxys+E7QAFe81FAG+fFzmMKlwjA=; b=WXErhk10OZAGLkKwTOqd5Mn7EXFVIpB35AOTvFaKuodTq/Jgj4VnpEKmBwzPVXfLQuPmZw+eKZ+JIRwskVBTqhannNQVUeLkR3AtJuEuB1FrzdmrcQQjXvGXhjlFbZv317kz31GlQdVT4Meu7kae7JD6AnPEVh5D1EMFbElVtKP4GZEUdY58u1j23IsUUpRGDl2PhTbHK3D/N+7vYmsG3K009fl4M8tEjP6aipoY+EFr0aaVMyDlgQ+7z8tiVqn6pMTtnAUWazL0YBhh4tpdsXRKeDefaA+GfNqBwkFQ1Zco+L7Aq3nL+KmOMf3Uk1yHBrkE84mts5GcwcyBYNGPPw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349753 invoked by uid 111); 2 Apr 2026 04:15:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:03 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 06/12] find_last_dir_sep(): convert inline function to
 macro
Message-ID: <20260402041503.GF3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

The find_last_dir_sep() function is implemented as an inline function
which takes in a "const char *" and returns a "char *" via strrchr().
That means that just like strrchr(), it quietly removes the const from
our pointer, which could lead to accidentally writing to the resulting
string.

But C23 versions of libc (including recent glibc) annotate strrchr()
such that the compiler can detect when const is implicitly lost, and it
now complains about the call in this inline function.

We can't just switch the return type of the function to "const char *",
though. Some callers really do want a non-const string to be returned
(and are OK because they are feeding a non-const string into the
function).

The most general solution is for us to annotate find_last_dir_sep() in
the same way that is done for strrchr(). But doing so relies on using
C23 generics, which we do not otherwise require.

Since this inline function is wrapping a single call to strrchr(), we
can take a shortcut. If we implement it as a macro, then the original
type information is still available to strrchr(), and it does the check
for us.

Note that this is just one implementation of find_last_dir_sep(). There
is an alternate implementation in compat/win32/path-utils.h. It doesn't
suffer from the same warning, as it does not use strrchr() and just
casts away const explicitly. That's not ideal, and eventually we may
want to conditionally teach it the same C23 generic trick that strrchr()
uses.  But it has been that way forever, and our goal here is just
quieting new warnings, not improving const-checking.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4b4ea2498f..4bb59b3101 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -335,11 +335,7 @@ static inline int is_path_owned_by_current_uid(const char *path,
 #endif
 
 #ifndef find_last_dir_sep
-static inline char *git_find_last_dir_sep(const char *path)
-{
-	return strrchr(path, '/');
-}
-#define find_last_dir_sep git_find_last_dir_sep
+#define find_last_dir_sep(path) strrchr((path), '/')
 #endif
 
 #ifndef has_dir_sep
-- 
2.53.0.1172.ge9e20b5838

