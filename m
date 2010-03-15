From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Mon, 15 Mar 2010 14:30:43 -0700
Message-ID: <7vocipjmrg.fsf@alter.siamese.dyndns.org>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:31:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHsO-0003SN-QL
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936856Ab0COVa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:30:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936835Ab0COVa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06438A2170;
	Mon, 15 Mar 2010 17:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IX7olg9gyzvHJDvmr7pKsNmBhe8=; b=nwAaIc
	NIS6tRH76SYK+UaFEluIzRSfBwKBCDqTB0MiTP1ann6U2pmdu2sJ4eIfAS7NnJug
	Ub8rnhopop3rKv7VwpqDeKI3QG5MgisGb70e4FqmiUr+qR8b+i5LMFTwv8fdyryh
	lcDCwbO3juMH2/ZUI/D0ia0NKuTSfm9vvEs1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l8moXZW68wLshS6ozPuv/qYNS9KBiuoj
	oEnTQ1kyMt1l0XeX16/C9PVdBp6PgSIywaTF97PiIWKFyxnE/nWS9v3/osdr+RWN
	ocktt1Q23PWf+iuhrnbz8hqbuDPwYtx3uqE8/MI92qyYvhJe5zpEQk1hj2IiiPIl
	ZIeOFvsrgis=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9064A2169;
	Mon, 15 Mar 2010 17:30:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75A44A215E; Mon, 15 Mar
 2010 17:30:44 -0400 (EDT)
In-Reply-To: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 15 Mar 2010 00\:17\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 084354CA-307A-11DF-A7B1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142254>

Jay Soffian <jaysoffian@gmail.com> writes:

> I have the following scenario:
>
>   o---o---Ma---o---o    local-master
>  /       /
> |       | .-b'------d'  upstream-a
> |       |/  :       :
> o---o---a---b---c---d   upstream-master
>
> Local-master branched from upstream-master in distant past.
> upstream-master periodically cuts tentative release branch upstream-a.
> When they do this, that branch point (a) is merged into local-master
> (Ma).
>
> Over time, upstream applies fixes to upstream-a, but does so by
> committing the fixes to upstream-master and then cherry-picking them
> to upstream-a.
>
> The question is how to best integrate the fixes on upstream-a into
> local-master, w/o causing a headache when upstream cuts the next
> tentative release branch, at which point upstrea-master will again
> need to be merged into local-master (and that will also have other
> local development). Here are two options I've considered:

Is it an option not to treat "local-master" as anything but a throw-away
integration testing branch?

Presumably upstream-master would be a stable, non-rewinding branch, and
when they branch for their next release (i.e. at point 'a' in the
picture), you should be able to trust up to that commit.  So you would
arrange topics on your side to be based on commits before 'a', and never
let your people fork from or build directly on local-master.

Rebuild local-master every time you would want to run integration testing
with the recent upstream changes, either by starting the throw-away
local-master at upstream-master or upstream-a depending on what
development phase the upstream is in and what the targetted base for your
own release, and merging your topics you intend to ship into it.

                  your topics branch from local-base, which was forked
                  from the last known stable point of the upstream.
                    /       \   \   \
                   /         \   \   \  merge topics for integration testing
                  /           \   \   \
           ...---o local-base  x---x---x local-master (throw-away)
                /             /
    ---o---o---a---b----c----d
                \            upstream-master
                 b'--c'--d'
                         upstream-a

To keep track of the set of topics you know you may want to include in the
upcoming release, you could also merge "well cooked" topics into
local-base so that your people can build on top of other topics and test
them together.

                  your topics branch from (and possibly
                  merge into) local-base
                    / \   \       \   \ 
                   /   \   x---x---x---x local-master (throw-away) 
                  /     \ /   \
 local-base ..---o---o---o   \
                /           /
    ---o---o---a---b---c---d
                \          upstream-master
                 b'--c'--d'  
                         upstream-a

Again, when running integration testing with the recent upstream, you can
rebuild your throw-away local-master at the tip of local-base, and merge
either upstream-master or upstream-a to make sure your changes work with
them.

Individual developers can do the same when testing their own topics in
isolation, together with recent upstream, using their own throw-away
testing branches that merge their topic and recent upstream.
