Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96913BC25
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500766; cv=none; b=hdKDWRGR9PAfE/XO6cTpZb/AyVPS9UxCNFcS/DK+roYVn0jbFT8ELi1I6GHkCUiJt+ixS2vp/HGIXX8RNN5eHdV8lxR2vMxjtKm6w4j+hJ8ijSzlVA5yJHlzpWsTGtGTgw5i/VGQtQAX/5p2suTjb794Bcy5qR7F4w44P6A3Ldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500766; c=relaxed/simple;
	bh=kaLwKny1gYzh9Mc21OjV0JSFl2i9aiF7UcJScZ65ZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQDaezeH9uXWeMntTtiraJ9vB2Wjfy5oO8t7mfmx0TYUUUUoHOkU3ufGlJ09toe025yZw5fCTJm114ALrQlFL9yUArXqGFATk3KpaUpkJJ+9KbaQ6aiipHHxA9lud6MR6+iIPnZBvY4AMZQc+NdLpFFiEor+K0y/jRR6lt4AwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17052 invoked by uid 109); 1 Aug 2024 08:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 08:25:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29448 invoked by uid 111); 1 Aug 2024 08:26:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 04:26:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 04:25:56 -0400
From: Jeff King <peff@peff.net>
To: Bo Anderson <mail@boanderson.me>
Cc: Hong Jiang <ilford@gmail.com>, git@vger.kernel.org
Subject: [PATCH] credential/osxkeychain: respect NUL terminator in username
Message-ID: <20240801082556.GA640360@coredump.intra.peff.net>
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
 <20240731074228.GC595974@coredump.intra.peff.net>
 <9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>

On Wed, Jul 31, 2024 at 02:07:32PM +0100, Bo Anderson wrote:

> This is correct.
> 
> The reason I couldn’t reproduce the problem and how few will have noticed up to
> now is that for most users the CFStringGetCStringPtr call, which correctly uses
> strlen, does what is necessary and we return early. I don't entirely know the
> precise criteria where the fallback is used but I imagine it depends on certain
> system encodings/locales.
> 
> The patch changing this to strlen looks good to me to apply to master & maint.

Thanks. Here it is with a commit message. Hopefully Hong Jiang can
confirm that this fixes the problem, and we can added a "Tested-by"
trailer.

-- >8 --
Subject: [PATCH] credential/osxkeychain: respect NUL terminator in username

This patch fixes a case where git-credential-osxkeychain might output
uninitialized bytes to stdout.

We need to get the username string from a system API using
CFStringGetCString(). To do that, we get the max size for the string
from CFStringGetMaximumSizeForEncoding(), allocate a buffer based on
that, and then read into it. But then we print the entire buffer to
stdout, including the trailing NUL and any extra bytes which were not
needed. Instead, we should stop at the NUL.

This code comes from 9abe31f5f1 (osxkeychain: replace deprecated
SecKeychain API, 2024-02-17). The bug was probably overlooked back then
because this code is only used as a fallback when we can't get the
string via CFStringGetCStringPtr(). According to Apple's documentation:

  Whether or not this function returns a valid pointer or NULL depends
  on many factors, all of which depend on how the string was created and
  its properties.

So it's not clear how we could make a test for this, and we'll have to
rely on manually testing on a system that triggered the bug in the first
place.

Reported-by: Hong Jiang <ilford@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This is not even compile tested by me! It looks like an obvious enough
fix, and I wanted to make sure we don't forget about it. But anybody who
can reproduce or test would be greatly appreciated.

 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6ce22a28ed..1c8310d7fe 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -141,7 +141,7 @@ static void find_username_in_item(CFDictionaryRef item)
 				username_buf,
 				buffer_len,
 				ENCODING)) {
-		write_item("username", username_buf, buffer_len - 1);
+		write_item("username", username_buf, strlen(username_buf));
 	}
 	free(username_buf);
 }
-- 
2.46.0.452.g3bd18f5164

