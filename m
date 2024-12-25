Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97313A868
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735151926; cv=none; b=ElLQxzI3gediyW9hjMqKIpSbIsQ7lAcaxlqyu+M93zxGLqZO2GyoVLwR/YxEExnmjhpWWaz/nASa6N1MaLxwgWgNZlYS4zBIplh6N95BRvXQFcobfwSqAED5Yo3XyvUUBf6+5E7awH0U1AXYPlnB5yCTufFPYeTk9rewllo4Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735151926; c=relaxed/simple;
	bh=Z/JHz+z7FIsXGx+68zxNZULhRvRrrpElyuuK79vRy54=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kg3WaopPenKWkGv1Va1ggTmqdCcZzgguRjhbz0dHD9ZiYznzEcqlvHbVTFynDKzJRbP1Wuh378LiHpj113xLBvfjUTbd2T8vlS583GPtjEncerxslQoHKZoOReyQN+jaX4txrC8A8ZEipeyF/pGa/T1JxcN84+xhdLLrPVoVVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GQCEjvrR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GQCEjvrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735151916; x=1735756716; i=l.s.r@web.de;
	bh=k/f7vCIueZLUj1+/OP+ajP3BwxoOcliJCPq0CbxABq8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GQCEjvrRuvtZCPfPOrl8/w85sLIsVhlBqLpE7Oq9EiF9uiGqPiZ+79AiYiXamFUk
	 GhPTjQ7/QqRB8Ael8C2kAMdPThnM2F+11Typz87q1e0JSWm/R6J+RyCZxvub6hmdq
	 hr5FfgogTSGHLaNDck5UR4wmNmPazYtFMx3jwaBMkPjhJBEO/jF18cHACdDCns47c
	 VwTANakl7BS3wQUtk2Fu4PM+bFEwV3H5RMvLXH92MwAz4Nm6l2EHY/Ussg9FwmT+s
	 EvEAo49LjurcVegLniRjQySixpndDhqMAhWFBm5bPJQOug86APpP3bR/wLcTTNDxk
	 5EWk5vP7G0gfb9lIJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4bUq-1tPyZx46ru-001fbm; Wed, 25
 Dec 2024 19:38:36 +0100
Message-ID: <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de>
Date: Wed, 25 Dec 2024 19:38:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] reftable: fix allocation count on realloc error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Language: en-US
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RsUfda+umVSM49EO9ljw3kt2DwVFqxdyfCt0OibJOtIFFna5uxR
 aAvGrr+XKPzvJKxxOVKi8EjS3Q8Dau5fdwEnJqXfaoxX3bZBsytx6F6aknvbFLzHub4d2jd
 pOr8y/0+Oud+d0Uv41eL/Le7LlU/YQwCHpj4M9ipJV6bsJPVi+WxbrMdiOQF21hdDX7FWME
 eXIsILJHXbMrxUM8mHJ1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/26J9k6uNjg=;+KXNAUCtz/2KTHw9Q/AQjsZp7YT
 c9JcJo+D9RueUsAfITXgtMQ172v3V+zGhPwOrnxA3Y+ky+krxVssKlb1YycWxp7svvjbMckoq
 maroKAra9DmWvTdFYfpaVq9PE63W63JcQXe/106hnGC8JHHqphIKTH8WEiHFlPtOKWW8B6b77
 xw9DxOmim2eDzhpgYg3+CBUxjKFiURZC8Q6y9pSCpWgXOGCduuwdZmQFnOxWFFRhwjfno5zfI
 tb9hL6dBPGyLh2Eh+hEEkOrEqE9DU/N+r2/YqIH4uSV3GZt2RBpJ//x/mTJRQqPIXZRZ62Wd+
 TxF8gjPXn24iTmdOfxaKYjY1dSm/4MtlmXN4MveqI0RCig+34QgnQieQt/3vyz76gIhlz5rJJ
 rZgHF5bCqr8S68dfmCGX3x4uqwJobEuN+EP+TtBI8TDcc/Px5WUZ1AHaIFhsrgY7RsaUwrb1M
 lSHkOppQTzwq8P2sEkQ7tgCLn38ZHq/vDWXLkco+mh3g30YIzA8AMUE92l86EjWWKeTjNk0lP
 JN7NliW88bGoAS0RSpsljUn8qX5qYKYaIzSuwHBy3gz5HucGhJjWF6Mo2QzCh3IX9rQiMJ/5f
 /axiSTpUw0Tw1hP8a0C+bBwHRotKniOmECobKvrBM2pnpVWE+ol5cXHrY/aiyICkGI4ZCEypV
 LY7WYnTPPtJJoOXgupT4GblV/TWXtA8nBgipFLGABYZ+A0p2Ft0I/eSvP+lPAnEdNtF7dy3Fq
 W6A/mWCAKn/fF4LZ6IidiyfKY03sqT65QIf0X2aRL9DFDXKISh5GcUa6MB/nxWJGQyi0Jrqa/
 Zc8xovb9SPVkvVmKF5E9WgOfgGliv5bKHQ8bSsYgJSREMtCBbfg2d85Mim/Ri7MLO8bl+JfpB
 Y0ibZJJRGYdjIoY36nHA2TMkGYEXAZZ8ICaujTPGhJc3s9CWtbFpfzPsHMZ85kaIGCSHhGLNY
 IvDaZ7Ih/UTAwprh9all7d9amtb9ftfT8EUJeoOPqwilk4owbOFdlbHrEPqaXg+we9AJy3m0U
 psUaKjZEh/rgPZc7xiipuT4LtFOdYYd8SWOUOGcCBIbdaLYEzNLb7JQIQrl9vlQ+k8mpFUzfu
 oppbImzg8=

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
 reftable/basics.c | 11 +++--------
 reftable/basics.h | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 21 deletions(-)

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
index 259f4c274c..fa5d75868b 100644
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
+		reftable_free(x); \
 		alloc =3D 0; \
+	} else { \
+		alloc =3D reftable_alloc_grow_or_null_alloc; \
 	} \
 } while (0)

=2D-
2.47.1
