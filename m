Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF861F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEC1x (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:27:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:37347 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBEC1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 21:27:52 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id qqSkgsJSpAOoyqqSlgNq26; Tue, 05 Feb 2019 02:27:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=uP4WOHBJvssIi0xb6kEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/2] Makefile: improve SPARSE_FLAGS customisation
Message-ID: <3933d9e9-eb1a-c3ee-2aee-e24f99ac87d3@ramsayjones.plus.com>
Date:   Tue, 5 Feb 2019 02:27:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHDXO1ZxpyCzu1KeHOi6eSKQv1d8foiXq2OsghsDtebub6MWkWbdCa+Lxg4Uu3hPe0lu+gS2koUVuD0lR1EBU/WYiLoBNKJ+JKzOBJwmIo8UYUu+QvRl
 HNuDW0AdYdcAChFoyEi2RCnAuVIEwQeFyZXbBk6ZqlQqYseMGKGNDmeNvjpbUhOgm1cI8+dG536hOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In order to enable greater user customisation of the SPARSE_FLAGS
variable, we introduce a new SP_EXTRA_FLAGS variable to use for
target specific settings. Without using the new variable, setting
the SPARSE_FLAGS on the 'make' command-line would also override the
value set by the target-specific rules in the Makefile (effectively
making them useless). Also, this enables the SP_EXTRA_FLAGS to be
used in the future for any other internal customisations, such as
for some platform specific values.

In addition, we initialise the SPARSE_FLAGS to the default (empty)
value using a conditional assignment (?=). This allows SPARSE_FLAGS
to be set from the environment as well as from the command-line.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 6e8d017e8e..fcb7575e1b 100644
--- a/Makefile
+++ b/Makefile
@@ -574,7 +574,11 @@ SPATCH = spatch
 
 export TCL_PATH TCLTK_PATH
 
-SPARSE_FLAGS =
+# user customisation variable for 'sparse' target
+SPARSE_FLAGS ?=
+# internal/platform customisation variable for 'sparse'
+SP_EXTRA_FLAGS =
+
 SPATCH_FLAGS = --all-includes --patch .
 
 
@@ -2369,10 +2373,10 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
-http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
+http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
-pack-revindex.sp: SPARSE_FLAGS += -Wno-memcpy-max-count
+pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
 
 ifdef NO_EXPAT
 http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
@@ -2386,7 +2390,7 @@ endif
 ifdef USE_NED_ALLOCATOR
 compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR
-compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
+compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
@@ -2710,7 +2714,7 @@ SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
 $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-		$(SPARSE_FLAGS) $<
+		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
 
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
-- 
2.20.0
