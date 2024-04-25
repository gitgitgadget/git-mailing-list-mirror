Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97D6EB51
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040337; cv=none; b=R4DlsR+grmUH93iwbGNsVtUqPRcnG5nYzyRgkHUZ8SCKK1MdDAe16TIe6gms2Uh6z6Sa7EHp5Ij7emmj8QbuAal6iQNj4rwlt/ay2etGRzw1PJpsdd/Vezb6jkscCmpJkueqa2QD6OFrZVTrXH3W/L2V55TfwVIZfBk7Ilu8KNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040337; c=relaxed/simple;
	bh=BLpYec6Wl0HmYH16pCrfAsbDgcM5B9ZGYS75UGUnfMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/F7aWFH8DGS6PBVis3RpxlZ2MAo9oqYxiZgTdVntBPf49dTsRhlYo8PhcSbong4FKA2N5vDf/K0mHj1OnnD8wtxyg0YfaUtK40Sj4stxBBdpC8ZL8JNCpj6ftXPaE2XS/v3fy6ZV2bzXn3cEwPhTjWx17AnFjbLy/DsqwRX5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBn-0005rU-Cm; Thu, 25 Apr 2024 12:18:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBm-00EFFE-1R; Thu, 25 Apr 2024 12:18:50 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBl-002yLL-3C;
	Thu, 25 Apr 2024 12:18:49 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3 1/3] completion: add 'symbolic-ref'
Date: Thu, 25 Apr 2024 12:18:42 +0200
Message-Id: <20240425101845.708554-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

Even 'symbolic-ref' is only completed when
GIT_COMPLETION_SHOW_ALL_COMMANDS=1 is set, it currently defaults to
completing file names, which is not very helpful. Add a simple
completion function which completes options and refs.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
PATCH v3:
 - make use of __gitcomp_builtin instead of hard-coded options, and add
   a test for it (thanks to Patrick Steinhardt)
 - add empty line between test cases (thanks to Patrick Steinhardt)

PATCH v2: https://lore.kernel.org/git/20240424215019.268208-1-rhi@pengutronix.de
 - no changes

PATCH v1: https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 75193ded4bde..4d63fb6eeaf7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3581,6 +3581,17 @@ _git_svn ()
 	fi
 }
 
+_git_symbolic_ref () {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin symbolic-ref
+		return
+		;;
+	esac
+
+	__git_complete_refs
+}
+
 _git_tag ()
 {
 	local i c="$__git_cmd_idx" f=0
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 569cf2310434..963f865f27ed 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2518,6 +2518,29 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
+test_expect_success 'symbolic-ref completes builtin options' '
+	test_completion "git symbolic-ref --d" <<-\EOF
+	--delete Z
+	EOF
+'
+
+test_expect_success 'symbolic-ref completes short ref names' '
+	test_completion "git symbolic-ref foo m" <<-\EOF
+	main Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_success 'symbolic-ref completes full ref names' '
+	test_completion "git symbolic-ref foo refs/" <<-\EOF
+	refs/heads/main Z
+	refs/heads/mybranch Z
+	refs/tags/mytag Z
+	refs/tags/A Z
+	EOF
+'
+
 test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
-- 
2.39.2

