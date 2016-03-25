From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use @{-1} with push?
Date: Fri, 25 Mar 2016 11:58:15 -0700
Message-ID: <xmqqoaa22xmg.fsf@gitster.mtv.corp.google.com>
References: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
	<xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
	<CAHd499B3Z58hj--Pa0uM36A2H3Xpmayrb+RiLeOBkmnu70yW1A@mail.gmail.com>
	<CAHd499BCciG5Udd_sj550jPKg_ahZmWOi-zUOU-cr_wYmri=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:58:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWwG-0006ee-5y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbcCYS6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:58:19 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752608AbcCYS6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:58:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81E8A4E78E;
	Fri, 25 Mar 2016 14:58:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxRwy+ehFdm2cnpP/Q6/dAej93g=; b=P/ayO7
	jDDLSiYPlM8Nfxe1SeshXCEBcdtgZfP50epZBRD/70+E1mcNw4uFg+ZQoJpoUPLC
	D90Lzsh/HnXTMu6AJQQoiXdKoV0rw+vqpKnlsVWSkRtEchZWVJOffuRNx7BvETAU
	DgGSHkqOS85WTJHf5xtU82+qjhHCkdk6jhbD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzcIXIKGYmXX+VOw0LFKaMvuMN92rY+S
	amsUf081uv+j81WqMu40NnX2gyKDMgX8/ecSDh13scyp6m1zH/sjyDQDQoPylPgL
	sUV4ueJJD8hBL7+MUN1ceo4crvQQg/irw52O2FherQ+ZSFObmdlSgLEZUxZv3Wku
	mgoUa+RiT5s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74F8B4E78C;
	Fri, 25 Mar 2016 14:58:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E93B94E78B;
	Fri, 25 Mar 2016 14:58:16 -0400 (EDT)
In-Reply-To: <CAHd499BCciG5Udd_sj550jPKg_ahZmWOi-zUOU-cr_wYmri=Rg@mail.gmail.com>
	(Robert Dailey's message of "Fri, 25 Mar 2016 13:11:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88A02D46-F2BB-11E5-A439-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289943>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> So the push works with the fully-qualified ref, but not git branch:

I thought these are clear from their documentation.  "push" works on
refnames, "branch" works on branch names.  "push" takes an branch
name as a short-hand and adds refs/heads/ when it makes sense, but
because it does not make any sense for "git branch" to create a
"branch" in a random place in refs/ (e.g. "refs/tags/foo" is not a
branch), it takes "foo" (i.e. the name of the branch, whose
underlying ref is "refs/heads/foo").

So

	ref=$(git rev-parse --symbolic-full-name "$2") &&
        case "$ref" in
        '') echo >&2 "No such thing $2"; exit 1 ;;
        refs/heads/*) ref=${ref#refs/heads/} ;;
        *) echo >&2 "That's not a branch $2"; exit 2 ;;
	esac &&
	git push "$1" "refs/heads/$ref" &&
        git branch -D "$ref"

or something?

>
> $ git rev-parse --symbolic-full-name foo
> refs/heads/foo
>
> $ git branch -d refs/heads/foo
> error: branch 'refs/heads/foo' not found.
>
> Any reason for this? I'm using git 2.7.4 on windows
