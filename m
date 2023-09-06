Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F24EE14D0
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbjIFU03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbjIFU01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 16:26:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7A19AF
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 13:26:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D72A719A5C2;
        Wed,  6 Sep 2023 16:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=5oPEqtim9ixVZmDUe6OrULqiwnL/7k1PSdS8oU
        NE0bI=; b=ETVrkQDEjAqzmPrdxOEkH9vBvZFeYrzZVDQnaN03ALEC5BppCNzuvp
        +dqc2lZ9TLdrLqerVVdChoPxAoJw0ofIOblzP007xTzPErvd8nwZBt0728/kjQ8v
        MytHwGBoRFapXaYaihZW2lDbM3G8yyjB5OV691FHdW8rFMDBBZoUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF4E019A5C1;
        Wed,  6 Sep 2023 16:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 389D019A5C0;
        Wed,  6 Sep 2023 16:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Sergey Organov <sorganov@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
        (Tao Klerks's message of "Wed, 6 Sep 2023 20:04:17 +0200")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <87edjbuugw.fsf@osv.gnss.ru>
        <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
        <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
Date:   Wed, 06 Sep 2023 13:26:21 -0700
Message-ID: <xmqqledjm4k2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4E81A14-4CF3-11EE-8F8A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> I like the nomenclature, I like the simple "zero (i.e. bare) or one
> inline worktree, zero or more attached worktrees" explanation.

We have used "main worktree" to refer to the working tree part (plus
the repository) of a non-bare repository.  And it makes sense to
explain it together with the concept of "worktree", as the primary
one is very much special in that it cannot be removed.  You can see
that "git worktree remove" would stop you from removing it with an
error message:

	fatal: '../there' is a main working tree.

It probably does not add much value to introduce a new term
"inline".  Here is what "git worktree --help" has to say about it.

    A repository has one main worktree (if it's not a bare repository) and
    zero or more linked worktrees.

I applaud whoever wrote this sentence for packing so much good
information in a concise and easy-to-understand description.

We can read that (1) a non-bare repository itself is considered
its "main worktree", (2) a bare repository, by inference, has no
main worktree (otherwise we wouldn't have said "if it's not"), and
(3) both bare and non-bare repositories can have linked worktrees
(again, otherwise we wouldn't have brought up a bare repository in
the description).

Perhaps we should borrow it to update the glossary, like so?


 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
index 5a537268e2..d9ba3bab88 100644
--- c/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -694,8 +694,8 @@ The most notable example is `HEAD`.
 	plus any local changes that you have made but not yet committed.
 
 [[def_worktree]]worktree::
-	A repository can have zero (i.e. bare repository) or one or
-	more worktrees attached to it. One "worktree" consists of a
+	A repository has one main worktree (if it's not a bare
+	repository) and zero or more linked worktrees.  One "worktree" consists of a
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
