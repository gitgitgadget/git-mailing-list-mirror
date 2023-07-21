Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB2FEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGURAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGURAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327126A0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:00:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43D862E9FD;
        Fri, 21 Jul 2023 13:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JSvuEcqpdsFd
        2swImsdJM7KxYeeIuOhwIc4kflmzdvU=; b=uK7uAEXpUBQwMfsVsEUbYwEKR8C7
        gVKVe28PGGl+a3J2O7laDr7swbXzmspVwgQvBDqhe0tp6PAOH0bxX6auqw4Q1MAm
        xKHUeMrHH2nqDdMDe6UO0GWP5c8XwLKz33ttPLF31VZPorrHCvZJ1ymO20Vgd1/j
        7zNFwk/5Wl6nS3k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C31C2E9FC;
        Fri, 21 Jul 2023 13:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B08D2E9FB;
        Fri, 21 Jul 2023 13:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
Date:   Fri, 21 Jul 2023 10:00:04 -0700
In-Reply-To: <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 15:41:33 +0200")
Message-ID: <xmqqy1j9urmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AFB4DDE-27E8-11EE-88EB-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ren=C3=A9 Scharfe <l.s.r@web.de>
Date: Fri, 21 Jul 2023 15:41:33 +0200

Since 2c33f75754 (Teach git-describe --exact-match to avoid expensive
tag searches, 2008-02-24) git describe accepts --no-exact-match, but it
does the same as --exact-match, an alias for --candidates=3D0.  That's
because it's defined using OPT_SET_INT with a value of 0, which sets 0
when negated as well.

Let --no-exact-match set the number of candidates to the default value
instead.  Users that need a more specific lack of exactitude can specify
their preferred value using --candidates, as before.

The "--no-exact-match" option was not covered in the tests, so let's
add a few.  Also add a case where --exact-match option is used on a
commit that cannot be described without distance from tags and make
sure the command fails.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
[jc: added trivial tests]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Stole tests from my version.

 builtin/describe.c  | 17 ++++++++++++++---
 t/t6120-describe.sh |  8 ++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 55b4baaa22..a5ba584cdd 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,6 +24,7 @@
 #include "commit-slab.h"
=20
 #define MAX_TAGS	(FLAG_BITS - 1)
+#define DEFAULT_CANDIDATES 10
=20
 define_commit_slab(commit_names, struct commit_name *);
=20
@@ -40,7 +41,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int first_parent;
 static int abbrev =3D -1; /* unspecified */
-static int max_candidates =3D 10;
+static int max_candidates =3D DEFAULT_CANDIDATES;
 static struct hashmap names;
 static int have_util;
 static struct string_list patterns =3D STRING_LIST_INIT_NODUP;
@@ -556,6 +557,15 @@ static void describe(const char *arg, int last_one)
 	strbuf_release(&sb);
 }
=20
+static int option_parse_exact_match(const struct option *opt, const char=
 *arg,
+				    int unset)
+{
+	BUG_ON_OPT_ARG(arg);
+
+	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
+	return 0;
+}
+
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains =3D 0;
@@ -567,8 +577,9 @@ int cmd_describe(int argc, const char **argv, const c=
har *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first paren=
t")),
 		OPT__ABBREV(&abbrev),
-		OPT_SET_INT(0, "exact-match", &max_candidates,
-			    N_("only output exact matches"), 0),
+		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
+			       N_("only output exact matches"),
+			       PARSE_OPT_NOARG, option_parse_exact_match),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c9afcef201..0a5c487540 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -85,6 +85,7 @@ check_describe e-1-gHASH --tags HEAD^^
 check_describe c-2-gHASH --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
+check_describe e --tags --exact-match HEAD^^^
=20
 check_describe heads/main --all HEAD
 check_describe tags/c-6-gHASH --all HEAD^
@@ -96,6 +97,13 @@ check_describe A-3-gHASH --long HEAD^^2
 check_describe c-7-gHASH --tags
 check_describe e-3-gHASH --first-parent --tags
=20
+check_describe c-7-gHASH --tags --no-exact-match HEAD
+check_describe e-3-gHASH --first-parent --tags --no-exact-match HEAD
+
+test_expect_success '--exact-match failure' '
+	test_must_fail git describe --exact-match HEAD 2>err
+'
+
 test_expect_success 'describe --contains defaults to HEAD without commit=
-ish' '
 	echo "A^0" >expect &&
 	git checkout A &&
--=20
2.41.0-376-gcba07a324d

