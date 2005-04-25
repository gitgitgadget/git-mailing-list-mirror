From: Paul Jakma <paul@clubi.ie>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 04:03:02 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0504250323040.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.62.0504250212200.14200@sheen.jakma.org> <426C5266.6050200@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 05:01:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPtqJ-0003Rd-Kd
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 05:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVDYDF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 23:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVDYDF2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 23:05:28 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:47245 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262487AbVDYDFF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 23:05:05 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j3P32xiD014015;
	Mon, 25 Apr 2005 04:03:04 +0100
X-X-Sender: paul@sheen.jakma.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <426C5266.6050200@dwheeler.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
X-Virus-Scanned: ClamAV 0.83/851/Mon Apr 25 02:19:30 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, David A. Wheeler wrote:

> Right.  I suggested putting it in the same directory as the 
> objects, so that rsync users get them "for free", but a separate 
> directory has its own advantages & that'd be fine too. In fact, the 
> more I think about it, I think it'd be cleaner to have it separate. 
> You could prepend on top of the signature (if signatures are 
> separate from assertions) WHAT got signed so that the index could 
> be recreated from scratch when desired.

Well, i'm trying to play with git right now to see what would fit 
with how it abstracts things.

I think possibly:

- add the 'signature object' to the respository after the signed
   object

So a 'signed commit' turns into the

- tool preparing the commit object,
 	- get the user to sign it
 	- save the detached signature for later
- adding the commit object to the repository
- prepare the signing object and add to repository

The repository head then refers then to signature object, which could 
(handwaving) look something like:

 	Object		Signature
 	Signing 	<object ID, in this case of the commit object>
 	Sign-type 	GPG

 	<signature data>

Tools should then treat signature objects as 'stand ins' for the 
object they are signing (verify the signature - if desired - and then 
just retrieve the 'Signing' object ID and use that further).

I have no working knowledge of git though, other than following this 
list. So I have no idea whether above is at all appropriate or 
workable.

> If you mean "the signatures aren't stored with the objects", NO. 
> Please don't! If the signatures are not stored in the database, 
> then over time they'll get lost.

No more lost than anything else in the git 'fs'.

If someone prunes old objects, they'll lose the signed objects along 
with the signatures. If those files weren't replicated anywhere else, 
well they've just blown away history for good, both the history of 
the source and corresponding signatures.

> It's important to me to store the record of trust, as well as what 
> changed, so that ANYONE can later go back and verify that things 
> are as they're supposed to be, or exactly who trusted what.

See above.

> git definitely doesn't have this currently, though you could run 
> the fsck tools which end up creating a lot of the info (but it's 
> then thrown away).

Well, it could be retained then.

> Yes. The problem is that maintaining the index is a pain.

Possibly.

> It's probably worth it for signatures, because the primary use is 
> the other direction ("who signed this?"); it's not clear that the 
> other direction is common for other data.

In CVS it is. If you 'cvs log' a file, you can get a report on which 
revisions of the file belong to which tags (which can be useful 
information sometimes: "ah, so that release had the buggy version" 
type of thing. Or as a sanity check to make sure you got a tag right 
- particularly when you have to move a wrong tag[1]). So, in addition 
to signatures, a general 'referrers of this object' index could be 
useful for reports.

1. This might be just a CVS thing, and not wanted for git -> the 
ability to tag historical revisions and indeed change what tags refer 
to.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Decaffeinated coffee?  Just Say No.
