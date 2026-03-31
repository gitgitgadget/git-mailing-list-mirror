Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B53B3C0B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000658; cv=none; b=hdvZ41LsWve4YXcO+3lGx6WW2YDvJLwsUfKIYq7xOjspxA3NfRiZS87h3JoaWl+sGIb55zu/7NwIwtqPT6U4i4yOvnmQyhQ1irkJZIRD7ZWHC/8dxxq9QpSoCuUEn27YnwwqTV9ZCmb8IEATao6Xzz1mXZNLxBngrh/8p98zl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000658; c=relaxed/simple;
	bh=AW8Rl4fZOfFKJK8kOuYJ6dLAoXZMD9aX1CJ6qiycaf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Wlzyw9/y5O28O5HfzTjkgPQX6T6ojpYcNeCImYF96sjhIZJqO96w9ATfI7NmgbCYKHN3+si/IAyMpNXL6J9KiL6tGYHPar504UOZOaG9kpGLXCrOcN55kmQjoJeAWy6Cypvy8QK0UeVgoZW3VxEf5o+I8thSK3bulUeArQEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=apJQ+XVP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="apJQ+XVP"
Received: (qmail 206639 invoked by uid 106); 31 Mar 2026 23:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AW8Rl4fZOfFKJK8kOuYJ6dLAoXZMD9aX1CJ6qiycaf0=; b=apJQ+XVPVqM6EAYvAJmfSmWt3hNO9Q4CYXAUkXRq3dlSndLV8aXYM1Iybrrjq2/LWtfpgE5y6eSBZKDKB6Bb3cLh/CRHGUcWnHAAT/FK8LrpO703gP8uNUZBvJeBscZrq9gG1sxcR5xJGCkfMvMDz3uB4YGEifyCp2RX9kRq8u1BzTIhbngNq2634h0mocVo3MfnunIPnPC/0+F3tUPs/D0Jlb5yIWW9/zne6vQq33ODPB0Fy6SLKzWAHc9JFIw8f1tzWS3q+LZYhqZuoJVkeFsop2baMRj5S1sZ18pztdvhbvInKJX+gm86EPxCWD7Ir9clvrIk3w/QNA1ApQiLDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:44:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326445 invoked by uid 111); 31 Mar 2026 23:44:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:44:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:44:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 06/12] find_last_dir_sep(): convert inline function to macro
Message-ID: <20260331234415.GF2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

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
2.53.0.1136.gd760fbd4a0

