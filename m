From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: save log from daemonized gc --auto and print it next time
Date: Tue, 24 Mar 2015 15:07:22 -0700
Message-ID: <xmqqy4mm3v8l.fsf@gitster.dls.corp.google.com>
References: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:07:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaWz2-0005xm-JF
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 23:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbbCXWHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 18:07:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbbCXWHZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 18:07:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8834318D;
	Tue, 24 Mar 2015 18:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7xYZ8syEe6Gf
	btf7WVYySXa5wOY=; b=A6CujHZYUkR7jPw140TVte9uLkwJMDxKtQtB6QiaefrR
	dp1ZwszVM18ui45P7NlBN7Y+FbNR3CQz/SHAhBnZYoVimpnAguTCkFaz5yCSfyGt
	ubKmCOCbPqW+rz8/1ghG+JfB6yWbyKnjcx8L+8m0Df46QqJDntX5AADMhdjmzFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z5RV63
	vGZJ/7VY+pRyHWdCI6ak7iLUrG53yplCeCGAsEGWJiAhpW5bx0/OvMt6/1zI05Nh
	gtzjESZvX5nsSysqWKR7DZwEipz+dLNpYXqC4uXA6uQ1SjERssqeuHvTlLq2EkgK
	e60eUEPFk6psru1XjXL3PheOacJEpGFUAyVdg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 255584318C;
	Tue, 24 Mar 2015 18:07:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91FDD4318A;
	Tue, 24 Mar 2015 18:07:23 -0400 (EDT)
In-Reply-To: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 24
 Mar 2015 19:17:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26262914-D272-11E4-9F09-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266232>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> While commit 9f673f9 (gc: config option for running --auto in
> background - 2014-02-08) helps reduce some complaints about 'gc
> --auto' hogging the terminal, it creates another set of problems.
>
> The latest in this set is, as the result of daemonizing, stderr is
> closed and all warnings are lost. This warning at the end of cmd_gc()
> is particularly important because it tells the user how to avoid "gc
> --auto" running repeatedly. Because stderr is closed, the user does
> not know, naturally they complain about 'gc --auto' wasting CPU.
>
> Besides reverting 9f673f9 and looking at the problem from another
> angle, we could save the stderr in $GIT_DIR/gc.log. Next time, 'gc
> --auto' will print the saved warnings, delete gc.log and exit.

I wonder what this buys us if multiple auto-gc's are triggered
because the user is running a long svn import or something similar.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 63194d8..54bc9c4 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -30,4 +30,24 @@ test_expect_success 'gc -h with invalid configurat=
ion' '
>  	test_i18ngrep "[Uu]sage" broken/usage
>  '
> =20
> +test_expect_success !MINGW 'gc --auto and logging' '
> +	git init abc &&
> +	(
> +		cd abc &&
> +		# These create blobs starting with the magic number "17"
> +		for i in 901 944; do

There are numbers smaller than these, like 263 and 410 ;-)

> +			echo $i >test && git hash-object -w test >/dev/null

"hash-object --stdin"?

> +		done &&
> +		git config gc.auto 1 &&

test_config?

> +		LANG=3DC git gc --auto &&
> +		sleep 1 && # give it time to daemonize
> +		while test -f .git/gc.pid; do sleep 1; done &&

Yuck...

> +		grep "too many unreachable loose objects" .git/gc.log &&
> +		LANG=3DC git gc --auto 2>error &&
> +		grep skipped error &&
> +		grep "too many unreachable loose objects" error &&
> +		! test -f .git/gc.log
> +	)
> +'

=46or that "17/ has very many loose objects that are still young and
unreachable" issue, I wonder if the right solution is somehow to
flag the repository and prevent "gc --auto" from running until the
situation improves.  "I checked at this time and found too many in
17/"; upon finding that flag file (with a timestamp), if there are
new files in 17/ or if there are other reasons to do a gc (perhaps
there are too many packfiles to be consolidated?), then do the gc
but otherwise quite silently before spending too many cycles on it,
or something along that line?
