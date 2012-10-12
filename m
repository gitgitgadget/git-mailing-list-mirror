From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Fri, 12 Oct 2012 12:09:57 -0700
Message-ID: <7vy5jb33sq.fsf@alter.siamese.dyndns.org>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
 <1349864466-28289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 21:10:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMkci-0006hs-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab2JLTKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 15:10:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab2JLTKC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 15:10:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EDF991C9;
	Fri, 12 Oct 2012 15:10:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=I4FReBtt6OId
	XwpgJq0ZUfnBwuY=; b=gsNWRrYASwOK1KIt9gA88xxBMLDRrzACT75Gl0HzIFOb
	GgYLkwrx/Yh1HeId+nXewrQeP/VT3s9HS2rW3naUTt2OcMXIUK7oCPgsxJ3UOP9s
	Zg5Ua2ogmDf9tzdf/8CAVXdzt3av+o//1UsWaOSxoA2AAL0C0dIZwj4quDi99CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QkKYNG
	FisT0rXB7eJ2tvwHl1OcU9OMltsrWTGaXdNL9DGmA6OslD3nyCFI2j+m95n3q9OG
	xy1N+pz53qAqem0iXqWNgtLtd+948hP+VC9RSYFiq7e/ghC7EznEhu57gfdgVsV7
	BS60Vw5JlnCXSmnwFf8peJmv/O79GWudEhJrk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB3291C8;
	Fri, 12 Oct 2012 15:10:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE62991C7; Fri, 12 Oct 2012
 15:09:59 -0400 (EDT)
In-Reply-To: <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 10 Oct
 2012 17:21:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B0CFEB4-14A0-11E2-A470-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207563>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 51f3045..4a1402f 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -242,4 +242,18 @@ test_expect_success 'bare repository: test info/=
attributes' '
>  	attr_check subdir/a/i unspecified
>  '
> =20
> +test_expect_success 'leave bare' '
> +	cd ..
> +'
> +
> +test_expect_success 'negative patterns' '
> +	echo "!f test=3Dbar" >.gitattributes &&
> +	test_must_fail git check-attr test -- f
> +'
> +
> +test_expect_success 'patterns starting with exclamation' '
> +	echo "\!f test=3Dfoo" >.gitattributes &&
> +	attr_check "!f" foo
> +'
> +
>  test_done

This is not entirely your fault, but please don't do that "cd ..".

The original test had "cd bare", made an assumption that step will
never fail (which is mostly correct), and ran everything afterward
in that subdirectory.

Adding "Do a 'cd ..' to come back" is a horrible way to build on
it.  Imagine what happens when another person also did the same
thing, and both changes need to be merged.  You will end up going up
two levels, which is not what you want.

I think the right fix is to make each of the test that wants to run
in "bare" chdir in its own subshell, or not append these new tests
that do not run in the "bare" to the end of this file, but before
the execution goes down to "bare".
