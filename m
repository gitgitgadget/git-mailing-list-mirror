Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9802035F
	for <e@80x24.org>; Tue, 25 Oct 2016 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754865AbcJYPa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 11:30:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:65416 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753905AbcJYPa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 11:30:27 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVNWU-1cPsdv3QTe-00YhpK; Tue, 25 Oct 2016 17:30:13
 +0200
Date:   Tue, 25 Oct 2016 17:30:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
cc:     Gavin Lambert <github@mirality.co.nz>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-svn: do not reuse caches memoized for a different
 architecture
Message-ID: <653aa0cd566a2486bbc38cfd82ddfcfdfe48271c.1477398004.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xsyrIdYk+nMlGAmYLqzuXueLHB5zEk+NHuFKG6xvXynLUPNkvxb
 19PjTnzbYT72EEdRQcPP+uL5xwzI8XTbuxJiGheBMjNgmaX3uxKezxy6kyhB9hiIJFw4qlX
 gNuaumUG+9JgmQfnbDDRzuOfvBWsYf9XbsCGTmFsLZ9wvGCYtLNXi6z2BvocYkuci++XD+F
 sSAI9L+Ptb0tXIGt4+DcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QO41+hGOxKI=:eKvBmm4eovSbMGz5hqcgTT
 WqDzrRKxFC7g6sZDA19VhsfAEdvEByHDlQaaL762E9lFtVgJeAXFP9BkUn/8vZuEv/1Y57MWl
 21ILKhEU7c092IV35YMJVhB2kTIIpmI9sZkBg0rHkrAAOwd/ZKR+vZolyHaK901fP8LToywOp
 5YemwRYqMfC8Y4x1lVj9KrVzlqUwrYly9kad3ASEUumdhFAoWLoN1vgDv3k7EyOk4B7r1nrkC
 Qi9Y675d15tcwntI1XX+Z/Eg/NUMtHGksKiZeY8shZXK1Mq8Meb/R8gFlkH2JwG0AnwQ+NWiq
 YhFLWt6/1/ArM5RdKqiFCZX8Wby7TB9+ZrFJxNK8eT4wcJWVrDKw32MsnQrMUiPPaeO0ffdS1
 w35g8Jr2RfSbpBkMll06XJSblV6DuS48Xlco3FZ8pishqURslP/lJffFZr/lOEQajGzO+8oDT
 yIJ41JF2CZpunIrByQb/N5yyNlU15UqskK+0dELnqBy5/rHq+dBXIrhuM/F4tImNRLSwK4heF
 oNsfl9H/W/8fXjlsMKEgYGQQWDHQzzBEiDJG+YG95auudXR5ofil1w2+LYteIfke1mZM+PlMN
 G4ICjM7nMjJVZC57/EjpBarekOyDt5HcmFD3T2bMjzKSzgdC1ZNqWi9iK4n55qKGqKbrryYsJ
 agQ2eGkChkLHl9VumzMz+KXIBs7nEKlaoqEZ1mRhF1lKeUui3ry05Pdf4uhhu7S761Q81l13N
 ljE1AwbpiDZz8CbmNr4p302vKdNY+KffR9SzDluhc43D0Xr0s/74l9fDUFmSK6pYStkzcQIt9
 rbs4FIa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gavin Lambert <github@mirality.co.nz>

Reusing cached data speeds up git-svn by quite a fair bit. However, if
the YAML module is unavailable, the caches are written to disk in an
architecture-dependent manner. That leads to problems when upgrading,
say, from 32-bit to 64-bit Git for Windows.

Let's just try to read those caches back if we detect the absence of the
YAML module and the presence of the file, and delete the file if it
could not be read back correctly.

Note that the only way to catch the error when the memoized cache could
not be read back is to put the call inside an `eval { ... }` block
because it would die otherwise; the `eval` block should also return `1`
in case of success explicitly since the function reading back the cached
data does not return an appropriate value to test for success.

This fixes https://github.com/git-for-windows/git/issues/233.

Signed-off-by: Gavin Lambert <github@mirality.co.nz>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/svn-multi-arch-v1
Fetch-It-Via: git fetch https://github.com/dscho/git svn-multi-arch-v1

We carried this for some time in Git for Windows.

 perl/Git/SVN.pm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 018beb8..025c894 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1658,6 +1658,11 @@ sub tie_for_persistent_memoization {
 	if ($memo_backend > 0) {
 		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
 	} else {
+		# first verify that any existing file can actually be loaded
+		# (it may have been saved by an incompatible version)
+		if (-e "$path.db") {
+			unlink "$path.db" unless eval { retrieve("$path.db"); 1 };
+		}
 		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
 	}
 }

base-commit: 659889482ac63411daea38b2c3d127842ea04e4d
-- 
2.10.1.583.g721a9e0
