From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 07 Sep 2008 15:22:08 -0700
Message-ID: <7v1vzvlhpr.fsf@gitster.siamese.dyndns.org>
References: <20080907103415.GA3139@cuci.nl>
 <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org> <20080907201038.GB8765@cuci.nl>
 <200809072316.58516.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 08 00:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcSfq-0002mZ-GX
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbYIGWWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbYIGWWS
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:22:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132AbYIGWWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:22:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 80F477839C;
	Sun,  7 Sep 2008 18:22:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3FF977839B; Sun,  7 Sep 2008 18:22:10 -0400 (EDT)
In-Reply-To: <200809072316.58516.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun, 7 Sep 2008 23:16:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C4E234A-7D2B-11DD-A6CB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95184>

Thomas Rast <trast@student.ethz.ch> writes:

> Stephen R. van den Berg wrote:
>> Junio C Hamano wrote:
>> >             o---...o---B---A
>> >            /                \ (wrong)
>> >        ---o---o---...o---X---A'
> [...]
>> >To put it another way, having the parent link from A' to A is a statement
>> >that A' is a superset of A.  Because A contains B, you are claiming A'
>> >also contains B, which is not the case in your cherry-picked history.
>> 
>> Which existing git command actually misbehaves because it makes the
>> above assumption?
>
> Most importantly: merge.

Yes, and this is not about "misbhave" and "assumption".  It is much more
fundamental.

Stephen earlier seems to have mistaken what I taught in an earlier message:

  Remember, when you are making a commit on top of one or more parents, you
  are making this statement:

   * I have considered all histories leading to these parent commits, and
     based on that I decided that the tree I am recording as a child of
     these parents suits the purpose of my branch better than any of them.

  This applies to one-parent case as well.

as a mere convention or something, but it is not.  It is what the merge
semantics and merge-base computation (implemented in mathematical terms
over commit DAG) do, expressed in layman's terms.

The decision to merge your history with A' means that (1) you trust what
you have done so far, (2) you trust the judgement of what the other person
who built the history that leads to A' as well, and (3) you deem that the
purpose of these two histories are compatible with each other.  The last
item is why you are merging with him.

                             v you were here
                     o---o---o---M
                    /           /
            o---...O---B---A   /
           /                \ /
       ---o---o---...o---X---A'

Because of the "I have considered all things behind this commit, and I
declare this tree suits my purpose better than any of them" statement when
a merge A' was made, and the fact that you trust the judgement of the
person who made that statement, and the fact that you think the purpose of
his history is compatible with yours, we look at O as the merge base when
merging with A' to create M, and resulting history that lead to M claims
that it has A _and B_, in addition to X and other developments done on the
bottom branch of his, on top of what you used to have.

However, the transition from A to A' involves reverting B among other
things, and the history M includes that revert.  That's the consequence of
you trusting judgement made when A' was made (i.e. "fix in B does not
matter, and reverting it is better for my history") and thinking that
judgement is compatible with the purpose of your history (i.e. "yes, I
agree that dropping the fix made in B does not matter to my history
either, and that is why I am merging with A'").
