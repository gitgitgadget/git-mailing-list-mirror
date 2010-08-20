From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xmalloc: include size in the failure message
Date: Fri, 20 Aug 2010 07:47:18 -0700
Message-ID: <7vhbipcpe1.fsf@alter.siamese.dyndns.org>
References: <1282309272-20906-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSsY-00020e-DS
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0HTOr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:47:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab0HTOr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:47:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F20ECF3BA;
	Fri, 20 Aug 2010 10:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2UK3A5snTDX5sPCmv56RnLvuxy4=; b=HglRbI
	04zrDYxoGmSqR3cG3WX765jVPHjeXoNMURjFueLoVP1lEzNSyuQ0DBRTOluDJQ+i
	e74v1xdcrv8F6KElXIPB7L71HIfYy9Mhaesv/+o4KNRjJLbOBH+Am/yUfYtRefpH
	dn4pDu+IeQPxJLxGxnaME58qL5Mus9QCRdrDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Llvvx4+eDgehhMeEdUqT9xuSh+dCZHbS
	Sfr3Oq6qAC9fgWd7k9z338A+FoHRjoHFZNitYSF1wDqxymT+ruGrF2SqR9x6Z4Ni
	VbAeIp0BtbTRgOfAmYOJVEtO5clLbakp+dsfaX/ybbSRwSvNZea+3u2xRTv6iyZW
	ckx3HHc3fLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B8E7CF3B8;
	Fri, 20 Aug 2010 10:47:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC35CCF3B7; Fri, 20 Aug
 2010 10:47:19 -0400 (EDT)
In-Reply-To: <1282309272-20906-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 20 Aug 2010 15\:01\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D76C3F80-AC69-11DF-A395-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154046>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Out-of-memory errors can either be actual lack of memory, or bugs (like
> code trying to call xmalloc(-1) by mistake). A little more information
> may help tracking bugs reported by users.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This kind of thing may help for cases like
>
> Subject: Out of memory error during git push
> http://thread.gmane.org/gmane.comp.version-control.git/153988

Unless a single allocation try to grab unreasonably amount of memory,
probably a failure from a specific single failure may not help much.

But why not.

>  wrapper.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index afb4f6f..7057cbd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -40,7 +40,7 @@ void *xmalloc(size_t size)
>  		if (!ret && !size)
>  			ret = malloc(1);
>  		if (!ret)
> -			die("Out of memory, malloc failed");
> +			die("Out of memory, malloc failed (tried to allocate %u bytes)", size);

Perhaps use %lu format with cast to ulong?

I see (conditional) use of %zu in alloc.c only for a debugging codepath
nobody exercises, which does this:

        #ifdef NO_C99_FORMAT
        #define SZ_FMT "%u"
        #else
        #define SZ_FMT "%zu"
        #endif

        static void report(const char *name, unsigned int count, size_t size)
        {
            fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
        }

which looks wrong.

-- >8 --
alloc.c: fix formatting size_t to string

Under NO_C99_FORMAT the format and the argument would not match if size_t
is not the same size as uint.  As the one in sha1_file.c seems to be done
in a better way, let's use that one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 alloc.c     |   11 ++---------
 cache.h     |    8 ++++++++
 sha1_file.c |    8 --------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/alloc.c b/alloc.c
index 6ef6753..5324115 100644
--- a/alloc.c
+++ b/alloc.c
@@ -51,19 +51,12 @@ DEFINE_ALLOCATOR(commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
-#ifdef NO_C99_FORMAT
-#define SZ_FMT "%u"
-#else
-#define SZ_FMT "%zu"
-#endif
-
 static void report(const char *name, unsigned int count, size_t size)
 {
-    fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
+    fprintf(stderr, "%10s: %8u (%" SZ_FMT " kB)\n", name, count,
+	    sz_fmt(size));
 }
 
-#undef SZ_FMT
-
 #define REPORT(name)	\
     report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
 
diff --git a/cache.h b/cache.h
index 37ef9d8..1cfc5f0 100644
--- a/cache.h
+++ b/cache.h
@@ -1101,4 +1101,12 @@ int split_cmdline(char *cmdline, const char ***argv);
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
 
+#ifdef NO_C99_FORMAT
+#define SZ_FMT "lu"
+static inline unsigned long sz_fmt(size_t s) { return (unsigned long)s; }
+#else
+#define SZ_FMT "zu"
+static inline size_t sz_fmt(size_t s) { return s; }
+#endif
+
 #endif /* CACHE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 0cd9435..4f392b9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,14 +25,6 @@
 #endif
 #endif
 
-#ifdef NO_C99_FORMAT
-#define SZ_FMT "lu"
-static unsigned long sz_fmt(size_t s) { return (unsigned long)s; }
-#else
-#define SZ_FMT "zu"
-static size_t sz_fmt(size_t s) { return s; }
-#endif
-
 const unsigned char null_sha1[20];
 
 int safe_create_leading_directories(char *path)
