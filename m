From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Fri, 11 Mar 2016 08:53:39 -0800
Message-ID: <xmqqfuvxarcc.fsf@gitster.mtv.corp.google.com>
References: <20160307221539.GA24034@sigill.intra.peff.net>
	<xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
	<20160308121444.GA18535@sigill.intra.peff.net>
	<CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
	<20160308132524.GA22866@sigill.intra.peff.net>
	<20160310122020.GA24007@lanh>
	<20160310211052.GC30595@sigill.intra.peff.net>
	<xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
	<20160310214042.GB32608@sigill.intra.peff.net>
	<CACsJy8BRhuSOs96fonjBJ0ok6JZJ3CwLkDPCP_9QQdROZUVh8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 17:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeQK7-0004f4-T3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 17:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbcCKQxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 11:53:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932643AbcCKQxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 11:53:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 523AD4A767;
	Fri, 11 Mar 2016 11:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEAn0n0aYO7vbK75HE5gZKNtfv0=; b=mDfRqj
	1NOofPznSqJGjz9RFFLWlpQFjgb7vwNPKg1f9hjkaTgpidpzaDl/A2AySaoTDo8J
	7eN4/xXCW78aHa8Oh1UWveKF7DVseB8mMckrE4UiJatCUX9+ZUSDzb1s4DcrrwwF
	W8j0Zzh93E805thunXdjID6rl4YRZwkSb7BnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxlcJ70+hSNmR4DPA4v6/c9w17IAsNC/
	7IUxaQmr63e3Hhz1UNdXjBLcGc8L+oJWLxdyH/r674mMyOch5AbWrWli6MniNVgA
	IenM/8WLKz0OzFs6toqtroMTex03BJVUMLoEcRhMUxrc4i8YzpJdTxDHihZ8OEmQ
	E0rn2RvyOt0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 476EA4A766;
	Fri, 11 Mar 2016 11:53:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE4E04A764;
	Fri, 11 Mar 2016 11:53:40 -0500 (EST)
In-Reply-To: <CACsJy8BRhuSOs96fonjBJ0ok6JZJ3CwLkDPCP_9QQdROZUVh8w@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 11 Mar 2016 07:47:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEA85CCC-E7A9-11E5-92D0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288690>

Duy Nguyen <pclouds@gmail.com> writes:

> Well, assume again that F and G are ref heads, and their respective
> distance to C and D are the same (like the below graph), then "fetch
> --deptch=<distance>" can mark C and D as shallow cut points because
> --depth traverses from refs until the distance is met, it does not do
> total exclusion ^C like rev-list.
>
>        --- B ---- C ---- H ---- F
>           /      /
>      --- D ---- E ---- G

Hmph, so we do not realize that D is reachable from C because we do
not even look at the parents of the latter.  Is there a remification
that breaks the proposed mental view coming from this?

Let me think aloud.  Later when we fetch again (without asking to
change the depth but without refusing an unsolicited depth change),
a fetch of history that lead to descendants of F or G will still not
realize that C and D are related, because the traversal down to C
would stop there without noticing that E is reachable from C.  That
won't break.  If the tips of the history have been rewound and now
points at the tips of a history that is forked before B and D (let's
say the new tip to replace G is Z), would that be a problem?  The
side that does have the full history would notice that the fork
point X is an ancestors of cutoff C and D, and can tell that the
side-branch proper, Y and Z, are interesting but X is where their
truncated history must stop.

        --- B ---- C ---- H ---- F
           /      /
 -- X --- D ---- E ---- G
     \
      Y --- Z

While doing so the side that originally had C and D as the cutoff
would be told that now X is also a cutoff.  In general, because the
side that has the full history and gets fetched would not have to
know about _all_ the refs and objects the fetching side has, so if
it didn't learn about the shallow side still having G, it wouldn't
be able to say that D is no longer an interesting cutoff, but would
that be a problem?  The side with full history should also be able
to notice that E can also be added as a cutoff.  Would that be a
good thing to do?  If so, perhaps we should have done that when the
original history was shallowing cloned with depth=2 in your picture,
perhaps?  After all, even though the shallow side may not know C and
D are related, the side that supplied the truncated history knows,
so after depth traversal finds C and D, it perhaps can postprocess
it to realize C and E is the set that should be sent as the cutoff?
