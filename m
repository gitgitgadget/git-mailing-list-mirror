From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 16/28] Fix backslash handling when creating names of imported patches.
Date: Fri, 21 Mar 2014 08:31:54 +0100
Message-ID: <1395387126-13681-17-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyg-00045e-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbaCUHek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:40 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33719 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbaCUHdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:25 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so1360716lbi.22
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=syTGUuisKBK74D0mO33RGxWWbzyPElg1CbgA/Aodsw8=;
        b=WELwAwb8Ho0i1+VNpcWC1lPv4NZPdyXArWPqVnk50fuGYZxbLdBDlNmwqfUtkqCXun
         J7aIGbLLqTE8HFrszoGWajwfUFaU5oGH9o0aAvOVmqGhzZJIZd4UBjhhgg58tHH+V3FV
         +Jm8ULcBnVmicztPgNnxNusfmCtJEKGc9avaCUK1LP6kw7JcQT6fXR3l2F+UugyIvJIm
         Sl2aFEd5H5zDapbTeQtq39pE665nonsZz1JkH7AEkwrQmuyyzgwzCw+1d2QnQK+v0qY8
         oFbt6PpIxgkN4bC/S/xfb4BJXbF7Cj5amIivcf34BjI8haDTMz8KQLNrPvVJdFi9EfkQ
         n2Jw==
X-Gm-Message-State: ALoCoQkOTmKo/yQc9nOQhddaucWHAJUX8xIk31SIwK0DvthUBriXS25xbAlTj2qCRPFglNthY3WE
X-Received: by 10.112.28.82 with SMTP id z18mr31034958lbg.18.1395387203685;
        Fri, 21 Mar 2014 00:33:23 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244671>

The 'echo %s' construct sometimes processes escape sequences.  (This
happens, for instance, under Ubuntu 14.04 when /bin/sh is actually
dash.)  We don't want that to happen when we are importing commits, so
use 'printf %s "$s"' instead.

(The -E option of bash that explicitly disables backslash expansion is
not portable; it is not supported by dash.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-import-commit  |  2 +-
 regression/t-034.out | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/guilt-import-commit b/guilt-import-commit
index a4119d6..6eb2f4e 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -30,7 +30,7 @@ for rev in `git rev-list $rhash`; do
 
 	# Try to convert the first line of the commit message to a
 	# valid patch name.
-	fname=`echo $s | sed -e "s/&/and/g" -e "s/[ :]/_/g" -e "s,[/\\],-,g" \
+	fname=`printf %s "$s" | sed -e "s/&/and/g" -e "s/[ :]/_/g" -e "s,[/\\],-,g" \
 			-e "s/['\\[{}]//g" -e 's/]//g' -e 's/\*/-/g' \
 			-e 's/\?/-/g' -e 's/\.\.\.*/./g' -e 's/^\.//' \
 			-e 's/\.patch$//' -e 's/\.$//' | tr A-Z a-z`
diff --git a/regression/t-034.out b/regression/t-034.out
index 7bc9459..bda4399 100644
--- a/regression/t-034.out
+++ b/regression/t-034.out
@@ -236,7 +236,7 @@ Date:   Mon Jan 1 00:00:00 2007 +0000
 About to begin conversion...
 Current head: 2a8b1889aa5066193bac978e6bf5073ffcfa6541
 Converting 2a8b1889 as can-have-embedded-single-slashes
-Converting 0a46f8fa as backslash-isorbidden
+Converting 0a46f8fa as backslash-is-forbidden
 Converting aedb74fd as x
 Converting 30187ed0 as cannot@have@the@sequence@at-brace
 Converting 106e8e5a as cannot_end_in_
@@ -300,7 +300,7 @@ Applying patch..cannot@have@the@sequence@at-brace.patch
 Patch applied.
 Applying patch..x.patch
 Patch applied.
-Applying patch..backslash-isorbidden.patch
+Applying patch..backslash-is-forbidden.patch
 Patch applied.
 Applying patch..can-have-embedded-single-slashes.patch
 Patch applied.
@@ -311,7 +311,7 @@ Date:   Mon Jan 1 00:00:00 2007 +0000
 
     Can/have/embedded/single/slashes
 
-commit 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141 (refs/patches/master/backslash-isorbidden.patch)
+commit 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141 (refs/patches/master/backslash-is-forbidden.patch)
 Author: Author Name <author@email>
 Date:   Mon Jan 1 00:00:00 2007 +0000
 
@@ -518,8 +518,6 @@ d .git/patches/master
 d .git/refs/patches
 d .git/refs/patches/master
 f 06beca7069b9e576bd431f65d13862ed5d3e2a0f  .git/patches/master/ctrlisforbidden.patch
-f 08267ec6783ea9d1adae55b275198f7594764ed0  .git/patches/master/series
-f 08267ec6783ea9d1adae55b275198f7594764ed0  .git/patches/master/status
 f 09b7e9be44ae5ec3a4bb30f5ee9d4ebc2c042f64  .git/patches/master/two_consecutive_dots_(.)_is_forbidden.patch
 f 0b971c9a17aeca2319c93d700ffd98acc2a93451  .git/patches/master/question-mark-is-forbidden.patch
 f 2b8392f63d61efc12add554555adae30883993cc  .git/patches/master/cannot-end-in-slash-.patch
@@ -529,7 +527,7 @@ f 34e07c584032df137f19bdb66d93f316f00a5ac8  .git/patches/master/tildeisforbidden
 f 49bab499826b63deb2bd704629d60c7268c57aee  .git/patches/master/the_sequence_-._is_forbidden.patch
 f 5bcddb8ccb6e6e5e8a61e9e56cb2e0f70cbab2f5  .git/patches/master/cannot@have@the@sequence@at-brace.patch
 f 637b982fe14a240de181ae63226b27e0c406b3dc  .git/patches/master/asterisk-is-forbidden.patch
-f 698f8a7d41a64e3b6be1a3eba86574078b22a5f3  .git/patches/master/backslash-isorbidden.patch
+f 698f8a7d41a64e3b6be1a3eba86574078b22a5f3  .git/patches/master/backslash-is-forbidden.patch
 f 7b103c3c7ae298cd2334f6f49da48bae1424f77b  .git/patches/master/crisalsoforbidden.patch
 f 9b810b8c63779c51d2e7f61ab59cd49835041563  .git/patches/master/x.patch
 f a22958d9ae9976fd7b2b5a9d0bcd44bf7ad9b08a  .git/patches/master/caretisforbidden.patch
@@ -537,6 +535,8 @@ f ab325bf5a432937fc6f231d3e8a773a62d53952b  .git/patches/master/multiple-slashes
 f cb9cffbd4465bddee266c20ccebd14eb687eaa89  .git/patches/master/delisforbidden.patch
 f d0885a1a1fdee0fd1e4fedce3f7acd3100540bc4  .git/patches/master/openbracketisforbidden.patch
 f d2903523fb66a346596eabbdd1bda4e52b266440  .git/patches/master/check-multiple-.-dots-.-foo.patch
+f da90de1c84138194524994e0bc3bc4ca8189c999  .git/patches/master/series
+f da90de1c84138194524994e0bc3bc4ca8189c999  .git/patches/master/status
 f dfc11f76394059909671af036598c5fbe33001ba  .git/patches/master/space_is_forbidden.patch
 f e47474c52d6c893f36d0457f885a6dd1267742bb  .git/patches/master/colon_is_forbidden.patch
 f e7a5f8912592d9891e6159f5827c8b4f372cc406  .git/patches/master/the_sequence_.lock-_is_forbidden.patch
@@ -548,7 +548,7 @@ r 1626a11d979a1e9e775c766484172212277153df  .git/refs/patches/master/asterisk-is
 r 3a0d5ccef0359004fcaa9cee98fbd6a2c4432e74  .git/refs/patches/master/tildeisforbidden.patch
 r 434e07cacdd8e7eb4723e67cb2d100b3a4121a3a  .git/refs/patches/master/can-have-embedded-single-slashes.patch
 r 74df14ab3a0ec9a0382998fbf167ebb1b0a36c6a  .git/refs/patches/master/question-mark-is-forbidden.patch
-r 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141  .git/refs/patches/master/backslash-isorbidden.patch
+r 7c3ffa4f940c862e9f11f5d4a5ae421f7a8d3141  .git/refs/patches/master/backslash-is-forbidden.patch
 r 96a3e92c4df85f52362ce4f6d31983c462db9ae9  .git/refs/patches/master/a-component-may-not-end-in-foolock.patch
 r 9fc9677b61880f9159838e89f714893e0a2fcafb  .git/refs/patches/master/delisforbidden.patch
 r a275ed5d7f10ea88c986852ee95a7d5a61663b5f  .git/refs/patches/master/cannot@have@the@sequence@at-brace.patch
-- 
1.8.3.1
