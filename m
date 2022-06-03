Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F6C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiFCVQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFCVQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:16:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4D2870E
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:16:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59BA619A348;
        Fri,  3 Jun 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FmTnbd6tqGXBzsOU32YkGOpyDTT1VsUa1NyJYM
        xivFg=; b=CQYVSgDfUj03gGpAsyAQDCoWMU9fxwajo6uBkzCNopB1A6cRqSfRNi
        VWCMFzH7iO8QgxfdkGTtbFolesC31JxNtDcYN6SwYtaT+cpK5SoWUpWLv9AFnQQ9
        LBG97Ynit/uqlRdXVK/97nMvOwrsLuCNV0U+nYgy7RBRmFggQMqS0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5304419A346;
        Fri,  3 Jun 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1CA619A342;
        Fri,  3 Jun 2022 17:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     Joakim Petersen <joak-pet@online.no>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
References: <20220602145935.10512-1-joak-pet@online.no>
        <20220603142521.42863-1-joak-pet@online.no>
        <xmqqy1ydhfcc.fsf@gitster.g>
        <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
        <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
        <CAGTqyRxkiGt7CRggV7VeXNRK2VmDMxDX3EpOr5cPcc5AdH8ZaA@mail.gmail.com>
Date:   Fri, 03 Jun 2022 14:16:37 -0700
In-Reply-To: <CAGTqyRxkiGt7CRggV7VeXNRK2VmDMxDX3EpOr5cPcc5AdH8ZaA@mail.gmail.com>
        (Justin Donnelly's message of "Fri, 3 Jun 2022 15:43:11 -0400")
Message-ID: <xmqqwndxcuru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74DB6E24-E382-11EC-B147-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Justin Donnelly <justinrdonnelly@gmail.com> writes:

> Hi all. I'm the author of 0ec7c23c (git-prompt: make upstream state
> indicator location consistent, 2022-02-27). Sorry I'm a little late
> jumping in. I was also going to propose something more comprehensive
> and future-proof than what's there (adding the applicable color
> (including clear) to all the indicators), but I like Junio's idea
> better. The only other thing I have to add is that it's probably a
> good idea to include a comment in the function
> `__git_ps1_colorize_gitstring` explaining the design so future
> developers/reviewers know.

After thinking it again, I actually am OK with the original coloring
code structure.  The rule is "you always counter whatever color
settings left behind by somebody who came before you".

As long as the color effect you use is not additive (e.g. if the
final product is $a$b, and $a is prefixed with $c_red and $b is
prefixed with $c_blue, an additive coloring scheme may end up
painting b in purple), we'll save number of $c_clear we would need
to emit.  Plain colors are probably not additive, but some
attributes are, so this is more brittle than "always reset to the
base state" rule, but it may be more desirable in practice.

I have no strong preference either way.  But if we are to go that
route, we definitely need to make sure that the last element added
to gitstring is followed by $c_reset, by doing something like the
attached patch.  Currently, $r has unconditional $c_clear in front
of it, and $upstream is never colored, and that is the only thing
that is saving us from leftover color bleeding into whatever comes
after the prompt.

 contrib/completion/git-prompt.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
index 87b2b916c0..c803b9fae5 100644
--- c/contrib/completion/git-prompt.sh
+++ w/contrib/completion/git-prompt.sh
@@ -287,6 +287,7 @@ __git_ps1_colorize_gitstring ()
 		u="$bad_color$u"
 	fi
 	r="$c_clear$r"
+	end_of_gitstring=$c_clear
 }
 
 # Helper function to read the first line of a file into a variable.
@@ -556,6 +557,7 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
+	local end_of_gitstring=
 	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
@@ -570,7 +572,7 @@ __git_ps1 ()
 	fi
 
 	local f="$h$w$i$s$u$p"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${end_of_gitstring}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
