Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636CC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhK1Tt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 14:49:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59404 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhK1Tr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 14:47:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97C001659DA;
        Sun, 28 Nov 2021 14:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SsecWxJaQrDD
        +n9IEYMPk1YGpQhC5wwhd/XV/1LqStQ=; b=Vbwhmu/4FNB2qklcXu25FHJrsX6q
        T8YqSqdWeN2n2mI3M0bzzZNL8TcUJDorTA6H8ZB5pExQbA88WT5Qn7BbyWvSyRk0
        iIQKgRuIDsS0CVfB+T9qQbBIrdKcQAuZ5CQNjMKVMPIo9VUF/JFGH00NqXMaa5w/
        JJNRJi9wVHKKHvk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FF671659D9;
        Sun, 28 Nov 2021 14:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 682D51659D8;
        Sun, 28 Nov 2021 14:44:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
Subject: Re: [PATCH] add -p: avoid use of undefined $key when ReadKey -> EOF
References: <20211128174903.5623-1-carenas@gmail.com>
Date:   Sun, 28 Nov 2021 11:44:33 -0800
In-Reply-To: <20211128174903.5623-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 28 Nov 2021 09:49:03 -0800")
Message-ID: <xmqq8rx85ala.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D7764D8-5083-11EC-BFCC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> b5cc003253 (add -i: ignore terminal escape sequences, 2011-05-17)
> add an additional check to the original code to better handle keys
> for escape sequences, but failed to account for the possibility
> the first ReadKey call returned undef (ex: stdin closes) and that
> was being handled fine by the original code in ca6ac7f135 (add -p:
> prompt for single characters, 2009-02-05)
>
> Add a test for undefined and encapsulate the loop and the original
> print that relied on it within it.

I wondered where a change to t/ directory was, but we are not
talking about that kind of test ;-)  OK.

> After this, the following command (in a suitable repository state)
> wouldn't print any error:
>
>   $ git -c interactive.singleKey add -p </dev/null
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  git-add--interactive.perl | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index bc3a1e8eff..95887fd8e5 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1175,15 +1175,17 @@ sub prompt_single_character {
>  		ReadMode 'cbreak';
>  		my $key =3D ReadKey 0;
>  		ReadMode 'restore';
> -		if ($use_termcap and $key eq "\e") {
> -			while (!defined $term_escapes{$key}) {
> -				my $next =3D ReadKey 0.5;
> -				last if (!defined $next);
> -				$key .=3D $next;
> +		if (defined $key) {
> +			if ($use_termcap and $key eq "\e") {
> +				while (!defined $term_escapes{$key}) {
> +					my $next =3D ReadKey 0.5;
> +					last if (!defined $next);
> +					$key .=3D $next;
> +				}
> +				$key =3D~ s/\e/^[/;
>  			}
> -			$key =3D~ s/\e/^[/;
> +			print "$key";
>  		}
> -		print "$key" if defined $key;

This was from the very original and was a strong clue that $key
could be undef; well spotted.

>  		print "\n";
>  		return $key;
>  	} else {

Essentially, the code added by b5cc0032 (add -i: ignore terminal
escape sequences, 2011-05-17) wanted to say

    The original code

    - called ReadKey and took its output in $key,=20
    - echoed it if it was defined (otherwise $key wasn't echoed),
    - emitted a line feed,
    - and returned $key.

    We deal with the case where a single keystroke of some keys is
    delivered to us as an escape sequence of multiple "key"s from
    ReadKey, and the way we do so is to replace that single ReadKey
    with the new code that accumulates these multiple "key"s in
    $key.

I am undecided, but the minimum patch below seems to makes the above
intention in the updated code clearer.

diff --git i/git-add--interactive.perl w/git-add--interactive.perl
index bc3a1e8eff..c459c675e7 100755
--- i/git-add--interactive.perl
+++ w/git-add--interactive.perl
@@ -1175,7 +1175,7 @@ sub prompt_single_character {
 		ReadMode 'cbreak';
 		my $key =3D ReadKey 0;
 		ReadMode 'restore';
-		if ($use_termcap and $key eq "\e") {
+		if (defined $key && $use_termcap and $key eq "\e") {
 			while (!defined $term_escapes{$key}) {
 				my $next =3D ReadKey 0.5;
 				last if (!defined $next);
