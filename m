Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGGRYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGGRYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 13:24:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660D26B1
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 10:24:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B23A244FD;
        Fri,  7 Jul 2023 13:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=szgKzxHk21XWAmi1PRUHGmlDHI0bTNbm+clb4Z
        cVneI=; b=HdbovvsAYr8wy2YQg3afOoPFPR6BAHVppndYTf+frsWItzwWaW9q3e
        0HutkIgVGo6tw2LyjGTCbt4b7Aewx9ALYOCL1Xmu1h0VwJPvprRiITJtyxsUH7ow
        +xdLIdIQ2n9FIoTJybeYCAkSUIihCNKlHK5jWl7t0NkTQFfwIgBAs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 738F7244FC;
        Fri,  7 Jul 2023 13:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 094C4244FA;
        Fri,  7 Jul 2023 13:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Hughes <mhughes@uw.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: Expected behaviour for pathspecs matching attributes in
 subdirectories
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
        <xmqq7crddjtq.fsf@gitster.g>
        <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
        <xmqqjzvcbvqd.fsf@gitster.g>
        <CAEzX-aCnp0avSbMdyFQz=3s4-hjdeVwnndR5b7UeZo4oNMnv7A@mail.gmail.com>
Date:   Fri, 07 Jul 2023 10:23:56 -0700
In-Reply-To: <CAEzX-aCnp0avSbMdyFQz=3s4-hjdeVwnndR5b7UeZo4oNMnv7A@mail.gmail.com>
        (Matthew Hughes's message of "Fri, 7 Jul 2023 09:45:03 +0100")
Message-ID: <xmqq1qhjbpoz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E753E5A-1CEB-11EE-BC6A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Hughes <mhughes@uw.co.uk> writes:

> I'd be happy to submit a patch adding those tests if you'd like. Though I would
> like to just confirm that in the patch I shared it is not a bug that:
>
>     git ls-files ":(attr:otherLabel)sub/" >actual &&
>     test_must_be_empty actual
>
> I.e. that no files are listed here even tough `sub/fileSetLabel` has the
> attribute `otherLabel`?

I do not think it is a good idea to cast in stone the behaviour,
which we do not know if it is sensible, with a new test, before
knowning what behaviour we want.

I think in this case the common prefix optimization in "ls-files.c"
is broken.  If we disable it like the attached illustration patch,
we will see that pathspecs that end with "sub" or "sub/" behave the
same way, which is what I think people would expect.

The code change in this illustration is not a "fix", of course ;-).

Thanks.

 builtin/ls-files.c             |  2 +-
 t/t6135-pathspec-with-attrs.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git c/builtin/ls-files.c w/builtin/ls-files.c
index a0229c3277..17baed30ca 100644
--- c/builtin/ls-files.c
+++ w/builtin/ls-files.c
@@ -724,7 +724,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	 * submodule entry because the pathspec may match something inside the
 	 * submodule.
 	 */
-	if (recurse_submodules)
+	if (!!"disable common prefix optimization" || recurse_submodules)
 		max_prefix = NULL;
 	else
 		max_prefix = common_prefix(&pathspec);
diff --git c/t/t6135-pathspec-with-attrs.sh w/t/t6135-pathspec-with-attrs.sh
index 457cc167c7..a805fa132b 100755
--- c/t/t6135-pathspec-with-attrs.sh
+++ w/t/t6135-pathspec-with-attrs.sh
@@ -253,4 +253,21 @@ test_expect_success 'backslash cannot be used as a value' '
 	test_i18ngrep "for value matching" actual
 '
 
+test_expect_success 'reading from .gitattributes in a subdirectory' '
+	test_when_finished "rm -f sub/.gitattributes" &&
+	test_write_lines "fileSetLabel label1" >sub/.gitattributes &&
+
+	git ls-files ":(attr:label1)" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual &&
+
+	git ls-files ":(attr:label1)sub" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual &&
+
+	git ls-files ":(attr:label1)sub/" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual
+'
+
 test_done

