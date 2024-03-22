Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE40823A4
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145648; cv=none; b=uzcaR1ybfAs1Ty1+hissceiMMf610G7+rgh8UNzXJPbPViRxuY5TurEz51KznM/bglazxe9qHsS5581NkJEWIUknbCHDIIqG+gb312yxS3l5653Mm+Jurey0ko9HBWFH6HqncdTLUfoyQHufOBWBEAXwISbR76IKfSWN+6uSDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145648; c=relaxed/simple;
	bh=trBhGdehN0Wt/SXG9bQuxMyUinyhaZ5MtTv3rs9BWXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwdb6o37uDu9uLQPP9g3E6ss6WeQpq6viHpptD2sy5/zdBMecmm3HpimenvNRAZFa1AEAm32KQVxXS600V7owcdWDpCc5Z5DvIMGkIKH/5P+qVwpoJ1s4DcM1y0XVYW6WwAp6YkcwCFLQM0I2Z4H4amfo4aXeHUBWe6FwPxkne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=zIPKeWBW; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="zIPKeWBW"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 3406F6037D;
	Fri, 22 Mar 2024 23:13:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXrpPHLZFaKXcQPNpkAahZyZz/rn+FU0YFVbXIQKhAY=;
	b=zIPKeWBWSnMMEnwrfo+O+70pfB2PUym/1CliF7qgVel10crOaGi2CXTM6HmiJK1IEKBUg9
	uST2CPfr/N10wDS7OjMD9p4Ga/Vj6hF1gtm0/LBNypi5URKlAxKgiF5dMJsAaxrSEgUBWV
	G8AKmSJDqhMqXfKjO9TuogHkBqjc+6rF9bvnx97q8TlqDQsI9xWDyKYcJhmbn308JLa3O4
	sF7UQ+djk8pwERom7/4LfB0DZRqpt4jPcRhxMRDZvsGJbV7W/iAvZxcKDTN/x+or3LPvKV
	W1ro4ntG0mL68oQzKCqjv/iE1OwqZ8xKGGucyvttRSjX2qSnzeGDndVe/qWlHQ==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] maintenance: update tests for systemd scheduler
Date: Fri, 22 Mar 2024 23:11:11 +0100
Message-ID: <20240322221327.12204-7-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322221327.12204-1-mg@max.gautier.name>
References: <20240322221327.12204-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The systemd units are now in the source tree, rather than produced when
running git maitenance start. There is no need anymore to couple
validating the units and testing `git maintenance start`.

Adjust the test to verify the new `systemctl` command used, discard
checks for presence/absence of unit files in $XDG_CONFIG_HOME.

Validate the systemd units in the source tree, with one test per unit to
have more distinct failures.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Max Gautier <mg@max.gautier.name>
---

Notes:
    I encountered the same issue that
    cover.1697319294.git.code@khaugsbakk.name tried to solve; I was
    expecting multiples tests to be independent while they weren't (in
    particular the MacOS ones).
    
    Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>

 t/t7900-maintenance.sh | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 37aa408d26..dc0bf39250 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -24,13 +24,6 @@ test_lazy_prereq SYSTEMD_ANALYZE '
 	systemd-analyze verify /lib/systemd/system/basic.target
 '
 
-test_systemd_analyze_verify () {
-	if test_have_prereq SYSTEMD_ANALYZE
-	then
-		systemd-analyze verify "$@"
-	fi
-}
-
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h >actual &&
 	test_grep "usage: git maintenance <subcommand>" actual &&
@@ -776,23 +769,32 @@ test_expect_success 'start and stop Windows maintenance' '
 		hourly daily weekly >expect &&
 	test_cmp expect args
 '
+test_expect_success SYSTEMD_ANALYZE 'validate maintenance systemd service unit' '
+	git_path=$(command -v git) &&
+	sed "s+@BINDIR@/git+${git_path}+" "$TEST_DIRECTORY"/../systemd/user/git-maintenance@.service.in > git-maintenance@.service &&
+	systemd-analyze verify git-maintenance@hourly.service git-maintenance@daily.service git-maintenance@weekly.service &&
+	rm git-maintenance@.service &&
+	unset git_path
+'
+
+test_expect_success SYSTEMD_ANALYZE 'validate maintenance systemd timer unit' '
+	SYSTEMD_UNIT_PATH="$TEST_DIRECTORY"/../systemd/user/: systemd-analyze verify git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer
+	# ':' at the end of SYSTEMD_UNIT_PATH appends the default systemd search path
+	# This is needed because analyze tries to load implicit / default unit dependencies
+'
 
 test_expect_success 'start and stop Linux/systemd maintenance' '
 	write_script print-args <<-\EOF &&
 	printf "%s\n" "$*" >>args
 	EOF
 
-	XDG_CONFIG_HOME="$PWD" &&
-	export XDG_CONFIG_HOME &&
 	rm -f args &&
 	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start --scheduler=systemd-timer &&
 
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
-
-	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	echo "--user --force --now enable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >expect &&
 	test_cmp expect args &&
 
 	rm -f args &&
@@ -801,10 +803,7 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	# stop does not unregister the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
-	test_path_is_missing "systemd/user/git-maintenance@.service" &&
-
-	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	echo "--user --force --now disable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >expect &&
 	test_cmp expect args
 '
 
@@ -819,12 +818,12 @@ test_expect_success 'start and stop when several schedulers are available' '
 		hourly daily weekly >expect &&
 	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >>expect &&
-	printf -- "systemctl --user enable --now git-maintenance@%s.timer\n" hourly daily weekly >>expect &&
+	echo "systemctl --user --force --now enable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >>expect &&
 	test_cmp expect args &&
 
 	rm -f args &&
 	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
-	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	echo "systemctl --user --force --now disable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >expect &&
 	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >>expect &&
 	for frequency in hourly daily weekly
@@ -837,7 +836,7 @@ test_expect_success 'start and stop when several schedulers are available' '
 
 	rm -f args &&
 	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
-	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	echo "systemctl --user --force --now disable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >expect &&
 	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >>expect &&
 	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
@@ -846,7 +845,7 @@ test_expect_success 'start and stop when several schedulers are available' '
 
 	rm -f args &&
 	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
-	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	echo "systemctl --user --force --now disable" git-maintenance@hourly.timer git-maintenance@daily.timer git-maintenance@weekly.timer >expect &&
 	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >>expect &&
 	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
-- 
2.44.0

