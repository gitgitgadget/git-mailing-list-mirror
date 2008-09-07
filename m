From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sun, 07 Sep 2008 12:18:02 -0700
Message-ID: <7v8wu3n4t1.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
 <20080907184922.GA3909@efreet.light.src>
 <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPnS-0005sF-Dj
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbYIGTSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbYIGTSN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:18:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367AbYIGTSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:18:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B96895E0C0;
	Sun,  7 Sep 2008 15:18:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA4DA5E0BD; Sun,  7 Sep 2008 15:18:05 -0400 (EDT)
In-Reply-To: <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Sep 2008 11:56:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5B578F4-7D11-11DD-A098-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95165>

Junio C Hamano <gitster@pobox.com> writes:

> Jan Hudec <bulb@ucw.cz> writes:
> ...
>> Why is this a *mis*design? Couldn't push be fixed by redesigning it's
>> protocol along the lines of:
>>  - clients sends a list of sha1s it wants to push, from the tip down
>>  - server stops it when it sees an object it has -- this check can be done
>>    against the object store without having a ref for it.
>
> Because your second step is *BROKEN*.
>
> Think of a case where an earlier commit walker started fetching into that
> "server" end, which got newer commits and their associated objects first
> and then older ones, and then got killed before reaching to the objects it
> already had.  In such a case, the commit walker will *not* update the refs
> on the server end (and for a very good reason).
>
> After that, the server end would have:
>
>  * refs that point at some older commits, all objects from whom are

s/from whom/reachable from which/;

>    guaranteed to be in the repository (that's the "ref" guarantee);
>
>  * newer commits and their objects, but if you follow them you will hit
>    some objects that are *NOT* in the repository.

To visualize, the server object store and refs would be like this:

    ---o---o---A...x...x...x...x...o---o---X
               ^ ref

Commits 'x' are all missing because the commit walker fetched commit X,
inspected its tree and got the necessary tree and blob objects, went back
to get X's parent, did the same, then its parent, attempted to do the same
but got killed before connecting the history fully to A.

If you accepted history on top of X before guaranteeing that you have
everything reachable from X already in this round of push will give you this:


    ---o---o---A...x...x...x...x...o---o---X---o---o---Y
               ^ ref =========== (wrong) ============> ^ ref

and if you update the ref to point at Y, then you cannot satisfy requests
from other people who want the history that leads to Y, because somewhere
between A and X there are commit that you do not even have to begin with.

So you may even be able accept objects between X..Y, but you cannot update
the ref from A to Y after accepting such a push, which is pointless.

You could try a variant of it to unbreak your trick, though.  When you see
an object that you have, say 'X' above, you traverse down from there until
reaching some ref (in this case, A) and make sure that you have everything
in between (not just commits but also associated trees and blobs that are
needed).  This is quite similar to what is happening when the commit
walker says "walk deadbeef..." in its progress output.  So it _could_ be
done, but it would be somewhat expensive.
