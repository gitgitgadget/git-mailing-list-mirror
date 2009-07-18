From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] pull: support rebased upstream + fetch + pull
 --rebase
Date: Sat, 18 Jul 2009 10:55:35 -0700
Message-ID: <7vk5253mg8.fsf@alter.siamese.dyndns.org>
References: <adf1fd3d0907170624t7c2bf8f5w35c03788fdd82422@mail.gmail.com>
 <1247924785-31886-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 19:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSE8U-0001Ha-So
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 19:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbZGRRzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbZGRRzm
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 13:55:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZGRRzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 13:55:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B469884D;
	Sat, 18 Jul 2009 13:55:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 287CB8846; Sat,
 18 Jul 2009 13:55:37 -0400 (EDT)
In-Reply-To: <1247924785-31886-1-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Sat\, 18 Jul 2009 15\:46\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35231D18-73C4-11DE-8147-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123528>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Changes since v2:
>   - Hopefully enhance the commit log
>   - Use a 'for' loop for the reflog entries
>   - provide a default value in case there is no reflog
> diff --git a/git-pull.sh b/git-pull.sh
> index 4b78a0c..c8f1674 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -125,9 +125,16 @@ test true =3D "$rebase" && {
>  	die "refusing to pull with rebase: your working tree is not up-to-d=
ate"
> =20
>  	. git-parse-remote &&
> -	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> +	remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> +	oldremoteref=3D &&
> +	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
> +	do
> +		test $reflog =3D $(git merge-base $reflog $curr_branch) &&
> +		oldremoteref=3D$reflog && break
> +	done
> +	[ -z "$oldremoteref" ] &&
>  	oldremoteref=3D"$(git rev-parse -q --verify \
> -		"$reflist")"
> +		"$remoteref")"
>  }

Looks nicer.

I notice that you are breaking && chain with this patch.

If get_remote_merge_branch fails, oldremoteref is not initialized to em=
pty
string, the for loop is skipped and then the last step (by the way, ple=
ase
write that as 'test -z "$oldremoteref"') may not kick in, using whateve=
r
random value the variable originally had in the environment.

It probably makes more sense to do it in a slightly different order:

        . git-parse-remote &&
        oldremoteref=3D"$(get_remote_merge...)" &&
	remoteref=3D$oldremoteref &&
        for old in $(git rev-list -g "$remoteref" 2>/dev/null)
        do
        	if test "$old" =3D "$(git merge-base "$old" "$current_branch")
		then
			oldremoteref=3D"$old"
			break
                fi
	done
	# and you do not need 'if test -z "$oldremoteref"' anymore...

But other than that, I agree that this is the most straightforward
algorithm to express what you wanted to do.  I guess another possibilit=
y
is to instead look in the reflog of the _current_ branch to check how t=
he
previous rebase was done, iow, find out onto which commit the recent pa=
rt
of the current branch was rebased to, and rebase onto the current remot=
e
tip using that as the base.
