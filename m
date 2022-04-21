Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3670C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiDUVlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376329AbiDUVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:41:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA974C43A
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:38:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C58E5196377;
        Thu, 21 Apr 2022 17:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2J4+Tyuqwb2JXMczqgZ2FYfkZuqMILBey+2KLL
        ETSmo=; b=DG8Qd59yndkZ2YFp3dpQsLpdPFuSlnopaUlf5MyPaKarvolWmK0Jq5
        zwjCYr+P+NTQ2QiLNQqPwTAkSEYqkSG3j7qtRTx8kBpaDzK6ykyA395yCw5cB+w1
        Whha6kj6c2eRrFtucZxWlt0PSwoRdBir2ODMw/71Eqa/K4g/UTgcY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF4BD196376;
        Thu, 21 Apr 2022 17:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33C4B196375;
        Thu, 21 Apr 2022 17:38:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
        <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
        <xmqqo80uf9jn.fsf@gitster.g>
        <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
        <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
Date:   Thu, 21 Apr 2022 14:38:33 -0700
In-Reply-To: <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 21 Apr 2022 17:29:42 -0400")
Message-ID: <xmqq7d7if76u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 652F67D4-C1BB-11EC-9E5D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> really isn't (the `-e` is being consumed by the `-i` option).

That makes sense.  So after all 4-year old random finding on the
internet had some value in pregventing a new breakage to sneak into
our codebase.  Good ;-)

> Any of
> the following would likely be less confusing (in no particular order
> of preference):
>
>     * sed -i .bak -e '...' "$path"
>     * rename dance
>     * perl -pi -e ...

That order happens to match my preference, but if the first one
comes with a comment to dissuade readers to copy-and-paste the
construct to other places in our code, that would be even better.

Perhaps something along this line.

 ci/install-dependencies.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
index 540deab448..2a5ee34246 100755
--- c/ci/install-dependencies.sh
+++ w/ci/install-dependencies.sh
@@ -41,7 +41,12 @@ macos-latest)
 		echo Installing perforce failed, assuming and working around SHA256 mismatch >&2 &&
 
 		path=$(brew edit --print-path perforce) &&
-		sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
+
+		# we do not do this unconditionally because we want
+		# to know that we are falling back.  Do not copy this
+		# use of 'sed -i .bak' elsewhere---it does not work with
+		# other implementations of "sed".
+		sed -i .bak -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
 		brew install perforce
 	}
 
