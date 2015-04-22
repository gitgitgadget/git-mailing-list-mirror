From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I resolve conflict after popping stash without adding the file to index?
Date: Wed, 22 Apr 2015 10:41:04 -0700
Message-ID: <xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
References: <5535697E.2030204@yandex.ru>
	<xmqqsibujyit.fsf@gitster.dls.corp.google.com>
	<553583C0.6090404@yandex.ru> <20150421212922.GC13230@peff.net>
	<5536D099.1000103@yandex.ru> <20150421225228.GB26322@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkyeV-0003IS-70
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbbDVRlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:41:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752508AbbDVRlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:41:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 365F24B0D2;
	Wed, 22 Apr 2015 13:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wCVWBOSx6/CId3+zVCo7AFkHjpE=; b=NLWiER
	GgKfzYnpPFfFdEpEVUBW5Re0sELRnfIpER0nuZal9pQyK81Ad7Kox8th8GA062H2
	wTsahtOsHuOYF5ALT6mLdfdQzBDe86V33VkAc+x/HgLlAP+J2VNr0lwy30+STmOi
	1QozYTKGDufXbhvIf6kiqhQz8vjQKcdhddFS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kLbO2E6zk4rJugw5B0HWtq0wajxyqN0Q
	+N/bM6yd+CJwQqr1pB4QvoQ13u+436gexdOwsJX9Mo5vG4DKfyWTPbsN1EiluO7R
	M1vyPDUY1XfuL08rbvWy4mivdUwPKlkaFPx708o8klc9gyjm3PrlHED135LG1OSE
	r8EQBZvVyJ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E6604B0D1;
	Wed, 22 Apr 2015 13:41:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8BED4B0C6;
	Wed, 22 Apr 2015 13:41:05 -0400 (EDT)
In-Reply-To: <20150421225228.GB26322@peff.net> (Jeff King's message of "Tue,
	21 Apr 2015 18:52:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C097EFE0-E916-11E4-AF80-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267598>

Jeff King <peff@peff.net> writes:

> Right, I am suggesting that latter: that stash should abort if the index
> has modified entries. The abort for modified working tree files is done
> by git-merge, which can be selective about which entries will be changed
> (since it knows which ones need written).  I haven't thought hard enough
> to say whether it should be doing the same for the index (i.e., whether
> this is a "merge" problem or a "stash" problem).

This is a stash problem.  I've always thought that it insisted on
having a clean index and a clean working tree, but apparently it
doesn't, as shown in Dmitry's example sequence.

Generally speaking, any mergy operation should be done with a clean
index (i.e. matches HEAD) so that any difference between the index
and the HEAD after it stops in the middle is purely the result of
that mergy operation, and the commands should stop when the index is
not clean as a safety measure (e.g. "git am -3", "git merge") [*1*].

An especially tricky command may also insist on a clean working tree
if it is not easy to guarantee that it will not clobber changes by
the user when it stops in the middle (e.g. "git rebase").  But this
is an escape hatch for lazy implementations ;-) It would be ideal if
a command stops without doing anything when the set of paths it
needs to touch would overlap the set of paths in which user has
changes before the command is run (e.g. "git merge" works that way).

I think that "stash apply" requires a clean working tree for the
latter reason, and does not require a clean index because it just
forgot that it must do so.
