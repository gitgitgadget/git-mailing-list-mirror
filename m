Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C63FE54
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406241; cv=none; b=aVTHlc76/qClRIqipI3D/3yechM9smKbdki0dFbBWYqF8cffRLFiuJPYcT0fidwLFcjRVhD7q4/aVtA6gn7D1/YarZVB4D/DD5zHq0oWXg5AiSE/GvCPAnIado/NQU4mZ9spEu1mlYVRm/qYOPHNDHRACFZcnp9l3O/eMC7TFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406241; c=relaxed/simple;
	bh=XaOz0t95BPKfm/vULkguS+6VCx7JT12I9sJEbNBvkZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kkt1XXvM5TdHLpM8x4nEeHVwRJOmUMUuzCaQbl+ILuoMBg+YZtyS6PLfeS79zYV0NUAm2lNXC6mbLum0pSHwo5NUGhaPJ20PGlPnsOts+F8uVXPAqgczXny0PIe257drCD5UlC03L/MSawvabJzUbqyFFt4Wzo1lVXwTQYjHY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xvNuewLm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xvNuewLm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E18211E4D65;
	Sat,  2 Mar 2024 14:03:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XaOz0t95BPKfm/vULkguS+6VC
	x7JT12I9sJEbNBvkZQ=; b=xvNuewLmsJQ+fok/adYK/V0jAK1woM9wahGdVgdX4
	tqGFc9g3rmd9NY7yeqaQdMfTOLqmm16naUWDZLVAvRyJgz5Q+m6OJOaF+JuAqE0J
	FQe/szjBcoEJvYMgwyn2N9vl8FGogALjmqGfjQta1zylJycD5nquxogMF7kAiW8Y
	wc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C9F1E4D64;
	Sat,  2 Mar 2024 14:03:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50DBB1E4D63;
	Sat,  2 Mar 2024 14:03:58 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] repack: check error writing to pack-objects subprocess
Date: Sat,  2 Mar 2024 11:03:48 -0800
Message-ID: <20240302190348.3946569-4-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-84-gb387623c12
In-Reply-To: <20240302190348.3946569-1-gitster@pobox.com>
References: <20240302190348.3946569-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9FA407BA-D8C7-11EE-B984-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

When "git repack" repacks promisor objects, it starts a pack-objects
subprocess and uses xwrite() to send object names over the pipe to
it, but without any error checking.  An I/O error or short write
(even though a short write is unlikely for such a small amount of
data) can result in a packfile that lacks certain objects we wanted
to put in there, leading to a silent repository corruption.

Use write_in_full(), instead of xwrite(), to mitigate short write
risks, check errors from it, and abort if we see a failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ede36328a3..15e4cccc45 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -314,8 +314,9 @@ static int write_oid(const struct object_id *oid,
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
=20
-	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
-	xwrite(cmd->in, "\n", 1);
+	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 |=
|
+	    write_in_full(cmd->in, "\n", 1) < 0)
+		die(_("failed to feed promisor objects to pack-objects"));
 	return 0;
 }
=20
--=20
2.44.0-84-gb387623c12

