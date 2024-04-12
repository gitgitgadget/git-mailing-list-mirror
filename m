Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D54AEE3
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909022; cv=none; b=Ibw7Nep3q5qHh2wfAHshQoZqxdfyA/D3Fwzt7agEy7nJoHgCwOkJqy5Dak8d7Vs7NDbDiaFF8GWm7n7SaFuV26NT/6w2saUWKPp+s4N6yrciYTStZpHnp/XA1Z4aS2kaYOoPX1+iI11uTb0BKflwJti0iR2p6q8CYbr3Mw4uIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909022; c=relaxed/simple;
	bh=ck3BFtd1ltyhi5GaxmtS2VzFLBxzlWURVPuIGQGM+5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjaATn2Z2S5lPrHZt7qqVJIlH46k1C0xpnKIRPA7MB49oZzYmYP27lszNeafhjB2ZqFcWmr8XnDhJARj2OMsHmudm/NAhanZvXXXG+0KzEQXTbhx+gchdYZV1aULIY3jsOM0J+9OzOW5A3LBM400lFT3BnaCgVfTJUbu/cHlE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=V4pB4cdm; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="V4pB4cdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712909007; x=1713168207;
	bh=ck3BFtd1ltyhi5GaxmtS2VzFLBxzlWURVPuIGQGM+5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=V4pB4cdmxN5FYHKdreujSOxqfZcKJ/d15sqD407dsQt48AoeZBGSATRQ9zt5LrkNv
	 rDqTHjBwgxttU63aNvLD+OOKqY8L8cPPP5Gk2AnJv/KBzYLPQDLmmhIGac5MFQiYH5
	 8x08nPsDHB8kUZ2+1VZ/MzVojRknZ0LWF+/jBfOGk6weev64NZ6OxdGUS0ZNlerJXK
	 l9KBYtwvwQTJA3+cDEnXBh/pl52gRMJWSxfTRJdQr3qbfF0HMMeitavvcEbIz+yX3y
	 CaC2TcICo6WzTH0cYZ3k4brgFJ9rY/oykrwP9oayicj9pcdicCVfXL/FhLZevZSAH3
	 5cAbKblJ2JtBw==
Date: Fri, 12 Apr 2024 08:03:22 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v4 4/8] fast-import: remove dead strbuf
Message-ID: <1a2b0dc6162c754fa63525c017801b2cf25fead3.1712907684.git.thalia@archibald.dev>
In-Reply-To: <cover.1712907684.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev>
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


