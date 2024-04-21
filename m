Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDF219F9
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725965; cv=none; b=IWslq5vrTOmSkkg7FxYHuh0BhPWudP5BH+WZT2QeJ4ZxfchnIENL+GqblgH6KZYgzw5tBdETn3YfT0PJVoAWYFbCcPxZGAQcVvzv8aLesNlZYhIXHBJBAlRJ+KAtK4UzWHIo3+J2MKgFqGhanyBEdvGqF3smw5tmZW30eDCLkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725965; c=relaxed/simple;
	bh=rT4vsG1iA/ZIsyH8MtE/9r5rFjIfLsbLRZjmaadoPhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7vuXe95h/zsDgikMlX5AMKR8AeDhZEh35o6yotFA8W/q1r+H5TNqwSsTtOe5qpN1zHwM0DXCW0Z1mS8h4f8MIoOHVEKIeBFW7qW6h85ITu9LJamY03Uhrzfga186GGcb6Vi4zsE+pdkZezcvcqa59iZR9L34nBmutcxwQo6ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wwt3GCsL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wwt3GCsL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D233233CA;
	Sun, 21 Apr 2024 14:59:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=rT4vsG1iA/ZIsyH8MtE/9r5rF
	jIfLsbLRZjmaadoPhg=; b=Wwt3GCsL3eE5AVM0/RPUld3ftf/1GzVtpjqbu6Epp
	TjX5VpXUm3Zwed2QXp3WgEtLo0BXK0Le+eAeith1w7uhM7zfsP09ApcQsmmaFqnT
	Nsb8XlkVM9hmIQAzf7DJ2dyBOhcOh9X7vT4FAissPUuMov3gf30xoCmJ2pXi04SU
	/k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 54E71233C9;
	Sun, 21 Apr 2024 14:59:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C698A233C2;
	Sun, 21 Apr 2024 14:59:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3 2/2] format-patch: "--rfc=-(WIP)" appends to produce [PATCH (WIP)]
Date: Sun, 21 Apr 2024 11:59:15 -0700
Message-ID: <20240421185915.1031590-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-rc0
In-Reply-To: <20240421185915.1031590-1-gitster@pobox.com>
References: <xmqqy1993tc1.fsf@gitster.g>
 <20240421185915.1031590-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4248A6B8-0011-11EF-90EE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

In the previous step, the "--rfc" option of "format-patch" learned
to take an optional string value to prepend to the subject prefix,
so that --rfc=3DWIP can give "[WIP PATCH]".  This commit shows that
the mechanism can be extended easily to allow "--rfc=3D-(WIP)" [*1*]
to signal that the extra string is to be appended instead of getting
prepended, resulting in "[PATCH (WIP)]".

Having worked on the patch, I am personally not 100% on board with
this part of the feature myself, and that is why this update is a
separate step from the main "--rfc takes an optional string value"
step.

If a way to prepend an arbitrary adornment is added to the system,
and people can now say "--rfc=3DRESEND" to produce "[RESEND PATCH]",
those who used to use "[PATCH RESEND]" by tweaking the subject
prefix in other ways [*2*] would do one of three things:

 (1) keep using their existing ways and keep sending their message
     with the "[RESEND PATCH]" prefix.

 (2) rejoice in the new automation, switch to use "--rfc=3DRESEND",
     and start sending their messages with "[RESEND PATCH]" prefix
     instead of "[PATCH RESEND]" prefix.

 (3) complain and demand a way to append instead of prepend so that
     they can use an automation to produce "[PATCH RESEND]" prefix.

I do not believe in adding slightly different ways that allow users
to be "original" when such differences do not make the world better
in meaningful ways [*3*], and I expect there are many more folks who
share that sentiment and go to route (2) than those who go to route
(3).  If my expectation is true, it means that this patch goes in a
wrong direction, and I would be happy to drop it.


[Footnote]

 *1* The syntax takes inspiration from Perl's three-arg open syntax
     that uses pipes "open fh, '|-', 'cmd'", where the dash signals
     "the other stuff comes here".

 *2* ... because "--rfc" in released versions does not even take any
     string value to prepend, let alone append, to begin with.

 *3* https://lore.kernel.org/git/b4d2b3faaf2914b7083327d5a4be3905@manjaro=
.org/
     gathered some stats to observe that "[RFC PATCH]" is more
     common than "[PATCH RFC]" by a wide margin, while trying to see
     how common "[RESEND PATCH]" (or "[PATCH RESED]") were used (the
     answer: much less common).  But it wouldn't have needed to
     count "[PATCH RFC]" and "[RFC PATCH]" separately if using a
     prefix and not a suffix (or vice versa) were established more
     firmly as the standard practice.

     It is a fine example that useless diversity making needless
     work.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 4 ++++
 builtin/log.c                      | 8 ++++++--
 t/t4014-format-patch.sh            | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-forma=
t-patch.txt
index e553810b1e..dbccb210cd 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -247,6 +247,10 @@ RFC means "Request For Comments"; use this when send=
ing
 an experimental patch for discussion rather than application.
 "--rfc=3DWIP" may also be a useful way to indicate that a patch
 is not complete yet ("WIP" stands for "Work In Progress").
++
+If the string _<rfc>_ begins with a dash ("`-`"), the rest of the
+_<rfc>_ string is appended to the subject prefix instead, e.g.,
+`--rfc=3D'-(WIP)'` results in "PATCH (WIP)".
=20
 -v <n>::
 --reroll-count=3D<n>::
diff --git a/builtin/log.c b/builtin/log.c
index 5c1c6f9b15..dd11953260 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2063,8 +2063,12 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode =3D parse_cover_from_description(cover_fro=
m_description_arg);
=20
-	if (rfc)
-		strbuf_insertf(&sprefix, 0, "%s ", rfc);
+	if (rfc) {
+		if (rfc[0] =3D=3D '-')
+			strbuf_addf(&sprefix, " %s", rfc + 1);
+		else
+			strbuf_insertf(&sprefix, 0, "%s ", rfc);
+	}
=20
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 645c4189f9..fcbde15b16 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1394,6 +1394,15 @@ test_expect_success '--rfc=3DWIP and --rfc=3D' '
 	test_cmp expect-raw actual
 '
=20
+test_expect_success '--rfc=3D-(WIP) appends' '
+	cat >expect <<-\EOF &&
+	Subject: [PATCH (WIP) 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc=3D"-(WIP)" >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--rfc does not overwrite prefix' '
 	cat >expect <<-\EOF &&
 	Subject: [RFC PATCH foobar 1/1] header with . in it
--=20
2.45.0-rc0

