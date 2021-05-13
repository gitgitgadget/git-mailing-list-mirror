Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F6C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F7D61417
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhEMEOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 00:14:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54172 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEMEO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 00:14:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5663312D006;
        Thu, 13 May 2021 00:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uY8cK7kDSB7bBdnnUZrP8tKnDOH/lgWffrINtB
        tqRyE=; b=l/QubsKpj7y7Fsu8h3KfPJ/5UcCDaxOssi0myFAIXeP+RL4tItbJ9c
        /BBMX3Glm/k3WGkZMmr5vPAeft5NQZlLGd/NGO+xq/f71B/MPsXVvUBRMeLcCmIr
        v+Kg9Pj/SkfqrqkQAFdSljqF1PwQzF5Rn8QNGWkPtq/pqH97D50nw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C92D12D002;
        Thu, 13 May 2021 00:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62F1A12CFEF;
        Thu, 13 May 2021 00:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Christoph Anton Mitterer <calestyo@scientia.net>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
        <xmqq4kf7cmaj.fsf@gitster.g>
Date:   Thu, 13 May 2021 13:13:14 +0900
In-Reply-To: <xmqq4kf7cmaj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        13 May 2021 13:03:48 +0900")
Message-ID: <xmqqzgwzb7ad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AC5200C-B3A1-11EB-B0F4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>
>> Could it be that git-sh-prompt no longer works properly?
>>
>> With git 2.31.1:
>> $ . /usr/lib/git-core/git-sh-prompt
>> $ PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>> $ cd someGitRepo
>> bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
>> $ 
>
> Would
>
>     $ set +u
>
> fix it, I have to wonder?

Assuming that the answer is yes,...

I do not know who maintains this contrib/ script, but here is what

$ git grep -e '\$GIT_PS1_' -e '\${GIT_PS1_[^}-]*}' contrib/completion

gave me a handful candidates for fixes.  Randomly picking Elijah from
the output of

    $ git shortlog --no-merges -sn --since=18.months  \
	contrib/completion/git-prompt.sh |
      head -n 1

for ideas.

Thanks.

 contrib/completion/git-prompt.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
index 4640a1535d..b9485f4016 100644
--- i/contrib/completion/git-prompt.sh
+++ w/contrib/completion/git-prompt.sh
@@ -139,7 +139,7 @@ __git_ps1_show_upstream ()
 
 	# parse configuration values
 	local option
-	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+	for option in ${GIT_PS1_SHOWUPSTREAM-}; do
 		case "$option" in
 		git|svn) upstream="$option" ;;
 		verbose) verbose=1 ;;
@@ -433,8 +433,8 @@ __git_ps1 ()
 	fi
 
 	local sparse=""
-	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
-	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
+	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
+	   [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
 	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 		sparse="|SPARSE"
 	fi
@@ -543,7 +543,7 @@ __git_ps1 ()
 			u="%${ZSH_VERSION+%}"
 		fi
 
-		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
+		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
 		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 			h="?"
 		fi
