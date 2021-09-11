Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3958C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA406611BF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhIKAQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:16:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57305 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhIKAQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:16:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10519E9022;
        Fri, 10 Sep 2021 20:14:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y340CKGM5zBM
        IyP0r9dasEpbSfGkbhG1dxPQRzXlT2s=; b=jiRvdTdM1o7KivbqBoEuIDB8aSUP
        rro6XOlSLAxQ/GItCVQZgex/r7hN4iWCwF6avqInS3r7ceS5QLj5NbTURdMAEOo+
        NIIg8IHgpTZY50HgDPu8//mz2HCaE2aiCYV5dKE5hpWcisnRiVd+KkbVyOj/e1/e
        /mwD+tddPbE29ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9FE2E9021;
        Fri, 10 Sep 2021 20:14:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F794E901F;
        Fri, 10 Sep 2021 20:14:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for built-ins
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 17:14:56 -0700
In-Reply-To: <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 17:38:32
        +0200")
Message-ID: <xmqqr1dwotmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BE091A2-1295-11EC-92D5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the implementation of b5dd96b70ac (make credential helpers
> builtins, 2020-08-13) to declare in the "struct cmd_struct" that
> NO_UNIX_SOCKETS can't be set.

It may happen to be that two credential-cache program are both
related to the same CPP macro NO_UNIX_SOCKETS, but I think the
pattern you are tackling with this topic is that a fallback
definition of a function that is designed to always die when invoked
misuses the parse-options API.  I do not want to see you invent a
new bit in cmd_struct for each and every conditional that lets us
define such a die-only fallback implementation.

I may be missing something obvious, but can't the following suffice,
and if not, why?

Thanks.

 builtin/credential-cache--daemon.c | 9 ---------
 builtin/credential-cache.c         | 9 ---------
 2 files changed, 18 deletions(-)

diff --git i/builtin/credential-cache--daemon.c w/builtin/credential-cach=
e--daemon.c
index 4c6c89ab0d..f11a89a89b 100644
--- i/builtin/credential-cache--daemon.c
+++ w/builtin/credential-cache--daemon.c
@@ -304,15 +304,6 @@ int cmd_credential_cache_daemon(int argc, const char=
 **argv, const char *prefix)
=20
 int cmd_credential_cache_daemon(int argc, const char **argv, const char =
*prefix)
 {
-	const char * const usage[] =3D {
-		"git credential-cache--daemon [options] <action>",
-		"",
-		"credential-cache--daemon is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] =3D { OPT_END() };
-
-	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
 	die(_("credential-cache--daemon unavailable; no unix socket support"));
 }
=20
diff --git i/builtin/credential-cache.c w/builtin/credential-cache.c
index e8a7415747..dd794f84ce 100644
--- i/builtin/credential-cache.c
+++ w/builtin/credential-cache.c
@@ -142,15 +142,6 @@ int cmd_credential_cache(int argc, const char **argv=
, const char *prefix)
=20
 int cmd_credential_cache(int argc, const char **argv, const char *prefix=
)
 {
-	const char * const usage[] =3D {
-		"git credential-cache [options] <action>",
-		"",
-		"credential-cache is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] =3D { OPT_END() };
-
-	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
 	die(_("credential-cache unavailable; no unix socket support"));
 }
=20

