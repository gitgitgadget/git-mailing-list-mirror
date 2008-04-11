From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 02/10] Teach rebase interactive the reset command
Date: Fri, 11 Apr 2008 16:56:00 -0700
Message-ID: <7viqyondyn.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:57:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkT76-00022S-Le
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbYDKX4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 19:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758407AbYDKX4P
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:56:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbYDKX4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 19:56:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BEBA1CA9;
	Fri, 11 Apr 2008 19:56:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB32D1CA7; Fri, 11 Apr 2008 19:56:08 -0400 (EDT)
In-Reply-To: <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Thu, 10 Apr 2008 01:58:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79316>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> ---
>  git-rebase--interactive.sh    |   20 ++++++++++++++++++++
>  t/t3404-rebase-interactive.sh |   10 ++++++++++
>  2 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b001ddf..7dac51b 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -258,6 +258,16 @@ parse_mark() {
>  	return 1
>  }
> =20
> +mark_to_sha1() {
> +	local mark

Bashism.

> +	if mark=3D$(parse_mark $1)
> +	then
> +		cat "$MARKS"/$mark

This cat may become "rev-parse --verify" if we decide to move $MARKS
underneath refs/ namespace somewhere.

> +	reset|r)
> +		comment_for_reflog reset
> +
> +		mark_action_done
> +		tmp=3D$(mark_to_sha1 $sha1) || \
> +			tmp=3D$(git rev-parse --verify $sha1) ||

and you then would not need to do the verify twice.

> +			die "Invalid parent '$sha1' in $command $sha1 $rest"
> +		output git reset --hard $tmp

Could this step fail, and if it does what should happen?

> @@ -569,6 +588,7 @@ do
>  #  edit =3D use commit, but stop for amending
>  #  squash =3D use commit, but meld into previous commit
>  #  mark #NUM =3D mark the current HEAD for later reference
> +#  reset #NUM|commit =3D reset HEAD to a previous set mark or a comm=
it

"to a previously set mark".  But I would say upfront "in the todo insn
whenever you need to refer to a commit, in addition to
the usual commit object name, you can use '#num' syntax to refer to a
commit previously marked with the 'mark' insn." and make this line just
read:

    #  reset commit =3D reset HEAD to the commit
