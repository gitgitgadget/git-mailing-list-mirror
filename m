Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1E11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBHTDd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:03:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55568 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:03:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so4868266wmh.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbxqRl+Sj+i+Lau/Y35RGrw/1JKNVd+DoGdkTw53GyM=;
        b=YNCw/zydpCjsxcir8POsRz+ytTfAuFFVJnQvqfW59ZA7go2yKsFFip3PZFCPdsuFBR
         ZHRi1vERrUPA937ZvF0e/04evFDDPZpnaGCanid/N7auZzpA+GuKIU4DrVFP9Uvsu6yX
         1RKiOwyT3gqhF1hSvG/uw4K92dhb1ILGXEzgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbxqRl+Sj+i+Lau/Y35RGrw/1JKNVd+DoGdkTw53GyM=;
        b=SU8vRcz71la5HNUhtSfBmyvkzd2OCCnCU600daKsf7hNvQyfU3zhY/bz645pw2y9Iw
         8DHDQ2LOMGLHFsvP6kD6mFQE1cmLqvytT9WWqz6Uxb+/yyBM37+Ow4nlqnINiHKTLCWF
         s9uAX96Rovt7v4bXJFQzgjiaK6lqXkmmmGeo47it/sCPktVDBoNPDStgI+tnawywdcyR
         SYsAQ8a+m4zOSMVdsrZUIEV+Xnq990kH0Y3u5EBCyKfGuD2tLoNfprAfri6waTYXeLnW
         GAf6lnTWTiLNaC4lRIclByfoC5W6W03UHDVNHrrsKKPQJ9hvaoZYg/yapuYbXJ7YQbH3
         7A3g==
X-Gm-Message-State: AHQUAuZ0vqs71jipQtlgjFGYZwyHxmZY4Eg6RMMXrmBmM2AuhK4B8xI4
        W5hlxg2SfXydbzcMzJZxIRINkw5lpF+8lA==
X-Google-Smtp-Source: AHgI3IYxcQCnVfgZM2t9fUre1cNa0T/4k/XeuslFxzzpzDOGFhgSIPDqJuwufV0F1fxZ4AGLtqa20Q==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr13464042wmj.105.1549652611226;
        Fri, 08 Feb 2019 11:03:31 -0800 (PST)
Received: from barracuda.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id b16sm1463731wrt.55.2019.02.08.11.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:03:30 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luke Diamand <ldiamand@roku.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: ticket expiry test: use a fake p4 to avoid use of 'sleep'
Date:   Fri,  8 Feb 2019 19:02:31 +0000
Message-Id: <20190208190231.8134-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.612.g17ebf93fb6.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Diamand <ldiamand@roku.com>

This tests for p4 ticket expiry by creating a ticket, and then waiting
long enough for the ticket to nearly expire. However, this is
unreliable.

Instead, create a 'fake' p4 which returns expiry times under the
control of the test script, and forwards other commands to the
real p4 executable.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9833-errors.sh | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index 277d347012..9d7cb5b35b 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -45,30 +45,32 @@ test_expect_success 'ticket logged out' '
 	)
 '
 
-test_expect_success 'create group with short ticket expiry' '
-	P4TICKETS="$cli/tickets" &&
-	echo "newpassword" | p4 login &&
-	p4_add_user short_expiry_user &&
-	p4 -u short_expiry_user passwd -P password &&
-	p4 group -i <<-EOF &&
-	Group: testgroup
-	Timeout: 3
-	Users: short_expiry_user
-	EOF
-
-	p4 users | grep short_expiry_user
-'
+# create a fake version of "p4" which returns a TicketExpiration based
+# on $EXPIRY, for testing login expiration
+create_fake_p4() {
+	(
+		cd "$git" && mkdir expire-p4 &&
+		cat >>expire-p4/p4 <<-EOF &&
+		#!/usr/bin/python
+		import marshal, os, subprocess, sys
+		if "login" in sys.argv:
+		    marshal.dump({"foo" : "bar", "code" : "stat", "TicketExpiration" : os.environ["EXPIRY"]}, sys.stdout)
+		else:
+		    subprocess.check_call([os.environ["P4"]] + sys.argv[1:])
+		EOF
+		chmod 0755 expire-p4/p4
+	)
+}
 
 test_expect_success 'git operation with expired ticket' '
-	P4TICKETS="$cli/tickets" &&
-	P4USER=short_expiry_user &&
-	echo "password" | p4 login &&
+	create_fake_p4 &&
+	echo "newpassword" | p4 login &&
 	(
 		cd "$git" &&
-		git p4 sync &&
-		sleep 5 &&
-		test_must_fail git p4 sync 2>errmsg &&
-		grep "failure accessing depot" errmsg
+		P4=$(command -v p4) && export P4 &&
+		EXPIRY=3600 PATH=$PWD/expire-p4:$PATH git p4 sync &&
+		EXPIRY=1 PATH=$PWD/expire-p4:$PATH test_must_fail git p4 sync -v 2>errmsg &&
+		grep "failure accessing depot.*expires in 1 second" errmsg
 	)
 '
 
-- 
2.20.1.612.g17ebf93fb6.dirty

