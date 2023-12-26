Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE710951
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QeLmIqH2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53B091D8701;
	Tue, 26 Dec 2023 18:32:30 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=t10ET0JO+R6qTaD0DHzjOuTwx
	1Nhi3Ain34zFZOMtSE=; b=QeLmIqH2R9nDWl8eG3Tf+eM0x0euy63v+QmyGqv3/
	1MDBNm4iau0CToPdsml3kyIhiwt6wbhhjjhrJMkgOipfFQVhdloaE8A6Py7kIqdH
	FKY9ZlW7nD25c4u6ZMih6sZm1mnelwNhPSeC9y3GwYIyoQKRPcaicmU1eJocI/LM
	Wo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B73C1D8700;
	Tue, 26 Dec 2023 18:32:30 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B52091D86FF;
	Tue, 26 Dec 2023 18:32:29 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 3/3] apply: code simplification
Date: Tue, 26 Dec 2023 15:32:18 -0800
Message-ID: <20231226233218.472054-4-gitster@pobox.com>
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
 091C70F2-A447-11EE-A731-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rewrite a bit hard-to-read ternary ?: expression into a cascade of
if/else.

Given that read-cache.c:add_index_entry() makes sure that the
.ce_mode member is filled with a reasonable value before placing a
cache entry in the index, if we see (ce_mode =3D=3D 0), there is
something seriously wrong going on.  Catch such a bug and abort,
instead of silently ignoring such an entry and silently skipping
the check.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 6b1adccb2f..493a263a48 100644
--- a/apply.c
+++ b/apply.c
@@ -3780,11 +3780,15 @@ static int check_preimage(struct apply_state *sta=
te,
 	}
=20
 	if (!state->cached && !previous) {
-		if (!trust_executable_bit)
-			st_mode =3D (*ce && (*ce)->ce_mode)
-				? (*ce)->ce_mode : patch->old_mode;
-		else
+		if (*ce && !(*ce)->ce_mode)
+			BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
+
+		if (trust_executable_bit)
 			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
+		else if (*ce)
+			st_mode =3D (*ce)->ce_mode;
+		else
+			st_mode =3D patch->old_mode;
 	}
=20
 	if (patch->is_new < 0)
--=20
2.43.0-174-g055bb6e996

