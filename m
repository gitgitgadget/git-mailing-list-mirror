Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C18C3A59D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJUVGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJUVGj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:06:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FCE2A17DD
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:06:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B4EB1B3757;
        Fri, 21 Oct 2022 17:06:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lLYyOsly9g5cg914NXfLIDx7KgoO7B1nceKHXN
        HvLsU=; b=NjM8Rp3UgwRhbzJSpQuKSv+dRkR3pmc+92IPJW8l7eVXpvnf+xjDNO
        lEpMCCOvUx0K4zS+DCSQY7NI8KWqGuxlCpYOxUJ3i580rVnmcin6IXuj4k3sPsPy
        KorYVIXHNePM7FlgVLwuhn/5gQtm12Og+2EToTceFdxOfIPG4a1Vc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 527301B3756;
        Fri, 21 Oct 2022 17:06:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 70CA01B3751;
        Fri, 21 Oct 2022 17:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/9] test-lib-functions: mark 'test_commit' variables as
 'local'
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
        <832e910aadc47309392feed69927c2e8693cbfc5.1666365220.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 14:06:32 -0700
In-Reply-To: <832e910aadc47309392feed69927c2e8693cbfc5.1666365220.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 21 Oct 2022
        15:13:31 +0000")
Message-ID: <xmqq8rl8kht3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DEC0692-5184-11ED-BC3B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Some variables in 'test_commit' have names that are common enough that
> it is very likely that test authors might use them in a test. If they do
> so and use 'test_commit' between setting such a variable and using it,
> the variable value from 'test_commit' will leak back into the test and
> most likely break it.
>
> Prevent that by marking all variables in 'test_commit' as 'local'. This
> allow a subsequent commit to use a 'tag' variable.

This is the right thing to do, if done onn day 1 of the project, and
it is the right thing to do for the longer term health of the
project.  But it is a bit scary thing to do in the middle.

I wonder if there is an easy way to detect that a set of callers of
test_commit are relying on the fact that calling test_commit without
passing --author option cleared their $author variable (similarly
for other variables that are cleared or set to a known value as a
side effect of calling test_commit).  If their correctness depends
on $author becoming empty after calling the script today, they will
get broken by this change.

While it is OK to argue that they deserve it, we would have to be
finding and fixing them ourselves after all.

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/test-lib-functions.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 527a7145000..adc0fb6330c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -273,13 +273,13 @@ debug () {
>  # <file>, <contents>, and <tag> all default to <message>.
>  
>  test_commit () {
> -	notick= &&
> -	echo=echo &&
> -	append= &&
> -	author= &&
> -	signoff= &&
> -	indir= &&
> -	tag=light &&
> +	local notick= &&
> +	local echo=echo &&
> +	local append= &&
> +	local author= &&
> +	local signoff= &&
> +	local indir= &&
> +	local tag=light &&
>  	while test $# != 0
>  	do
>  		case "$1" in
> @@ -322,7 +322,7 @@ test_commit () {
>  		shift
>  	done &&
>  	indir=${indir:+"$indir"/} &&
> -	file=${2:-"$1.t"} &&
> +	local file=${2:-"$1.t"} &&
>  	if test -n "$append"
>  	then
>  		$echo "${3-$1}" >>"$indir$file"
