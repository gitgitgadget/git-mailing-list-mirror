Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C726AD8
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406238; cv=none; b=YOPvIhrgo0SRtnvKqTbfDSmC59IFhC66vFKR4Q9/776FcN5T66tV0fYNMAFj/hvuoB6Jk5OvdkPQWZJNZYn8rcyIUPrmZjiy/+/faNxHjxs2/zYwxYfNkV5NXwlj9x5Sde5k0SRHaTWV20zqqdkTOF669xQ336NxpJy3rb0TlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406238; c=relaxed/simple;
	bh=bfBLdkhvrjwwqfFtC8El3Pa5YQgL7Kuu8t+g5D8ajXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+JVzwvIaGCHM+REwXVLRyorQDRU91BArn/FVyncn4uTbVZ8jKu2N0uZIIIIkY7SVGna9zzA7FOSq7ZouuyJpdcy9mte3B3P+h0Tps/lwTFl7l6dY9qE4FGdu2vDLc3Q1DnuvfGPgDJOsGCksjWCRnchXcZvoqFoNePkkGU5mJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=J8iIDt9G; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J8iIDt9G"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D5B8126D0C;
	Sat,  2 Mar 2024 14:03:56 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=bfBLdkhvrjwwqfFtC8El3Pa5Y
	QgL7Kuu8t+g5D8ajXI=; b=J8iIDt9GohV1ixXpgduAPZBnb1aH59vSuFkvcC4f5
	e7XBdhYq0U+KGasm1+9toW4US86667uFY+zsCZhCw4v/xWBmJBIGMf1FfiJ4U4/I
	Ovhgj30Cvo1Tdvcijs4xM2PZneut2E3siiNcC8rTO8cMZVA+TK1/nXn4NxqARat+
	M8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CDE6F26D0B;
	Sat,  2 Mar 2024 14:03:56 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A73C26D09;
	Sat,  2 Mar 2024 14:03:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] unpack: replace xwrite() loop with write_in_full()
Date: Sat,  2 Mar 2024 11:03:46 -0800
Message-ID: <20240302190348.3946569-2-gitster@pobox.com>
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
 9CB8A4CA-D8C7-11EE-9390-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We have two packfile stream consumers, index-pack and
unpack-objects, that allow excess payload after the packfile stream
data. Their code to relay excess data hasn't changed significantly
since their original implementation that appeared in 67e5a5ec
(git-unpack-objects: re-write to read from stdin, 2005-06-28) and
9bee2478 (mimic unpack-objects when --stdin is used with index-pack,
2006-10-25).

These code blocks contain hand-rolled loops using xwrite(), written
before our write_in_full() helper existed. This helper now provides
the same functionality.

Replace these loops with write_in_full() for shorter, clearer
code. Update related variables accordingly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c     | 17 +++--------------
 builtin/unpack-objects.c |  8 +-------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a3a37bd215..856428fef9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1524,14 +1524,12 @@ static void final(const char *final_pack_name, co=
nst char *curr_pack_name,
 	struct strbuf pack_name =3D STRBUF_INIT;
 	struct strbuf index_name =3D STRBUF_INIT;
 	struct strbuf rev_index_name =3D STRBUF_INIT;
-	int err;
=20
 	if (!from_stdin) {
 		close(input_fd);
 	} else {
 		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name=
);
-		err =3D close(output_fd);
-		if (err)
+		if (close(output_fd))
 			die_errno(_("error while closing pack file"));
 	}
=20
@@ -1566,17 +1564,8 @@ static void final(const char *final_pack_name, con=
st char *curr_pack_name,
 		write_or_die(1, buf.buf, buf.len);
 		strbuf_release(&buf);
=20
-		/*
-		 * Let's just mimic git-unpack-objects here and write
-		 * the last part of the input buffer to stdout.
-		 */
-		while (input_len) {
-			err =3D xwrite(1, input_buffer + input_offset, input_len);
-			if (err <=3D 0)
-				break;
-			input_len -=3D err;
-			input_offset +=3D err;
-		}
+		/* Write the last part of the buffer to stdout */
+		write_in_full(1, input_buffer + input_offset, input_len);
 	}
=20
 	strbuf_release(&rev_index_name);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..f1c85a00ae 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -679,13 +679,7 @@ int cmd_unpack_objects(int argc, const char **argv, =
const char *prefix UNUSED)
 	use(the_hash_algo->rawsz);
=20
 	/* Write the last part of the buffer to stdout */
-	while (len) {
-		int ret =3D xwrite(1, buffer + offset, len);
-		if (ret <=3D 0)
-			break;
-		len -=3D ret;
-		offset +=3D ret;
-	}
+	write_in_full(1, buffer + offset, len);
=20
 	/* All done */
 	return has_errors;
--=20
2.44.0-84-gb387623c12

