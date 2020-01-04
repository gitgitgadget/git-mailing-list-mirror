Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A556BC00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FF221734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZUXWcLxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgADD1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:27:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56481 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgADD1L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 22:27:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6394098938;
        Fri,  3 Jan 2020 22:27:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m4hxmIGK2sNOj6d6J91moaZ8iEI=; b=ZUXWcL
        xR3p1V2w+veY5qZ82/G6KqsYEb2byVy7BpSeAfIiUcGQfuzBh9vbGaOWSE+4Ximc
        Gk3+XWtrJWJOzG/ApRA3YLZZFKLw0LC+ScO2wiaSl1Y7LnUpSTmdhdH0kMH5dbKl
        1BEDNz5iwsS9dUZrZhVl/5OmEPpLNQLJpW7nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XY5lCO9kA+KJuWu/Yner3mayu4lfCc21
        jfwDr5U/F8f3r2gt4Cky9mNBSmI8dj/VxPC3+Er6hLkd9iKnkkdYP1gxeWqkTywK
        bsUP62SvDtlKI89X+uSPIAgcJQ4ybg8zRofzfrxxYmnPl7zUzjaWJ76dhPmD583o
        7b5c3sRqwcs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B43A98936;
        Fri,  3 Jan 2020 22:27:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 821D498934;
        Fri,  3 Jan 2020 22:27:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
References: <20200103043027.4537-1-stevie@qrpff.net>
Date:   Fri, 03 Jan 2020 19:27:04 -0800
In-Reply-To: <20200103043027.4537-1-stevie@qrpff.net> (Stephen Oberholtzer's
        message of "Thu, 2 Jan 2020 23:30:28 -0500")
Message-ID: <xmqqftgvdhpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1551753A-2EA2-11EA-A47E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Oberholtzer <stevie@qrpff.net> writes:

> If your automated test naturally yields zero for _old_/_good_,
> 1-124 or 126-127 for _new_/_bad_, then you're set.
>
> If that logic is reversed, however, it's a bit more of a pain: you
> can't just stick a `sh -c !` in front of your command, because that
> doesn't account for exit codes 125 or 129-255.

Hmm.

No off-the-shelf tool I know of exits 125 to signal "I dunno", so if
you have to care about the special status 125, the "command" you are
driving with "git bisect run" must be something that was written
specifically to match what "git bisect" expects by knowing that 125
is a special code to declare that the commit's goodness cannot be
determined.  Now, what's the reason why this "command" written
specifically to be used with "git bisect", which even knows the
special 125 convention, yields "this is good" in the wrong polarity?

The only realistic reason I can think of is when the user is hunting
for a commit that fixed what has long been broken.  In such a use
case, commits in the older part of the history would not pass the
test (i.e. the exit status of the script would be non-zero) while
commits in the newer part of the history would.  

> -git bisect run <cmd>...
> +git bisect run [--expect=<term> | -r | --invert] [--] <cmd>...
>  	use <cmd>... to automatically bisect.

I'd suggest dropping "-r", which has little connection to "--invert".

> @@ -238,6 +238,31 @@ bisect_replay () {
>  bisect_run () {
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
>  
> +	SUCCESS_TERM=$TERM_GOOD
> +	FAIL_TERM=$TERM_BAD
> +	INVERT_SET=
> +	while [ "$1" != "${1#-}" ]; do

Let's not make the style violations even worse.  Ideally, a
preliminary clean-up patch to fix the existing ones before the main
patch would be a good idea (cf. Documentation/CodingGuidelines).

It is more efficient and conventional (hence easier to read) to
reuse the single "case" you would need to write anyway for the loop
control, i.e.

	while :
	do
		case "$1" in
                --) ... ;;
                --invert | ... ) ... ;;
                -*) die "unknown command ;;
		*) break ;;
		esac
	done

> +		--expect=*)
> +			# how to localize part 2?

Using things like "%2$s", you mean?

As I alluded earlier, it is unclear how this new feature should
interact with the "we use 'xyzzy' to mean 'good', and 'frotz' to
mean 'bad'" feature.  One part of me would want to say that when
running bisect with good and bad swapped, we should reverse the
polarity of "bisect run" script automatically, but the rest of me
of course would say that it would not necessarily be a good idea,
and it is of course a huge backward incompatible change, so anything
automatic is a no go.

> @@ -262,11 +287,13 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>  			state='skip'
>  		elif [ $res -gt 0 ]
>  		then
> -			state="$TERM_BAD"
> +			state="$FAIL_TERM"
>  		else
> -			state="$TERM_GOOD"
> +			state="$SUCCESS_TERM"
>  		fi
>  
> +		echo "exit code $res means this commit is $state"

Is this a leftover debugging output?

In any case, I wonder why something along the line of the attached
patch is not sufficient and it needs this much code.

 git-bisect.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..7fc4f9bd8f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -247,6 +247,15 @@ bisect_run () {
 		"$@"
 		res=$?
 
+		if test -n "$invert_run_status"
+		then
+			case "$res" in
+			0)	res=1 ;;
+			125)	;;
+			*)	res=0 ;;
+			esac
+		fi
+
 		# Check for really bad run error.
 		if [ $res -lt 0 -o $res -ge 128 ]
 		then
