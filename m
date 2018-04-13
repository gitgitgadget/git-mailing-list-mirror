Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8771F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDMIHy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:07:54 -0400
Received: from ao2.it ([92.243.12.208]:53700 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDMIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:07:52 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6tjL-0007hv-GC; Fri, 13 Apr 2018 10:06:47 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6tkM-0001fh-4M; Fri, 13 Apr 2018 10:07:50 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 07/10] FIXME: wrap-for-bin.sh: set 'core.submodulesFile' for each git invocation
Date:   Fri, 13 Apr 2018 10:07:30 +0200
Message-Id: <20180413080733.6380-1-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to test custom gitmodules file paths. The default path can be
overridden using the 'GIT_MODULES_FILE' environmental variable.

Maybe In the final patch the option should be set only when running
tests and not unconditionally in the wrapper script, but as a proof of
concept the wrapper script was a convenient location.

Also, in the final patch a fixed custom file path could be used instead
of the environmental variable: to exercise the code it should be enough
to have a value different from the default one.

The change to 't0001-init.sh' is needed to make the test pass, since now
a config is set on the command line.
---
 Makefile        | 3 ++-
 t/t0001-init.sh | 1 +
 wrap-for-bin.sh | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 wrap-for-bin.sh

diff --git a/Makefile b/Makefile
index f18168725..38ee1f6a2 100644
--- a/Makefile
+++ b/Makefile
@@ -2480,7 +2480,8 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' \
+	     -e 's|git\"|git\" $$GIT_OPTIONS|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c413bff9c..6fa3fd24e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -93,6 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
+			-e "/^GIT_CONFIG_PARAMETERS=/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
 	EOF
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
old mode 100644
new mode 100755
index 584240881..02bf41cbd
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -20,6 +20,8 @@ PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
+GIT_OPTIONS="-c core.submodulesfile=${GITMODULES_FILE:-.gitmodules}"
+
 if test -n "$GIT_TEST_GDB"
 then
 	unset GIT_TEST_GDB
-- 
2.17.0

