Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AB158A3A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742997; cv=none; b=JI+GH7o8MZuog3KwEsmE7Ui6+7BRnn1/bE+mecx/ukpAyPcLLhmc8b+Ea8qh0JaV4VFh+LWVxuHoIsxQdLiD1BpEPI7T8W016jqAN3fBkLDEpj57baoIpVmFGOWHevzjnwxlSP1YXIgg6cIzW15B7ypz4ApLF1N+glg2hO6+ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742997; c=relaxed/simple;
	bh=ck3BFtd1ltyhi5GaxmtS2VzFLBxzlWURVPuIGQGM+5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtvARxhEnP0BjxR4JWWcTSSyxsLYarJ3A+B4AXerZh8TmuBjV0pspqmDad0RPaY6f1TIabdBcTUdAe++WmxuybYK12/sCwIluFGA2fDsHjWIuS3NKmMaodtFZUlNis5KZlGfWds15MKRmgqhi+/6RlsIHOh37oU4zbyEu3tQR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=AUEs+WUf; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="AUEs+WUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742994; x=1713002194;
	bh=ck3BFtd1ltyhi5GaxmtS2VzFLBxzlWURVPuIGQGM+5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AUEs+WUfpGNXRU5MStj87qUvw1Nky625seda90SWbqk682T9jtANGd6j6BwPnQi2L
	 rDvnlZja3beDm50ZUpKNFbWrj8EJ1TNovGBKB2sjkT0ev7sq4HNqgSB+osGbijgfjm
	 vUvHpR71TXXGz/pgBfb6fl/tDdiQAwPsl07d+zmD0j/8UM+wq3BwPyQpw5Mw834/JB
	 GrSCtF5mKVR0nQTN512KlDk5BhhEOPIWDQkiP+sYT6PHE26a2J7tuo7HUIf/NqjnPV
	 DJleeSlsWoK2/g9mB/xlGhovbPJpI88H7OpkPE4YbYUYYtrlU5iSjYi8O/mnS80hZU
	 ht+A5BcSn0zCA==
Date: Wed, 10 Apr 2024 09:55:49 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 4/8] fast-import: remove dead strbuf
Message-ID: <1cef05e59a806069cc921511329dea67eee80dba.1712741871.git.thalia@archibald.dev>
In-Reply-To: <cover.1712741870.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The strbuf in `note_change_n` is to copy the remainder of `p` before
potentially invalidating it when reading the next line. However, `p` is
not used after that point. It has been unused since the function was
created in a8dd2e7d2b (fast-import: Add support for importing commit
notes, 2009-10-09) and looks to be a fossil from adapting
`file_change_m`. Remove it.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0da7e8a5a5..7a398dc975 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2444,7 +2444,6 @@ static void file_change_cr(const char *p, struct bran=
ch *b, int rename)
=20
 static void note_change_n(const char *p, struct branch *b, unsigned char *=
old_fanout)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct branch *s;
 =09struct object_id oid, commit_oid;
@@ -2509,10 +2508,6 @@ static void note_change_n(const char *p, struct bran=
ch *b, unsigned char *old_fa
 =09=09die("Invalid ref name or SHA1 expression: %s", p);
=20
 =09if (inline_data) {
-=09=09if (p !=3D uq.buf) {
-=09=09=09strbuf_addstr(&uq, p);
-=09=09=09p =3D uq.buf;
-=09=09}
 =09=09read_next_command();
 =09=09parse_and_store_blob(&last_blob, &oid, 0);
 =09} else if (oe) {
--=20
2.44.0


