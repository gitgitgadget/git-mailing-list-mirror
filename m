From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 23:08:51 -0400
Message-ID: <426C5F43.8010705@dwheeler.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>       <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>       <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>       <20050423175422.GA7100@cip.informatik.uni-erlangen.de>       <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1> <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com> <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jakma <paul@clubi.ie>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 05:02:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPtrT-0003Wt-HF
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 05:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVDYDHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 23:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVDYDHF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 23:07:05 -0400
Received: from aibo.runbox.com ([193.71.199.94]:35243 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262494AbVDYDGl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 23:06:41 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPtvf-0006Ha-DZ; Mon, 25 Apr 2005 05:06:35 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPtve-0006eG-Dw; Mon, 25 Apr 2005 05:06:35 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 24 Apr 2005, David A. Wheeler wrote:
> 
>>It may be better to have them as simple detached signatures, which are
>>completely separate files (see gpg --detached).
> 
> Actually, if we do totally separate files, then the detached thing is ok, 
> and we migth decide to not call the objects at all, since that seems to be 
> unnecessarily complex.
> 
> Maybe we'll just have signed tags by doing exactly that: just a collection 
> of detached signature files. The question becomes one of how to name such 
> things in a distributed tree. That is the thing that using an object for 
> them would have solved very naturally.

I agree, naming signatures using the same way other objects are named
would be very clean.  So, why not? It's perfectly reasonable to
just store detached signatures as hashed objects, just like the rest;
just create a new object type ("signature").
If 3 different keys are used to sign the same object, the detached
signatures will have different hash values, so they'll get named easily.

Now you just have to FIND the signature of a signed object,
i.e. efficiently go the "other way" from signed object to detached
signature.  A separate directory with this mapping, or embedding the
mapping inside the object directory (HASH.d/<list>) both solve it.

The more I think about it, the more I think a separate "reverse"
index directory would be a better idea. It just needs to from
"me" to "who references me", at least so that you can quickly
find all signatures of a given object. If the reverse directory
gets wonky, anyone can just delete the reverse index directory
at any time & reconstruct it by iterating the objects.
Before "-----BEGIN PGP SIGNATURE-----" you should add:
  signatureof HASHVALUE
to make reconstruction easy; PGP processors ignore stuff
before "-----".  The PGP data does include a hash, but it's not
easy to get it out (I don't see a way to do it in gpg from the
command line), and it's quite possible that a signer won't
use SHA-1 when they sign something (they may not even
realize it; it depends on their implementation's configuration).
Better to include something about what was signed with the signature.

Hmm, probably worth backtracking to see what's needed.
There needs to be a way to identify tags, and a way to sign that
tag so that you can decide to trust some tags & not others.
There needs to be a way to sign commits, and store that info
for later.  And really, these are special cases of general
assertions about other things; you might want someone to be
able to make other signed assertions (e.g., that it
passed test suite XYZ).

If tags & commits are all you plan to sign for now, well, you
already have commits.  You can just add a "tag" type and a
"signature" type of object (the "signature" is just a detached
OpenPGP signature).  "signature" can sign tag or commit types.
I still like the idea of a more general "assertion" type, esp.
for assertions that something passed a test suite on a certain date
or was reviewed at a certain date by someone, but admittedly
that could be added later in the same manner.

Then you need to be able to quickly find a signature, given a
commit or tag.  A "reverse" directory then does that nicely,
and if you put enough information in front of the signature,
you can regenerate the reverse directory whenever you wish.

--- David A. Wheeler
