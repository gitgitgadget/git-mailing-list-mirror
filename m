Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96A185E4F
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021088; cv=none; b=Ltu4qgQsckee6REh9+V777NOzzOqPhWuXyu0PPygjWLHqyC4D4CYbVHQgkLbc1dKyL1jZ1jiZfTNYv+jcyyv2ak38ZHQJSObQ/kPEmoepHi/vg2HZbTb9E3DIyj4MD/FOI6Zd8jUYOqtBRbwr78h1R6Nr7Uy+eLexHK8ae1358c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021088; c=relaxed/simple;
	bh=tnTNuUah18SgSEi14IH9aikOULs+vfgc8cO6jloSDm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvMsaqUrs/v65htgYNv0hGnHTO2Kbd58C5aohWm/4bzbclyZrV28cj613b8f2p+vlkZ3YiDleeTDxxDMeiDVTINNHaAcRoeD2wTqKtB6+My0j42Kuzfr5vyJDiGNWqmQZ0uITwIbj/ug4Oj7HMNqvnT49wi2pzTK5QDA5PjxBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAqu4JJX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAqu4JJX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5A262E054;
	Wed,  3 Jul 2024 11:38:06 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=tnTNuUah18SgSEi14IH9aikOU
	Ls+vfgc8cO6jloSDm0=; b=dAqu4JJX2/hn381Kzz2TDriDshitwPLHQVlJwB2c9
	CyJbYiAWrW9lNWpoX1M4bFdg+W+mFLaf5nCO5wtHKlofJVg9M7koJBBBlPssY5+2
	VQi5G0gJieWdZx85ddNUWsPQJv0Avnp/16CZuh4bPtElInhws4MRCjbU462rxvaf
	IU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DE98E2E053;
	Wed,  3 Jul 2024 11:38:06 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FC082E04E;
	Wed,  3 Jul 2024 11:38:01 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/2] t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
Date: Wed,  3 Jul 2024 11:37:31 -0400
Message-ID: <20240703153738.916469-2-tmz@pobox.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703153738.916469-1-tmz@pobox.com>
References: <20240703153738.916469-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3BD32FCC-3952-11EF-9324-C38742FD603B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

We create the $GNUPGHOME directory in both the GPG and GPGSSH prereqs.
Replace the redundancy with a function.

Use `mkdir -p` to ensure we do not fail if a test includes more than one
of these prereqs.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index add11e88fc..4e44f182bb 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -9,6 +9,11 @@
 GNUPGHOME=3D"$PWD/gpghome"
 export GNUPGHOME
=20
+prepare_gnupghome () {
+	mkdir -p "$GNUPGHOME" &&
+	chmod 0700 "$GNUPGHOME"
+}
+
 test_lazy_prereq GPG '
 	gpg_version=3D$(gpg --version 2>&1)
 	test $? !=3D 127 || exit 1
@@ -38,8 +43,7 @@ test_lazy_prereq GPG '
 		# To export ownertrust:
 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
 		#		> lib-gpg/ownertrust
-		mkdir "$GNUPGHOME" &&
-		chmod 0700 "$GNUPGHOME" &&
+		prepare_gnupghome &&
 		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
@@ -132,8 +136,7 @@ test_lazy_prereq GPGSSH '
 	test $? =3D 0 || exit 1;
=20
 	# Setup some keys and an allowed signers file
-	mkdir -p "${GNUPGHOME}" &&
-	chmod 0700 "${GNUPGHOME}" &&
+	prepare_gnupghome &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMA=
RY}" >/dev/null &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_S=
ECONDARY}" >/dev/null &&
--=20
2.45.2

