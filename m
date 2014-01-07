From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] stash: handle specifying stashes with spaces
Date: Tue, 07 Jan 2014 10:42:39 -0800
Message-ID: <xmqq7gabeiqo.fsf@gitster.dls.corp.google.com>
References: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:42:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bc0-0000TT-AW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbaAGSmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 13:42:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbaAGSmm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 13:42:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B53C76104C;
	Tue,  7 Jan 2014 13:42:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IG+Wp+ffdyGp
	1vAS7UbzKl4B/Jk=; b=HTZ0NGQlTb3VqcvLziDPhkyu2yY/AzyMG805+xmLKRlK
	HCfKKpsdkMKVzZUzmCKcaurQuJoPOxbztg85eNFdu1b6WFcAfO6K9ZN22bWVyoRv
	3IIaGeFj/PwkSmvLI+eAV9VOAInZzAwOTtFdzspMo6Wiul7OsvWqQXc25mLq4h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XRxmIU
	SLNv7F3uD4kzVC0eZyzXeHBxpWSVEk/sNJJ1x1jSPfC6d2qRG6kCL2i1clf8sRQR
	f5qqtZJCYmdgezqqbrWed4NX3R9n2qHkpzL4PUttW2BuGSXLUO0Dy2lxb281Lgdk
	202LtA/BtG+uqVvnli70qwlDV+gVauu9Ay2vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55456104B;
	Tue,  7 Jan 2014 13:42:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E72BE6104A;
	Tue,  7 Jan 2014 13:42:40 -0500 (EST)
In-Reply-To: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Tue, 7 Jan 2014 09:22:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CF24A8C-77CB-11E3-93FA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240126>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> When trying to pop/apply a stash specified with an argument containin=
g
> spaces git-stash will throw an error:
>
>     $ git stash pop 'stash@{two hours ago}'
>     Too many revisions specified: stash@{two hours ago}
>
> This happens because word splitting is used to count non-option
> arguments. Make use of rev-parse's --sq option to quote the arguments
> for us to ensure a correct count. Add quotes where necessary.
>
> Also add a test that verifies correct behaviour.
>
> Helped-by: Thomas Rast <tr@thomasrast.ch>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> v3 uses the same eval/--sq technique as v2, suggested by Thomas Rast.
> This is basically a resend except that I added a missing '&&' in the
> test that Eric Sunshine noticed when reading v1.

The change looks good.

An unrelated tangent, but here is a tip-of-the-day for the
approximate parser.  You could have just said

	git stash pop stash@{2.hours}

and it would have been interpreted just the same ;-)

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index debda7a..7eb011c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -673,4 +673,15 @@ test_expect_success 'store updates stash ref and=
 reflog' '
>  	grep quux bazzy
>  '
> =20
> +test_expect_success 'handle stash specification with spaces' '
> +	git stash clear &&
> +	echo pig > file &&

Style: no SP between redirection operator and its target, i.e.

	echo pig >file &&

> +	git stash &&
> +	test_tick &&
> +	echo cow > file &&
> +	git stash &&
> +	git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&

This is brittle.  If new tests are added before this, the test_tick
will give you different timestamp and this test will start failing.

Perhaps grab the timestamp out of the stash that was created, e.g.

	...
        test_tick &&
        git stash &&
        stamp=3D$(git log -g --format=3D"%cd" -1 refs/stash) &&
	test_tick &&
        echo cow >file &&
        git stash &&
        git stash apply "stash@{$stamp}" &&

or something?

> +	grep pig file
> +'
> +
>  test_done
