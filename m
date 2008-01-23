From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I'm a total push-over..
Date: Tue, 22 Jan 2008 18:36:43 -0800
Message-ID: <7v63xlqnd0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	<7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVUx-0000tW-SS
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYAWChF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYAWChE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:37:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYAWChC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:37:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 430757082;
	Tue, 22 Jan 2008 21:36:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 845DB7081;
	Tue, 22 Jan 2008 21:36:55 -0500 (EST)
In-Reply-To: <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 22 Jan 2008 18:23:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71494>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Ok, here's an interesting patch based on the current 'next' (since it very 
>> intimately requires the new in-memory index format).
>
> This is nice.  It does not do anything specific with HFS+ issues
> but aims for faster look-ups, which would help everybody.
>
> Two things I noticed (only two, not necessarily because you are
> good but mostly because I am still mired in day job and could
> not get enough uninterrupted minutes to read the patch ;-)):
>
>  - You might want to store the hash table (once computed) in the
>    index extension section, and lazily unpack the table the
>    first time index_name_exists() or set_index_entry() is called
>    on the given istate, instead of unpacking it immediately when
>    you read from the disk.  That way, ls-files does not have to
>    suffer at all.

Actually, I take one fourth of this back.  

 * I am not yet retracting the suggestion to do the hashing
   lazily (what I mean by "lazily" is that the first access that
   wants hashed access will iterate active_cache and hash them
   all, not "lazily one entry at a time as needed" which would
   not make any sense for a hashtable).  I have to find time to
   try benching the effect of it myself.  So that's one half
   retained.

 * We certainly do not necessarily want to store this in the
   index right now.  The hash algorithms would be improved from
   the version you are almost ashamed of ;-).  That sounds as if
   I am retrating the other half, but not quite.

 * Once we have a mechanism to detect that the extension section
   stores a precomputed hash that was done with a different
   algorithm and ignore it (and recompute afresh when needed),
   then we can afford to put a more elaborate hashing algorithm,
   slightly loosening one of your "Guiding principles", and keep
   the result in the generated index to be reused by the next
   user.  So that is why I am retracting only half of the
   suggestion to save it in the extension section (which in turn
   is a half of my suggestion).
