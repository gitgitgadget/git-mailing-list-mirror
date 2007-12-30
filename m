From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Sun, 30 Dec 2007 13:49:11 -0800
Message-ID: <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	<7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 22:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J962j-0001fN-SX
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 22:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685AbXL3VtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757600AbXL3VtY
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 16:49:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbXL3VtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 16:49:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03F2A7032;
	Sun, 30 Dec 2007 16:49:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B407030;
	Sun, 30 Dec 2007 16:49:18 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 30 Dec 2007 11:58:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69379>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 30 Dec 2007, Junio C Hamano wrote:
>> 
>> With this patch, we actually see slight improvements in
>> execution time as well.  In the same partial kde repository
>> (3.0GB pack, 95MB idx; the numbers are from the same machine as
>> before, best of 5 runs):
>
> Ok, I tried this a year ago, and never got any real improvement.

Yes, I remember that one.

> and I decided it wasn't worth it. Yours looks much better, and seems to 
> get a real performance improvement, so go for it, but I doubt that the 
> actual object lookup is really ever the main issue. I've never seen it 
> stand out in the real profiles, although if it is able to cut down on IO 
> (and your minor fault numbers are promising!), it might be more important 
> than I'd otherwise think.

The cost of the key comparison done in each round is
insignificant compared to the actual cost of accessing the
object data through zlib.  The only potential performance
benefit that could come from this patch to reduce the average
number of rounds in the search is I/O reduction.

The only case I can think of that this may matter in real life
is accessing only small number of objects in a history with a
huge pack.  Once you dig down the history deep enough to check
enough number of objects inside a single process, you would need
to touch every page of the mapped idx and the minor-fault gain
rapidly diminishes.

Accessing only small number of objects in a huge history most
often happens when building near the tip of the history
(e.g. commit, rebase, merge), but these operations tend to deal
with very young objects, often unpacked.  We check pack first
and then loose objects, so the search for young loose objects
will benefit from the patch because the negative look-up to
notice that they do not live in any pack also becomes cheaper,
but I do not think it is such a big deal.
