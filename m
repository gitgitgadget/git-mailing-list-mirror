From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase: use reflog to find common base with upstream
Date: Mon, 09 Dec 2013 12:11:50 -0800
Message-ID: <xmqq7gbdzsvt.fsf@gitster.dls.corp.google.com>
References: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7BQ-0007dN-0K
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761204Ab3LIUL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:11:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3LIULz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:11:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91E35922E;
	Mon,  9 Dec 2013 15:11:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+LhSY6UyeYrSr7odRRzdL8VGS8=; b=FIvMDO
	3DhivwZdSJqbqaYchfl6VecALTzLVYjsRnR1tri4Zu6dZcsn4bHtJRxQAyEIr/+W
	vPiGkOPXN92X+9fQA6MDnYduPhJP+P7tSP8EMcANsIWoIpVca7ujh9d4OipNHOWp
	YWFDzPekLGMxPf5JOIrJ79m3zevlQM6qbIYBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGsxIAOxg4kR3jTOkCBwPBK4ROgz3ez/
	TzIjrQyCO699X5Q3QKfLoKkeWTA6UhNBMX+sOfun2WkORJwldK5qUTZ3RUUovGK8
	UI2uC1cccOPjCUSIsWelxahd+dvvemaRpcnicPP8HAJ6I+uK0vVJ6T4d07JeXCni
	Rv2/mWMg8fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 996725922C;
	Mon,  9 Dec 2013 15:11:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE32F5922A;
	Mon,  9 Dec 2013 15:11:53 -0500 (EST)
In-Reply-To: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 8 Dec 2013 20:06:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 258AB97E-610E-11E3-B4B4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239086>

John Keeping <john@keeping.me.uk> writes:

> Last time this came up [1], there was some discussion about moving the
> added block of code to affect upstreams given on the command line as
> well as when the upstream is discovered from the config.  Having tried
> that, it has some more fallout on the test suite than I like; this
> pattern ends up dropping the tip commit of "side" because it's in the
> reflog of "master":
>
> 	# start on "master"
> 	git branch side &&
> 	git reset --hard HEAD^ &&
> 	git checkout side &&
> 	git rebase master

We shouldn't do anything funky using the reflog when an explicit
commit object name was given like in the last step above, I think.
Automation to help human end-users is good, but at some level there
must be a mechanism to reliably reproduce the same result given the
same precondition for those who implement such automation, and I do
not think it is a good idea to force scripts to say

	git rebase --do-not-look-at-reflog master

in order to do so.

> I wonder if it would be better to add a --fork-point argument to
> git-rebase and default it to true when no upstream is given on the
> command line.

I am not sure what you exactly mean by "when no upstream is given",
though.  Do you mean

	git rebase <no other arguments>

which we interpret as "rebase the current branch on @{u}", and it
should behave as if the command was run like so:

	git rebase --fork-point @{u}

If that is what you suggest, I certainly can buy that.  Those who
want to disable the automation can explicitly say

	git rebase @{u}

and rebase the current exactly on top of the named commit (e.g. the
current value of refs/remotes/origin/master or whatever remote-tracking
branch you forked from).
