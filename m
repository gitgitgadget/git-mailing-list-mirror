Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD3C433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D4B2074B
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MB/OFrUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgFFAXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:23:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbgFFAXv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 20:23:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D8DB609CF;
        Sat,  6 Jun 2020 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591403000;
        bh=p8Bq2wMbkFJl3PK8jd2HAfV/sHtjpRJ8ThrJmXorEYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=MB/OFrUWq710Wj8fnkpU9WBRnIlBOSl8mMi711amWARbMxiFw3xgxsbz01Vva+fP8
         XjdFcoCbnlipmjQA+EAJaOM+Uxam6BcuRsXwuIHVDHofTdMUfkfALAdb31TWh5lCMz
         9l5JwYnddoz8+TvL76qvbEGMdmTsFWLNgUpIW2CKFDLpcEYDK+4a9G1nVmcPA8zqxB
         +Lbn0gZUVmc3/cFMZo09bDln2x4wfKoIYL0JkfxTnNUPtDS1hZjrOsi+H3VRDUshcX
         pgZQ2ANYPSQUaoaGfDBmltxb4lf5pSpA4mltvk7IJ806M9dHTfR1i/3e/adjrgkqD3
         62B9l4fQhxKyc4cp9OhBi2sYGOXLw4mSJs4r22pNoaOdXrR1BhDHgepn0CoXEn10+j
         2WSYMYaDWl3VZ7j4rDk/1lg0J/122zstq3xIC5uaEMPHnGuXDcJrjds1NQX+uu3q87
         dbESZ0aTEsekT3wfS+oUGu1O2eb/PPqSgjlezqz+LVThDMZz1Ff
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Billes Tibor <tbilles@gmx.com>
Subject: [PATCH v2] exec: run final pipeline command in a subshell in sh mode
Date:   Sat,  6 Jun 2020 00:22:41 +0000
Message-Id: <20200606002241.1578150-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200606002241.1578150-1-sandals@crustytoothpaste.net>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
 <20200606002241.1578150-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

zsh typically runs the final command in a pipeline in the main shell
instead of a subshell.  However, POSIX requires that all commands in a
pipeline run in a subshell, but permits zsh's behavior as an extension.

Since zsh may be used as /bin/sh in some cases (such as macOS Catalina),
it makes sense to have the POSIX behavior when emulating sh, so do that
by checking for being the final item of a multi-item pipeline and
creating a subshell in that case.

From the comment above execpline(), we know the following:

  last1 is a flag that this command is the last command in a shell that
  is about to exit, so we can exec instead of forking.  It gets passed
  all the way down to execcmd() which actually makes the decision.  A 0
  is always passed if the command is not the last in the pipeline. […]
  If last1 is zero but the command is at the end of a pipeline, we pass
  2 down to execcmd().

So there are three cases to consider in this code:

• last1 is 0, which means we are not at the end of a pipeline, in which
  case we should not change behavior.
• last1 is 1, which means we are effectively running in a subshell,
  because nothing that happens due to the exec is going to affect the
  actual shell, since it will have been replaced.  So there is nothing
  to do here.
• last1 is 2, which means our command is at the end of the pipeline, so
  in sh mode we should create a subshell by forking.

input is nonzero if the input to this process is a pipe that we've
opened.  At the end of a multi-stage pipeline, it will necessarily be
nonzero.

Note that several of the tests may appear bizarre, since most developers
do not place useless variable assignments directly at the end of a
pipeline.  However, as the function tests demonstrate, there are cases
where assignments may occur when a shell function is used at the end of
a command.  The remaining assignment tests simply test additional cases,
such as the use of local, that would otherwise be untested.
---
 Src/exec.c           | 10 ++++++----
 Test/B07emulate.ztst | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Src/exec.c b/Src/exec.c
index 29f4fc5ca..f2650f311 100644
--- a/Src/exec.c
+++ b/Src/exec.c
@@ -2866,11 +2866,13 @@ execcmd_exec(Estate state, Execcmd_params eparams,
 	    pushnode(args, dupstring("fg"));
     }
 
-    if ((how & Z_ASYNC) || output) {
+    if ((how & Z_ASYNC) || output ||
+	(last1 == 2 && input && EMULATION(EMULATE_SH))) {
 	/*
-	 * If running in the background, or not the last command in a
-	 * pipeline, we don't need any of the rest of this function to
-	 * affect the state in the main shell, so fork immediately.
+	 * If running in the background, not the last command in a
+	 * pipeline, or the last command in a multi-stage pipeline
+	 * in sh mode, we don't need any of the rest of this function
+	 * to affect the state in the main shell, so fork immediately.
 	 *
 	 * In other cases we may need to process the command line
 	 * a bit further before we make the decision.
diff --git a/Test/B07emulate.ztst b/Test/B07emulate.ztst
index 7b1592fa9..45c39b51d 100644
--- a/Test/B07emulate.ztst
+++ b/Test/B07emulate.ztst
@@ -276,3 +276,25 @@ F:Some reserved tokens are handled in alias expansion
 0:--emulate followed by other options
 >yes
 >no
+
+  emulate sh -c '
+  foo () {
+    VAR=foo &&
+    echo $VAR | bar &&
+    echo "$VAR"
+  }
+  bar () {
+    tr f b &&
+    VAR="$(echo bar | tr r z)" &&
+    echo "$VAR"
+  }
+  foo
+  '
+  emulate sh -c 'func() { echo | local def="abc"; echo $def;}; func'
+  emulate sh -c 'abc="def"; echo | abc="ghi"; echo $abc'
+0:emulate sh uses subshell for last pipe entry
+>boo
+>baz
+>foo
+>
+>def
