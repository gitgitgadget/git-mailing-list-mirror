Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472551F181F
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950186; cv=none; b=f5jITN9swICM/oHJugfqo7GeCRkyIFurGWweMDGBqJ4Jzh5Wum0EYv53y85wkpFhER+ccIVRKTX0YBwpPI/NYoJt53rUn5wv4szPfEowgdnyNWhCfL6L5gxW1y6etPJt1tfQUev80tHvtRA/NYqMKTDrDPEd3wAThYTF7BHqG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950186; c=relaxed/simple;
	bh=8Bej10sPsA1pHS8YjZmVZ30sFMjHkAmnF9BkNUzIyyM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nMFaruPE1pwaF1GVk2Ld73Bq/2uug3sFQ5zeENmfF3RIHDKBX1RZFdNvzPV5UrBI6qgRfsTrfQ9aGr8OpfqfZi86wHQUwOuEKXqvDlyoLJNh2ECnVvzxyAy/DJrP0VXse3lYqculi3BbxLrkSCCHw0Kf42+5QSg9+lqOmvYPBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KqC393JI; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KqC393JI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1761950172; x=1762209372;
	bh=8Bej10sPsA1pHS8YjZmVZ30sFMjHkAmnF9BkNUzIyyM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KqC393JIQq65IwqE3P25IW5Vp/1+tMmBSaut2CNlxzzm52cLS7X6+cJ1tD1ULKRG0
	 LHNiHWZ5uZkc40lOE6zQgwS5gtyg4Ve2WdhOcKNA6TcZbCPsilMzPQbxVqagErh/UW
	 PFpWsVGMQjZNZ/o533gmaVmzr6AzdHeJ/ASVHWRToseYISl23jZ1TglRslG6633AMe
	 3lPOGEuDpNmyZqpuS7VlKe0RKZjTU6C8UlYFiQRXYIVz2H10XDCjx98facUFtoSHux
	 zACfPlEKizT2vY9Ugay747CGexa4DFphpfuwG1AIM6o36o38XLMCMD2qktkHaWOGMt
	 N9WWe104rhfMQ==
Date: Fri, 31 Oct 2025 22:36:06 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: keita <rudykeita@proton.me>
Cc: "outreachy@gitgitgadget.github.io" <outreachy@gitgitgadget.github.io>
Subject: [Outreachy][PATCH] fsck: use starts_with() in fsck_commit()
Message-ID: <ZnguenVBGUNCP_SasWltMBlNoXc9tGPVGW8CkPcMu0Dw8KbZnXaBEipkyvNjU7H8dJ-Yi6atr93mzNPDznQjdXCENwL04OGyCX1CN0xNC-E=@proton.me>
Feedback-ID: 145215173:user:proton
X-Pm-Message-ID: 52f2331751a5d5c179a8346d5ac136e390252d03
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 30136adebaffb97edacae2c58c4ea491e39e3f5b Mon Sep 17 00:00:00 2001From:=
 Songiso Cooper Lyambai <rudykeita@proton.me>
Date: Fri, 31 Oct 2025 23:45:23 +0200
Subject: [PATCH] fsck: use starts_with() in fsck_commit()

*=C2=A0Replace manual buffer checks with starts_with() for safety and clari=
ty.=C2=A0
*This avoids buffer overreads and follows Git's idiomatic style used=C2=
=A0

--- fsck.c | 124 +++++++++++++++++++++++++++++++-------------------------- =
1 file changed, 67 insertions(+), 57 deletions(-) diff --git a/fsck.c b/fsc=
k.c index 341e100d24..7172c4ff1c 100644 --- a/fsck.c +++ b/fsck.c @@ -921,6=
7 +921,77 @@ static int fsck_ident(const char **ident, } static int fsck_co=
mmit(const struct object_id *oid, - const char *buffer, unsigned long size,=
 - struct fsck_options *options) + const char *buffer, unsigned long size, =
+ struct fsck_options *options) { - struct object_id tree_oid, parent_oid; =
- unsigned author_count; - int err; - const char *buffer_begin =3D buffer; =
- const char *buffer_end =3D buffer + size; - const char *p; + struct objec=
t_id tree_oid, parent_oid; + unsigned author_count =3D 0; + int err =3D 0; =
+ const char *buffer_end =3D buffer + size; + const char *p; - /* - * We _m=
ust_ stop parsing immediately if this reports failure, as the - * memory sa=
fety of the rest of the function depends on it. See the - * comment above t=
he definition of verify_headers() for more details. - */ - if (verify_heade=
rs(buffer, size, oid, OBJ_COMMIT, options)) - return -1; - if (buffer >=3D =
buffer_end || !skip_prefix(buffer, "tree ", &buffer)) - return report(optio=
ns, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tre=
e' line"); - if (parse_oid_hex(buffer, &tree_oid, &p) || *p !=3D '\n') { - =
err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid '=
tree' line format - bad sha1"); - if (err) - return err; - } - buffer =3D p=
 + 1; - while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffe=
r)) { - if (parse_oid_hex(buffer, &parent_oid, &p) || *p !=3D '\n') { - err=
 =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'p=
arent' line format - bad sha1"); - if (err) - return err; - } - buffer =3D =
p + 1; - } - author_count =3D 0; - while (buffer < buffer_end && skip_prefi=
x(buffer, "author ", &buffer)) { - author_count++; - err =3D fsck_ident(&bu=
ffer, oid, OBJ_COMMIT, options); - if (err) - return err; - } - if (author_=
count < 1) - err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTH=
OR, "invalid format - expected 'author' line"); - else if (author_count > 1=
) - err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "in=
valid format - multiple 'author' lines"); - if (err) - return err; - if (bu=
ffer >=3D buffer_end || !skip_prefix(buffer, "committer ", &buffer)) - retu=
rn report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid fo=
rmat - expected 'committer' line"); - err =3D fsck_ident(&buffer, oid, OBJ_=
COMMIT, options); - if (err) - return err; - if (memchr(buffer_begin, '\0',=
 size)) { - err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT=
, - "NUL byte in the commit object body"); - if (err) - return err; - } - r=
eturn 0; + /* + * We _must_ stop parsing immediately if this reports failur=
e, as the + * memory safety of the rest of the function depends on it. See =
the + * comment above the definition of verify_headers() for more details. =
+ */ + + if (verify_headers(buffer, size, oid, OBJ_COMMIT, options)) + retu=
rn -1; + + + if (!skip_prefix(buffer, "tree ", &buffer)) + return report(op=
tions, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, + "invalid format - expected=
 'tree' line"); + if (parse_oid_hex(buffer, &tree_oid, &p) || *p !=3D '\n')=
 { + return report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, + "inv=
alid 'tree' line format - bad sha1"); + } + buffer =3D p + 1; + + while (st=
arts_with(buffer, "parent ")) { + if (!skip_prefix(buffer, "parent ", &buff=
er) || + parse_oid_hex(buffer, &parent_oid, &p) || *p !=3D '\n') { + return=
 report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, + "invalid 'par=
ent' line format - bad sha1"); + } + buffer =3D p + 1; + } + + while (start=
s_with(buffer, "author ")) { + author_count++; + if (!skip_prefix(buffer, "=
author ", &buffer)) + return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISS=
ING_AUTHOR, + "invalid format - expected 'author' line"); + if ((err =3D fs=
ck_ident(&buffer, oid, OBJ_COMMIT, options))) + return err; + } + + if (aut=
hor_count < 1) + return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_A=
UTHOR, + "invalid format - expected 'author' line"); + if (author_count > 1=
) + return report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, + "i=
nvalid format - multiple 'author' lines"); + + if (!starts_with(buffer, "co=
mmitter ")) + return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMM=
ITTER, + "invalid format - expected 'committer' line"); + + if (!skip_prefi=
x(buffer, "committer ", &buffer)) + return report(options, oid, OBJ_COMMIT,=
 FSCK_MSG_MISSING_COMMITTER, + "invalid format - expected 'committer' line"=
); + + if ((err =3D fsck_ident(&buffer, oid, OBJ_COMMIT, options))) + retur=
n err; + + if (memchr(buffer, '\0', buffer_end - buffer)) + return report(o=
ptions, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT, + "NUL byte in the commit =
object body"); + + return 0; }




Signed-off-by: Songiso Cooper Lyambai <rudykeita@proton.me>
