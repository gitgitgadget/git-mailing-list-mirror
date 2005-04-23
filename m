From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 10:31:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>  <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com>  <426A4669.7080500@ppp0.net> 
 <1114266083.3419.40.camel@localhost.localdomain>  <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 19:25:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPONf-0005bd-Lr
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 19:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVDWR3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVDWR3w
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 13:29:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:36487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261627AbVDWR3n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 13:29:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NHTUs4022273
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 10:29:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NHTTo8009448;
	Sat, 23 Apr 2005 10:29:29 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114266907.3419.43.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, David Woodhouse wrote:
> 
> Nah, asking Linus to tag his releases is the most comfortable way.
> 
> mkdir .git/tags
> echo 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 > .git/tags/2.6.12-rc2
> echo a2755a80f40e5794ddc20e00f781af9d6320fafb > .git/tags/2.6.12-rc3

The reason I've not done tags yet is that I haven't decided how to do 
them.

The git-pasky "just remember the tag name" approach certainly works, but I 
was literally thinking o fsetting up some signing system, so that a tag 
doesn't just say "commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 is 
v2.6.12-rc2", but it would actually give stronger guarantees, ie it would 
say "Linus says that commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 is 
his 2.6.12-rc2 release".

That's something fundamentally more powerful, and it's also something that 
I actually can integrate better into git.

In other words, I actually want to create "tag objects", the same way we 
have "commit objects". A tag object points to a commit object, but in 
addition it contains the tag name _and_ the digital signature of whoever 
created the tag.

Then you just distribute these tag objects along with all the other
objects, and fsck-cache can pick them up even without any other knowledge,
but normally you'd actually point to them some other way too, ie you could 
have the ".git/tags/xxx" files have the pointers, but now they are 
_validated_ pointers.

That was my plan, at least. But I haven't set up any signature generation
thing, and this really isn't my area of expertise any more. But my _plan_ 
literally was to have the tag object look a lot like a commit object, but 
instead of pointing to the tree and the commit parents, it would point to 
the commit you are tagging. Somehting like

	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
	tag v2.6.12-rc3
	signer Linus Torvalds

	This is my official original 2.6.12-rc2 release

	-----BEGIN PGP SIGNATURE-----
	....
	-----END PGP SIGNATURE-----

with a few fixed headers and then a place for free-form commentary, 
everything signed by the key (and then it ends up being encapsulated as an 
object with the object type "tag", and SHA1-csummed and compressed, ie it 
ends up being just another object as far as git is concerned, but now it's 
an object that tells you about _trust_)

(The "signer" field is just a way to easily figure out which public key to
check the signature against, so that you don't have to try them all. Or
something. My point being that I know what I want, but because I normally 
don't actually ever _use_ PGP etc, I don't know the scripts to create 
these, so I've been punting on it all).

If somebody writes a script to generate the above kind of thing (and tells 
me how to validate it), I'll do the rest, and start tagging things 
properly. Oh, and make sure the above sounds sane (ie if somebody has a 
better idea for how to more easily identify how to find the public key to 
check against, please speak up).

			Linus
