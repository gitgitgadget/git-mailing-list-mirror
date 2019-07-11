Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1641F461
	for <e@80x24.org>; Thu, 11 Jul 2019 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfGKWDG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 18:03:06 -0400
Received: from avasout04.plus.net ([212.159.14.19]:60988 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGKWDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 18:03:06 -0400
Received: from [10.0.2.15] ([146.90.155.229])
        by smtp with ESMTPA
        id lh9chvtftaslVlh9dhxNPf; Thu, 11 Jul 2019 23:03:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1562882585; bh=fw3pxj9YX1OR3nDxB92Q/iEFtIM/zy1NGy3dqBtxh8Y=;
        h=From:To:Cc:Subject:Date;
        b=HHwi8Y3QNTLBtKbvFNAiVzcC89CuAS2pldKEMU9/LpkQKiYnxR6ifY4T4nwhmr17j
         C998lZtT0dF5T0hqTIVuy/RwprWH+U4wFm3DXEmI/2U55Z1DAdkuT3Fp93eboDQS1V
         gdHI9KQbUXgeYnfrJhtXQ1YMhfjStjccXQRyvFyWqaKw2WKvQiDUWk3YPgKtfIzOP+
         8wedpoO6m6YaqupkPyIsHDa123TWttvj+PFAjgW/2nmEZX9l9qoXB1Om+u6TCtDrvm
         UN/gq0wtnh/iv0en+imeNcGeoIdhin8Mj9JEKui2Fxm33MeRdNNRpCFaUkxlo4g09M
         dObE0W9B8kmkA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=vIuMZWos35SQ56IFzOfLHA==:117 a=vIuMZWos35SQ56IFzOfLHA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=8m-p5IFQrjB3aJAUfiYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
Message-ID: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
Date:   Thu, 11 Jul 2019 23:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfF2cDcv72Aseb9w+nhsHV00aKL640TufDkbD+QbqDECIcKDQShEXNWdVGEdhj39emOTc0FAXHwVpswhZQPpiUyNuNH9TkCgEGRCA2cmFbToY50kGIr7p
 +9n5VciNoGy784urUT5e2kFYfKxYQ3REQS+J+CdcPeNaH0pNbZ4R+s2IyqpF/HZfRP0D/MhrC7a3xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Thomas,

If you need to re-roll your 'tg/range-diff-output-update' branch, could
you please squash (parts) of this into the relevant patches.

The first hunk fixes a couple of 'hdr-check' warnings:

  $ diff nhcout phcout | head
  4a5,13
  > apply.h:146:22: error: ‘GIT_MAX_HEXSZ’ undeclared here (not in a function); did you mean ‘NI_MAXHOST’?
  >   char old_oid_prefix[GIT_MAX_HEXSZ + 1];
  >                       ^~~~~~~~~~~~~
  >                       NI_MAXHOST
  > apply.h:151:19: error: array type has incomplete element type ‘struct object_id’
  >   struct object_id threeway_stage[3];
  >                    ^~~~~~~~~~~~~~
  > Makefile:2775: recipe for target 'apply.hco' failed
  > make: *** [apply.hco] Error 1
  $ 

and needs to be applied to commit b9f62a7e24 ("apply: make parse_git_header
public", 2019-07-08).

The second hunk fixes a sparse 'Using plain integer as NULL pointer'
warning, and needs to be applied to commit 04539fc67b ("range-diff: add
section header instead of diff header", 2019-07-08).

Thanks!

ATB,
Ramsay Jones

 apply.h      | 1 +
 range-diff.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/apply.h b/apply.h
index ade50f66c5..c8c9287cb2 100644
--- a/apply.h
+++ b/apply.h
@@ -3,6 +3,7 @@
 
 #include "lockfile.h"
 #include "string-list.h"
+#include "hash.h"
 
 struct repository;
 
diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..0f24a4ad12 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -102,7 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
 		}
 
 		if (starts_with(line, "diff --git")) {
-			struct patch patch = { 0 };
+			struct patch patch = { NULL };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
 
-- 
2.22.0
