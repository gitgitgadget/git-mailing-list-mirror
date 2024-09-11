Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C87E110
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035181; cv=none; b=aGrcb1eo51jrboX+eViYHIyedE33c+Cz0K1ZaiIa1Aeqf+uPs+gNQtww0GmXwZab46DPKW15GE/d4ZN9qSG+4tH81NpjrAnWU8QBHMC0V57S8bVa0vsC7ORMbIt1vnWUw1M/my7UGdXjnoBLdBcKfdiJVi2gvASQdQp9wC3D1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035181; c=relaxed/simple;
	bh=LN2jmgqhd5tj/lgObDSgEVyAXKOIT6nK5IWZp0GO0IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grBjd/imeEOeAkqdYU/1Q7Ylz/5Qzf6pqcMgDxfsw8HwWWVwFcIFYh9JrPCik8gvsVHu0i9P8C1djrGIHghYCqvhH2+d4TE5PLtV5il+zhXtaGpMdlkEGIKaOBtZkl9HsdPnXrbxgGDzAPj7uifmQ1cWMsMVmmP74IIu1TiBwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9466 invoked by uid 109); 11 Sep 2024 06:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 06:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5753 invoked by uid 111); 11 Sep 2024 06:12:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 02:12:57 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 02:12:57 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of
 Git without OpenSSL
Message-ID: <20240911061257.GA1538490@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
 <20240911061009.GA1538383@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911061009.GA1538383@coredump.intra.peff.net>

On Wed, Sep 11, 2024 at 02:10:10AM -0400, Jeff King wrote:

>   2. That sets the options for _all_ versions of Git that we build. And
>      it's possible for two versions to require conflicting knobs. E.g.,
>      building with "make NO_OPENSSL=Nope OPENSSL_SHA1=Yes" causes
>      imap-send.c to barf, because it declares a fallback typdef for SSL.
>      This is something we may want to fix, but of course many historical
>      versions are affected, and the interop scripts should be flexible
>      enough to build everything.

And here's the fix to make this combo work (and likewise, the "fast"
variant). We'd still want the interop fix for the reasons given above,
but it feels like one less gotcha for people to hit if they are using
OPENSSL_SHA1_FAST.

-- >8 --
Subject: [PATCH] imap-send: handle NO_OPENSSL even when openssl exists

If NO_OPENSSL is defined, then imap-send.c defines a fallback "SSL"
type, which is just a void pointer that remains NULL. This works, but it
has one problem: it is using the type name "SSL", which conflicts with
the upstream name, if some other part of the system happens to include
openssl. For example:

  $ make NO_OPENSSL=Nope OPENSSL_SHA1=Yes imap-send.o
      CC imap-send.o
  imap-send.c:35:15: error: conflicting types for ‘SSL’; have ‘void *’
     35 | typedef void *SSL;
        |               ^~~
  In file included from /usr/include/openssl/evp.h:26,
                   from sha1/openssl.h:4,
                   from hash.h:10,
                   from object.h:4,
                   from commit.h:4,
                   from refs.h:4,
                   from setup.h:4,
                   from imap-send.c:32:
  /usr/include/openssl/types.h:187:23: note: previous declaration of ‘SSL’ with type ‘SSL’ {aka ‘struct ssl_st’}
    187 | typedef struct ssl_st SSL;
        |                       ^~~
  make: *** [Makefile:2761: imap-send.o] Error 1

This is not a terribly common combination in practice:

  1. Why are we disabling openssl support but still using its sha1? The
     answer is that you may use the same build options across many
     versions, and some older versions of Git no longer build with
     modern versions of openssl.

  2. Why are we using a totally unsafe sha1 that does not detect
     collisions? You're right, we shouldn't. But in preparation for
     using unsafe sha1 for non-cryptographic checksums, it would be nice
     to be able to turn it on without hassle.

We can make this work by adjusting the way imap-send handles its
fallback. One solution is something like this:

  #ifdef NO_OPENSSL
  #define git_SSL void *
  #else
  #define git_SSL SSL
  #endif

But we can observe that we only need this definition in one spot: the
struct which holds the variable. So rather than play around with macros
that may cause unexpected effects, we can just directly use the correct
type in that struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2dd42807cd..ec68a06687 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -31,9 +31,6 @@
 #include "parse-options.h"
 #include "setup.h"
 #include "strbuf.h"
-#if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
-typedef void *SSL;
-#endif
 #ifdef USE_CURL_FOR_IMAP_SEND
 #include "http.h"
 #endif
@@ -85,7 +82,11 @@ struct imap_server_conf {
 
 struct imap_socket {
 	int fd[2];
+#if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
+	void *ssl;
+#else
 	SSL *ssl;
+#endif
 };
 
 struct imap_buffer {
-- 
2.46.0.883.g5805d96482

