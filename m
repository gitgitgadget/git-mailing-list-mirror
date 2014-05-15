From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] check_bindir: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 10:07:59 -0700
Message-ID: <xmqq7g5ngec0.fsf@gitster.dls.corp.google.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:08:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkz8x-0004na-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaEORI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:08:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50703 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbaEORI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:08:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDB9B169A7;
	Thu, 15 May 2014 13:08:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dUmvxI7Xbs4VpgkD6+LStnGOdWs=; b=YpJ66y
	n3zeBVS9jvSuwjiFZrQ/PVrMpEwROW3QTBjDHxdRr1WcFlqGFeb0iXUqxXnaDulb
	sMdTaASHsVilFAF1bzgXnJ6NZegSErb2iL3RoGpF3+CZWw2R2TYvD87dihyPvw7C
	Rr9sqxEH98B/otwCqofNn7Avj2ANkvlM3v3HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FCDJLxwbi/iH0yhIR6O68XeI5zueecz+
	KchApbaPBTVlWrBsPL2/AjK2+AVxguPGM7R6bqmsg29MM1k9n4bPpk3sx6tS8YY+
	8oAmdgVptSAQE31vblFDLjk8GHuCI6HXzIVsFKsRf8uMg6bcqE7fLHj5brB3/EsY
	K3V5DlDw83c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2B57169A6;
	Thu, 15 May 2014 13:08:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B230216953;
	Thu, 15 May 2014 13:08:02 -0400 (EDT)
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 15 May 2014 07:21:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7958C580-DC53-11E3-87FE-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249119>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Even though POSIX.1 lists -a/-o as options to "test", they are
> marked "Obsolescent XSI". Scripts using these expressions
> should be converted  as follow:
>
> test "$1" -a "$2"
>
> should be written as:
>
> test "$1" && test "$2"
>
> Likewise
>
> test "$1" -o "$2"
>
> should be written as:
>
> test "$1"  test "$2"

Something missing from here???

> But note that, in test, -a has higher precedence than -o while
> "&&" and "||" have equal precedence in the shell.
>
> The reason for this is that the precedence rules were never well
> specified, and this made many sane-looking uses of "test -a/-o" problematic.
>
> For example, if $x is "=", these work according to POSIX (it's not
> portable, but in practice it's okay):
>
>    $ test -z "$x"
>    $ test -z "$x" && test a = b
>
> but this doesn't
>
>    $ test -z "$x" -a a = b
>    bash: test: too many arguments
>
> because it groups "test -n = -a" and is left with "a = b".
>
> Similarly, if $x is "-f", these
>
>    $ test "$x"
>    $ test "$x" || test c = d
>
> correctly adds an implicit "-n", but this fails:
>
>    $ test "$x" -o c = d
>    bash: test: too many arguments
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056
>
>  check_bindir |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/check_bindir b/check_bindir
> index a1c4c3e..623eadc 100755
> --- a/check_bindir
> +++ b/check_bindir
> @@ -2,7 +2,7 @@
>  bindir="$1"
>  gitexecdir="$2"
>  gitcmd="$3"
> -if test "$bindir" != "$gitexecdir" -a -x "$gitcmd"
> +if test "$bindir" != "$gitexecdir" && test -x "$gitcmd"
>  then
>  	echo
>  	echo "!! You have installed git-* commands to new gitexecdir."
