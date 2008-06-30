From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 16:27:27 -0700
Message-ID: <7vtzfatsf4.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
 <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
 <200807010116.30214.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSnY-0007jl-JO
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbYF3X1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 19:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYF3X1o
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:27:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbYF3X1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:27:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A18319075;
	Mon, 30 Jun 2008 19:27:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 45C471906E; Mon, 30 Jun 2008 19:27:35 -0400 (EDT)
In-Reply-To: <200807010116.30214.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 1 Jul 2008 01:16:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22FAF3E0-46FC-11DD-A050-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86965>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yes, I assume C is also bad.
>
>> ... which means you are dealing with *two* breakages.  That's outside
>> what bisect deals with.
>
> Sorry, I don't understand why I am assuming 2 breakages.

Your topology is

>> > A-B-C-D
>> >    \E-F

and you start with "D F" so D is bad and F is good, right?

bisect operates on a history with a single breakage that separates older
good ones and newer bad ones.

Now D is bad, so there must be somewhere in

	A--B--C--D

that broke D.  It could be D itself, or it may have been broken at A
already.

But if A or B were bad, then, because F is good, this part of the picture:

	A--B--E--F

does not deal with "old good followed by new bad sparated by a single
breakage point".  Maybe E or F have fixed it, but then before that is bad
and after that is good.  That's not what bisect deals with.

Going back to the original picture, then:

>> > A-B-C-D
>> >    \E-F

For F to be good, all of its ancestors are by definition good (that is the
basic assumption of bisection).  A and B are good.  If D is broken, C or D
must be broken.

So we do not decend into B nor its ancestor.

The logic is the same if the history is linear.

	A--B--C--D--E--F

If B is good and F is bad, and if you check D and find out that D is still
good, then we can ignore everything behind D, and that is what lets us
limit the search space and suspect only E or F.  This is exactly the same
"Everything that leads to a good one is good" principle upon which
bisection works.
