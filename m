Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517AC2BB85
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492D320753
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5Yjhu7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDIULg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:11:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51881 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgDIULf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 16:11:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4428958D20;
        Thu,  9 Apr 2020 16:11:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ovu8b5UVLRhg8b6+goXT9/UUZ
        C0=; b=e5Yjhu7yGCX70psek14f9N6nd4mcE1E5o06NVc2a76pGOLrMdwx0ACKtg
        KOIEmtcqjz+IEVrldTTUAYCx7omu6uC8EgWouoq0Sw2Z2LTMslSOVoB7Y5aS3fJh
        uOO2V/xltaY94Eg2ZJOJh1ldjgyfJUorJce0eFWNvTZV0h5Ct8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=VRsz6gheSozSefg+gqE
        Wf0vD1qGLgcILPk1RdDKeWlE8EYaVSzWaNyAvWyzrfCeRVvwNTTtiByxyplYqgGR
        w48SlMGc+Nx59XrtLqA8dgVoMjzv+kG+4NInnupcLd3iGcb/OPDhKR4H6+OHGMzO
        4rhJBzZyI75DUxQjI3QUbHho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CB0858D1F;
        Thu,  9 Apr 2020 16:11:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA86758D1E;
        Thu,  9 Apr 2020 16:11:33 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com
Subject: [PATCH 1/2] mingw: refactor test_path_is_hidden out to t/test-lib-functions.sh
Date:   Thu,  9 Apr 2020 13:11:28 -0700
Message-Id: <20200409201129.82608-2-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-106-g9fadedd637
In-Reply-To: <20200409201129.82608-1-gitster@pobox.com>
References: <xmqqmu7locys.fsf@gitster.c.googlers.com>
 <20200409201129.82608-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4F0B9C7C-7A9E-11EA-82B0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two scripts had a copy of the same helper function, which needed the
same fix at the same time.  Let's move it to a common place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0001-init.sh         | 13 +++----------
 t/t5611-clone-config.sh | 13 +++----------
 t/test-lib-functions.sh |  9 +++++++++
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2456688b28..6b2e2e3dc2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -392,13 +392,6 @@ test_expect_success SYMLINKS 're-init to move gitdir=
 symlink' '
 	test_path_is_dir realgitdir/refs
 '
=20
-# Tests for the hidden file attribute on windows
-is_hidden () {
-	# Use the output of `attrib`, ignore the absolute path
-	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
-	return 1
-}
-
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
@@ -406,7 +399,7 @@ test_expect_success MINGW '.git hidden' '
 		mkdir newdir &&
 		cd newdir &&
 		git init &&
-		is_hidden .git
+		test_path_is_hidden .git
 	) &&
 	check_config newdir/.git false unset
 '
@@ -419,7 +412,7 @@ test_expect_success MINGW 'bare git dir not hidden' '
 		cd newdir &&
 		git --bare init
 	) &&
-	! is_hidden newdir
+	! test_path_is_hidden newdir
 '
=20
 test_expect_success 'remote init from does not use config from cwd' '
@@ -456,7 +449,7 @@ test_expect_success MINGW 'core.hidedotfiles =3D fals=
e' '
 		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		git -C newdir init
 	) &&
-	! is_hidden newdir/.git
+	! test_path_is_hidden newdir/.git
 '
=20
 test_expect_success MINGW 'redirect std handles' '
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 87b8073cd7..8e0fd39823 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -92,24 +92,17 @@ test_expect_success 'clone -c remote.<remote>.fetch=3D=
<refspec> --origin=3D<name>' '
 	test_cmp expect actual
 '
=20
-# Tests for the hidden file attribute on windows
-is_hidden () {
-	# Use the output of `attrib`, ignore the absolute path
-	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
-	return 1
-}
-
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=3Dfalse . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=3DdotGitOnly . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=3Dtrue . child &&
-	is_hidden child/.gitattributes
+	test_path_is_hidden child/.gitattributes
 '
=20
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..39b478e731 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -760,6 +760,15 @@ test_path_is_missing () {
 	fi
 }
=20
+# Tests for the hidden file attribute on windows
+test_path_is_hidden () {
+	# Use the output of `attrib`, ignore the absolute path
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in
+	*H*?:*)		return 0;;
+	esac
+	return 1
+}
+
 # test_line_count checks that a file has the number of lines it
 # ought to. For example:
 #
--=20
2.26.0-106-g9fadedd637

