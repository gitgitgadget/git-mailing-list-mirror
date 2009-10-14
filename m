From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Changing branches in supermodule does not affect submodule?
Date: Wed, 14 Oct 2009 13:02:58 -0700
Message-ID: <7vtyy1bv65.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se>
 <4AD47C65.5080904@web.de> <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyA6O-0005iX-Oq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759662AbZJNUDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbZJNUDx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:03:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759108AbZJNUDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:03:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76BFB77691;
	Wed, 14 Oct 2009 16:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uvrW1tgoT8lRYMe0kbrqLeeH6hU=; b=i5cgKT
	Z8GZ163usE2M7OfKSOuBb2DD5oHpI65CGa4YGpxCclmN76lhGivKMNonFxScO6B4
	9XNxhxLJhrF5M08IS6fIKAbZCKmulBAwcdT5SEoYQ+Vs2gUCN1yl6f2H+e3rAlRQ
	Cat2nWke1owMjExO7+Jal7sepn+Or/JeJdm8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CVJuQDLZvT8pBPyKwytQ1b4a8PlwK7ap
	X4LH31ybrPFSs4UsWsBlIfN9a3Nj7gOwN1tzfNCBONu7pVTv0tMPoJCQnDiNHH6o
	zMZlneKCm6zzKz8CwFTq1WX59NzSQHsAk43J9gdG5GZvrTOhtFRZKyNcFKsh0c0g
	qIxFNDbBGi8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EDFE7768D;
	Wed, 14 Oct 2009 16:03:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 770AD7768C; Wed, 14 Oct 2009
 16:03:00 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se> (Peter
 Krefting's message of "Wed\, 14 Oct 2009 07\:31\:04 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95D4F582-B8FC-11DE-904C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130330>

Peter Krefting <peter@softwolves.pp.se> writes:

> Basically, I would like it to update all the submodules to the state
> recorded in the commit I move to, if they were in a clean state before
> I moved. I do not want it to change states if I do something like
>
>   cd submodule
>   # do some changes
>   git commit
>   cd ..
>   git checkout -b newbranch
>
> because there I want the commit I made to the submodule to be recorded
> on the new branch I created. But then it was in a dirty state before I
> created the branch anyway, so that shouldn't be a problem.

My understanding is that the primary reason "git checkout $another_branch"
does not touch submodules (other than updating the commit object name
bound in the index in the superproject) is because we did not know what
people would want to happen when submodule support was introduced.

Now people have used submodules for a while, we can update this.  I think
modelling the behaviour after how normal blobs are updated upon branch
switching would make sense.

So let's step back a bit and review what happens to a normal blob upon
branch switching.  There are three cases for a path while switching
branches from A to B:

 #1 The path is the same between A and B.  In this case, whatever you have
    for path in the index and in the work tree stay the same.  Your local
    modification is carried across branch switching.

    This is already what we do with submodules.  In cases #2 and #3 below,
    path is different between A and B.

 #2 You do not have any change to the path in either the index nor in the
    work tree.  The path is updated to B's version in the index and also
    what you have in the work tree matches it.

    Note that if B lacks the path, it is _removed_ from both the index and
    the work tree.

 #3 You have a change to the path in the index or in the work tree.  The
    branch switch is refused if the index does not match what is in B.

    I think this also is already what we do with submodules.

With a reasonable definition of "have a change in the work tree" for a
submodule path, we can define a reasonable behaviour for updating the
submodules when a different branch is checked out in the superproject.

For a regular blob, having a change in the work tree is that the object
recorded in HEAD (in the superproject) is different from what you have in
the work tree.  What should the definition be for a submodule?

The HEAD (in the submodule), the index (in the submodule) and the work
tree (in the submodule) form the "state" of what you have in the path, and
that corresponds to the "work tree state".  So I think we can say that
there is no change in the work tree for a submodule at path P if all of
the following holds:

    - the HEAD in the submodule matches the commit recorded for the path P
      in the HEAD in the superproject;

    - the index in the submodule matches the HEAD in the submodule; and

    - the work tree in the submodule matches the index in the submodule.

With this definition, you should be able to patch "git checkout" to
recurse into the submodule directory for case #2.

As to the implementation, I'd suggest:

 - the check between the submodule HEAD and what the superproject records
   in the HEAD (the first condition above) be done inside the main process
   (because we already have a working check for #3 to refuse branch
   switching, I think it would be easier to implement this check by
   comparison between the submodule HEAD and the superproject index).

 - the check between the index and the HEAD in the submodule and the check
   between the index and the work tree in the submodule (the second and
   the third conditions above) be done in a subprocess that runs something
   like "git status" via the run_command() interface; and

 - the actual recursive checkout to happen in a subprocess that runs
   another instance of "git checkout" via the run_command() interface.

There is one caveat.  The potential removal of the work tree path in #2
may not be desirable for a submodule path, even if you do not have any
change to it (i.e. both the index and the work tree in the submodule match
the HEAD in the submodule), as you may have untracked files you would
rather want to keep in the submodule work tree.
