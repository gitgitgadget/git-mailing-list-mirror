From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of
 --commit-filter
Date: Fri, 30 May 2008 16:41:57 -0700
Message-ID: <7v63svgy0q.fsf@gitster.siamese.dyndns.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org>
 <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
 <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat May 31 01:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2EFT-0006JS-Q4
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYE3XmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 19:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYE3XmL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 19:42:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYE3XmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 19:42:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8EDA34D5;
	Fri, 30 May 2008 19:42:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C056934D2; Fri, 30 May 2008 19:42:05 -0400 (EDT)
In-Reply-To: <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org> (Kevin Ballard's
 message of "Fri, 30 May 2008 16:07:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0495325C-2EA2-11DD-A19E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83358>

Kevin Ballard <kevin@sb.org> writes:

>> But I am also confused by the new description:
>>
>>        In that history, we will make sure that rewritten D (original
>>        commit being C) have A as parent.  IOW, we will have
>>
>>                --A'--C'  D'
>>                         /
>>                        A
>>
>> which is not what happens.  What it does is that the commits in the
>> output
>> from the filter (i.e. A) are first mapped to the corresponding
>> commits in
>> the rewritten history (i.e. A'), and they will be used as the
>> parents of
>> the rewritten commit, to form this history:
>>
>>                --A'--C'
>>
>> isn't it?
>
> So basically, you think it's missing the fact that the emitted id is
> mapped to rewritten commits? From reading the git-filter-branch code,
> I don't think that's correct. When each commit is created, its
> original parents get mapped to new values, but the results of the
> commit-filter are dumped straight into the map.

Ah, I misread this part of the code:

	parentstr=
	for parent in $parents; do
		for reparent in $(map "$parent"); do
			parentstr="$parentstr -p $reparent"
		done
	done
	if [ "$filter_parent" ]; then
		parentstr="$(echo "$parentstr" | eval "$filter_parent")" ||
				die "parent filter failed: $filter_parent"
	fi

You get the commit object names from the new history, and you are supposed
to give back names from the new history from the filter.

So "the rewritten commit will have the output from parent-filter as its
parents" is what happens, right?

IOW, in the history in the previous message, when rewriting C (to create
C'), the filter will get A' and B' (i.e. from the new history), and can
choose to return A', and that is recorded when creating C'.  "the
rewritten children of the commit" in your:

    +commit ids; in that case, the rewritten children of the original
    +commit will have all of them as parents.

sounded as if you are talking about D' not C', and that was what I was
confused about.

> To give an example, let's examine your tree. A will be processed
> first, and A' gets put into the map for A. B gets processed next (or
> maybe before A, but that's irrelevant) and B' gets put into the map
> for B. C gets processed, and it emits A, so A goes into the map for C.

Hmm?  I meant C is rewritten to become C' but when it does so filter can
remove B from its parent set (iow, the filter is told that unless it
intervenes C' will have A' and B' as its parents, but the filter can
choose to return only A').  So I do not quite get "it emits A" part.  Do
you mean "the filter outputs A'"?  Also do you mean by "map" the mapping
from <A, B, C> to <A', B', C'> commit namespace?  If so, even when the
filter "emits A'", I do not think it "goes into the map for C".  When the
filter "emits A'", it is used as _the_ single parent to create C', and it
is C' that "goes into the map for C".  Am I still confused?

Now, I admit that I did not look at the implementation of the "map" in the
code quoted above.  Perhaps that thing is busted, I dunno.
