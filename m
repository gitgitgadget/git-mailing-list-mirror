Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815571AA3DE
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365048; cv=none; b=vB4KU2DZqF2PBX5H3Crnuhr6VWnWvBjNOqXfp5oou8qzZ5AiwgDe7hTWYfVkEq74hgbw8ejwFCjYon3tZ902eE4COC5P7mEE7DzYJe9wl6ZG2HIuHKNqt7LcVZqhLxZ8/deJ4plMqLcsESAe8uZtWsqr1ovCsVlAP037SbnXjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365048; c=relaxed/simple;
	bh=peNggeRphG34L/UmwcpDr6En10ce6XQJ2ph26t0OO+0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieoOCE6e3fADsJBkzqhk0Mam/baRN2HNA3GNsTLcrUvhjQ2TigCz0F7nDC7+pPesRepu3C6TCEXKvyLVLEeTun7VNF0pNv3CBKd28GBtiB4obyWyU1Ks+LmV87gin8xyA7i/HHYa92dxco/6yWHp7CTCkN0uBCUhigehQwHoV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zad2DxQj; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zad2DxQj"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E5ED11ACC2;
	Tue, 30 Jul 2024 14:44:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=peNggeRphG34L/UmwcpDr6En1
	0ce6XQJ2ph26t0OO+0=; b=Zad2DxQj8n/qP8xcOQR8/fJsZNpddGLHtGBhvCrwv
	2PUYH0sv80iJTVEmstcxZtA9U7ts0PSHUideKntw4nBRWE9I/sGh9Gh3KKRpudwH
	4DwhgYnxHW1NzaPwkNpnf4B4FWEAjfXvC0lUucf3MD0laPAuUPyPob4Brn7K1dED
	Xs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DFCBA1ACC1;
	Tue, 30 Jul 2024 14:44:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DF2E1ACBF;
	Tue, 30 Jul 2024 14:43:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 1/4] safe.directory: preliminary clean-up
Date: Tue, 30 Jul 2024 11:43:49 -0700
Message-ID: <20240730184352.2503276-2-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-77-g633c50689c
In-Reply-To: <20240730184352.2503276-1-gitster@pobox.com>
References: <20240730011004.4030246-1-gitster@pobox.com> <20240723021900.388020-1-gitster@pobox.com> <20240720220915.2933266-1-gitster@pobox.com>
 <20240730184352.2503276-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 AE74B454-4EA3-11EF-B346-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

The paths given in the safe.directory configuration variable are
allowed to contain "~user" (which interpolates to user's home
directory) and "%(prefix)" (which interpolates to the installation
location in RUNTIME_PREFIX-enabled builds, and a call to the
git_config_pathname() function is tasked to obtain a copy of the
path with these constructs interpolated.

The function, when it succeeds, always yields an allocated string in
the location given as the out-parameter; even when there is nothing
to interpolate in the original, a literal copy is made.  The code
path that contains this caller somehow made two contradicting and
incorrect assumptions of the behaviour when there is no need for
interpolation, and was written with extra defensiveness against
two phantom risks that do not exist.

One wrong assumption was that the function might yield NULL when
there is no interpolation.  This led to the use of an extra "check"
variable, conditionally holding either the interpolated or the
original string.  The assumption was with us since 8959555c
(setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02) originally introduced the safe.directory
feature.

Another wrong assumption was that the function might yield the same
pointer as the input when there is no interpolation.  This led to a
conditional free'ing of the interpolated copy, that the conditional
never skipped, as we always received an allocated string.

Simplify the code by removing the extra defensiveness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index d458edcc02..3177d010d1 100644
--- a/setup.c
+++ b/setup.c
@@ -1235,17 +1235,15 @@ static int safe_directory_cb(const char *key, con=
st char *value,
 		char *allowed =3D NULL;
=20
 		if (!git_config_pathname(&allowed, key, value)) {
-			const char *check =3D allowed ? allowed : value;
-			if (ends_with(check, "/*")) {
-				size_t len =3D strlen(check);
-				if (!fspathncmp(check, data->path, len - 1))
+			if (ends_with(allowed, "/*")) {
+				size_t len =3D strlen(allowed);
+				if (!fspathncmp(allowed, data->path, len - 1))
 					data->is_safe =3D 1;
-			} else if (!fspathcmp(data->path, check)) {
+			} else if (!fspathcmp(data->path, allowed)) {
 				data->is_safe =3D 1;
 			}
-		}
-		if (allowed !=3D value)
 			free(allowed);
+		}
 	}
=20
 	return 0;
--=20
2.46.0-77-g633c50689c

