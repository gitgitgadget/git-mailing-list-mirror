Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F5C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258FC60234
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhIETIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 15:08:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51139 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIETIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5BC1151708;
        Sun,  5 Sep 2021 15:07:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=2/6AvU6ZalkuO1n7RL6sLDrOy
        E394IlKB6M1GpYldGc=; b=KD7g1gC6tIk4jh4a8+FeBwub15zyxwldL+ngdjUnU
        UOa8tOlhGXL2s9PNb0p47aYVVPC6r74f7wqYSuKo7aU0tP+bNcfrET9n2DcI6ojo
        bH1m7RYp4+GJzvFvo2ERWVtBcUZRvmVg65vblJqX4wQoYIJu+gr/6K7LLOmTGzKx
        8Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD79F151707;
        Sun,  5 Sep 2021 15:07:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1EFF7151705;
        Sun,  5 Sep 2021 15:06:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     lilinchao@oschina.cn, Elijah Newren <newren@gmail.com>,
        jerry@skydio.com
Subject: [PATCH v2] apply: resolve trivial merge without hitting ll-merge with "--3way"
Date:   Sun,  5 Sep 2021 12:06:57 -0700
Message-Id: <20210905190657.2906699-1-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-408-g8e1aa136b3
In-Reply-To: <xmqqczr26i9f.fsf@gitster.g>
References: <xmqqczr26i9f.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 71E880CA-0E7C-11EC-8B57-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ll_binary_merge() function assumes that the ancestor blob is
different from either side of the new versions, and always fails
the merge in conflict, unless -Xours or -Xtheirs is in effect.

The normal "merge" machineries all resolve the trivial cases
(e.g. if our side changed while their side did not, the result
is ours) without triggering the file-level merge drivers, so the
assumption is warranted.

The code path in "git apply --3way", however, does not check for
the trivial three-way merge situation and always calls the
file-level merge drivers.  This used to be perfectly OK back
when we always first attempted a straight patch application and
used the three-way code path only as a fallback.  Any binary
patch that can be applied as a trivial three-way merge (e.g. the
patch is based exactly on the version we happen to have) would
always cleanly apply, so the ll_binary_merge() that is not
prepared to see the trivial case would not have to handle such a
case.

This no longer is true after we made "--3way" to mean "first try
three-way and then fall back to straight application", and made
"git apply -3" on a binary patch that is based on the current
version no longer apply.

Teach "git apply -3" to first check for the trivial merge cases
and resolve them without hitting the file-level merge drivers.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
[jc: stolen tests from Jerry's patch]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 apply.c                   | 21 ++++++++++++++++++
 t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/apply.c b/apply.c
index 44bc31d6eb..c9f9503e90 100644
--- a/apply.c
+++ b/apply.c
@@ -3467,6 +3467,21 @@ static int load_preimage(struct apply_state *state=
,
 	return 0;
 }
=20
+static int resolve_to(struct image *image, const struct object_id *resul=
t_id)
+{
+	unsigned long size;
+	enum object_type type;
+
+	clear_image(image);
+
+	image->buf =3D read_object_file(result_id, &type, &size);
+	if (!image->buf || type !=3D OBJ_BLOB)
+		die("unable to read blob object %s", oid_to_hex(result_id));
+	image->len =3D size;
+
+	return 0;
+}
+
 static int three_way_merge(struct apply_state *state,
 			   struct image *image,
 			   char *path,
@@ -3478,6 +3493,12 @@ static int three_way_merge(struct apply_state *sta=
te,
 	mmbuffer_t result =3D { NULL };
 	int status;
=20
+	/* resolve trivial cases first */
+	if (oideq(base, ours))
+		return resolve_to(image, theirs);
+	else if (oideq(base, theirs) || oideq(ours, theirs))
+		return resolve_to(image, ours);
+
 	read_mmblob(&base_file, base);
 	read_mmblob(&our_file, ours);
 	read_mmblob(&their_file, theirs);
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 65147efdea..cc3aa3314a 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -230,4 +230,49 @@ test_expect_success 'apply with --3way --cached and =
conflicts' '
 	test_cmp expect.diff actual.diff
 '
=20
+test_expect_success 'apply binary file patch' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply bin.diff
+'
+
+test_expect_success 'apply binary file patch with 3way' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
+test_expect_success 'apply full-index patch with 3way' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --full-index >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
 test_done
--=20
2.33.0-408-g8e1aa136b3

