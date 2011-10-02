From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Sun, 02 Oct 2011 07:19:30 +0200
Message-ID: <4E87F462.3000308@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <201109301041.13848.mfick@codeaurora.org> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org> <7vwrcola0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 07:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAESo-0004R6-Ce
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 07:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab1JBFTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 01:19:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60891 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1JBFTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 01:19:41 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC733.dip.t-dialin.net [84.190.199.51])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p925JVGS018165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Oct 2011 07:19:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vwrcola0m.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182594>

On 10/01/2011 10:41 PM, Junio C Hamano wrote:
> Martin Fick <mfick@codeaurora.org> writes:
>> I guess this makes sense, we invalidate the cache and have 
>> to rebuild it after every new ref is added?  Perhaps a 
>> simple fix would be to move the invalidation right after all 
>> the refs are updated?  Maybe write_ref_sha1 could take in a 
>> flag to tell it to not invalidate the cache so that during 
>> iterative updates it could be disabled and then run manually 
>> after the update?
> 
> It might make sense, on top of Julian's patch, to add a bit that says "the
> contents of this ref-array is current but the array is not sorted", and
> whenever somebody runs add_ref(), append it also to the ref-array (so that
> the contents do not have to be re-read from the filesystem) but flip the
> "unsorted" bit on. Then update look-up and iteration to sort the array
> when "unsorted" bit is on without re-reading the contents from the
> filesystem.

My WIP patch series does one better than this; it keeps track of what
part of the array is already sorted so that a reference can be found in
the sorted part of the array using binary search, and if it is not found
there a linear search is done through the unsorted part of the array.  I
also have some code (not pushed) that adds some intelligence to make the
use case

    repeat many times:
        check if reference exists
        add reference

efficient by picking optimal intervals to re-sort the array.  (This sort
can also be faster if most of the array is already sorted: sort the new
entries using qsort then merge sort them into the already-sorted part of
the list.)

But there is another reason that we cannot currently update the
reference cache on the fly rather than invalidating it after each
change: symbolic references are stored *resolved* in the reference
cache, and no record is kept of the reference that they refer to.
Therefore it is possible that the addition or modification of an
arbitrary reference can affect how a symbolic reference is resolved, but
there is not enough information in the cache to track this.

IMO the correct solution is to store symbolic references un-resolved.
Given that lookup is going to become much faster, the slowdown in
reference resolution should not be a big performance penalty, whereas
reference updating could become *much* faster.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
