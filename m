From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Thu, 20 Dec 2007 14:31:07 -0800
Message-ID: <7v4pedov6c.fsf@gitster.siamese.dyndns.org>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218154211.GB12549@alea.gnuu.de>
	<7vabo7y762.fsf@gitster.siamese.dyndns.org>
	<200712202145.lBKLj7Fu015050@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 23:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Tvc-0007Xc-DK
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 23:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbXLTWbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 17:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbXLTWbT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 17:31:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXLTWbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 17:31:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 16EE424E3;
	Thu, 20 Dec 2007 17:31:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E81B24E2;
	Thu, 20 Dec 2007 17:31:10 -0500 (EST)
In-Reply-To: <200712202145.lBKLj7Fu015050@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Wed, 21 Dec 2007 06:40:38
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69021>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> How about making this behavior configurable?

=46irst, as a general principle, I'd like to avoid having commands that
changes their behaviour drastically depending on who the user is.  It
makes it harder for people experienced a bit more than totally new to
help others.  If they are truly experts and are familiar about the
configuration stash.quick, then they will be fine, but others would say
"Well, it works for me -- 'git stash' itself won't stash but list.  Why
isn't it working for you, I don't know" and scratch head.

Having said that, I reserve rights to change my mind later and start
liking this approach as a compromise.

There are a few suggestions and comments.

> +allow_quick_stash () {
> +=09
> +	quick=3D$(git config stash.quick)
> +	if test $? !=3D 0
> +	then

I think this is not a per-repository but per-person configuration (I
already said I do not want per-person configuration to affect the
fundamental behaviour of commands, but let's put that objection on hold
for now).  "git config --global" would be more appropriate.

So if the user hasn't seen this behaviour before, then...

> +		if ! test -t 0 || ! test -t 1
> +		then
> +			return 0
> +		fi

If it is not interactively called, allow "git stash" sans parameters as
before.  Nice attention to the details.

> +		echo '
> +*** First time users ***
> ...
> +		git config stash.quick $quick
> +		echo '
> +You can reconfigure this by editing your $HOME/.gitconfig file'
> +
> +	fi

Again, you would want --global here.  Also hint about explicit "save"
and "list" in addition to "you can reconfigure" might be helpful.

> +	case "$quick" in
> +	true)	return 0 ;;
> +	false)	return 1 ;;
> +	ask)	: do not return ;;
> +	esac
> +=09
> +	if ! test -t 0 || ! test -t 1
> +	then
> +		return 0
> +	fi

Even if it is configured to 'ask', we allow it for non-interactive
session (aka scripts).  Although I would agree with this logic, it coul=
d
be debatable.

> @@ -226,11 +289,16 @@ create)
>  	create_stash "$*" && echo "$w_commit"
>  	;;
>  *)
> -	if test $# -eq 0
> +	if test $# -ne 0
> +	then
> +		usage
> +	fi
> +	if allow_quick_stash
>  	then
>  		save_stash && git-reset --hard
>  	else
> -		usage
> +		echo "*** Stash List ***"
> +		list_stash
>  	fi

I was scratching my head about this extra "echo" and tried your version
after removing it, to realize this is another nice attention to the
details.  Without it, what's output from the command is not very clear
to people who do not know what "git stash" is configured to do for the
session.
