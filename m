Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E26D20C11
	for <e@80x24.org>; Sat,  2 Dec 2017 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdLBJNU (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 04:13:20 -0500
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21057 "EHLO
        sender-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdLBJNR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 04:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1512205995;
        s=zoho; d=shikherverma.com; i=root@shikherverma.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1936; bh=+bOzGsab1m9Q+PthxIf3O1Lnt0JwvcFyZLZHUou9VWw=;
        b=gf+AUYUaENK1tdT1J5BXaTbmz+TqxipuBUs/Cz6dgBH3E1Jllo9fzNoxq7HHWQjy
        n+XUzfjOblm2dzX6Ov9iLqQF0y5Qrn3UK5d9ftxIH+VRq8Tze9IZz2qTHB05MUuU82L
        SYNAkk/vNSrJ734KkmwukjW8kta7mTBTZFtvoi2Y=
Received: from weakknees.security.iitk.ac.in (125.17.242.34 [125.17.242.34]) by mx.zohomail.com
        with SMTPS id 151220599588979.75830158319161; Sat, 2 Dec 2017 01:13:15 -0800 (PST)
From:   Shikher Verma <root@shikherverma.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, root@shikherverma.com, santiago@nyu.edu,
        sbeller@google.com
Subject: [PATCH] Add a sample hook which saves push certs as notes
Date:   Sat,  2 Dec 2017 14:42:48 +0530
Message-Id: <20171202091248.6037-1-root@shikherverma.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <xmqqtvzzqt5u.fsf@gitster.mtv.corp.google.com>
References: <xmqqtvzzqt5u.fsf@gitster.mtv.corp.google.com>
X-ZohoMailClient: External
X-ZohoMail: Z_65354923 SPT_1 Z_50090816 SPT_1 SLF_D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hooks--post-receive.sample: If push cert is present, add it as a git
note to the top most commit of the updated ref.

Signed-off-by: Shikher Verma <root@shikherverma.com>
---
 templates/hooks--post-receive.sample | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 templates/hooks--post-receive.sample

diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
new file mode 100755
index 000000000..b4366e43f
--- /dev/null
+++ b/templates/hooks--post-receive.sample
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# An example hook script to store push certificates as notes.
+#
+# To enable this hook, rename this file to "post-receive".
+#
+# The stdin of the hook will be one line for each updated ref:
+# <old-id> <new-id> <refname>
+#
+# For each updated ref this script will :
+# 1. Verify that the ref update matches that in push certificate.
+# 2. add the push cert as note (namespace pushcerts) to <new-id>.
+#
+# If this hook is enabled on the server then clients can prevent
+# git metadata tampering, by using signed pushes and 
+# doing the following while fetching :
+# 1. fetch the git notes (of namespace pushcerts) from server.
+#     $ git fetch origin refs/notes/pushcerts:refs/notes/pushcerts
+# 2. Check that the fetched ref's top most commit has a note
+#     containing a push certificate.
+# 3. Verify the validity of the push certificate in the note and 
+#     check that the ref update matches that in push certificate.
+#
+
+if test -z GIT_PUSH_CERT ; then
+    exit 0
+fi
+
+push_cert=$(git cat-file -p  $GIT_PUSH_CERT)
+
+while read oval nval ref
+do
+	# Verify that the ref update matches that in push certificate.
+	if [[ $push_cert == *$oval" "$nval" "$ref* ]]; then
+		# add the push cert as note (namespaced pushcerts) to nval.
+		git notes --ref=pushcerts add -m "$push_cert" $nval -f
+	fi
+done
-- 
2.15.0


