From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 12:39:42 -0800
Message-ID: <7vr4lvcstt.fsf@alter.siamese.dyndns.org>
References: <50EC8025.8000707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsfxv-00057q-5s
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 21:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab3AHUjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 15:39:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab3AHUjq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 15:39:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFC2B50C;
	Tue,  8 Jan 2013 15:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OIvIRmpzng8X
	ZXuLSIeeGGMTE3w=; b=v6orfc4TzuLOzujtptvoRJo88P/CydoxW4otvnYk37tV
	W0O+3SSYUk2z1rd4C/APOrOnbsy+jOc1674aY29AAX+18juaal1++DPOCA0xbSwV
	kwiL+jJl37YnnI7ihbmjYBJXeE1KQF0zwsFoInGFHmh3h2YcfY2EkwkB6eCwTbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x8xwq8
	8otnHSUVItzLknH4vejsqe/9Shj2yc+Z6vv0qjwXiqHc4/NGu1VZY/0WXgquZqJ9
	fG2RP/yO0NcUuZJVv7ASueedfOkTG/Ib/+o9KcKa/rUSfINyeSQNew7NGrtlXZUm
	hr0YjnB5u05rVRt/uzdBHQBkzmrIjaSOXBS1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5E0B509;
	Tue,  8 Jan 2013 15:39:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC6A5B507; Tue,  8 Jan 2013
 15:39:44 -0500 (EST)
In-Reply-To: <50EC8025.8000707@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 08 Jan 2013 21:23:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 893CAC36-59D3-11E2-8A7B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213004>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The test fails for me on NetBSD 6.0.1 and reports:
>
> 	ok 1 - ref name '' is invalid
> 	ok 2 - ref name '/' is invalid
> 	ok 3 - ref name '/' is invalid with options --allow-onelevel
> 	ok 4 - ref name '/' is invalid with options --normalize
> 	error: bug in the test script: not 2 or 3 parameters to test-expect-=
success
>
> The alleged bug is in this line:
>
> 	invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'
>
> invalid_ref() constructs a test case description using its last argum=
ent,
> but the shell seems to split it up into two pieces if it contains a
> space.  Minimal test case:
>
> 	# on NetBSD with /bin/sh
> 	$ a() { echo $#-$1-$2; }
> 	$ t=3D"x"; a "${t:+$t}"
> 	1-x-
> 	$ t=3D"x y"; a "${t:+$t}"
> 	2-x-y
> 	$ t=3D"x y"; a "${t:+x y}"
> 	1-x y-
>
> 	# and with bash
> 	$ t=3D"x y"; a "${t:+$t}"
> 	1-x y-
> 	$ t=3D"x y"; a "${t:+x y}"
> 	1-x y-
>
> This may be a bug in the shell, but here's a simple workaround: Const=
ruct
> the description string first and store it in a variable, and then use
> that to call test_expect_success().

Interesting.  I notice that t0008 added recently to 'pu' has the
same construct.

>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  t/t1402-check-ref-format.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.s=
h
> index 1ae4d87..1a5a5f3 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -11,7 +11,8 @@ valid_ref() {
>  		prereq=3D$1
>  		shift
>  	esac
> -	test_expect_success $prereq "ref name '$1' is valid${2:+ with optio=
ns $2}" "
> +	desc=3D"ref name '$1' is valid${2:+ with options $2}"
> +	test_expect_success $prereq "$desc" "
>  		git check-ref-format $2 '$1'
>  	"
>  }
> @@ -22,7 +23,8 @@ invalid_ref() {
>  		prereq=3D$1
>  		shift
>  	esac
> -	test_expect_success $prereq "ref name '$1' is invalid${2:+ with opt=
ions $2}" "
> +	desc=3D"ref name '$1' is invalid${2:+ with options $2}"
> +	test_expect_success $prereq "$desc" "
>  		test_must_fail git check-ref-format $2 '$1'
>  	"
>  }
