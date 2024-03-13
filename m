Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9A63513
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351144; cv=none; b=rhe9HJd+owhknyAMw5F4WMbRclRIKxemvXS0RKUMILh7nOjUM7Bpl2h66sgBeXfSZOIgJxfrtZccNGCScMCaRNiRbtKXGfIwAUk2ajaMoKH779Lrg6kRNQbgb7lfJxczoeGPIyHYaOWkJeWX237Rmbds4YaicOXWo4WtUt68aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351144; c=relaxed/simple;
	bh=znDchIgv9Sgh6yT6U5CzSdpVOYLz3RA1nHL8b7DaDqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBcayICHey561IubctUAEoBiG0b1ww+xzszrGzVn+xB5voXOkZnmKl9N6AWUVlvJ56nqOx3WZDS+sCtF3NHRVBDMGQSZYCG7FNIgYCv1lvUkFQ6iObXKceXNWmUH9TpVEAYPQTXIWfuGkEgX0Lwuljk0Ef85ohxMyLszwyEZlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jhUo9gYA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhUo9gYA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EE071DCE1F;
	Wed, 13 Mar 2024 13:32:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=znDchIgv9Sgh6yT6U5CzSdpVO
	YLz3RA1nHL8b7DaDqA=; b=jhUo9gYAsoQGx97o10sHTlwhNUw+U3YPUXRjagZBg
	Qqxxr72EbTK+wNtQhQbawcbmqxqZi66hTdmH2bX0L7XtISP6mzdRdVLoMIE/jMob
	Vcm+R2CXfrew8PZdlsEVWBIx1qioJetjHRJ3uEJ+mFmcCmjxW69NmxrrhtjQnBBz
	JI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 463DB1DCE1E;
	Wed, 13 Mar 2024 13:32:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE2051DCE1C;
	Wed, 13 Mar 2024 13:32:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] status: allow --untracked=false and friends
Date: Wed, 13 Mar 2024 10:32:14 -0700
Message-ID: <20240313173214.962532-3-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-191-g945115026a
In-Reply-To: <20240313173214.962532-1-gitster@pobox.com>
References: <20240313173214.962532-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A55914DE-E15F-11EE-88F9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

It is natural to expect that the "--untracked" option and the
status.showuntrackedFiles configuration variable to take a Boolean
value ("do you want me to show untracked files?"), but the current
code takes nothing but "no" as "no, please do not show any".

Allow the usual Boolean values to be given, and treat 'true' as
"normal", and 'false' as "no".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/status.txt |  2 ++
 Documentation/git-commit.txt    |  2 ++
 Documentation/git-status.txt    |  2 ++
 builtin/commit.c                | 13 +++++++++++--
 t/t7508-status.sh               | 32 ++++++++++++++++++++++----------
 5 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/status.txt b/Documentation/config/statu=
s.txt
index 2ff8237f8f..8caf90f51c 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -57,6 +57,8 @@ status.showUntrackedFiles::
 --
 +
 If this variable is not specified, it defaults to 'normal'.
+All usual spellings for Boolean value `true` are taken as `normal`
+and `false` as `no`.
 This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
=20
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a6cef5d820..89ecfc63a8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -347,6 +347,8 @@ The possible options are:
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
=20
+All usual spellings for Boolean value `true` are taken as `normal`
+and `false` as `no`.
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
 --
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b0f36fabfb..9a376886a5 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -79,6 +79,8 @@ Consider enabling untracked cache and split index if su=
pported (see
 `git update-index --untracked-cache` and `git update-index
 --split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
+All usual spellings for Boolean value `true` are taken as `normal`
+and `false` as `no`.
=20
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
diff --git a/builtin/commit.c b/builtin/commit.c
index e61e459ca9..ddf4198c92 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1163,6 +1163,17 @@ static enum untracked_status_type parse_untracked_=
setting_name(const char *u)
 	 * Please update $__git_untracked_file_modes in
 	 * git-completion.bash when you add new options
 	 */
+	switch (git_parse_maybe_bool(u)) {
+	case 0:
+		u =3D "no";
+		break;
+	case 1:
+		u =3D "normal";
+		break;
+	default:
+		break;
+	}
+
 	if (!strcmp(u, "no"))
 		return SHOW_NO_UNTRACKED_FILES;
 	else if (!strcmp(u, "normal"))
@@ -1469,8 +1480,6 @@ static int git_status_config(const char *k, const c=
har *v,
 	if (!strcmp(k, "status.showuntrackedfiles")) {
 		enum untracked_status_type u;
=20
-		if (!v)
-			return config_error_nonbool(k);
 		u =3D parse_untracked_setting_name(v);
 		if (u =3D=3D SHOW_UNTRACKED_FILES_ERROR)
 			return error(_("Invalid untracked files mode '%s'"), v);
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a3c18a4fc2..e9afa59968 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -419,14 +419,19 @@ Changes not staged for commit:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status -uno >output &&
+	test_cmp expect output &&
+	git status -ufalse >output &&
 	test_cmp expect output
 '
=20
-test_expect_success 'status (status.showUntrackedFiles no)' '
-	test_config status.showuntrackedfiles no &&
-	git status >output &&
-	test_cmp expect output
-'
+for no in no false 0
+do
+	test_expect_success "status (status.showUntrackedFiles $no)" '
+		test_config status.showuntrackedfiles "$no" &&
+		git status >output &&
+		test_cmp expect output
+	'
+done
=20
 test_expect_success 'status -uno (advice.statusHints false)' '
 	cat >expect <<EOF &&
@@ -488,14 +493,21 @@ Untracked files:
=20
 EOF
 	git status -unormal >output &&
+	test_cmp expect output &&
+	git status -utrue >output &&
+	test_cmp expect output &&
+	git status -uyes >output &&
 	test_cmp expect output
 '
=20
-test_expect_success 'status (status.showUntrackedFiles normal)' '
-	test_config status.showuntrackedfiles normal &&
-	git status >output &&
-	test_cmp expect output
-'
+for normal in normal true 1
+do
+	test_expect_success "status (status.showUntrackedFiles $normal)" '
+		test_config status.showuntrackedfiles $normal &&
+		git status >output &&
+		test_cmp expect output
+	'
+done
=20
 cat >expect <<EOF
  M dir1/modified
--=20
2.44.0-191-g945115026a

