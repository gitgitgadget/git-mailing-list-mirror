From: Junio C Hamano <gitster@pobox.com>
Subject: Re: overly smart rebase - bug or feature?
Date: Mon, 10 Nov 2008 15:57:14 -0800
Message-ID: <7v1vxj3zj9.fsf@gitster.siamese.dyndns.org>
References: <20081110212333.GU6799@sun.com>
 <7vod0n41i5.fsf@gitster.siamese.dyndns.org> <20081110233649.GI6799@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roman.Shaposhnick@Sun.COM
X-From: git-owner@vger.kernel.org Tue Nov 11 00:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzgf5-0004xM-U0
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbYKJX6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbYKJX6A
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:58:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYKJX57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:57:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 319929552B;
	Mon, 10 Nov 2008 18:57:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E8F9195522; Mon,
 10 Nov 2008 18:57:16 -0500 (EST)
In-Reply-To: <20081110233649.GI6799@sun.com> (Fedor Sergeev's message of
 "Tue, 11 Nov 2008 02:36:49 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65A29AA0-AF83-11DD-B67D-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100602>

Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:

> On Mon, Nov 10, 2008 at 03:14:42PM -0800, Junio C Hamano wrote:
>> Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:
>> 
>> > I have recently hit a behavior which might well be a feature, 
>> > but it was very surprising (in a bad sense) to me.
>> 
>> It is a feature misfiring.
>> 
>> Rebase is essentially a repeated cherry-pick, and a cherry-pick of commit
>
> But cherry-pick does fail, as shown in my original mail!
>
>> A on top of commit B is done by a simplified 3-way merge between A and B
>> using the parent of A as the common ancestor.
>> 
>>      A                          A'
>>     /                          /
>>    A^... pseudo history ...---B
>
> Well, my history is exactly that, not pseudo (and I dont quite follow your reasoning
> yet to understand whether this is important or not):
>
>    A   B
>     \ /
>      A^
>
> A^ *is* a common ancestor of both A and B.
>
>> 
>> When your history has renamed Makefile to Makefile2 (thereby losing
>> Makefile)
>
> My history did not rename Makefile.
> There were three identical Makefiles (in A^)
> After that one was deleted (in B).
> On alternative branch it was edited (in A).
>
> If I do *merge* A into B then it fails.
> If I do *cherry-pick* A into B then it fails.
> If I do *rebase* A onto B then it succeeds.
>
>> while transition from A^ to A modified Makefile, the difference
>> between A^ to A that is applied to B to produce A' contains only the
>> change about Makefile (and does not talk about the unchangedness of
>> Makefile1 nor Makefile2 --- in fact, when A' is created, the machinery
>> does not even know if A^ and A had Makefile1 or Makefile2).
>> 
>> When applying the change to Makefile, it notices that B does not have
>> Makefile, but there is a path that is _identical_ to the preimage your
>> change applies to (namely, Makefile2).  To support people who rename
>> Makefile to Makefile2 in the history that led to B
>
> There was no rename. There was a copy in initial commit (and you cant say if it
> was Makefile copied into Makefile2 or vice verse).
> I dont believe it should really be called "rename", even if one of the copies was killed later.
>
>>, rebase (actually the
>> underlying "am -3" it calls is where this rename detection smart lies)
>> applies the changes to the "renamed" path.
>
> In this given case both Makefile1 and Makefile2 were absolutely equal. 
> If rebase chose to edit Makefile2 why didnt it change Makefile1?
>
>> 
>> You might be able to work this around by forcing rebase not to use the
>> simplified 3-way merge, by saying "rebase -m".
>
> Yeah, it worked.
> ...
> CONFLICT (delete/modify): Makefile deleted in master and modified in HEAD~0. Version HEAD~0 of Makefile left in tree.
> ...
>
> Though it does make me wonder why *simplified* 3-way merge is smarter than git merge ;)))

Simplified one is not _smarter_.  It is merely _faster_, exactly because
it only looks at the paths between A^..A and nothing else.

And that is why it cannot tell between the case where both A^ and A have
Makefile2 or they both lack it.  And that is exactly why application of
this change on top of B is mistaken as a patch to a renamed path.  From
B's point of view:

 - Incoming change says "I changed Makefile from this shape to that
   shape", and nothing else;

 - B does not have Makefile, but it happens to have the contents at path
   Makefile2 that is identical to the preimage of that incoming change.

which makes it guess (when falling back to 3-way merge) that somewhere
leading to B what used to be at Makefile (which is what the incoming
change claims to change) may have been renamed to Makefile2 (because B
does not have Makefile but does have it).
