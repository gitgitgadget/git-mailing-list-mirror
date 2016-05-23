From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Mon, 23 May 2016 11:30:06 -0700
Message-ID: <xmqqiny4aaq9.fsf@gitster.mtv.corp.google.com>
References: <20160517171836.GA12183@kitenet.net>
	<xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
	<20160517182645.GA27396@kitenet.net>
	<20160522190404.GA20998@kitenet.net>
	<xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
	<20160523172951.GA1184@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Mon May 23 20:30:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ucM-0002gR-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbcEWSaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:30:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752329AbcEWSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:30:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3A101CE73;
	Mon, 23 May 2016 14:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kmCAk7IRDrKPFp0qUg5gpOxK/rA=; b=mbXSqh
	Q+EWzgSnQnvqzOW45llK3I+pcLhCiO6KsiAQcfZ/QjrvJKYszO4ENCHT8Japf3C+
	0Z01TpN4bp3QsfTKxhB6wN3G1g7KGtfoJgghTD//hvUAWN81ObApl0glodzCnbIw
	8BEgads1+uh73aY5+iVQu4gbUdrtOQkSQFlow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AataS6yaxq8ILOnNdIFtMTZNRxD/6sv2
	/8wcT4JZcm41bx8HdGKZUVjAHRJS3zquL7N5iWacp39xOsVGy8+edlaRczNQTvZN
	cY++JEvbQhZX++3ddVk/ULTWLA1amu6pfyAMm4GQE1fDz/kTUYj6xD33D/VL89QK
	iCerMf5l+MM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FCD71CE70;
	Mon, 23 May 2016 14:30:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC1241CE6F;
	Mon, 23 May 2016 14:30:08 -0400 (EDT)
In-Reply-To: <20160523172951.GA1184@kitenet.net> (Joey Hess's message of "Mon,
	23 May 2016 13:29:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60CD1C48-2114-11E6-BD3D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295346>

Joey Hess <id@joeyh.name> writes:

> I feel it should be made consistently relative to top of work tree.
>
> Seems fairly unlikely that any scripts driving git rely on it
> being relative to the pwd when GIT_WORK_TREE etc is set.

Oh, I do agree that the current status may be a sign that nobody
that is cautious to cater to all possible cases would be relying on
the current behaviour in their scripts.  It is likely that their
scripts would first notice GIT_INDEX_FILE being relative, turn it
into absolute (or even error out---if the authors were aware of the
issue), before doing anything else.

But people do write their scripts assuming that they will never use
GIT_WORK_TREE environment (i.e. they rely on their workflow to stay
within a subset of cases you described in your message); IOW, it is
OK for them that their script is usable only in their workflow.

And once you start worrying about not breaking them, your update
would become a lot trickier.

I personally think that it would be OK as long as we do not change
behaviours for those who do not use core.worktree, $GIT_DIR and/or
$GIT_WORK_TREE and change behaviour for others to match that
behaviour, simply because the plain vanilla no-configuration would
be used by the largest number of people.  But depending on the size
of the "minority", you may get pushback from them.

> (I'd prefer relative to pwd because that is much more sane IMHO, but
> making that change is more likely to break something.)

I am not sure if relative to PWD is useful.  If it were relative to
either the GIT_DIR or the GIT_WORK_TREE, i.e. a fixed point, then
you can set and export GIT_INDEX_FILE and chdir around without
having to adjust it.  If it were relative to PWD, you would need to
adjust it every time you chdir, no?
