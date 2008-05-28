From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 13:43:06 -0700
Message-ID: <7v7idetb1h.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
 <7vskw2tgu2.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805281455100.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 28 22:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1SVI-0002PP-MX
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYE1UnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbYE1UnV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 16:43:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbYE1UnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 16:43:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 375B269B9;
	Wed, 28 May 2008 16:43:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A35669B4; Wed, 28 May 2008 16:43:10 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0805281455100.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 28 May 2008 16:06:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2AB8BC8-2CF6-11DD-A83E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83133>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Ah, yes, CE_VALID. But it doesn't quite work as well as I'd like, because 

No, I do not think we should involve CE_VALID here.  It means something
completely different.  What I meant was that through "git status" the user
can tell there is an unexpected breakage in the work tree, _if_ we make
checkout to finish with "best effort" (and still report an error).

> I think the right test for this is if create_file() returns EEXIST, but 
> readdir doesn't show anything.

I think relying on EEXIST is too specific for this particular breakage,
even though such a test may catch it.  A checkout may fail in the middle
if a filesystem refuses to create a pathname that has certain characters
in it (e.g. dosen't NTFS refuse a path with :|<"?*> in it, or is it just
the Explorer UI layer rejecting them?), or perhaps one leading directory
may be unwritable.  We would want to catch and cope with such a brokage
the same way.

The checkout "unpack-trees" codepath does:

 - Make sure things can be checked out safely with the internal data
   before doing anything to the filesystem, i.e. no lost local changes, no
   lost untracked files, etc.

 - For each path:

   - make room for it, removing directory at the place as necessary where
     a blob must sit and removing an existing blob as needed;

   - create a new file or symlink;

And currently I think we stop on any failure.  The thing is, stopping on a
failure during the internal checking is fine --- no external damage has
been made yet.  But once we started updating the work tree, we _are_
committed and not aborting in the middle for a single failure would be the
saner thing to do.  In addition, even after such a failure after we are
committed, we probably should update the HEAD and the index.

"status" would then show the difference between what should have been
checked out and what is.  It might be enough to improve the issue of "git
bisect hitting a checkout failure --- the work tree is half checked-out
state, and the index, the HEAD, and the work tree are in a very
inconsistent state".

We would probably signal such an error from git-checkout differently from
an early refusal that does not do anything, to tell the callers, such as
"git-bisect", that the checkout _has been_ already done, even though there
may be breakages in the work tree.

> ... that notes the situation where you seem to have file A instead of 
> file B, but fstat("B") returns A's inode, and marks the index to say that 
> entry B is listed in the filesystem as A instead.

I personally do not think such auto-substution is a way to go --- what
makes you trust inode information from such an untrustworthy filesystem
that does not do what it was told to do?  I suspect that stopping at the
error site and not automatically making the damage yet larger by doing
such magic would keep the recovery procedure simpler.

But I wouldn't keep people from experimenting.  Perhaps the end result
could be even readable and mergeable, although I am quite pessimistic.
