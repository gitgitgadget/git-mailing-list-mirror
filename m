Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4F620209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdGAMvD (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:51:03 -0400
Received: from mout.web.de ([212.227.17.12]:65296 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbdGAMvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:51:02 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7sw0-1deOrU0y7k-00vPAu; Sat, 01
 Jul 2017 14:51:00 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/2] cygwin: Allow pushing to UNC paths
Date:   Sat,  1 Jul 2017 14:50:59 +0200
Message-Id: <20170701125059.16210-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
In-Reply-To: <20170628162958.519-1-tboegi@web.de>
References: <20170628162958.519-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:m37Jvh/a1/dHjhcXi5jFL6AefvG4wo7ZaPdqShmQNoa6xJ+VHB3
 9J9dXt/JeurFHNaMYlbvLrb2YQE/ggl2iWXDxm/ihXNVDszUCrImZ08D3p/jXXHWd498J3h
 5CKgOqA1Zz7GtcDYn1W6sI+H/sdTy3tv1db15C2NdYRNpaZTjGuNxreuebwaz53wSM2kIKg
 1fIDsACXKJXohchmh3fDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c3qqEcS+4Bs=:PUhjl1HdEiOcdIuM3a7dTf
 3EZPAsU+SyCga20LOMJlzfzSbJB1sFj8mO0SpNBDlK3uwko03LiD/KXRqd96WDqwPZTvKJRlM
 ZF1xANr+8dwggXBDgDagAPUgUA7hyjq96EqvN1U9EI4syz9Jo/prENCq87O9VPUEZ/A4JJq7f
 JVRUPJsmoxB8ES5AraqS53nqOuoOkhyes1zH7jZEGWhSKjAiEZocZdaUxeqyhE7qwDV7oWWwn
 92cGi0kQVmGD23ozyZ2VRSOfL1CnzEOmxisQq0dKUbrziDDmjod6Y5EKiFe1R6ENRBBMotUrU
 Hf6XH772/CNAmSgftWeYZyf6a8eVqHA2BoT+hyIuU9Q70emQsfW9RmRCsV34NFp/MtWZ+XAO6
 ZV8OcGuUlWJFoVK8DTCgE3gbgQGImYCh7qbnbFPzg/dX8IwWpHw12ooNeRjg8HBOtcHprLE2S
 DJ4RMc4j/YAkB6uWiiKB7ftZepI2xhMFOdXhcNEX4kkNuXNPj0uStpjqVk49mLN7Q99nivogV
 Ctopr0G16DIoRnY45hroq9WzMqAvJqnu2zaTD0ynzkR47vEuE/1ycBJcuyCuBIkYhTNK0X2SF
 UkVW4El1KYHCG/UuX/TCW7cKUJMZpiXwPnr7YDD86v+NmBEaj8YbPPHQkM5FWR8PJjXPnl2uO
 PJaw726pf9Xt4XRI87bLD3EUBvhufv3MVGvhqFS2Mvwnpl7l/jtJoBRQeE4owifUfZbSBTF99
 8RcdnwMcoRJYB6R3qCHumjjLbCNmHOvd/Y7pZ/wRTW5ZrF9Q2EvLrzgBMV28Hj1pzBv/XCJxk
 KTr6E38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

 cygwin can use an UNC path like //server/share/repo
 $ cd //server/share/dir
 $ mkdir test
 $ cd test
 $ git init --bare

 However, when we try to push from a local Git repository to this repo,
 there is a problem: Git converts the leading "//" into a single "/".

 As cygwin handles an UNC path so well, Git can support them better:
 - Introduce cygwin_offset_1st_component() which keeps the leading "//",
   similar to what Git for Windows does.
 - Move CYGWIN out of the POSIX in the tests for path normalization in t0060.
---
 config.mak.uname      | 1 +
 git-compat-util.h     | 3 +++
 t/t0060-path-utils.sh | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index adfb90b..551e465 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -184,6 +184,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	COMPAT_OBJS += compat/cygwin.o
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 047172d..db9c22d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,6 +189,9 @@
 #include <sys/sysctl.h>
 #endif
 
+#if defined(__CYGWIN__)
+#include "compat/cygwin.h"
+#endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4..7ea2bb5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -70,6 +70,8 @@ ancestor() {
 case $(uname -s) in
 *MINGW*)
 	;;
+*CYGWIN*)
+	;;
 *)
 	test_set_prereq POSIX
 	;;
-- 
2.10.0

