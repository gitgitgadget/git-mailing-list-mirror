Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA0C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 22:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3887222582
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 22:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgLOWdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:33:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57065 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgLOWdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 17:33:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91B9D11630C;
        Tue, 15 Dec 2020 17:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o7twrcAYKTSp9ag2vVdCkiCtnX4=; b=fyV60v
        6UvTvrMMgjuzd9J0MrOSmUmtWFfv15LTS0DWoWB+vG3KNv7awhOYuv+ba6Mhy3rm
        69hv5u9NslIKuRQQYfawiR+FLnYtqgwaNVBC5eY0+CZsBaJXIKJiYu1o+3mUH+VK
        dX6PIiaKrRH0mE9DVr/GVLzENLngW9INPkQ6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v3FDNET8p9TiSSQ5w3D0xJB3pDVyEguQ
        Wt5HGNPW39SwWljZs8O9qupZMUIWtvzDzoid7IAu0lUg6GimFMv3t2+oL7maMuOH
        qNiWwAa/BoADo93q4EgivdQQXLCCx1FaL/wOdXTbyCfes9/JQCeSDlTUwV47e6od
        5AQ6wekg5XA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B59611630B;
        Tue, 15 Dec 2020 17:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B898011630A;
        Tue, 15 Dec 2020 17:32:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Daniel C. Klauer" <daniel.c.klauer@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org
Subject: Re: bug report: "git pack-redundant --all" crash in minimize()
References: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
        <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
Date:   Tue, 15 Dec 2020 14:32:34 -0800
In-Reply-To: <X9j+nuzjiYyw/vQx@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 15 Dec 2020 13:21:18 -0500")
Message-ID: <xmqq8s9y7la5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EA73978-3F25-11EB-AA29-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We had a discussion not too long ago[1] about whether we should
> deprecate and remove pack-redundant, as it's not generally useful. I'm
> curious if you have any more context on why it's used in that tool.
>
> -Peff
>
> [1] https://lore.kernel.org/git/20200825172214.GC1414394@coredump.intra.peff.net/

Hmm, it seems that we didn't follow through.

I do want to learn from the answer you just asked above, but in the
meantime, here is to save future work of digging the archive for me ;-)

Thanks.

-- >8 --
Subject: [PATCH] pack-redundant: gauge the usage before proposing its removal

The subcommand is unusably slow and the reason why nobody reports it
as a performance bug is suspected to be the absense of users.  Let's
show a big message that asks the user to tell us that they still
care about the command when an attempt is made to run the command,
with an escape hatch to override it with a command line option.

In a few releases, we may turn it into an error and keep it for a
few more releases before finally removing it (during the whole time,
the plan to remove it would be interrupted by end user raising hand).

Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 13 +++++++++++++
 t/t5323-pack-redundant.sh | 28 +++++++++++++++-------------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3e70f2a4c1..d3b5ee8364 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -554,6 +554,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int i_still_use_this = 0;
 	struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
@@ -580,12 +581,24 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			alt_odb = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--i-still-use-this")) {
+			i_still_use_this = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(pack_redundant_usage);
 		else
 			break;
 	}
 
+	if (!i_still_use_this) {
+		fputs(_("'git pack-redundant' is nominated for removal.\n"
+			"If you still use this command, please add an extra\n"
+			"option, '--i-still-use-this', on the command line\n"
+			"and let us know you still use it by sending an e-mail\n"
+			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
+	}
+
 	if (load_all_packs)
 		load_all();
 	else
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 6b4d1ca353..2dd2d67b9e 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -39,6 +39,8 @@ relationship between packs and objects is as follows:
 master_repo=master.git
 shared_repo=shared.git
 
+git_pack_redundant='git pack-redundant --i-still-use-this'
+
 # Create commits in <repo> and assign each commit's oid to shell variables
 # given in the arguments (A, B, and C). E.g.:
 #
@@ -154,7 +156,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		EOF
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -192,7 +194,7 @@ test_expect_success 'master: one of pack-2/pack-3 is redundant' '
 		cat >expect <<-EOF &&
 			P3:$P3
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -231,7 +233,7 @@ test_expect_success 'master: pack 2, 4, and 6 are redundant' '
 			P4:$P4
 			P6:$P6
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -266,7 +268,7 @@ test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
 			P6:$P6
 			P8:$P8
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -284,9 +286,9 @@ test_expect_success 'master: clean loose objects' '
 test_expect_success 'master: remove redundant packs and pass fsck' '
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all | xargs rm &&
+		$git_pack_redundant --all | xargs rm &&
 		git fsck &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -304,7 +306,7 @@ test_expect_success 'setup shared.git' '
 test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -343,7 +345,7 @@ test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
 			P5:$P5
 			P7:$P7
 			EOF
-		git pack-redundant --all --verbose >out 2>out.err &&
+		$git_pack_redundant --all --verbose >out 2>out.err &&
 		test_must_be_empty out &&
 		grep "pack$" out.err | format_packfiles >actual &&
 		test_cmp expect actual
@@ -356,9 +358,9 @@ test_expect_success 'shared: remove redundant packs, no packs left' '
 		cat >expect <<-EOF &&
 			fatal: Zero packs found!
 			EOF
-		git pack-redundant --all --alt-odb | xargs rm &&
+		$git_pack_redundant --all --alt-odb | xargs rm &&
 		git fsck &&
-		test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
+		test_must_fail $git_pack_redundant --all --alt-odb >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
@@ -386,7 +388,7 @@ test_expect_success 'shared: create new objects and packs' '
 test_expect_success 'shared: no redundant without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -417,7 +419,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 test_expect_success 'shared: one pack is redundant with --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all --alt-odb >out &&
+		$git_pack_redundant --all --alt-odb >out &&
 		format_packfiles <out >actual &&
 		test_line_count = 1 actual
 	)
@@ -454,7 +456,7 @@ test_expect_success 'shared: ignore unique objects and all two packs are redunda
 			Px1:$Px1
 			Px2:$Px2
 			EOF
-		git pack-redundant --all --alt-odb >out <<-EOF &&
+		$git_pack_redundant --all --alt-odb >out <<-EOF &&
 			$X
 			$Y
 			$Z
-- 
2.30.0-rc0-186-g20447144ec

