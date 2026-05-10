Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354F379EDC
	for <git@vger.kernel.org>; Sun, 10 May 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416947; cv=none; b=lsn8NWNW4V95egQopJMiKK5lx2xfNifT1XqbGzaDUmv+7a3bdKIqTkwJbWRvY23Gr/tgndy9KT9nkzTu25NA7rgyYjF5vijmS2yOBc6+zC1lqP0HBknWFmArGmGJzIlwo7iR64+wPlSPH9eyAV5epb+Md9iywTu705zKgVjQdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416947; c=relaxed/simple;
	bh=a7SdtbDT3qjdPAlMvhae5ndUVEK5CyO+edhqEQGGE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQjketEXPLQi3QA03B/Kt0nEJNpX9GipX8/tJLfgDUgfebbFrOsnGXEqQoju0xIVLdLkojqjkA7jeKnn1DZNRTzZHuNdhb6vy1uj5sV/ueJPstiJnV7t0u91NAf9jpH2gGJHaw7YvrxbHFsFMPZ9e0+Gr5GnNSrUnp/SCuJ8fdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BXH4YZwv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BXH4YZwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778416924; x=1779021724; i=l.s.r@web.de;
	bh=9hizcNomQe3MyDSvSc9m0XXlAhxW1Za9hHPmjaCeWOY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BXH4YZwvB0be746SELezxwOPAwJbYFRw8hgeTUBQ9jo5Rdp7MrLAoSaObup+8pMa
	 vyS4pr3wICyr8W2ogrZbhF7QBL9DdK9EOUFtqw+5j0v1eJOwxrJ27c+bAyxExVP9o
	 S40DJ5j3IaOj/Xjt573nf7gVk7c466srvGMUEvWn/4hFjw3TVgTlpoQ4kWDIk0xoe
	 Q1u9okJBPV09u5PVy6MoMmsjZU551Z0dic//LtGejuZenF9gEzboucAFvrKOzBib6
	 VSVs6GatJCFlfsTHVz6q8Te6WFRxkB9yodX2om112ItY6rgDaPp2jgU1MLXO0++yX
	 jwwza7J41FkwxdYbdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1wVN9i37fm-009oeT; Sun, 10
 May 2026 14:42:04 +0200
Message-ID: <9826dabf-c9a6-4397-8ae6-a24f9c507f1b@web.de>
Date: Sun, 10 May 2026 14:42:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] sideband: clear full line when printing remote messages
To: Chris Torek <chris.torek@gmail.com>,
 Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: git@vger.kernel.org
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
 <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLRO85M221rEtmWRWWzLOfpOgT6wGphzSXk5ddvhQKbGUcXP1Gy
 M4wV3gYzIeeKrj1WRTRDa7IaYbDCc+BqQLdzPer9qYRkY5Z13CYf0ak0xd0s6et4Dzncrz6
 9K2kVX9pcIS66K0nkN/D5XIVRzBafpS9CelOCy99cCjyclZT4Tv2lKg5vOO2zkcjCItOoWV
 QDjndNfmMxO87TNTgCHTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iJnHVLPVXcg=;zbREEtfGODxmkNKKkTtkUJYf4lR
 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
 WfA8FBc8QHC4wFQTWK0lkdxRqnnrBZbzor2A=

demultiplex_sideband() can write its remote output over active local
progress lines.  That's why it has been using ANSI code Erase in Line on
smart terminals to clear the remainder of lines it writes since
ebe8fa738d (fix display overlap between remote and local progress,
2007-11-04).

This erases the last character of remote lines that span the full width
of the terminal, though, as the cursor is stuck at the rightmost column
for them.  It's the same effect as in the following command, which
clears the 1 and shows just the leading zeros:

   $ EL=3D"\033[K"
   $ printf "%0${COLUMNS}d${EL}\n" 1

If we move the ANSI code to the start we get to see the 1 as well:

   $ printf "${EL}%0${COLUMNS}d\n" 1

So do the same in demultiplex_sideband() and emit the ANSI code as a
prefix instead of a suffix to show messages in full even if they happen
to fill the whole width of a smart terminal.

Reported-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Suggested-by: Chris Torek <chris.torek@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 sideband.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..48ed4c8099 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -120,7 +120,7 @@ static void maybe_colorize_sideband(struct strbuf *des=
t, const char *src, int n)
=20
 #define DISPLAY_PREFIX "remote: "
=20
-#define ANSI_SUFFIX "\033[K"
+#define ANSI_PREFIX "\033[K"
 #define DUMB_SUFFIX "        "
=20
 int demultiplex_sideband(const char *me, int status,
@@ -129,15 +129,18 @@ int demultiplex_sideband(const char *me, int status,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type)
 {
-	static const char *suffix;
+	static const char *prefix, *suffix;
 	const char *b, *brk;
 	int band;
=20
 	if (!suffix) {
-		if (isatty(2) && !is_terminal_dumb())
-			suffix =3D ANSI_SUFFIX;
-		else
+		if (isatty(2) && !is_terminal_dumb()) {
+			prefix =3D ANSI_PREFIX DISPLAY_PREFIX;
+			suffix =3D "";
+		} else {
+			prefix =3D DISPLAY_PREFIX;
 			suffix =3D DUMB_SUFFIX;
+		}
 	}
=20
 	if (status =3D=3D PACKET_READ_EOF) {
@@ -171,8 +174,7 @@ int demultiplex_sideband(const char *me, int status,
 	case 3:
 		if (die_on_error)
 			die(_("remote error: %s"), buf + 1);
-		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
-			    DISPLAY_PREFIX);
+		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "", prefix);
 		maybe_colorize_sideband(scratch, buf + 1, len);
=20
 		*sideband_type =3D SIDEBAND_REMOTE_ERROR;
@@ -203,7 +205,7 @@ int demultiplex_sideband(const char *me, int status,
 				strbuf_addstr(scratch, suffix);
=20
 			if (!scratch->len)
-				strbuf_addstr(scratch, DISPLAY_PREFIX);
+				strbuf_addstr(scratch, prefix);
=20
 			/*
 			 * A use case that we should not add clear-to-eol suffix
@@ -229,8 +231,8 @@ int demultiplex_sideband(const char *me, int status,
 		}
=20
 		if (*b) {
-			strbuf_addstr(scratch, scratch->len ?
-				    "" : DISPLAY_PREFIX);
+			if (!scratch->len)
+				strbuf_addstr(scratch, prefix);
 			maybe_colorize_sideband(scratch, b, strlen(b));
 		}
 		return 0;
=2D-=20
2.54.0
