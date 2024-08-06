Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32063D5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904556; cv=none; b=JEsJ7EJZ354ytOSoL4j5RmPDO8n5qjRXJMXDtg7IsL8CEQxuKjCO1oeBFXkNfooHZBQiBMbffFtQ7ZvtTB7+a1iL4G1AwDJpxIhbjosbiKoopSxVEYZ+oxjmrdvpwNfWjP+aNnkyz8mYLl21aARqqqLHvz89CtAqOANzkjsgBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904556; c=relaxed/simple;
	bh=eloSFMoHn/U/W/RNcCyh0KI+rb0bJDm61+NrvbD5BvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7NuCwGxZDH2vQLR+65LQ0NYLw2VI57WS8VdLg1J5r5cNnS5UHSBgPTIQ4UmbTxGvl7d4CDW9LOpaASEwjEX7pIuNGvbEKwrtDzH102im0CWxh+MRURS36hZcXAxtN1/gomBLAtwPZpfAUHEhusOWPqOkZ3KCQr36oVvWDJIAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RUD7y+zY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUD7y+zY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 23FFB1BFC1;
	Mon,  5 Aug 2024 20:35:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=eloSFMoHn/U/W/RNcCyh0KI+r
	b0bJDm61+NrvbD5BvE=; b=RUD7y+zYLqKBde3oCM6Ewlq+xk7Gwr2f4qx47DqV0
	mhayfNHrvOFWqVFZyj8cuziMnRl+t2Kmk/hdJB1nSawfAN9QCawmnN/bCSR4PpO4
	f4cTxuq+he/uQyQUfn3uBO8aYfxqX5xCxzY+7G1LBB9ofQuun0f/7nDBUKVXM32a
	08=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D0021BFC0;
	Mon,  5 Aug 2024 20:35:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C0BF1BFBD;
	Mon,  5 Aug 2024 20:35:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 3/4] notes: avoid "too many arguments"
Date: Mon,  5 Aug 2024 17:35:38 -0700
Message-ID: <20240806003539.3292562-4-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-235-g968ce1ce0e
In-Reply-To: <20240806003539.3292562-1-gitster@pobox.com>
References: <20240806003539.3292562-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 D46DCCB2-538B-11EF-8E17-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Imagine seeing your command failing with "too many arguments" when
you run "git cmd foo bar baz".  Can you tell it will work if you
said "git cmd foo bar"?  Or is that trimming your command line too
much?  Too little?

Instead, if the command reports "unknown argument: 'bar'", you'd know
that "bar" and everything after it is unwanted.

Let's make it so for "git notes".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c  | 18 +++++++++---------
 t/t3301-notes.sh |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..235baeb118 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -447,7 +447,7 @@ static int list(int argc, const char **argv, const ch=
ar *prefix)
 				     git_notes_list_usage, 0);
=20
 	if (1 < argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[1]);
 		usage_with_options(git_notes_list_usage, options);
 	}
=20
@@ -509,7 +509,7 @@ static int add(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_KEEP_ARGV0);
=20
 	if (2 < argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[2]);
 		usage_with_options(git_notes_add_usage, options);
 	}
=20
@@ -591,7 +591,7 @@ static int copy(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (from_stdin || rewrite_cmd) {
 		if (argc) {
-			error(_("too many arguments"));
+			error(_("unknown argument: '%s'"), argv[0]);
 			usage_with_options(git_notes_copy_usage, options);
 		} else {
 			return notes_copy_from_stdin(force, rewrite_cmd);
@@ -603,7 +603,7 @@ static int copy(int argc, const char **argv, const ch=
ar *prefix)
 		usage_with_options(git_notes_copy_usage, options);
 	}
 	if (2 < argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[2]);
 		usage_with_options(git_notes_copy_usage, options);
 	}
=20
@@ -686,7 +686,7 @@ static int append_edit(int argc, const char **argv, c=
onst char *prefix)
 			     PARSE_OPT_KEEP_ARGV0);
=20
 	if (2 < argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[2]);
 		usage_with_options(usage, options);
 	}
=20
@@ -762,7 +762,7 @@ static int show(int argc, const char **argv, const ch=
ar *prefix)
 			     0);
=20
 	if (1 < argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[1]);
 		usage_with_options(git_notes_show_usage, options);
 	}
=20
@@ -915,7 +915,7 @@ static int merge(int argc, const char **argv, const c=
har *prefix)
 		error(_("must specify a notes ref to merge"));
 		usage_with_options(git_notes_merge_usage, options);
 	} else if (!do_merge && argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[0]);
 		usage_with_options(git_notes_merge_usage, options);
 	}
=20
@@ -1069,7 +1069,7 @@ static int prune(int argc, const char **argv, const=
 char *prefix)
 			     0);
=20
 	if (argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[0]);
 		usage_with_options(git_notes_prune_usage, options);
 	}
=20
@@ -1091,7 +1091,7 @@ static int get_ref(int argc, const char **argv, con=
st char *prefix)
 			     git_notes_get_ref_usage, 0);
=20
 	if (argc) {
-		error(_("too many arguments"));
+		error(_("unknown argument: '%s'"), argv[0]);
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 536bd11ff4..9db6a2f5c4 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1472,7 +1472,7 @@ test_expect_success 'git notes copy diagnoses too m=
any or too few arguments' '
 	test_must_fail git notes copy 2>error &&
 	test_grep "too few arguments" error &&
 	test_must_fail git notes copy one two three 2>error &&
-	test_grep "too many arguments" error
+	test_grep "unknown argument: ${SQ}three${SQ}" error
 '
=20
 test_expect_success 'git notes get-ref expands refs/heads/main to refs/n=
otes/refs/heads/main' '
--=20
2.46.0-235-g968ce1ce0e

