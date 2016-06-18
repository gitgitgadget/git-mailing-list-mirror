Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47B51F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbcFRKtS (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:49:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:61061 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcFRKtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:49:17 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LiDKt-1bjPcx256x-00nUcb; Sat, 18 Jun 2016 12:49:12
 +0200
Date:	Sat, 18 Jun 2016 12:49:11 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] mingw: work around t2300's assuming non-Windows paths
In-Reply-To: <cover.1466246919.git.johannes.schindelin@gmx.de>
Message-ID: <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
References: <cover.1466246919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6sZBr7qQ+7MkjbEMbQcsefWZe1pz4Cj3xO8ffOHnVpEqABVa2Up
 wVoEKZgDF+FbLyS0yyn9xGxGxdJKHsAd0iftnBuTsp4TBPFMssXe4Jqx9+vlGqlgmHLa3B5
 aMzaBReBlR5RrUNfISyMbkO43vr2KloJ+wKiIqKuNQzo692HiG4coIVqvLjmH11a3jdxULl
 d7aHEp8TEbUia8vXz0FOg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:J8tew/GgOy0=:3A+XwXbqq7VlSCddgZAuBo
 sjbsjemCMJcInJR8qDQ5TV2C6VLYXlqbPkPTBV95yHFyHnYwQ3EqrerU+Os3mYp6lk25XWPpP
 GvDp7+1zcldLC1SjUCN2Og4auswh1tKb17bUSV2v9CdmUO3AJFI5hJqbAvj8Llgag2IsaLTLW
 n4YNXf3bTcAS6xK5hZ/A/PqQFAEedo47gFxv92JuZAuczLZCBlMocHdKqMHEFFK76QPnAd1P2
 IMPl5cqzxNsSsYh61H3qTXGOs9r0mt6Jj8BKVlvMEmCK2i/HVKIKmEps/d0Xi66ObPWz1rq3I
 Pn4ivk12SaitAzJmJfMABtbbFWQlkdGCE6eBhtzv5lYq8yhp86hXClFwe/fWFD9DO56r1I27f
 ISlMZ5XLOhWDAaSbNYFci4HahLMY7u02KFcK3bNdGSsWBJJnVEzAoFrMIav9wDlS+fm4Qb9MP
 m+zl87vN+iwz9u9JxbyPLkVSk54Pv6hRMw0zXqmipGsdrVTJ1x1C9lkQiFxGFL+W4jy4mWSdY
 9JFWJJghiq1ARjeIzjhnwe1aOyMS4NemEGnU61ytIwtNCX2bf3Vr/wywsRe9dxzoPNuyyrHKV
 QxXhel0VjFsjCO1J71rMmWLuZjDf9JsCyUq3WAAaLxjHuS6V7eQTz5i/hcsjDbXcJZILJrsnu
 2o/LOsO7Ii/SxuWDtqpBs8W83orF0r0N9U4Z3ZvhYej3Zdj6QG/5KNVyfwY1r1HwI7b2nfYIl
 k4zHQ0TJvOZd0n4zzwLXBzLHnZqtXKWA1lYKKdeFG7ogWQQ53rx7PXt/29NLftv0/9BJCzb8D
 ZM5o2/o
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Windows, we have to juggle two different schemes of representing
paths: the native, Windows paths (the only ones known to the main
Git executable) on the one hand, and POSIX-ish ones used by the Bash
through MSYS2's POSIX emulation layer on the other hand.

A Windows path looks like this: C:\git-sdk-64\usr\src\git. In modern
Windows, it is almost always legal to use forward slashes as directory
separators, which is the reason why the Git executable itself would use
the path C:/git-sdk-64/usr/src/git instead. The equivalent POSIX-ish
path would be: /c/git-sdk-64/usr/src/git.

This patch works around the assumption of t2300-cd-to-toplevel.sh that
`git --exec-path` spits out a POSIX-ish path, by converting the output
accordingly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2300-cd-to-toplevel.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index cccd7d9..c8de6d8 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -4,11 +4,19 @@ test_description='cd_to_toplevel'
 
 . ./test-lib.sh
 
+EXEC_PATH="$(git --exec-path)"
+test_have_prereq !MINGW ||
+case "$EXEC_PATH" in
+[A-Za-z]:/*)
+	EXEC_PATH="/${EXEC_PATH%%:*}${EXEC_PATH#?:}"
+	;;
+esac
+
 test_cd_to_toplevel () {
 	test_expect_success $3 "$2" '
 		(
 			cd '"'$1'"' &&
-			PATH="$(git --exec-path):$PATH" &&
+			PATH="$EXEC_PATH:$PATH" &&
 			. git-sh-setup &&
 			cd_to_toplevel &&
 			[ "$(pwd -P)" = "$TOPLEVEL" ]
-- 
2.9.0.118.gce770ba.dirty
