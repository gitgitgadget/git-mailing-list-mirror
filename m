Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA00C13D
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468401; cv=none; b=Kai3zR+YZ7w+zVCvXpUKblKVGCU9Xp9t9prUCvtbBqeiMDreLK3pe5bRHf+Zon+GnODMPxz2smSlC1wPzq2fng9ThayDla2xJVIfwVgclZERXVAt9b7LCoBfoXJW2BfhwznZ6xhfNt81VMRuneO0McKjtU6wQdaZlr3eRSaSm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468401; c=relaxed/simple;
	bh=SXKOH9kzxlmw7arRinl11yNleQFuBmLCTCOP3/PU0lQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/EbO/g6V9C9JunQ7s2gNJgVLWmnOcyl3SkjRRolRU19ghskOwNUdz+9sRr+5wSRo/BwhSE4b26uR2AssyQHhD7SmSzKYIlxKum1Zw+uc96xHGzRlN6HxDxhUmOdd9PvGX21WTeqbB3d7qp9s8vtbVY9b5OkQu99x0ldUSP+hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GKaWJ2vE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GKaWJ2vE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468393; x=1710073193; i=l.s.r@web.de;
	bh=SXKOH9kzxlmw7arRinl11yNleQFuBmLCTCOP3/PU0lQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=GKaWJ2vE1wWfzDkmCzJlq3is68z+bmdlaV1NfQ5oHGGIVFtoowGi4OtkDaJeB/Po
	 cxBNzs39OD+dXZZyl6CzMP5hL/rDMGZgox1Zlz+bpZTO1mmKfEpbsz4L3Znla+zAj
	 UdPlJrfhmFj1NIprS+zlwizKF1+TPXfTf4/HAU96vt6upU/ZakIjjClhfrXG7Fe3+
	 UQvnfxYIFyL6masmWTwKdSIWPOqDyBN6AEHDpcBToVq98kF9EEaIsVZqYM/E3NGwS
	 7LRhnnYWK1CbzmD0Ny0lmUW23NP6Ouyhb1I7WNeLspMhlQdmfRMEf2EJrwjJwD62T
	 ocDX6KAQ3tIx6Wew4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MrOhn-1r30Lm1vzL-00oPer for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 2/6] parse-options: set arg of abbreviated option lazily
Date: Sun,  3 Mar 2024 13:19:39 +0100
Message-ID: <20240303121944.20627-3-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uM+V6pGPt+VgygEjLkspfSQUZczj3ZMF6BUSv/DwxSTkndVGXhF
 bSgSNd8R0p8Z7mRzkEzUeZucdrrhw49CG+ASN8kdQPBaHCXio9CKCPwvQ7cx1hySYumzWPt
 YxyAzRLnWi0Azokpvp2e3CFtIJLbKiyNEnR6ahZ1ZjrMyf9wTYlvgpZNrgOX4cCCR1TctZI
 9r6Fi1iGPwmGJHvuP/K6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r6w7WAuTd9k=;WhoW4O0LbwesaQwLy5mpGbaBIim
 Usr4tCH8wpPILNshP/PqjNpls7NL0sll7Vtt6SNN7RFV3uES5vLBzr04nT+IlLxiaFmO6Xrh5
 Qt0Y1i3yZTxjvKUgBrwPRL8AcxK2YlU0QICRqPu2e233iVLba8PwvI4KaXFHkw0lldpHvoDq/
 jC9o5kK7HxgW3YxhhyUb0LdS6go12CQZZH1JZLfpLDuHNqm3VucJOuHes2VOnCoAFx8uQUtC3
 zcpBn+VgmEiEFfHfE2nKK/P2BSZ2jDB+j4ITSJCCjYZj9plh/5rTM7/LjEKbjrKs5wlZb2Iah
 bcOlTP+SF01gp2bRRt/XvToDUIO7lKFMiC9hEITKqqO05KLuO/C5bTY0R067HCpcpeVyIsA26
 Db9p9F3nLZo4JFupLKDPUvFrUMDefHrQgefwzAgrDv6yqReT6LWuP7ZoaeDBRVB86VyIuQCe/
 r1OxcUBNXH3Fi9eSGt+3Id0z6ruwDH2Q+YVcdE5cLAoFlbh5hTRVqBFWPF4ODiFuTchh5icYF
 /vPAL6uT8oFGgKPHMc4bwVyHW1AFw/eDs4x4H67Cm3BECql1PweeqFrjUwiCT64B4raHobzpB
 K297sZtSR9gD0FYx9IVPTrocugZpiI2F68VZB+h5FLZCuIyjzQHuCbWHJbMzy3vAKPIzX9OIT
 Ep1R6Y2McQEbm5X72vFIxpwJv/9E4EhRx/xNZXcyhfhJnsZ3WBQ9BGC37SjB5hWiinfex9O2/
 oC/J+F+BY8uutVLvB7ENR4gTpa4PE1v9CtaCaHYd+UPmZarRFiowB75qj2rOBAwth+RawUHwz
 ZyhzxVTA487Eg+2N4h5toPelAmLvn1HdNAg6uS2NjhNSk=

Postpone setting the opt pointer until we're about to call get_value(),
which uses it.  There's no point in setting it eagerly for every
abbreviated candidate option, which may turn out to be ambiguous.
Removing this assignment from the loop doesn't noticeably improve the
performance, but allows further simplification.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e4ce33ea48..056c6b30e9 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -391,8 +391,6 @@ static enum parse_opt_result parse_long_opt(
 					ambiguous_option =3D abbrev_option;
 					ambiguous_flags =3D abbrev_flags;
 				}
-				if (*arg_end)
-					p->opt =3D arg_end + 1;
 				abbrev_option =3D options;
 				abbrev_flags =3D flags ^ opt_flags;
 				continue;
@@ -441,8 +439,11 @@ static enum parse_opt_result parse_long_opt(
 			abbrev_option->long_name);
 		return PARSE_OPT_HELP;
 	}
-	if (abbrev_option)
+	if (abbrev_option) {
+		if (*arg_end)
+			p->opt =3D arg_end + 1;
 		return get_value(p, abbrev_option, abbrev_flags);
+	}
 	return PARSE_OPT_UNKNOWN;
 }

=2D-
2.44.0

