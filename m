Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333A1F16B
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712427079; cv=none; b=QcqYTq7XoFH8t0CezCvs5FZNWnsGTRg+mzHFn2o+UGN9y9bWVtBC5uRytkfW5dUVYkuDn99lE1ov3qOK87UR06B9DyfabmCWwFmZgrCh6IoTMtgoc+74Ml7NjOGCaXj1bW9heXe4V8nhEv5JF3chCopqUk9qN+Axv2zYUvdt5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712427079; c=relaxed/simple;
	bh=MM8zHnyGbZD8bdJTqxrwth+0AfoqbeO5efE6BEL0Hbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IyJ25WsoSsxbIABGsLP3x2MPqLQanccRDnWF3oJrCktbqhdeWrZ68xXDo731fGNXRfBer0Izzeodsia6KgI3N4b4JoAYNPptOOzGTJjPDKN6hpP0V8Ow5+aK13gdhsJaea+Mg3qQUve148hgnot3d7n+VdgU1nWwkje2PDgi8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVj8Gz6W; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVj8Gz6W"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 78EB62DB99;
	Sat,  6 Apr 2024 14:11:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=MM8zHnyGbZD8bdJTqxrwth+0A
	foqbeO5efE6BEL0Hbw=; b=wVj8Gz6WZKv6yxO8lgT/g+6ee0ZOJlrEqlJgYhIVU
	IPCz4GHp2xJc+RO0y+pl6PCp5UgQNHSLcto3vMxPHSXGT+HT87KOO35sNokYfVzr
	W0F6Y5aupbgmkRiYxoB/+Y2TMevoKpio70BptX+gRSh7Zo/hedwN8BRO80qS0vmf
	Uc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7145C2DB98;
	Sat,  6 Apr 2024 14:11:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8F772DB96;
	Sat,  6 Apr 2024 14:11:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: [PATCH] config: do not leak excludes_file
Date: Sat, 06 Apr 2024 11:11:12 -0700
Message-ID: <xmqqttkeicov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0DFB4EA0-F441-11EE-B945-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The excludes_file variable is marked "const char *", but all the
assignments to it are made with a piece of memory allocated just
for it, and the variable is responsible for owning it.

When "core.excludesfile" is read, the code just lost the previous
value, leaking memory.  Plug it.

The real problem is that the variable is mistyped; our convention
is to never make a variable that owns the piece of memory pointed
by it as "const".  Fixing that would reduce the chance of this kind
of bug happening, and also would make it unnecessary to cast the
constness away while free()ing it, but that would be a much larger
follow-up effort.

Reported-by: Rub=C3=A9n Justo <rjusto@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c         | 4 +++-
 t/t7300-clean.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index eebce8c7e0..ae3652b08f 100644
--- a/config.c
+++ b/config.c
@@ -1584,8 +1584,10 @@ static int git_default_core_config(const char *var=
, const char *value,
 	if (!strcmp(var, "core.askpass"))
 		return git_config_string(&askpass_program, var, value);
=20
-	if (!strcmp(var, "core.excludesfile"))
+	if (!strcmp(var, "core.excludesfile")) {
+		free((char *)excludes_file);
 		return git_config_pathname(&excludes_file, var, value);
+	}
=20
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 1f7201eb60..0aae0dee67 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'git clean basic tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 git config clean.requireForce no
--=20
2.44.0-501-g19981daefd

