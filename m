From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 14:05:20 -0700
Message-ID: <7vy71ys8a7.fsf@gitster.siamese.dyndns.org>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl>
 <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
 <20080911160040.GE2056@cuci.nl>
 <alpine.LFD.1.10.0809111222170.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdtN8-0006oQ-GN
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYIKVFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYIKVFb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:05:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIKVFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:05:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41F807DBE5;
	Thu, 11 Sep 2008 17:05:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43EF57DBE2; Thu, 11 Sep 2008 17:05:21 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0809111222170.23787@xanadu.home> (Nicolas
 Pitre's message of "Thu, 11 Sep 2008 13:02:36 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D03B9AA-8045-11DD-8199-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95647>

Nicolas Pitre <nico@cam.org> writes:

> Still, in your case, you probably won't get rid of your stable branches, 
> hence the reachability argument is rather weak for your usage scenario, 
> meaning that you could as well have that info in the free form text 
> (like cherry-pick -x), and even generate a special graft file from that 
> locally for visualization/blame purposes.  Sure the indirection will add 
> some overhead, but I doubt it'll be measurable.

I keep hearing "blame" in this discussion, but I do not understand why
people think blame should _follow_ this "origin" information (in the usual
sense of "following").

Suppose you cherry-pick an existing commit from unrelated context:

         ...---A---B
                    . (origin)
                     .
        ...---o---X---Y---Z

i.e. on top of X the difference to bring A to B is applied to produce Y,
and a new development Z is made on top.  You start digging from Z.

Without any "origin", here is how blame works:

 * What Z did is blamed on Z; what Z did not change is passed to Y;

 * Y needs to:
 
   (1) take responsibility for what it changed; and/or

   (2) the remaining contents came from X --- pass the blame to it.

Let's see how we would want "origin" get involved.  Instead of the above,
what Y would do would be:

   (1) if the contents (excluding the part Z changed) is different from X,
       instead of taking the blame itself, give the _final_ blame to B.

   (2) the remainder is passed to X as usual.

This is different from the normal "following" in that B is not allowed to
pass the blame to its parents (should it be allowed to pass it to its
"origin"?), because the _only thing_ cherry-pick did was to transport what
B did (relative to A) to the unrelated history that led to X.

IOW, you did not look at the contents outside "diff A..B" when you made
the cherry-pick.  There could well be parts of the content that are common
across all of A, Y, X and Z, but as far as Y and Z are concerned, they did
not get any part of that common common content from A (otherwise "origin"
is no different from "parent", but you did not merge).

The output from "origin" aware blame would be identical to the normal
blame, except that lines that usually are labeled with Y are labeled with
B.  However:

   (1) If you _are_ interested in the line that says Y, you can look at
       the commit object Y and see "cherry-pick -x" information to learn
       it came from B already; and

   (2) More importantly, if you want to dig deeper by peeling the blamed
       line (I think gitweb allows this, and probably git-gui), you
       shouldn't peel that line blamed on B to start running blame at A.
       That would continue digging the history of A, which is wrong when
       you are examining the history that led to Z.

So please leave "blame" out of this discussion.
