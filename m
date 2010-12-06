From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] parse-remote: handle detached HEAD
Date: Mon, 06 Dec 2010 08:03:46 -0800
Message-ID: <7vr5dusxb1.fsf@alter.siamese.dyndns.org>
References: <7vfwubtw1g.fsf@alter.siamese.dyndns.org>
 <1291630811-16584-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 17:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPdXx-0003cU-VJ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab0LFQD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 11:03:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab0LFQD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 11:03:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82A39313A;
	Mon,  6 Dec 2010 11:04:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/HAvFnevsuZd
	2q9tyA5hfdYSjzU=; b=ghQ3TqycBAvSPgRNRf1fDZ2ZmaGFiSNSHngqtBAPqWAM
	Mvl4UcLXDifjjlq2TD77IT9yD2T1NGcoPxhpDbTzLI4AtL5La97eZKxDErzYay6F
	G547owwxxA3tILv8jpJrGLmyvcpYr2l2T8N9rjYWUR/BMr5GTIBHatTDqN2Bhk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QozSl2
	sTy4q6EsIWav834JmUSIT2c6s9P4vQFBeJxbM9OiTBvArJ3mK6s5T8w3hZTOln5L
	O6aeXHbkmnnQDF6dJ5DIOHSpAVs7jol5NgZ6cN7GKaYLcTY4Ko0gACWLSIrBVZk9
	sVgqLW/NIrd4MZeCsdXgBrzeg56G0aRvadcWU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38AD13132;
	Mon,  6 Dec 2010 11:04:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B806E3130; Mon,  6 Dec 2010
 11:04:11 -0500 (EST)
In-Reply-To: <1291630811-16584-1-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Mon\,  6 Dec 2010 11\:20\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79B46B9A-0152-11E0-8FD5-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162997>

Santi B=C3=A9jar <santi@agolina.net> writes:

> get_remote_merge_branch with zero or one arguments returns the
> upstream branch. But a detached HEAD does no have an upstream branch,
> as it is not tracking anything. Handle this case testing the exit cod=
e
> of "git symbolic-ref -q HEAD".
>
> Reported-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
>
>> If that is the case, shouldn't we be not calling "echo" at all to be=
gin
>> with?  IOW, shouldn't the code read more like this?
>>
>>        curr_branch=3D$(git symbolic-ref -q HEAD) &&
>>        test "$origin" =3D "$default" &&
>>        echo ...
>
> Or course, you are right. I didn't know/think about the exit
> code... Thanks.

The calling codepath in git-pull that wants to determine remoteref and
oldremoteref seems to expect get-remote-merge-branch to succeed in orde=
r
to find its $oldremoteref variable, and returning false in detached HEA=
D
case here will change what happens there---it won't run "rev-list -g"
anymore and quits the codepath early, leaving the variable empty.

But we do want to set the variable to an empty string in this case anyw=
ay,
so there is no harm done (it probably is what we actually want to happe=
n).

So this should be Ok.  Sverre, do you want to do another round of testi=
ng
just to be sure before I apply this?

> Santi
>
>  git-parse-remote.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5f47b18..4da72ae 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -66,7 +66,7 @@ get_remote_merge_branch () {
>  	    origin=3D"$1"
>  	    default=3D$(get_default_remote)
>  	    test -z "$origin" && origin=3D$default
> -	    curr_branch=3D$(git symbolic-ref -q HEAD)
> +	    curr_branch=3D$(git symbolic-ref -q HEAD) &&
>  	    [ "$origin" =3D "$default" ] &&
>  	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
>  	    ;;
> --=20
> 1.7.3.3.399.g0d2be.dirty
