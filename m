From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/16] bash prompt speedup
Date: Mon, 24 Jun 2013 12:25:21 -0700
Message-ID: <7vzjuf71lq.fsf@alter.siamese.dyndns.org>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eduardo D'Avila <erdavila@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:25:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCOH-0008Eo-3f
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3FXTZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 15:25:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3FXTZY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 15:25:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00EB72BA8A;
	Mon, 24 Jun 2013 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KilaEiZhZGnU
	6tV3SewBzHio5rY=; b=wjmQesXSITc9GCji3izGKIvpbdK18o6be6roEVQi0e4J
	kLolFnHW8MpNh2XvJtMn+jKxFEMkE8l2oyHCXKiojAmS/PqQT7JDghbI883mYSJE
	kAQNYGhkTuyLRb0cX7a0jCv+4ZV1iNN/oA07pNMq+NONrY/0VwaCUWJB/iz8xUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nPr44b
	L4VTFiVSpaLjeE738rqWZShBGiTzNhFRd43AMSKUiO9NwNWGjlJbtS+/ngV4g7m+
	FehlnfzY5b0o0PkfzXR9AVznl8f8+rxIpY1CkmhHCVGn54nunKgo60BR7Patt8gg
	zQn6gDvtLBqwrbx1RbLvZAqSCUbcQsQrJN83o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE0E2BA89;
	Mon, 24 Jun 2013 19:25:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E492BA87;
	Mon, 24 Jun 2013 19:25:23 +0000 (UTC)
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 24 Jun 2013 18:39:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0EDA518-DD03-11E2-B062-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228905>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Hi,
>
> displaying the git-specific bash prompt on Windows/MinGW takes quite
> long, long enough to be noticeable.  This is mainly caused by the
> numerous fork()s and exec()s to create subshells and run git or other
> commands, which are rather expensive on Windows.
>
> This patch series eliminates many command substitutions and command
> executions in __git_ps1() from top to bottom by replacing them with
> bash builtins or consolidating them.  A few timing results are shown
> in the log message of the last patch.
>
> Changes since v2 [1]:
>
>  - The detached HEAD abbreviated object name is now unique and
>    respects core.abbrev; see patches 5 and 11, replacing v2's patch 9=
=2E
>    (This is why I asked the detached HEAD before root commit thing
>    yesterday.) =20
>  - Patches 12 and 16 are new.
>  - Incorporated Peff's suggestion about using the 'write_script'
>    helper into patch 2.
>  - Incorporated Eric's typofix.
>  - Rephrased a few commit messages.
>
> It applies on top of current master; 2847cae8 (prompt: squelch error
> output from cat, 2013-06-14) graduated recently.
>
> This patch series will conflict with Eduardo's work on refactoring th=
e
> colorizing function, and the conflict is not trivial.  Although there
> are still some open questions left with that series (using tput, zsh
> tests), those won't affect the conflicts between the two patch series=
=2E
> So, for the convenience of our maintainer, I picked up Eduardo's
> series, took the liberty to apply a fixup commit on top with my
> suggestions from [2], merged the two series, and published the result
> at:
>
>   https://github.com/szeder/git.git bash-prompt-speedup-and-color-ref=
actorization
>
> Eduardo, could you please also check that my conflict resolution is
> correct?  Thanks.

Well, then I'll fetch that premerged result and queue it on 'pu',
wait for a while just in case if you need to reroll based on
somebody else's input and otherwise merge that down to 'next' and
then to 'master'.

Thanks.
