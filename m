Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A578C6C
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379288; cv=none; b=Pi/5+VOSELBHdcuGLdZZ/fCeGfMB3W3fxJ/xCOV9Loy+99tcdcvHZpTkWItDptvkGyEJBf/hIAg8fG7vG5CeqC31r0W87X2JnqbJyXa6XuVp98KhV6npql9035vUsFaTJ2YYWSOyqpwj56vBC7uJsF8/kstJ7wIunqdJiDiKAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379288; c=relaxed/simple;
	bh=F0R2c5OzU4OHtrCBw1mEJYKk3Z7/EY7aroh9EMGqZBU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ajPJ/Phu/bBPfYR0I0/umiVaFc9evRClVsuvJS7g+RJDBPvjL+/rR6kdibDKWZhlyoMM327yQ67HwYjCqh0BeMkov3Ua6Zn2NCM06am+S5BcDK4EISYqM4usHRFSTZjn+8bnkKadJ+Et7+WemeNufOQ03nT/f5GYL7WJQskddKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PLLrVQbo; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PLLrVQbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735379281; x=1735984081; i=l.s.r@web.de;
	bh=LyUm3heSyZSHQOyd2BRQ1Rpa3Uq9HkHmGjrahLY6Ge8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PLLrVQboI6h06v0CUXDgVnYYC/wnKxFGXteZiBGLGdjGnz4zz0ckI1aCR7MYcSwN
	 5mWTfLKtXmoYdNIV/f5OApKyJeAd+WZwrl/dAO5EnrhsZyAf/3lLyOcavgDm5SBtV
	 upQmYL3DY+42FfEl96bExXaupudtfPqV1ecqD+4FAba0LyQ8217ub3JgRLdtBzHw0
	 /xV2Gk3ViSBbfbRyXfw1WahYyKtRS2JpkjXP9o+y2fNWUBE586B6F0Cw6eFaSL93O
	 /R3rZV4MuOpYwqbfla1Lm+eCrSe8UwV5QAL0r1WftWPTeQcwCtA0C4u6cAG21wULM
	 FBZdkCbDMatkc2a6qQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1t8yw60pUp-00KEE3; Sat, 28
 Dec 2024 10:48:01 +0100
Message-ID: <8bc6592f-f589-4c72-84d7-bd16ea9d753c@web.de>
Date: Sat, 28 Dec 2024 10:48:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] reftable: fix allocation count on realloc error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Language: en-US
In-Reply-To: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27/oszUJNAFZJsPT8zO0e/OFoRc2FpTU83RRaD6LrB5jelOqJPo
 tW9RqrSRXr+V1mZfPyrte8K/Z/0rbFPT6+xwVfKptrXXYt7Z1xBsafbts0AtY5qzigXnWZo
 38Oijrl7rSr0HgKcTCPyoRWD3dsF4fh58Pqh5F+DeQXi4BMLsvlPXfsuEUuneT/Yx2vR4Nm
 lTPpZfitOnFAYYNJ4yEGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jjMMp2fvGl4=;YtFTdExdpp3FzkBbLyf9iHFf5Rz
 Peh6YfSIjfC7LG4iZLjn3nCdpkfg1vaZo3+CEJSW5Vf0Z6Hes2ThC+IYFrIiqNSL5eOqEpWEx
 9ny5+9RX1dhQpfnoLWdUAxgT5UYw9xLDPULzUXXXxTYo6zhqRFDpm5uFcTmTDPPouLgBJksAJ
 7Jl0zKz7WnN16rr6s0I0WL6k0wE529ufuMzG+a0u7Gy1dnjYMCTGeVEU/cVf9NdE1qxy6h7PK
 toa/pr/kaVVQsskrORewRbohuI2pIi5ZvNo9LokjQon+sxzzls+XG7cGXRbcdY9XFSHQVKxCa
 f+CHmQEiMJ/W+BnnwuWVdSOoLqN/hgv+HTnJombNpHii0KSCHV88L+nCPCf+GgteS2ddr9rc2
 jNbV+o8Q1lmY86Kwu6wsAWSL21Gvkccrqfq6RzATLYgVS1ErIKh0umrERtTtqZhMlzTZfmXjU
 4Z/ktlJsKw/nsW5qqZq50U1h2YEUA4TgXRbz+faAdvQwRq/MAnWQkULbdOQn7YSbjbH5UkgyR
 1/tOz3wU8MLNXJWmUpbn+ode0sosI9ouy7SdsT9tLJxzuIH12/xg/YBAdMN0UkX2Myrtezvt0
 JecSDxYun9OxlJxoeOOPm94r9eLLVLthdiWX9/kZulJmqtaBwg2Nur4OqLKr7KO5iqrVigyS7
 KwhvMBKgwbQwsRfJlz5U+Km96sYiBk7iZeww8O/Ro9CO1dyY1ZuO4VYXYgwJ80Fln29kMtkAm
 eZ3ND5Y3wquMTIqejZFguEvC8B3ky02lunHyLdwf5dbzzXF4CxH5/OADeqDAgym25a6B4KEHG
 AoajKHjfgJrRgMShRkpSsR1/saHpzObwW47n5o6lTXFXu0cyasRy6Isg0cYrCHeHKpP5HOWfp
 5Vl4oWOUNLS4PAr5/9Edw+jCZDR1VRXgEDzCHGXE3IRBOhW9jsDoG3IJoe9TXOLPdprsr5s9Z
 CQFFGVxndXNjljAeHM0HegPbWsBY1eLFohmfyEhPGEKXpJKSJ2A6ONmd0WFaIHL+gKRJ5WLE3
 uP1qiGQs1YDBjlMFvkvTzg/QCHmXCpldhFcdFVJQRmSdITFSEafD5K3hRDLkWIGUzNNhB85ZH
 lpK/8AA6Q=

When realloc(3) fails, it returns NULL and keeps the original allocation
intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
the allocation count variable in that case, simultaneously leaking the
original allocation and misrepresenting the number of storable items.

parse_names() avoids the leak by keeping the original pointer if
reallocation fails, but still increase the allocation count in such a
case as if it succeeded.  That's OK, because the error handling code
just frees everything and doesn't look at names_cap anymore.

reftable_buf_add() does the same, but here it is a problem as it leaves
the reftable_buf in a broken state, with ->alloc being roughly twice as
big as the actually allocated memory, allowing out-of-bounds writes in
subsequent calls.

Reimplement REFTABLE_ALLOC_GROW to avoid leaks, keep allocation counts
in sync and still signal failures to callers while avoiding code
duplication in callers.  Make it an expression that evaluates to 0 if no
reallocation is needed or it succeeded and 1 on failure while keeping
the original pointer and allocation counter values.

Adjust REFTABLE_ALLOC_GROW_OR_NULL to the new calling convention for
REFTABLE_ALLOC_GROW, but keep its support for non-size_t alloc variables
for now.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/basics.c                | 11 +++------
 reftable/basics.h                | 39 +++++++++++++++++++++-----------
 t/unit-tests/t-reftable-basics.c | 26 +++++++++++++++++++++
 3 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 70b1091d14..cd6b39dbe9 100644
=2D-- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -124,11 +124,8 @@ int reftable_buf_add(struct reftable_buf *buf, const =
void *data, size_t len)
 	size_t newlen =3D buf->len + len;

 	if (newlen + 1 > buf->alloc) {
-		char *reallocated =3D buf->buf;
-		REFTABLE_ALLOC_GROW(reallocated, newlen + 1, buf->alloc);
-		if (!reallocated)
+		if (REFTABLE_ALLOC_GROW(buf->buf, newlen + 1, buf->alloc))
 			return REFTABLE_OUT_OF_MEMORY_ERROR;
-		buf->buf =3D reallocated;
 	}

 	memcpy(buf->buf + buf->len, data, len);
@@ -233,11 +230,9 @@ char **parse_names(char *buf, int size)
 			next =3D end;
 		}
 		if (p < next) {
-			char **names_grown =3D names;
-			REFTABLE_ALLOC_GROW(names_grown, names_len + 1, names_cap);
-			if (!names_grown)
+			if (REFTABLE_ALLOC_GROW(names, names_len + 1,
+						names_cap))
 				goto err;
-			names =3D names_grown;

 			names[names_len] =3D reftable_strdup(p);
 			if (!names[names_len++])
diff --git a/reftable/basics.h b/reftable/basics.h
index 259f4c274c..4bf71b0954 100644
=2D-- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -120,22 +120,35 @@ char *reftable_strdup(const char *str);
 #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) =3D reftable_malloc(st_mult(si=
zeof(*(x)), (alloc)))
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) =3D reftable_calloc((alloc), =
sizeof(*(x)))
 #define REFTABLE_REALLOC_ARRAY(x, alloc) (x) =3D reftable_realloc((x), st=
_mult(sizeof(*(x)), (alloc)))
-#define REFTABLE_ALLOC_GROW(x, nr, alloc) \
-	do { \
-		if ((nr) > alloc) { \
-			alloc =3D 2 * (alloc) + 1; \
-			if (alloc < (nr)) \
-				alloc =3D (nr); \
-			REFTABLE_REALLOC_ARRAY(x, alloc); \
-		} \
-	} while (0)
+
+static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t els=
ize,
+					size_t *allocp)
+{
+	void *new_p;
+	size_t alloc =3D *allocp * 2 + 1;
+	if (alloc < nelem)
+		alloc =3D nelem;
+	new_p =3D reftable_realloc(p, st_mult(elsize, alloc));
+	if (!new_p)
+		return p;
+	*allocp =3D alloc;
+	return new_p;
+}
+
+#define REFTABLE_ALLOC_GROW(x, nr, alloc) ( \
+	(nr) > (alloc) && ( \
+		(x) =3D reftable_alloc_grow((x), (nr), sizeof(*(x)), &(alloc)), \
+		(nr) > (alloc) \
+	) \
+)

 #define REFTABLE_ALLOC_GROW_OR_NULL(x, nr, alloc) do { \
-	void *reftable_alloc_grow_or_null_orig_ptr =3D (x); \
-	REFTABLE_ALLOC_GROW((x), (nr), (alloc)); \
-	if (!(x)) { \
-		reftable_free(reftable_alloc_grow_or_null_orig_ptr); \
+	size_t reftable_alloc_grow_or_null_alloc =3D alloc; \
+	if (REFTABLE_ALLOC_GROW((x), (nr), reftable_alloc_grow_or_null_alloc)) {=
 \
+		REFTABLE_FREE_AND_NULL(x); \
 		alloc =3D 0; \
+	} else { \
+		alloc =3D reftable_alloc_grow_or_null_alloc; \
 	} \
 } while (0)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-ba=
sics.c
index 5bf79c9976..990dc1a244 100644
=2D-- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -146,6 +146,32 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUS=
ED)
 		check_int(in, =3D=3D, out);
 	}

+	if_test ("REFTABLE_ALLOC_GROW works") {
+		int *arr =3D NULL, *old_arr;
+		size_t alloc =3D 0, old_alloc;
+
+		check(!REFTABLE_ALLOC_GROW(arr, 1, alloc));
+		check(arr !=3D NULL);
+		check_uint(alloc, >=3D, 1);
+		arr[0] =3D 42;
+
+		old_alloc =3D alloc;
+		old_arr =3D arr;
+		reftable_set_alloc(malloc, realloc_stub, free);
+		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
+		check(arr =3D=3D old_arr);
+		check_uint(alloc, =3D=3D, old_alloc);
+
+		old_alloc =3D alloc;
+		reftable_set_alloc(malloc, realloc, free);
+		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
+		check(arr !=3D NULL);
+		check_uint(alloc, >, old_alloc);
+		arr[alloc - 1] =3D 42;
+
+		reftable_free(arr);
+	}
+
 	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
 		int *arr =3D NULL;
 		size_t alloc =3D 0, old_alloc;
=2D-
2.47.1
