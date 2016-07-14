Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBAB20196
	for <e@80x24.org>; Thu, 14 Jul 2016 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbcGNN7J (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 09:59:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:64543 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcGNN7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 09:59:07 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MPYqL-1bRnu82Ej3-004mJr; Thu, 14 Jul 2016 15:59:01
 +0200
Date:	Thu, 14 Jul 2016 15:58:59 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: fix regression in t1308-config-set
Message-ID: <6f439a56703ca6fb5c269c75904796ae67e96960.1468504461.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NrgoLftFZ1nQGHh9f+/wjyG3+rKNb7MLz7dR0Y+g45x6er9Jc2+
 ktCd9SNZp76ZAXuoVsViunhaR9DVdKSHfPzfGjHZ5EyykXuxi36mZniW8NJ/l4A17pqTtyP
 nEVGo0F3a8LhNsaDeqILff5vWqoaMjc8zhzlynNX4wIfT04skhOJVpNPduqA2qDWGJNSI4f
 M7Sf+dOesQXyKKgrXAakw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:K/LnD7lCIGY=:LYBlD/7D863iEq7oB+ClB5
 CJdeHy7Os4ZNlugTsqhKOR9v6QcHtMPiYXLS0jGDhoP0wed6KN1mGAsOdzbTb36BVb1EeSxdD
 OBwm+/lazXh+RJf9xVf6C4fryDsvtVLZy1mlfU+65Mm4jVVvmi1aaKkWvDri/VbV3WvFSQzzi
 PzKeQynzht8Pjn/rwJC65XT9xhJxyCKfl84IMy1J3zz1h0XcIkzbclgBwd2egFVjWybS8CxYU
 Wjd9h+EdLZtyDxsDF/xpqcI6m5srP/NBWTRPnRb24ex6zuQQkZGs5UgwJCvvgwuiwaesZugrC
 WMcRTQmlgnVmSsyap4sFbKANTaLmzIdvLd3ndoN4VxNDNRAxKikONjbnIYBut0movgF8ipxam
 WGDpCiRUNwcJImQGq35RZaDV0uv72nw5l17N04OmvF/hRsrO406CS9ZLPp+0fK0PO+DvO3oRa
 Su4wMvK0DKSnKMDCh1K4CZBPvFrcCb3h4uCqXbUjv9CE/6pfquCWAQqbMekwUEeYiyuKWZ2dz
 QcLeX76mOgXzppHN2nkJgAmePElk/oLKjiNFGF6SiqNi+/YNStOrMmpMxughXU0AFc/804IZ5
 XDWEFvt9ejj3+VhHm8BXe4EgU3McoXtG8AsDtVYEeIVHpl2ITHMTA+DB2bgYQmW9wwzifk7br
 ma+Q3cJkS0JAGHVJ78IfMujkfJBp1s5X4waVmRmQiTScYBXJn479S4dMYALK9BNVV9QpiZ1Cg
 G0lLr+wezS0qxsk/Q0TNXUYgc/K9QGLSxPBH/O/cSdwzyCmt+Ug/n3sGHh6Sj3Ekmg4FEnYNY
 ohBKGsp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we tried to fix in 58461bd (t1308: do not get fooled by symbolic
links to the source tree, 2016-06-02) an obscure case where the user
cd's into Git's source code via a symbolic link, a regression was
introduced that affects all test runs on Windows.

The original patch introducing the test case in question was careful to
use `$(pwd)` instead of `$PWD`.

This was done to account for the fact that Git's test suite uses shell
scripting even on Windows, where the shell's Unix-y paths are
incompatible with the main Git executable's idea of paths: it only
accepts Windows paths.

It is an awkward but necessary thing, then, to use `$(pwd)` (which gives
us a Windows path) when interacting with the Git executable and `$PWD`
(which gives the shell's idea of the current working directory in Unix-y
form) for shell scripts, including the test suite itself.

Obviously this broke the use case of the Git maintainer when changing
the working directory into Git's source code directory via a symlink,
i.e. when `$(pwd)` does not agree with `$PWD`.

However, we must not fix that use case at the expense of regressing
another use case.

Let's special-case Windows here, even if it is ugly, for lack of a more
elegant solution.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/t1308-on-windows-v1

	Side note: it was not at all clear to me how 58461bd fixed the
	problem by replacing $(pwd) with $HOME, given that HOME is set to
	$TRASH_DIRECTORY which is set to $TEST_OUTPUT_DIRECTORY/... after
	TEST_OUTPUT_DIRECTORY was set to TEST_DIRECTORY which in turn was
	set to $(pwd).

	I guess the reason is that -P in `cd -P "$TRASH DIRECTORY"`, but
	then I *really* do not understand how $(pwd) and $PWD could
	disagree.

	Oh well. I have to move on to the next fire.

 t/t1308-config-set.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index a06e71c..7655c94 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -233,11 +233,19 @@ cmdline_config="'foo.bar=from-cmdline'"
 test_expect_success 'iteration shows correct origins' '
 	echo "[foo]bar = from-repo" >.git/config &&
 	echo "[foo]bar = from-home" >.gitconfig &&
+	if test_have_prereq MINGW
+	then
+		# Use Windows path (i.e. *not* $HOME)
+		HOME_GITCONFIG=$(pwd)/.gitconfig
+	else
+		# Do not get fooled by symbolic links, i.e. $HOME != $(pwd)
+		HOME_GITCONFIG=$HOME/.gitconfig
+	fi &&
 	cat >expect <<-EOF &&
 	key=foo.bar
 	value=from-home
 	origin=file
-	name=$HOME/.gitconfig
+	name=$HOME_GITCONFIG
 	scope=global
 
 	key=foo.bar
-- 
2.9.0.278.g1caae67

base-commit: 79ed43c28f626a4e805f350a77c54968b59be6e9
