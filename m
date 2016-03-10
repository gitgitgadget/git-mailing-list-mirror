From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git smudge filter fails
Date: Thu, 10 Mar 2016 14:04:55 -0800
Message-ID: <xmqqtwkec7lk.fsf@gitster.mtv.corp.google.com>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
	<20160310015939.GA12709@sigill.intra.peff.net>
	<CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
	<20160310210544.GB30595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:05:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8hd-00074B-ET
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbcCJWFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:05:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932379AbcCJWE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:04:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A50AB4B2BC;
	Thu, 10 Mar 2016 17:04:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EA9NN4084V1hFYA1oD912q3/jY=; b=p57VCu
	4XUtZVq3LNQ8Vce8mYVJTEI4/sJyBphftVZ+K8TIO03GglfPNr0zHocP/OFAKfWZ
	07897TasePiYE1X3lZ56fpDkzExcEpwbbe781sYGyPRcoSYsRCW+5G6L9frUX8x1
	9US+lbwtO3D/15LRrMsRgkMerk+JhlpohhwWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRV9DA7pWoxOPDt+SyL7hh8uP1Fic6MT
	t32M6HYUYcYATrQiiIjUAxGl9WZXB0pii/FJ2XNnfp9WS5WOvHPXDF7C62OWdb52
	nvX94KOMss4/0xalOXnA/7RBHw+WFw2Ok2N7x61FfgzQbjubzYnAOv1yEStKqdTt
	qseGFsaSdRc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CBB04B2BB;
	Thu, 10 Mar 2016 17:04:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 210654B2BA;
	Thu, 10 Mar 2016 17:04:57 -0500 (EST)
In-Reply-To: <20160310210544.GB30595@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Mar 2016 16:05:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2041F5C8-E70C-11E5-97AC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288650>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 10, 2016 at 09:45:19AM -0500, Stephen Morton wrote:
>
>> I am a bit confused because this is basically the example used in
>> ProGit [1] and it is fundamentally broken. In fact, if I understand
>> correctly, this means that smudge filters cannot be relied upon to
>> provide any 'keyword expansion' type tasks because they will all by
>> nature have to query the file with 'git log'.
>
> Interesting. Perhaps I am missing something (I am far from an expert in
> clean/smudge filters, which I do not generally use myself), but the
> example in ProGit looks kind of bogus to me. I don't think it ever would
> have worked reliably, under any version of git.
>
>> (Note that although in my example I used 'git checkout', with an only
>> slightly more complicated example I can make it fail on 'git pull'
>> which is perhaps a much more realistic use case. That was probably
>> implied in your answer, I just wanted to mention it.)
>
> Yeah, I think the issue is basically the same for several commands which
> update the worktree and the HEAD. Most of them are going to do the
> worktree first.

You can have a pair of branches A and B that have forked long time
ago, and have a path F that has been changed identically since they
forked, perhaps by cherry-picking the same change.  This happens all
the time.

If there were some mechanism that modifies the checked out version
of F with information that depends on the history that leads to A
(e.g. "which commit that is an ancestor of A last modified F?")
when you check out branch A, it will become invalid when you do "git
checkout B", because the path F will not change because they are the
same between the branches.  In short, CVS $Id$-style substitutions
that depend on the history fundamentally does not work, unless you
are willing to always rewrite the whole working tree every time you
switch branches.

The smudge and clean filters are given _only_ the blob contents and
nothing else, not "which commit (or tree) the blob is taken from",
not "which path this blob sits in that tree-ish", not "what branch
am I on" and this is a very much deliberate design decision made in
order to avoid leading people to a misguided attempt to mimick CVS
$Id$-style substitutions.
