Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C8156679
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992765; cv=none; b=K1zybl2WZNIxfIpZ9DY5FddsJaD+RGthuelfpn2JOXL7tvaU1N/Tzn+MgSAQj+SH5wi7ityRE2xQSPylDDDK54qcczXJuYNppFvYNljDN5Fv6Q4O4v0X+FvE1YtlGOnDssHoJ2/j3+vr/7kxy172y/jILrTVz0e0Wzd1Ew/zlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992765; c=relaxed/simple;
	bh=oGEdNlZwfI5MFVxtFEshp6Xs2Plzy7s4hL1tTvm/jKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mn2OclqsrabDuYHBmfAnUgWsJYCtbJynVv3+GqnfY7Hk2pwWflqw33UfDSmW8cwYYBrSl+ze9ZCh1syKH1N9jh3+2Be6Nm5yL3NFojSIZlFpISUyZJ2LhImcc4BKscuyFfVc9fC/0W+RKbRRn0fKT0Hq5b8MOjZBbAPqSd9SjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoU-0004eA-DA; Wed, 24 Apr 2024 23:05:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoR-00E9Aj-Hv; Wed, 24 Apr 2024 23:05:55 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoR-0014gv-1b;
	Wed, 24 Apr 2024 23:05:55 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] completion: add 'symbolic-ref'
Date: Wed, 24 Apr 2024 23:05:47 +0200
Message-Id: <20240424210549.256256-1-rhi@pengutronix.de>
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
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 75193ded4bde..ffcc55484bcd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3581,6 +3581,17 @@ _git_svn ()
 	fi
 }
 
+_git_symbolic_ref () {
+	case "$cur" in
+	--*)
+		__gitcomp "--delete --quiet --short --recurse --no-recurse"
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
index 569cf2310434..a34953da6c96 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2518,6 +2518,22 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
+test_expect_success 'symbolic-ref completes short ref names ' '
+	test_completion "git symbolic-ref foo m" <<-\EOF
+	main Z
+	mybranch Z
+	mytag Z
+	EOF
+'
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

