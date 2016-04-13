From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Tue, 12 Apr 2016 17:18:28 -0700
Message-ID: <1460506710-23994-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, pclouds@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 02:18:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8Vy-0005qn-RA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbcDMASe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:18:34 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35192 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbcDMASd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:18:33 -0400
Received: by mail-pf0-f174.google.com with SMTP id n1so23167145pfn.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vK4jrDLHtx5lTZZ65Z22ffiaVRzd/ROjMUyrB7rACNc=;
        b=Ym5xao+jJ8ztujqNK7UTlea0K7fiHLUFv3lfOq4HPNnxyS19hVplny9O1XaY3OzFxW
         n8HglWwHt2xxGK0EzM9hHvg4EHtVBkOEwbGpHBHfhGU73rvxXZyX1F/E7f2qAgSxyRtz
         PRvc5H97Hzk40f08hfEGEm08wRA4CtJ2SEB+jMVHHNPRGRKdlkI8DbYXtgnBhKaayssK
         mFvae+xxzbTOs9cMj+3a7p+4YCAwZE4q0QT/pSbtV9M77bNywUa55ey+3+Klbs4C61p/
         XwysZ0d3qTRR8U9SAjHAkIqaOiDZAdkSSlalO3lnFNFvc8rr8UJrssVXXlvfv/kkWHSv
         eBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vK4jrDLHtx5lTZZ65Z22ffiaVRzd/ROjMUyrB7rACNc=;
        b=K6GQFPPjmuKAMBe5dp60KmSfSqqf7lDfC8lMNTmf+/yTt4xqC0OqAbUl4Xe48tYddM
         fD5KOtxYeo0W/oa7y3t0NOt1/hZGrf3kHaz0mtR2NJpAfuNDfLgfgi33jljeg02H1D+Q
         HoTIGMNv5TuSpLVOlFFP+kxFgD+pe2d4Kmtmj8sym12xs4KCIch1ruRs7KJxA+JSoMAf
         +xjdJeVvvtcA4ObAG50RZKltxcWnJcisE+4lheqHww92joNbgcBDSUlWnq65zixbbkc9
         P6oDX49Lq/n+kAAYoNOCNXMritgB4GI97sAlCrMo/F2p9XbZoUcCACHZ/2y/x3KuSAl5
         eHpA==
X-Gm-Message-State: AOPr4FVGDPElxslSVTGy3t+4x1us6cysv3SVguqwFsBUeK1rGKukcAStUFd3rdvCwJ4WfWBX
X-Received: by 10.98.32.23 with SMTP id g23mr8680489pfg.74.1460506712778;
        Tue, 12 Apr 2016 17:18:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id 8sm46210467pfk.69.2016.04.12.17.18.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 17:18:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291334>

This is a resend of origin/sb/submodule-init (and it still applies on 
top of submodule-parallel-update)

I squashed a change which Michael Haggerty proposed in one of the
large cleanup series preparing for the new refs backend. (18/21)
As that is the only fix in that series touching submodules,
picking it up here would untangle sb/submodule-init from that series.

Thanks,
Stefan

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d942463..3078790 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -17,9 +17,8 @@ static char *get_default_remote(void)
 {
        char *dest = NULL, *ret;
        unsigned char sha1[20];
-       int flag = 0;
        struct strbuf sb = STRBUF_INIT;
-       const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+       const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 
        if (!refname)
                die(_("No such ref: %s"), "HEAD");


Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 316 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +----------------
 submodule.c                 |  21 +++
 submodule.h                 |   1 +
 t/t0060-path-utils.sh       |  43 ++++++
 5 files changed, 384 insertions(+), 115 deletions(-)

-- 
2.5.0.264.gc776916.dirty
