Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAE31F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeISFmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:42:14 -0400
Received: from avasout06.plus.net ([212.159.14.18]:55955 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:42:14 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q1MgDymkWLW22Q1OgvGFE; Wed, 19 Sep 2018 01:07:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=qjkeRr3d8Kl_ivoMdEsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/9] Makefile: add a hdr-check target
Message-ID: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:07:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLoz4eMxAMRvYjjnJH2OPf2qidEYtW5zdDrVikKfp67aNQPWloZJdJS93HLaYsvTtvzHktL8DWgxt95oVy5dxxzSF5RjWO/ofJUBbJpkRZLEZsKlGN25
 dopa2g2rSydWq+/iCOsYWzWqP/OjGFwnRq5kuKHJc6MDCYdzZl7OBunBcjoY5PPG9E8btlaAqOJ+/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit ef3ca95475 ("Add missing includes and forward declarations",
2018-08-15) resulted from the author employing a manual method to
create a C file consisting of a pair of pre-processor #include
lines (for 'git-compat-util.h' and a given toplevel header), and
fixing any resulting compiler errors or warnings.

Add a Makefile target to automate this process. This implementation
relies on the '-include' and '-xc' arguments to the 'gcc' and 'clang'
compilers, which allows us to effectively create the required C
compilation unit on-the-fly. This limits the portability of this
solution to those systems which have such a compiler.

The new 'hdr-check' target can be used to check most header files in
the project (for various reasons, the 'compat' and 'xdiff' directories
are not included). Also, note that individual header files can be
checked directly using the '.hco' extension (read: Hdr-Check Object)
like so:

    $ make config.hco
        HDR config.h
    $

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index b567ccca45..835030e22b 100644
--- a/Makefile
+++ b/Makefile
@@ -1793,6 +1793,7 @@ ifndef V
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
+	QUIET_HDR      = @echo '   ' HDR $<;
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2675,6 +2676,17 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
+GEN_HDRS := command-list.h unicode-width.h
+EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
+CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
+HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
+
+$(HCO): %.hco: %.h FORCE
+	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+
+.PHONY: hdr-check $(HCO)
+hdr-check: $(HCO)
+
 .PHONY: style
 style:
 	git clang-format --style file --diff --extensions c,h
-- 
2.19.0
