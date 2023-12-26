Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C5107AF
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q3MNYKDb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC3551DE124;
	Tue, 26 Dec 2023 18:32:28 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=O+I0h+A+q65ko/KgJC0FiVJng
	mCBXHw3gDDf+DEsxAg=; b=q3MNYKDb2R5Ub2cCoU+ISMQZZN52C5jThzAKUbc0d
	PhcwqCrWqTzzZdTU5dCGo1J7VmV419JbNbKSSLfE2LtD8UAXZrXb57ut4fC9213D
	vsrGf1QiKaY1+Ce4fa8JiauVl9DpbxHJDOUfleCGpUzCeokUEdKAn9dON57UP+Sc
	ik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D66C81DE123;
	Tue, 26 Dec 2023 18:32:28 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 344CD1DE122;
	Tue, 26 Dec 2023 18:32:28 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/3] apply: correctly reverse patch's pre- and post-image mode bits
Date: Tue, 26 Dec 2023 15:32:17 -0800
Message-ID: <20231226233218.472054-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
In-Reply-To: <20231226233218.472054-1-gitster@pobox.com>
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
 <20231226233218.472054-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 08336C90-A447-11EE-A45D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

When parsing the patch header, unless it is a patch that changes
file modes, we only read the mode bits into the .old_mode member of
the patch structure and leave .new_mode member as initialized, i.e.,
to 0.  Later when we need the original mode bits, we consult .old_mode.

However, reverse_patches() that is used to swap the names and modes
of the preimage and postimage files is not aware of this convention,
leading the .old_mode to be 0 while the mode we read from the patch
is left in .new_mode.

Only swap .old_mode and .new_mode when .new_mode is not 0 (i.e. we
saw a patch that modifies the filemode and know what the new mode
is).  When .new_mode is set to 0, it means the preimage and the
postimage files have the same mode (which is in the .old_mode member)
and when applying such a patch in reverse, the value in .old_mode is
what we expect the (reverse-) preimage file to have.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 3b090652cf..6b1adccb2f 100644
--- a/apply.c
+++ b/apply.c
@@ -2220,7 +2220,8 @@ static void reverse_patches(struct patch *p)
 		struct fragment *frag =3D p->fragments;
=20
 		SWAP(p->new_name, p->old_name);
-		SWAP(p->new_mode, p->old_mode);
+		if (p->new_mode)
+			SWAP(p->new_mode, p->old_mode);
 		SWAP(p->is_new, p->is_delete);
 		SWAP(p->lines_added, p->lines_deleted);
 		SWAP(p->old_oid_prefix, p->new_oid_prefix);
@@ -3780,9 +3781,8 @@ static int check_preimage(struct apply_state *state=
,
=20
 	if (!state->cached && !previous) {
 		if (!trust_executable_bit)
-			st_mode =3D (*ce && (*ce)->ce_mode) ? (*ce)->ce_mode :
-				(state->apply_in_reverse
-				 ? patch->new_mode : patch->old_mode);
+			st_mode =3D (*ce && (*ce)->ce_mode)
+				? (*ce)->ce_mode : patch->old_mode;
 		else
 			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
 	}
--=20
2.43.0-174-g055bb6e996

