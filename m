From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Revamp git-cherry(1)
Date: Fri, 22 Nov 2013 11:25:57 -0800
Message-ID: <xmqqa9gw1bne.fsf@gitster.dls.corp.google.com>
References: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
	<dde93c10b7f6cb7b8cf94e9a0310c8e05aca2517.1385137650.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjwMo-0008Jm-S5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab3KVT0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:26:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab3KVT0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:26:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C851C54213;
	Fri, 22 Nov 2013 14:26:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKnEnhFcMUYpDp2kmCBB3SUBnAg=; b=Frj97x
	h/zApi5OxEKekykP9lIzffiBMq1wi0hHxcLesV93ktKterZoiqQSQDRGF/LSYVJA
	XAzXwc1T0IK7JxCTkMjgXeogVdcLAmh+2nYxCX0yWvhn/TaI2v27h20Epu5C2yje
	oeZMFV93un5mACsGME58OpGfPHtxxE38VkEo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BgPmT2ISfzgbPk3OsULtnAt1aAzYZ7tW
	AHFGM8/xwhoa8ks+DN3IXncqWG6gPNjDyeR3teefoqvMxOXdwl8xHv3/OGynl8li
	1oGcrcWh6iQ3iIx17Iw9nqjMJMqfSpRGHVIYms5gBqpxXD642yRdR76XMBJq5qmW
	bLam8xQg5Bc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F37954212;
	Fri, 22 Nov 2013 14:26:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAACA54210;
	Fri, 22 Nov 2013 14:26:05 -0500 (EST)
In-Reply-To: <dde93c10b7f6cb7b8cf94e9a0310c8e05aca2517.1385137650.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Fri, 22 Nov 2013 17:29:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE93B6C4-53AB-11E3-976C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238205>

Thomas Rast <tr@thomasrast.ch> writes:

>  NAME
>  ----
> +git-cherry - Find commits not applied in upstream
>  
> +Determine whether there are commits in `<head>..<upstream>` that are
> +equivalent to those in the range `<limit>..<head>`.
>  
> +The equivalence test is based on the diff, after removing whitespace
> +and line numbers.  git-cherry therefore detects when commits have been
> +"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
> +linkgit:git-rebase[1].
>  
> +Outputs the SHA1 of every commit in `<limit>..<head>`, prefixed with
> +`-` for commits that have an equivalent in <upstream>, and `+` for
> +commits that do not.

Thanks, this reads really much better than tha original.

We are listing those that need to be added to the upstream with "+",
while listing those that can be dropped from yours if you rebase
with "-".  Hinting the rationale behind the choice of "+/-"
somewhere may help as a mnemonic to the readers (see below).

> +EXAMPLES
> +--------
> +
> +Patch workflows
> +~~~~~~~~~~~~~~~
> +
> +git-cherry is frequently used in patch-based workflows (see
> +linkgit:gitworkflows[7]) to determine if a series of patches has been
> +applied by the upstream maintainer.  In such a workflow you might
> +create and send a topic branch like this:
> +
> +------------
> +$ git checkout -b topic origin/master
> +# work and create some commits
> +$ git format-patch origin/master
> +$ git send-email ... 00*
> +------------
> +Later, you can see whether your changes have been applied by saying
> +(still on `topic`):

Perhaps we want a blank line before "Later, ..." to be consistent
with all the other displayed examples here (I'll squash it locally
before queuing), even though AsciiDoc seems to format this just
fine.

> +
> +------------
> +$ git fetch  # update your notion of origin/master
> +$ git cherry -v
> +------------
> +
> +Concrete example
> +~~~~~~~~~~~~~~~~

"A concrete example", perhaps?  I dunno.

> +In a situation where topic consisted of three commits, and the
> +maintainer applied two of them, the situation might look like:
> +
> +------------
> +$ git log --graph --oneline --decorate --boundary origin/master...topic
> +* 7654321 (origin/master) upstream tip commit
> +[... snip some other commits ...]
> +* cccc111 cherry-pick of C
> +* aaaa111 cherry-pick of A
> +[... snip a lot more that has happened ...]
> +| * cccc000 (topic) commit C
> +| * bbbb000 commit B
> +| * aaaa000 commit A
> +|/
> +o 1234567 branch point
> +------------
> +
> +In such cases, git-cherry shows a concise summary of what has been
> +applied:

It shows a concise summary of "what has yet to be applied" (to be
consistent with the one-line description in the NAME section).

> +------------
> +$ git cherry origin/master topic
> +- cccc000... commit C
> ++ bbbb000... commit B
> +- aaaa000... commit A
> +------------

And the earlier "why +/-" could be done after this picture,
perhaps like:

	Here, we see that the commits A and C (marked with `-`) can
	be dropped from your `topic` branch when you rebase it on
	top of `origin/master`, while the commit B (marked with `+`)
	still needs to be kept so that it will be sent to be applied
	to `origin/master`.

or somesuch?
