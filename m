From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy operation
Date: Wed, 18 Mar 2009 11:14:27 +0100
Message-ID: <49C0C983.5060602@viscovery.net>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net> <20090317202818.GA13458@blimp.localdomain> <7v63i7ridk.fsf@gitster.siamese.dyndns.org> <20090317213820.GC13458@blimp.localdomain> <7vmybjl1l6.fsf@gitster.siamese.dyndns.org> <49C0A919.7070606@viscovery.net> <7v8wn3i3ee.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljsof-0001vt-4e
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 11:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbZCRKOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 06:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZCRKOg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 06:14:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8776 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbZCRKOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 06:14:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ljsn6-0007jj-AE; Wed, 18 Mar 2009 11:14:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A59369F; Wed, 18 Mar 2009 11:14:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v8wn3i3ee.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113607>

Junio C Hamano schrieb:
> I've always thought core.filemode was about "On FAT the filesystem does
> not have x-bit and Cygwin fakes it by looking at .exe extension and using
> other heuristics", but this lstat() "trick" is not about that.  It is "On
> Windows you need to issue multiple FS API calls in order to get full
> information to fill struct stat, which is expensive.  We omit the one to
> learn about the x-bit; it won't make a difference because most people run
> with core.filemode."
> 
> If that is what is going on, I have a few quick questions:
> 
>  (1) How much of "struct stat" information can you get with the easiest
>      and quickest FS API call on Windows?  Does it give you big enough
>      subset of what we store in the cache entry to detect modification
>      reliably?

Yes.

>  (2) When you do an equivalent of "chmod +x path" on Windows, does it
>      change one of the fields in your answer to (1)?  In other words, can
>      you detect such a change with the fastest and reliable-enough FS API
>      call?

Unfortunately, no. That's why we have this discussion.

> If answers to both questions are "yes", then I suspect we might be able to
> improve the situation without sacrificing performance too much.
> 
> In the generic part, we use lstat(2) for various purposes:
> 
>  * To learn existence and type of a FS entity, in order to decide if we
>    need to descend into a directory or treat it as a blob;

The fast version does not detect Cygwin's symbolic links, hence, not all
types of FS entity that we are interested in are covered.

>  * To learn the current "status" that can be compared with what is stored
>    in the cache entry, in order to decide if the FS entity hasn't been
>    modified;
> 
>  * To learn the last-modified timestamp, in order to implement the
>    racy-git avoidance logic;
> 
>  * To learn x-bit, so that we can update it in the cache entry, and give
>    the appropriate x-bit to a file that we create (Alex's
>    lstat_for_copy() is about this usage).
> 
> If the first three can be learned with a fast-and-reliable-enough FS API
> call, and the x-bit and perhaps something else that do not fall into the
> first three need a lot more work to figure out, we could split lstat()
> into two.  The result from a "fast" variant of lstat() is used for the
> first three and allow platform implementation of it to be incomplete
> (i.e. the Cygwin "trick" to omit x-bit is OK for that purpose), and add
> another "slow" variant to complement it:

Sorry that I skip your elaboration on this. First, I barely understand
read-cache.c; and second, I have the feeling that this is
over-engineering: It introduces a genericity that we don't need in
practice. We don't need it because Cygwin by default is built with
NO_TRUSTABLE_FILEMODE, and the X-bit is uninteresting in this case anyway
[*]. And there is no other platform that would make use of it. Not even
the MinGW port, because it wouldn't have a "slow" part, either.

[*] Ok, Cygwin's slow part would also recognize symbolic links, but we
haven't heard complaints about the fast lstat() implementation in this
respect. Perhaps because we have an escape door for people who need it
(core.ignorecygwinfstricks=false).

> And if we do not need such an extra "struct gitstat", then there is no
> reason for us to introduce lstat_fast().  We can just use lstat(), keep
> the "fast and incomplete" Cygwin one as lstat(), but insert calls to
> lstat_remainder() at strategic places.  Immediately before copy_file() is
> called in builtin-init-db.c::copy_templates_1() would be one of those
> strategic places.

But that wouldn't be different in principle from Alex's patch that
introduced lstat_for_copy(), would it? Since it would be used in exactly
the same strategic places.

-- Hannes
