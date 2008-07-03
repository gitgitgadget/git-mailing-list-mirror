From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 03 Jul 2008 15:51:03 -0700
Message-ID: <7vbq1ey42w.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807031142540.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEXfB-0005Zn-Ra
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840AbYGCWvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbYGCWvY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:51:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbYGCWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 18:51:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F37AF12825;
	Thu,  3 Jul 2008 18:51:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 100BB12824; Thu,  3 Jul 2008 18:51:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8CD40524-4952-11DD-935A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87332>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> When the history looks like ---A---B and we are at A, cherry-picking B can
>> be optimized to just advancing to B, but that optimization has a slight
>> difference (or two) in the semantics.
>> 
>>  (1) The committer information would not record the user and time of the
>>      sequencer operation, which actually may be a good thing.
>
> This is debatable.  But I think you are correct, for all the same reasons 
> why a merge can result in a fast-forward.
>
>>  (2) When $what is revert, this codepath shouldn't be exercised, should 
>>  it?
>
> Yes.
>
>>  (3) If B is a merge, even if $what is pick, this codepath shouldn't be
>>      exercised, should it?
>
> I think it should, again for the same reason why a merge can result in a 
> fast-forward.

Sorry, I disagree.  "cherry-pick" when this optimization is not applicable
always creates a single parent commit.  If the original history looks like:

	D---A---B---C
               /
              M

and when you are cherry-picking B, the above logic would make the result a
merge if you happen to be at A but if you are working elsewhere (perhaps C
or D, or "rewritten A") the result will become a single-parent commit.  I
do not see the justification behind such an unreliable/unpredictable
result, from the end-user's point of view.

I like the check and avoidance of creating a commit that will anyway have
the same parent and the same tree as an _optimization_.  Making the result
of "cherry-pick B" a merge or a non-merge however is not an optimization;
it is changing semantics.
