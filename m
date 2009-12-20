From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: print the editor name if it fails to launch
Date: Sun, 20 Dec 2009 10:44:41 -0800
Message-ID: <7v4onlbi3q.fsf@alter.siamese.dyndns.org>
References: <4B2DE132.1080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 19:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMQm4-0002jn-GI
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 19:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZLTSoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 13:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZLTSoy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 13:44:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZLTSox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 13:44:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2E05A8017;
	Sun, 20 Dec 2009 13:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TvCxa1XCcMow
	AnmjdPE0X2tV7Tc=; b=ODoStYVApUPm/6o6H2ZQ8BJ9zmx81UZjqMKSerPuRDh/
	rJ0vkrW22blLkIT8361Sik74i1YJ+I/GS79wOthKuv+K1b2Ruql0/0h3TrXPpD+e
	oo1xZq3ezTSZzW1hgS8sgqaQk63nv0VJJesoZkS4vracGvun+6GnxR3q3Am12YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T4uw/V
	qL+oyLVbPBNW6a1nYFq149PCksF29YClgFnjyHVvV87/GL8fp5sVE/cqLlTRThEI
	igiSbgYB/bCAJx1wXZwvIBHnC+0rHRuO+GPvPWcNmAFveYzQH0EauLzzVjMzkDRC
	27Zpb6YIZVQny556fZ0A0Z48x+1/TOITlNlGs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91CF8A8016;
	Sun, 20 Dec 2009 13:44:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B08A3A8015; Sun, 20 Dec 2009
 13:44:43 -0500 (EST)
In-Reply-To: <4B2DE132.1080700@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Sun\, 20 Dec 2009 09\:32\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEDB5B2C-ED97-11DE-9C22-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135531>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> I am not sure whether "git am" also should be modified
> to call git_editor_error_string. Currently it ignores
> any errors from the call to git_editor. Should it abort
> if there is an error or should it print a warning like this
>
> echo "Warning: $(git_editor_error_string)"
>
> if the editor fails to launch?

It probably is better, even though the lack of check there is not as
harmful compared to the one in "rebase -i" that annoyed you (which I al=
so
see occasionally after freshly rebooting my environment, as I use
emacsclient like you do).  You will be taken back to the "what now?"
interactive loop and have a chance to \C-c out of it.  So such a patch
would help not in the sense that it would prevent the command from doin=
g
what you didn't intend to (which is your "rebase -i" patch is about), b=
ut
in the sense that it hints what needs to be fixed once you break out of
the command.

> -		git_editor "$TODO" ||
> -			die_abort "Could not execute editor"
> +		git_editor "$TODO" || die_abort "$(git_editor_error_string)"

Isn't this too elaborate?  git_editor() has already run and when it
attempted to launch the editor it assigned to GIT_EDITOR in order to us=
e
it as an eval string.

    git_editor "$TODO" ||
    die_abort "Failed to run '${GIT_EDITOR:-your editor}'"

would suffice, no?

The alternative string is for a case where "git var" gave an empty stri=
ng,
or GIT_EDITOR was an empty string from the beginning.
