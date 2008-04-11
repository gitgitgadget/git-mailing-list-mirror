From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Fri, 11 Apr 2008 16:48:41 -0700
Message-ID: <7vskxsneau.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkT04-0000TM-Iu
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbYDKXtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 19:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbYDKXs7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:48:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757525AbYDKXs7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 19:48:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F72D101F;
	Fri, 11 Apr 2008 19:48:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75F0D101E; Fri, 11 Apr 2008 19:48:51 -0400 (EDT)
In-Reply-To: <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Thu, 10 Apr 2008 01:58:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79315>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> This new command can be used to set symbolic marks for an commit whil=
e
> doing a rebase. This symbolic name can later be used for merges or
> resets.
> ---

Comments as requested...

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 8aa7371..b001ddf 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -23,6 +23,7 @@ DONE=3D"$DOTEST"/done
>  MSG=3D"$DOTEST"/message
>  SQUASH_MSG=3D"$DOTEST"/message-squash
>  REWRITTEN=3D"$DOTEST"/rewritten
> +MARKS=3D"$DOTEST"/marks

I wonder if this should live somewhere inside $GIT_DIR/refs namespace, =
so
that if any object pruning is triggered ever while rebasing interactive=
ly
the objects that marks require will be protected.

> @@ -240,6 +241,23 @@ peek_next_command () {
>  	sed -n "1s/ .*$//p" < "$TODO"
>  }
> =20
> +parse_mark() {
> +	local tmp

Bashism is not appreciated here.

> +	case "$tmp" in
> +	'#'[0-9]*)
> +		tmp=3D"${tmp#\#}"
> +		if test "$tmp" =3D $(printf %d "$tmp")
> +		then
> +			echo $tmp
> +			return 0
> +		fi
> +		;;
> +	esac

Wouldn't

	pick 5cc8f37 (init: show "Reinit" message even in ...)
	mark 1
	pick 18d077c (quiltimport: fix misquoting of parse...)
	mark 2
	reset 1
        merge #2

be easier for people?

When you reference a commit with mark name, it is reasonable to require=
 it
to be prefixed with '#', which is a character that cannot be either in
refname nor hex representation of a commit object.  I think it is Ok to
accept an optional prefix when defining one, e.g. "mark #47", but I do =
not
think requiring '#' prefix when defining one is needed.

> @@ -317,6 +335,23 @@ do_next () {
>  			die_with_patch $sha1 ""
>  		fi
>  		;;
> +	mark|a)

I understand that the reason why you did not pick a more obvious 'm' is
because you would want to add 'merge' later and give it 'm', but we do =
not
have to give a single-letter equivalent to all commands especially when
there is not an appropriate one.
