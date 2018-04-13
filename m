Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D5F1F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDMIIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:08:01 -0400
Received: from ao2.it ([92.243.12.208]:53708 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752970AbeDMIHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:07:53 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6tjM-0007i9-7c; Fri, 13 Apr 2018 10:06:48 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6tkM-0001fn-Mr; Fri, 13 Apr 2018 10:07:50 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 10/10] FIXME: add a hacky script to test the changes with a patched test suite
Date:   Fri, 13 Apr 2018 10:07:33 +0200
Message-Id: <20180413080733.6380-4-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413080733.6380-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
 <20180413080733.6380-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch all the hardcoded occurrences of '.gitmodules' and make the file
configurable via an environment variable.

This is only for demonstration purposes, the final patch to the test
suite could just use a fixed path for the custom gitmodules file,
matching the path passed in the wrapper script via the
'core.submodulesfile' option.

The rationale would be that testing with a custom gitmodules file covers
also the case of the default gitmodules file path.

Execute 'test-custom-gitmodules-file.sh' to check that the test pass
with either the default anda custom gitmodules file.
---
 test-custom-gitmodules-file.sh | 75 ++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 test-custom-gitmodules-file.sh

diff --git a/test-custom-gitmodules-file.sh b/test-custom-gitmodules-file.sh
new file mode 100755
index 000000000..d59b1e40d
--- /dev/null
+++ b/test-custom-gitmodules-file.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# This is a test script to demonstrate that the changes about
+# 'core.submodulesfile' do not cause regressions and even work as intended
+# when a custom gitmodules file is specified O_O.
+#
+# The script patches the hardcoded '.gitmodules' occurrences to be overridden
+# by an environment variable.
+#
+# Note that 'core.submodulesfile' affects no only the 'submodule' git command
+# but many other git commands that directly or or *indirecly* use the
+# submodules_file variable.
+#
+# In particular all the commands that use unpack_trees(), like 'am', 'clone',
+# etc. are affected.
+#
+# Anyways this is not a problem because the option is passed to all git
+# commands in the "./bin-wrappers/git" wrapper script.
+
+set -e
+
+if [ ! -e .patched_test_suite ];
+then
+
+  echo "Patching the test suite..."
+
+  find t/ -type f -name t7506-status-submodule.sh -exec sed -i \
+    -e "s/^cat \(.*\)\\\EOF/cat \1EOF/g" \
+    -e "s/\(.*\)\.gitmodules$/\1\${GITMODULES_FILE:-.gitmodules}/g" \
+    -e "s/^AA \.gitmodules$/AA \${GITMODULES_FILE:-.gitmodules}/g" \
+    {} \;
+
+  find t/ -type f -name t7508-status.sh -exec sed -i \
+    -e "s/touch \(.*\)\.gitmodules/touch \1\\\"\${GITMODULES_FILE:-.gitmodules}\\\"/g" \
+    -e "s/\t\.gitmodules$/\t\${GITMODULES_FILE:-.gitmodules}/g" \
+    {} \;
+
+  find t/ -type f -exec sed -i \
+    -e "s/git \(.*\)config \(.*\)-f ..\/\.gitmodules/git \1config \2-f ..\/\'\"\${GITMODULES_FILE:-.gitmodules}\"\'/g" \
+    -e "s/git \(.*\)config \(.*\)-f \.gitmodules/git \1config \2-f \"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/git \(.*\)config \(.*\)--file=\.gitmodules/git \1config \2--file=\"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/git add \(.*\)\.gitmodules\(.*\)/git add \1\"\${GITMODULES_FILE:-.gitmodules}\"\2/g" \
+    -e "s/test_cmp expect \.gitmodules/test_cmp expect \"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/cp .gitmodules pristine-\.gitmodules/cp \"\${GITMODULES_FILE:-.gitmodules}\" pristine-gitmodules/g" \
+    -e "s/cp pristine-\.gitmodules .gitmodules/cp pristine-gitmodules \"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/cp \.gitmodules \.gitmodules.bak/cp \'\"\${GITMODULES_FILE:-.gitmodules}\"\' .gitmodules.bak/g" \
+    -e "s/test-tool submodule-config/test-tool submodule-config --submodules_file \'\"\${GITMODULES_FILE:-.gitmodules}\"\'/g" \
+    -e "s/\$sha1:\.gitmodules/\$sha1:\'\"\${GITMODULES_FILE:-.gitmodules}\"\'/g" \
+    -e "s/cat >\.gitmodules/cat >\"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/sed \(.*\)<\.gitmodules/sed \1<\"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/rm \(.*\)\.gitmodules/rm \1\"\${GITMODULES_FILE:-.gitmodules}\"/g" \
+    -e "s/echo \(.*\)\.gitmodules/echo \1\\\"\${GITMODULES_FILE:-.gitmodules}\\\"/g" \
+    -e "s/\t\(.*\)\.gitmodules$/\t\1\'\"\${GITMODULES_FILE:-.gitmodules}\"\'/g" \
+    -e "s/\t\(.*\)\.gitmodules:/\t\1\'\"\${GITMODULES_FILE:-.gitmodules}\"\':/g" \
+    -e "s/\t\(.*\)\.gitmodules \&\&$/\t\1\'\"\${GITMODULES_FILE:-.gitmodules}\"\' \&\&/g" \
+    -e "s/\t\(.*\)\.gitmodules) \&\&$/\t\1\'\"\${GITMODULES_FILE:-.gitmodules}\"\') \&\&/g" \
+    -e "s/repo\/\.gitmodules /repo\/\'\"\${GITMODULES_FILE:-.gitmodules}\"\' /g" \
+    -e "s/Submodule sm2 a5a65c9..280969a:/Submodule sm2 a5a65c9..\'\$(git -C sm2 rev-list -1 HEAD | cut -c1-7)\':/g" \
+    -e "s/diff --git a\/sm2\/\.gitmodules /diff --git a\/sm2\/\'\"\${GITMODULES_FILE:-.gitmodules}\"\' /g" \
+    -e "s/^M\([ ]\{1,2\}\)\.gitmodules$/M\1\${GITMODULES_FILE:-.gitmodules}/g" \
+    -e "s/^D\([ ]\{1,2\}\)\.gitmodules$/D\1\${GITMODULES_FILE:-.gitmodules}/g" \
+    {} \;
+
+    make clean
+    make
+    touch .patched_test_suite
+fi
+
+echo "Running the tests with the default gitmodules file..."
+make test
+
+echo "Running the tests with a custom gitmodules file..."
+GITMODULES_FILE=.gitmodules_custom make test
+
+echo "Done."
-- 
2.17.0

