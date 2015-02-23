From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange reachability inconsistency (apparently, at least...)
Date: Sun, 22 Feb 2015 22:44:31 -0800
Message-ID: <xmqq1tlhunxs.fsf@gitster.dls.corp.google.com>
References: <144640746.551672305.1424355582540.JavaMail.root@zimbra39-e7.priv.proxad.net>
	<324985759.551780546.1424358217833.JavaMail.root@zimbra39-e7.priv.proxad.net>
	<CAPc5daW=OeNmPVMVWQvp3rfYzfV7z6c1=26E26y0SaRQH7JooA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>, dirson@bertin.fr, poulot@bertin.fr
To: ydirson@free.fr
X-From: git-owner@vger.kernel.org Mon Feb 23 07:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPmkx-0003Op-H4
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 07:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbbBWGof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 01:44:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750903AbbBWGoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 01:44:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7AB92C28A;
	Mon, 23 Feb 2015 01:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=shORIfROVfhw3UAzrA4wQvY8bJY=; b=CxcmaO
	Z9HA5pkw9tP5It4FTe/pHZoFgQQvCmZnqJwYh4RK+gZwuN6gPDOIlCncQAssH/1c
	dk4vkk6jEqWJbUoe3URwu4/VEP+yfqcI6/anpYI1cZz02UrBPzPKz78msju8bzYL
	0R+yv8jwj73Y5mWJmRcAXBcGJY2Up/PB1w96c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QF96AQrqK53HRnexZ53/9oyZH4V4rvdb
	dfL0+ZswiToE3aS/proXe0CYBiPcY1ZkgY1TcDOa5E7GsHoOJp+49o4jzHSD/VvE
	0fdqMN7DYiB4DXHsXOK6YpdRwZo1Bm/JHsKVHsd7jtoDiXEHB6j1GoDQZMduDkQM
	PHNC1P0Aq3U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF832C289;
	Mon, 23 Feb 2015 01:44:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 254792C288;
	Mon, 23 Feb 2015 01:44:33 -0500 (EST)
In-Reply-To: <CAPc5daW=OeNmPVMVWQvp3rfYzfV7z6c1=26E26y0SaRQH7JooA@mail.gmail.com>
	(Junio C. Hamano's message of "Sun, 22 Feb 2015 15:30:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CCFBAE0-BB27-11E4-93A5-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264248>

Junio C Hamano <gitster@pobox.com> writes:

> On Thu, Feb 19, 2015 at 7:03 AM,  <ydirson@free.fr> wrote:
>> I have a (fsck-clean) git tree in which for 2 commits A and B:
>>
>> * "git merge-base --is-ancestor A B" returns 0
>> * "git log B..A" returns a non-empty set of commits
>>
>> I get this behaviour with 2.3.0 as well as with 2.1.3 and 1.7.12.
>>
>> Is that a real bug or am I just misinterpreting something ?
>
> Sounds strange. Is it possible to share the repository (or an
> anonymised copy of it)?

Actually it does not sound all that strange.

I suspect that B is indeed a proper descendant of A, but you have
commits with screwed-up committer timestamps between these two
commits that break the cut-off heuristic used by log and reb-list.

Grab the output from "git rev-list B..A".  These are supposed to be
ahead of B (i.e. should not be reachable from B).  Then look at the
output from "git log B" (no lower bound) and see if these commits
appear there, perhaps like:

    $ git rev-list B..A | sed -e 's/^/^/' >phantoms
    $ git log --format='%H %ct' B | grep -C2 -f phantoms

Hits from the latter "grep" would indicate that what the traversal
B..A claimed that are not reachable from B contained some commits
that are indeed reachable from B.
