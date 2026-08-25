Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C732E12E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681048; cv=none; b=ghu4H1tA+7x4RUyBVJbJGnsD1/WyMzuoKRr8mvffp7DZMBC7mDy4Hd6m4sSYfn6NLS0LFnn0hAxb5fwL8WgbjNv6jMwbpH580W8TYuq5WNpq2Lyq842EVgXdrzX/70j6LYs9fBHYkFym6+jDzkYUe0yMHKu+cuda6RiC4Azyg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681048; c=relaxed/simple;
	bh=rBNmjLhKSqkN+nLu56XDGfABU+gysytqDN6SeoatGR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaLyzmHV+nGpogdV/9AspIDV0AI8/2ZyiMXODLoLiuE35VsC719p1yNl1jGzNcrBXCyWXINUuED2743mWk9GFKLxRCHnB0yIJ22Vrm2Mpv5n4UCxP9D/iM45L6c74GUBxfX4W6Pm3YmkqBrFI/nOpfeB+4YCJW3uy8ZLyZ60bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FqatDIuU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FqatDIuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787681036; x=1788285836; i=l.s.r@web.de;
	bh=JMwGPsNe9FQH01r/F9+DFhY3pwqpbz1+m0QTfcJUY/I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FqatDIuUfZy0tbqm//kfP7Flt/q3xHTzuxfhDKPnAWfaTC4kmisLo4WQ1Y0POcwO
	 3CrGhCDaA2x7VxRis6fKponqJ5GSmF/Sp+4SXvtm/WiVuIFK9xJhRSmOMmyIkS9jz
	 a3mKS1RETDZuI9g0Ok5/GFZy8MuxIdOxGKUCLN5hLE8/KMI8gBTdA0bOZDcKCsUKS
	 xgmASXMPIAhHcVuTBJXMyTXC1eHL8Qxp0cmU4fvKQ4/dZgU6u81C2Wlf5IvYnr0oI
	 afNDR+CY4foj3KZqhq1P7VIRXWEjfTE/HH31saklFzaxdrJLehIzZOIKP4gHQfaDS
	 N8bT+liMv/Qu+6G3kQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1wmeTw2xP2-00sKVw; Tue, 25
 Aug 2026 20:03:56 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Subject: [PATCH 1/4] worktree add: don't read out of bounds in worktree_basename()
Date: Tue, 25 Aug 2026 20:03:47 +0200
Message-ID: <20260825180350.2099-2-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825180350.2099-1-l.s.r@web.de>
References: <20260825180350.2099-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ScTo82s+rgzA6X8RHPOohc2MTZcn7OCYW+1cMDX0DUIJsh7rnHP
 8kP8miUZAGYcbmZXiiW5bFGWPqCOY9WuKrGfgtPkUxnM+Q1ez7+8XRA5MKm3llghddgaZ5o
 gzeHdMWCz2RSa66IdyhrOE9VRU8JWj79GKKzSyg9NGar72MPfNeRagknYNeONslIJcjZuaX
 d+xbWEzi9/iPgZkF++G2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aHMR+aLAucQ=;cPX7qanrm5bfXLRryRJE/K4SWH+
 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
 =

When we search for the start of the basename and `len` is zero, `name`
ends up being `path` - 1, out of bounds.  Avoid that by checking before
decrementing.

Fixes https://github.com/git-for-windows/git/issues/6346.

Original-patch-by: Matthias A=C3=9Fhauer <mha1993@live.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..a770dd5ead 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,11 +303,9 @@ static const char *worktree_basename(const char *path=
, int *olen)
 	while (len && is_dir_sep(path[len - 1]))
 		len--;
=20
-	for (name =3D path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
+	name =3D path + len;
+	while (name > path && !is_dir_sep(name[-1]))
+		name--;
=20
 	*olen =3D len;
 	return name;
=2D-=20
2.55.0

