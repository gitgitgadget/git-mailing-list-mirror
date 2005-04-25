From: Paul Jakma <paul@clubi.ie>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 04:24:03 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0504250413200.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <426C5F43.8010705@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 05:20:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPu8a-0004pG-0T
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 05:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVDYDYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 23:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVDYDYo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 23:24:44 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:26007 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262501AbVDYDYh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 23:24:37 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j3P3O03P016417;
	Mon, 25 Apr 2005 04:24:04 +0100
X-X-Sender: paul@sheen.jakma.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <426C5F43.8010705@dwheeler.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
X-Virus-Scanned: ClamAV 0.83/851/Mon Apr 25 02:19:30 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, David A. Wheeler wrote:

> Now you just have to FIND the signature of a signed object, i.e. 
> efficiently go the "other way" from signed object to detached 
> signature.  A separate directory with this mapping, or embedding 
> the mapping inside the object directory (HASH.d/<list>) both solve 
> it.

You dont even need it, see my other mail. If:

- the signature is an object and added after the commit object

- tools know that signatures are 'proxies of' or precursors to the
   objects they are signing (which makes sense, a signature by
   definition refers to something else)

- the signature object refers to the object it is signing (eg a
   'Signing <object ID>' header)

Then head can simply be the signature object and tools can find the 
commit by following the 'Signing' field of the signature (they dont 
even need to check the signature is valid). No index lookup needed.

You only need the index for historical verification really, and you 
can always generate an index if needs be. (and have the tools 
maintain it).

> The more I think about it, the more I think a separate "reverse"
> index directory would be a better idea. It just needs to from
> "me" to "who references me", at least so that you can quickly
> find all signatures of a given object. If the reverse directory
> gets wonky, anyone can just delete the reverse index directory
> at any time & reconstruct it by iterating the objects.
> Before "-----BEGIN PGP SIGNATURE-----" you should add:
> signatureof HASHVALUE
> to make reconstruction easy; PGP processors ignore stuff
> before "-----".

Oof, dont do this:

- makes assumptions about the format of the signature
 	- that it is ASCII
 	- that you can change it

Just add a git header which is independent of the signature data.

In lieu of the 'signature object as precursor' approach above, just 
have the tools maintain an index. It can be maintained as objects as 
added, and can always be blown away and recreated by inspection of 
the repository data.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
To doubt everything or to believe everything are two equally convenient
solutions; both dispense with the necessity of reflection.
 		-- H. Poincar'e
