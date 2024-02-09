Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F263A7
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511329; cv=none; b=qBtumt3Tg8TdUvLBb8592njlekagVE71xh03X6AFPNBWavFV0W+zhdpdQ9vjBGpX+v1PpH+9KHYSkSlDXhPxnp7yNbxvEqWVwvbp5f39+oF2FrYMMx610BT+ek86qCb5N8yX0q8OMcKBjG8AwQsEmaFXu5zh4maNysD79nz2scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511329; c=relaxed/simple;
	bh=cJ00YPPfc+eeUDmaJyV8HOAl1hXzny9bwtSSDE2qBS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q4fUKmz8pjNiEFWNnwAudf6ZFc8pxrZ+OhV4PMBo8VrauV/kMRSXa+D3KmvBJcbmF3e7F4XzPe7k95RtrH6Ljv1da0v32cnO2Kvf7czlefoJr9aQboi/k5GVSNDfEJaJRulm3jyQEhXe1Hfb7aVjAMHb36uFiQ/WZkWh97DTj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LdykzOQM; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LdykzOQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707511308; x=1708116108; i=l.s.r@web.de;
	bh=cJ00YPPfc+eeUDmaJyV8HOAl1hXzny9bwtSSDE2qBS8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=LdykzOQMmJngygFlLqcUEOkqhEKL4JWSp12Scr5jGVjixOuERDgFsicZgWfIWTq3
	 6xKAaeBxG4w6LCTr0lZBVntRfjZso4utBCyS1m0++0iV4kU9vxuffJgPJv5pyeCm4
	 lZ5VhmhY3m57zpbr8BaDD9U7H/EdV+GuLLnbzDmOrhxaeAFsSzxJ+Yvfp9jJFkTwn
	 Ulr7oPtPxBbpZLCKfgrcEeNP0gnxk1FaZrRuYXrHY4eouJDcS7+MT4rNthH+q4PKD
	 K2GPk9+eADCk8Htjv709UrcvSpSi18NcDqJKQPpXOdgFuF0vVsFeaxGkOOzo7cFvs
	 d5VMUs3coav8TkbUdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.17.81]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0PP-1rijuI3gNB-00CS4a; Fri, 09
 Feb 2024 21:41:47 +0100
Message-ID: <8b350cae-2180-4ac7-a911-d40043576445@web.de>
Date: Fri, 9 Feb 2024 21:41:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] receive-pack: use find_commit_header() in check_nonce()
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>, Jeff King <peff@peff.net>,
 Kyle Lippincott <spectral@google.com>, John Cai <johncai86@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
In-Reply-To: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZpbQwgqWu4xYiKuy0rmUePUZXCpIzAe5YGCEWAzGITLjmQfKTB
 oznsvfb1rZe2x5CEXSL5UkPezS16T9Gd9IJNagP3n1IE8Rcl9JBNLw7Ljwp0MU7vJ3+hQxO
 3ONtpgOfTJXB7lF+xm9Mx9HUish8pr5V18gFr/CY5Cl10Xc2tRWNiN0ZAF0vtjklknwk52T
 kiEH7EZ7RvWxL07F676tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xeRzycT1sW4=;9t2P4fbdKxHd/itXMYh/XaAvrrC
 +1crT2TyHOY8QqMlM8rMmF7oJBn6LPoEDy9/IWFuIBKD0PvWsVKWFGgymcbWkhme4nqd5zWCw
 9/8Bg76ufuOabq9RKjxCAu3EnAPMWOJl6zL8Jz+tSCCVOikIfUDBPe25HWToldyW+jVkEbpan
 DSQGPWlCUKH0cpfiHj8gSXuLlqv0zHf3axeLIm+EznXnJ3a/s+2aHMCM6/aBrNbDMLTAucg9G
 AtduhvSp+eErRAu/3MXB2/ukmuD7Sv6kgYoI9rx8g991Kan9iGbWhSPrzlfT+GPTWCS9n52RF
 lh+7zC7KWCthZx6YPBbUHlBnA27SOTtju5MSGfo+jVw/6JAj3r9i5BK9gqrMJuUyebtt0lK/j
 6uHNF5dUxlFEtKPqTb+cEhYc5/x7YZCkYhQAm887b3+7xbT9CDpG2EKu/dGmvEXO4ZxOPI0Yb
 YOhHgsaAeayABgEEgFaeObEVe7XI7aR86f0ZzXiWVLGoltM6ioQSZe/WSj4HOj3FZoakRN4xt
 H/gvQVUYu4xajxxGH3/OdCM5MsqJXSY+tDwSgmxx+GncPLyy8KnCmLsjuN4qjM4SKrGyjnYTP
 o1+3U/TOF3lC8/zNHwmflRTzw8KXSh2Y4GnfHlhHdvYZ2JE19a7ZoLK7e5LsFQF0F7zxT/7WT
 CaJB/z3Okel2dVsN90rz15T8Hz4Tt0elzeg27UctPNIeWlgLxlv4Ct7JM8sd+ow+/H0sA3H7t
 kxXskQEyUrV7OyD10xDwnY5Zps2NitrdfHNxD1Yvpa+mXfvKPNIuyVx8xoHOUcNcMAgPCJrqE
 VLt1or8Qoo969ilRtRVhqkiPaMjr4+ZF4kHADbFdHDlrg=

Use the public function find_commit_header() and remove find_header(),
as it becomes unused.  This is safe and appropriate because we pass the
NUL-terminated payload buffer to check_nonce() instead of its start and
length.  The underlying strbuf push_cert cannot contain NULs, as it is
built using strbuf_addstr(), only.

We no longer need to call strlen(), as find_commit_header() returns the
length of nonce already.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with -U5 for easier review.
Removing find_header_mem(), which basically becomes unused, left as an
exercise for the reader. ;)

 builtin/receive-pack.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8ebb3a872f..dbee508775 100644
=2D-- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -591,25 +591,10 @@ static char *prepare_push_cert_nonce(const char *pat=
h, timestamp_t stamp)
 	/* RFC 2104 5. HMAC-SHA1 or HMAC-SHA256 */
 	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, (int)the_hash_algo->hexsz, h=
ash_to_hex(hash));
 	return strbuf_detach(&buf, NULL);
 }

-static char *find_header(const char *msg, size_t len, const char *key,
-			 const char **next_line)
-{
-	size_t out_len;
-	const char *val =3D find_header_mem(msg, len, key, &out_len);
-
-	if (!val)
-		return NULL;
-
-	if (next_line)
-		*next_line =3D val + out_len + 1;
-
-	return xmemdupz(val, out_len);
-}
-
 /*
  * Return zero if a and b are equal up to n bytes and nonzero if they are=
 not.
  * This operation is guaranteed to run in constant time to avoid leaking =
data.
  */
 static int constant_memequal(const char *a, const char *b, size_t n)
@@ -620,17 +605,18 @@ static int constant_memequal(const char *a, const ch=
ar *b, size_t n)
 	for (i =3D 0; i < n; i++)
 		res |=3D a[i] ^ b[i];
 	return res;
 }

-static const char *check_nonce(const char *buf, size_t len)
+static const char *check_nonce(const char *buf)
 {
-	char *nonce =3D find_header(buf, len, "nonce", NULL);
+	size_t noncelen;
+	const char *found =3D find_commit_header(buf, "nonce", &noncelen);
+	char *nonce =3D found ? xmemdupz(found, noncelen) : NULL;
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect =3D NULL;
 	const char *retval =3D NONCE_BAD;
-	size_t noncelen;

 	if (!nonce) {
 		retval =3D NONCE_MISSING;
 		goto leave;
 	} else if (!push_cert_nonce) {
@@ -668,11 +654,10 @@ static const char *check_nonce(const char *buf, size=
_t len)
 	if (bohmac =3D=3D nonce || bohmac[0] !=3D '-') {
 		retval =3D NONCE_BAD;
 		goto leave;
 	}

-	noncelen =3D strlen(nonce);
 	expect =3D prepare_push_cert_nonce(service_dir, stamp);
 	if (noncelen !=3D strlen(expect)) {
 		/* This is not even the right size. */
 		retval =3D NONCE_BAD;
 		goto leave;
@@ -765,11 +750,11 @@ static void prepare_push_cert_sha1(struct child_proc=
ess *proc)
 		sigcheck.payload =3D xmemdupz(push_cert.buf, bogs);
 		sigcheck.payload_len =3D bogs;
 		check_signature(&sigcheck, push_cert.buf + bogs,
 				push_cert.len - bogs);

-		nonce_status =3D check_nonce(push_cert.buf, bogs);
+		nonce_status =3D check_nonce(sigcheck.payload);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
 		strvec_pushf(&proc->env, "GIT_PUSH_CERT=3D%s",
 			     oid_to_hex(&push_cert_oid));
 		strvec_pushf(&proc->env, "GIT_PUSH_CERT_SIGNER=3D%s",
=2D-
2.43.0
