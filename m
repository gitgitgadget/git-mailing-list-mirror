Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17997C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 17:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiHHRYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiHHRYc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 13:24:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C515A2B
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 10:24:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 550DA1B3057;
        Mon,  8 Aug 2022 13:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4xAX76FsDmR5awwzrUbZjPGnTGmf0K5yv5i3CB
        YgtDA=; b=nS+3ylSgFXE4FgEfNuEwyjBVCUtBrasYyvvjndmFeEef9JiXRlDoZd
        PWuZBfuFLMB1FZRNMnR62Bq+UU+43KmznGWm2xx6aKAxlNxYyg2d3YQ93jbvCmY4
        enm1oz5OqcW8oDFAxk8bDdjnFixs/nL27I4xNdB5Lcs+yX9HZACh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D9B01B3056;
        Mon,  8 Aug 2022 13:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2DEA1B3055;
        Mon,  8 Aug 2022 13:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
        <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
Date:   Mon, 08 Aug 2022 10:24:25 -0700
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Sun, 7 Aug 2022 12:13:31 +0800")
Message-ID: <xmqqmtcesl6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F414F300-173E-11ED-BACD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Turn on sparse-index feature within `git-rm` command.

That is a clearly written single-line summary.

> Add necessary modifications and test them.

This states an obvious without adding any useful information.  What
modifications were necessary and why they were necessary, what old
behaviour was undesirable and added tests prevent them to appear
again?  These details are better left to the proposed log message of
individual patches.

This series, when queued on top of 'master' without anything else,
seems to pass its own tests, but when combined with the "reset and
checkout fixes" <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
by Victoria, the last one t1092 fails.

---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
expecting success of 1092.27 'reset hard with removed sparse dir':
        init_repos &&

        test_all_match git rm -r --sparse folder1 &&
        test_all_match git status --porcelain=v2 &&

        test_all_match git reset --hard &&
        test_all_match git status --porcelain=v2 &&

        cat >expect <<-\EOF &&
        folder1/
        EOF

        git -C sparse-index ls-files --sparse folder1 >out &&
        test_cmp expect out

HEAD is now at 703fd3e initial commit
HEAD is now at 703fd3e initial commit
HEAD is now at 703fd3e initial commit
--- full-checkout-out   2022-08-08 17:19:19.820840016 +0000
+++ sparse-index-out    2022-08-08 17:19:19.836841239 +0000
@@ -1,3 +1 @@
-rm 'folder1/0/0/0'
-rm 'folder1/0/1'
-rm 'folder1/a'
+rm 'folder1/'
not ok 27 - reset hard with removed sparse dir
#
#               init_repos &&
#
#               test_all_match git rm -r --sparse folder1 &&
#               test_all_match git status --porcelain=v2 &&
#
#               test_all_match git reset --hard &&
#               test_all_match git status --porcelain=v2 &&
#
#               cat >expect <<-\EOF &&
#               folder1/
#               EOF
#
#               git -C sparse-index ls-files --sparse folder1 >out &&
#               test_cmp expect out
#
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 

When we have the index (incorrectly) fully expanded, and may have
(incorrectly) working tree files outside of our sparse-cone of
interest, we may have paths under the 'folder1/' that we may need to
remove (and report as removed), but after the bug that causes us to
"incorrectly check out" gets fixed, perhaps the 'folder1/' is the
only thing that needs removed if it is outside our sparse-cone of
interest?  IOW, is the test hardcoding the behaviour of a bug that
was fixed?  I dunno.



