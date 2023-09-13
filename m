Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9982EE3F39
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjIMA62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbjIMA61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:58:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EB170B
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:58:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7405619E8C6;
        Tue, 12 Sep 2023 20:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ISYB6jlxZRsQstmIJ/zGWecO0IRlQlqnVx8Edf
        zFb5M=; b=IuOdIKNmgb5YsJe5TwBknjjYc0ZBCmlhEI8OhPPe2P9hbvWHm6XMW6
        ylNyo/VP8WRz1L8HTLux3N7PCgLO78g6VCcoV2DCDSrsJ1EMiHaH/LkYdDPrzIr+
        xcUviZslxW43VNlIHwQjSWMMcS11JR9SiH4KjHk0Vz+zoKUiUsBBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A26C19E8C4;
        Tue, 12 Sep 2023 20:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCB0619E8C3;
        Tue, 12 Sep 2023 20:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Linus Arver <linusa@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] completion: improve doc for complex aliases
In-Reply-To: <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 12 Sep 2023 17:02:15 +0000")
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
        <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:58:20 -0700
Message-ID: <xmqqo7i6khxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2A0A2B2-51D0-11EE-A54D-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The completion code can be told to use a particular completion for
> aliases that shell out by using ': git <cmd> ;' as the first command of
> the alias. This only works if <cmd> and the semicolon are separated by a
> space, since if the space is missing __git_aliased_command returns (for
> example) 'checkout;' instead of just 'checkout', and then
> __git_complete_command fails to find a completion for 'checkout;'.
>
> The examples have that space but it's not clear if it's just for
> style or if it's mandatory. Explicitly mention it.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---

Thanks.  I scanned the case statement in the loop in the function
and thought "hmph, everybody says ': git <cmd> ;' but is 'git'
really needed?"

I had "git l3" alias that invokes "$HOM#/bin/git-l" command, like so:

    [alias]
            l3 = "!sh -c ': git log ; git l \"$@\"' -"

but if I did 's/: git log/: log/' it still completes just fine.

I wonder if this hack is worth adding, instead of (or in addition
to) requiring the user to insert $IFS to please the "parser", we can
honor the rather obvious wish of the user in a more direct way.



 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 19139ac121..e31d71955f 100644
--- c/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -1183,7 +1183,7 @@ __git_aliased_command ()
 			:)	: skip null command ;;
 			\'*)	: skip opening quote after sh -c ;;
 			*)
-				cur="$word"
+				cur="${word%;}"
 				break
 			esac
 		done
