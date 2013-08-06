From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 10:52:16 -0700
Message-ID: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
References: <87k3jy6cyc.fsf@fencepost.gnu.org> <vpqli4ekdni.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6lQr-0004AP-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab3HFRwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:52:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab3HFRwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E424F36692;
	Tue,  6 Aug 2013 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yq5+I2UMEH+PUV5Ono5CbXzpEc0=; b=OxKp+H
	3OXDXKAEt3uITj3nJf+CWiWtUK9tuDOmMNvXygyoqVYObasKl6QONV/zqqf9yGg0
	9dDGprShwxUHyA37LHZK5736hfB3G8wEz2ijI3F+YRc38Jqh6u4/c+56mOdR4G8Y
	iTKxu200VbrknPB82coRgN2q307ciKAebWzEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n4ZQc4NSAM1iiwDG0WrkB1OqaDrMUnpL
	A2hrwqefmpgSlgvfuooGl5byjbWizWbZmWHI5Q/Ibd786Hk5Myp7Ifjs8HuNQD3M
	0LY7m57WwRorFLH8gWCAepV8SElCfL+GAaKOca6JCXG3hPSBGZIuemQpO7LQ21nU
	MrZ5Z/iukdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D9336691;
	Tue,  6 Aug 2013 17:52:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E64043668B;
	Tue,  6 Aug 2013 17:52:21 +0000 (UTC)
In-Reply-To: <vpqli4ekdni.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	06 Aug 2013 18:05:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1DD8DE0-FEC0-11E2-B68F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231769>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Could not apply 16de9d2... Make tempo range 	empo 20~30 be input as 	empo 20-30 instead
>
> Indeed. The source of the problem is that our "die" shell function
> interprets \t (because it uses "echo").
>
> A simple fix would be this:
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7a964ad..97258d5 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -53,7 +53,7 @@ die () {
>  die_with_status () {
>         status=$1
>         shift
> -       echo >&2 "$*"
> +       printf >&2 "%s\n" "$*"
>         exit "$status"
>  }
>  
> It does not sound crazy as the shell function "say" right below uses the
> same printf "%s\n" "$*", but I'm wondering whether this could have other
> bad implications (e.g. if there are escape sequences in the commit
> message, aren't we going to screw up the terminal?).

I gave a quick look at "git grep -e 'die ' -- \*.sh" output, and I
do not think this change will break things (i.e. no caller expects
the non-portable behaviour of the shell such as "\c" at the end to
omit the trailing newline).

Thanks, care to roll it into a patch with a test or two?
