Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC542C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A519560F4B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbhIARQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:16:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhIARQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:16:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BBD6148AB2;
        Wed,  1 Sep 2021 13:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DfqRnPoSQgsP0uCYCT2VrpHmyiLZFoe7hjDec3
        OPgMg=; b=XpTv79QP1hksdshiYMEpavQn+dvib4GtoecoOmlasriZBGIKFwCjWd
        gNrFAjOrVXB34hbUnvpz8V1rU73WpersFd28lWL3a9BQaIqfHj94jsQGL8P72BLm
        U+sicMwlTc4oeXYFZ3yiG9gwaNt2UO7QYpX3zkBoB8NghJ31HKiHU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E943148AB0;
        Wed,  1 Sep 2021 13:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72DA1148AAE;
        Wed,  1 Sep 2021 13:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RESEND v2] make: add install-stripped target
References: <20210831013235.388682-1-bagasdotme@gmail.com>
        <xmqq8s0hwnkm.fsf@gitster.g>
        <96e4b388-d924-e5a9-b23f-07cc0007c328@gmail.com>
Date:   Wed, 01 Sep 2021 10:15:14 -0700
In-Reply-To: <96e4b388-d924-e5a9-b23f-07cc0007c328@gmail.com> (Bagas Sanjaya's
        message of "Wed, 1 Sep 2021 18:31:26 +0700")
Message-ID: <xmqqo89cqkt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D2939D4-0B48-11EC-8491-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> If we make $(INSTALL_OPTS) applies to both compiled executables and
> scripts, we have problem that $(INSTALL) -s only works for the former.

Then don't make it apply to both ;-)

Isn't that what your patch did for early part of the install target?
$(PROGRAMS) are installed with $(INSTALL_OPTS) while the invocation
of $(INSTALL) for $(SCRIPTS) lack $(INSTALL_OPTS).

If we were to pursue this further, it probably is a good idea to
rename the $(INSTALL_OPTS) to $(INSTALL_STRIP) to avoid complaints
by confused users.

Something like this squashed into your patch, perhaps.

 Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git c/Makefile w/Makefile
index 28d1e9bfae..ebef4da50c 100644
--- c/Makefile
+++ w/Makefile
@@ -465,6 +465,9 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
+# if your $(INSTALL) command supports the option.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -3014,19 +3017,15 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
-INSTALL_OPTS =
-
-.PHONY: install-stripped
-
-install-stripped: INSTALL_OPTS = -s --strip-program=$(STRIP)
+INSTALL_STRIP =
 
-install-stripped install: all
+install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(INSTALL_OPTS) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(INSTALL_OPTS) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
 
 ifdef MSVC

