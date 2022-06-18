Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F7BC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 22:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiFRWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiFRWFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 18:05:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5212081
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 15:05:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CAA1199884;
        Sat, 18 Jun 2022 18:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z2QANN+au5M4CsVp7WJhK8wtIb1Z+78x3R61zF
        CHlEA=; b=yZLHPoxVOGrxYVAFM1Ho3mYpiJx4HsktGEpZjxuoZkK6XYh9p9RF7P
        bMJnBIR7QNaQF0fc3TrGmUTqKxRmMvpTvy4kBQyOgYv1yJXsx4UCSMBwX2bYdTq/
        FlwQoxIuNN8w/D+EOBPFZDw1LOXFdpUFxYNVrtuMQq4VhHtti2Irw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24A39199883;
        Sat, 18 Jun 2022 18:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0932199880;
        Sat, 18 Jun 2022 18:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths
 containing colons
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <20220528231118.3504387-1-gitster@pobox.com>
        <20220528231118.3504387-3-gitster@pobox.com>
        <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org>
        <xmqqpmj9zohk.fsf@gitster.g>
        <20220615213656.zp36wdwbcz7yevac@lucy.dinwoodie.org>
        <nycvar.QRO.7.76.6.2206182213290.349@tvgsbejvaqbjf.bet>
Date:   Sat, 18 Jun 2022 15:05:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206182213290.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 18 Jun 2022 22:19:28 +0200 (CEST)")
Message-ID: <xmqqlettljad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBC19DDC-EF52-11EC-A1EF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd rather avoid changing FUNNYNAMES at this stage, if we can help it.

I wonder if it is sufficient to ask "unzip -l" the names of the
files in the archive, without having to materialize these files on
the filesystem.  Would that bypass the whole FUNNYNAMES business, or
is "unzip" paranoid enough to reject an archive, even when it is not
extracting into the local filesystem, with a path that it would not
be able to extract if it were asked to?

I do not know how standardized different implementations of "unzip"
is, and how similar output "unzip -l" implementations produce are,
but the following seems to pass for me locally.

 t/t5003-archive-zip.sh | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git c/t/t5003-archive-zip.sh w/t/t5003-archive-zip.sh
index 3992d08158..f2fdf2c235 100755
--- c/t/t5003-archive-zip.sh
+++ w/t/t5003-archive-zip.sh
@@ -207,23 +207,13 @@ check_zip with_untracked
 check_added with_untracked untracked untracked
 
 test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
-	if test_have_prereq FUNNYNAMES
-	then
-		PATHNAME="pathname with : colon"
-	else
-		PATHNAME="pathname without colon"
-	fi &&
+	PATHNAME="pathname with : colon" &&
 	git archive --format=zip >with_file_with_content.zip \
 		--add-virtual-file=\""$PATHNAME"\": \
 		--add-virtual-file=hello:world $EMPTY_TREE &&
-	test_when_finished "rm -rf tmp-unpack" &&
-	mkdir tmp-unpack && (
-		cd tmp-unpack &&
-		"$GIT_UNZIP" ../with_file_with_content.zip &&
-		test_path_is_file hello &&
-		test_path_is_file "$PATHNAME" &&
-		test world = $(cat hello)
-	)
+	"$GIT_UNZIP" -l with_file_with_content.zip >toc &&
+	grep -e " $PATHNAME\$" toc &&
+	grep -e " hello\$" toc
 '
 
 test_expect_success 'git archive --format=zip --add-file twice' '
