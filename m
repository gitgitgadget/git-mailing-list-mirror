Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A678C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359216AbiDUV2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiDUV2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:28:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897044745
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:25:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB0A5196D62;
        Thu, 21 Apr 2022 17:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n48xT541NLfcpM1ZQOwqBatjnZ1MqL0DcFg995
        5Vd6U=; b=B2xdYL8z5MTeLWGNnwoYp4xNHzP+Ki1ce7+ehq7bs9cPg+DdagwlPW
        RzBZy5OGvtWViHtAXkzKURb0J/+ZQQ+df7UwrDtspewM6jPsbYRiORmhkN2XUuiZ
        FgK/Ipc+f5CWgbp/NHSFJOfkN49PB/22/Qw60QYqS9Xf1wH2s5pCU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2C73196D61;
        Thu, 21 Apr 2022 17:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 343CE196D5E;
        Thu, 21 Apr 2022 17:25:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>
Subject: [PATCH] show-branch: -g and --current are incompatible
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
        <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
        <patch-v3-2.2-396c3338533-20220421T152704Z-avarab@gmail.com>
        <xmqqczhai8qv.fsf@gitster.g>
Date:   Thu, 21 Apr 2022 14:25:47 -0700
In-Reply-To: <xmqqczhai8qv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Apr 2022 11:36:40 -0700")
Message-ID: <xmqqh76mf7s4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C9D418E-C1B9-11EC-9267-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I am not sure if it even makes sense to allow the
> reflog listing mode with "current" in the first place, and a simpler
> option may be to just forbid the combination.  After all, when I
> adeed "--current" to "git show-branch" in 1aa68d67 (show-branch:
> --current includes the current branch., 2006-01-11), it was clearly
> meant to be used with "other branches"---"I would list branches I
> care about and I use as anchoring points on the command line, and I
> may or may not be on one of these main branches. Please make sure I
> can view the current one with respect to these other branches" is
> what "--current" is about, and mixing it with "how do recent reflog
> entries relate to each other" does not make much sense.

So, here is an alternative "fix" along that line.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] show-branch: -g and --current are incompatible

When "--current" is given to "git show-branch" running in the
"--reflog" mode, the code tries to reference a "reflog" message
that does not even exist.  This is because the --current is not
prepared to work in that mode.

The reason "--current" exists is to support this request:

    I list branches on the command line.  These are the branchesI
    care about and I use as anchoring points. I may or may not be on
    one of these main branches.  Please make sure I can view the
    commits on the current branch with respect to what is in these
    other branches.

And to serve that request, the code checks if the current branch is
among the ones listed on the command line, and adds it only if it is
not to the end of one array, which essentially lists the objects.
The reflog mode additionally uses another array to list reflog
messages, which the "--current" code does not add to.  This leaves
one uninitialized slot at the end of the array of reflog messages,
and causes the program to show garbage or segfault.

Catch the unsupported (and meaningless) combination and exit with a
usage error.

There are other combinations of options that are incompatible but
have not been tested.  Add test to cover them while adding coverage
for this new combination.

Reported-by: Gregory David <gregory.david@p1sec.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/show-branch.c  |  4 ++++
 t/t3202-show-branch.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git c/builtin/show-branch.c w/builtin/show-branch.c
index e12c5e80e3..73e8edbf02 100644
--- c/builtin/show-branch.c
+++ w/builtin/show-branch.c
@@ -711,6 +711,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				"--all/--remotes/--independent/--merge-base");
 	}
 
+	if (with_current_branch && reflog)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--reflog", "--current");
+
 	/* If nothing is specified, show all branches by default */
 	if (ac <= topics && all_heads + all_remotes == 0)
 		all_heads = 1;
diff --git c/t/t3202-show-branch.sh w/t/t3202-show-branch.sh
index 7a1be73ce8..f2b9199007 100755
--- c/t/t3202-show-branch.sh
+++ w/t/t3202-show-branch.sh
@@ -161,4 +161,18 @@ test_expect_success 'show branch --reflog=2' '
 	test_cmp actual expect
 '
 
+# incompatible options
+while read combo
+do
+	test_expect_success "show-branch $combo (should fail)" '
+		test_must_fail git show-branch $combo 2>error &&
+		grep -e "cannot be used together" -e "usage:" error
+	'
+done <<\EOF
+--all --reflog
+--merge-base --reflog
+--list --merge-base
+--reflog --current
+EOF
+
 test_done
