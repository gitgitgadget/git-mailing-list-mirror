From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Suggestion: generalize signed tags into "assertion objects"
Date: Sat, 23 Apr 2005 15:30:42 -0400
Message-ID: <426AA262.3050501@dwheeler.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>  <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>  <426A4669.7080500@ppp0.net>  <1114266083.3419.40.camel@localhost.localdomain>  <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:24:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQEc-0008BF-Q3
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDWT2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVDWT2u
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:28:50 -0400
Received: from cujo.runbox.com ([193.71.199.138]:39390 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261642AbVDWT2p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:28:45 -0400
Received: from [10.9.9.9] (helo=fetch.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPQIn-0002lO-55; Sat, 23 Apr 2005 21:28:29 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fetch.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPQIm-00038B-MD; Sat, 23 Apr 2005 21:28:29 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> The git-pasky "just remember the tag name" approach certainly works, but I 
> was literally thinking o fsetting up some signing system, so that a tag 
> doesn't just say "commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 is 
> v2.6.12-rc2", but it would actually give stronger guarantees, ie it would 
> say "Linus says that commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 is 
> his 2.6.12-rc2 release".
> 
> That's something fundamentally more powerful, and it's also something that 
> I actually can integrate better into git.
> 
> In other words, I actually want to create "tag objects", the same way we 
> have "commit objects". A tag object points to a commit object, but in 
> addition it contains the tag name _and_ the digital signature of whoever 
> created the tag.

I'm thinking out loud here, but maybe instead of just "tag objects",
how about broadening them into "assertion objects" that include
(1) a claim and (2) a signature.  Monotone, for example,
can do this -- it has a generalized mechanism for signed assertions.

A claim might be that some commit is a tag
("Linus Torvalds says this is tag 2.6.12-rc2") or even "I did this"
("Greg KH really committed this").  You could create the latter objects
when you push (just sign the head commit), and that would make it
really easy to do checks across an entire repository (who said what?).
Currently people can send signed emails that they really DID
commit something, but then that data's not available to everyone else.
Signed assertions about commits would suddenly make it possible for
arbitrary people to detect & counter subverted repositories (if they
have the public key list); fsck-cache could check signatures as it went.

With a more generalized assertion mechanism,
you could make the same assertion multiple times, e.g., if
your key gets captured, you could go back and re-sign with a new key,
simply creating a new assertion object.  You can also make
assertions about multiple objects (e.g., assert some relationship
between far-removed commits).  I'd expect assertion
objects to be stored by their hash, just like any other object.

> Then you just distribute these tag objects along with all the other
> objects, and fsck-cache can pick them up even without any other knowledge,
> but normally you'd actually point to them some other way too, ie you could 
> have the ".git/tags/xxx" files have the pointers, but now they are 
> _validated_ pointers.

Yes, that makes sense.  I think .git/tags/xxx should point to
the assertion objects that claim they are tags; you can then check
if you accept the assertion object's signature when you try to use it
(and locally cache that acceptance once you've checked the signature).

For generalized assertion objects, you need a way to travel FROM
the object(s) being described TO the assertion object.
A simple method might be to create subdirectories with the name
derived from the object(s) being described, and inside the
subdirectory have a set of files that have the hashes of
the assertion objects. E.G., this kind of structure

  00/
    10f32aca7ba78e2cd95dcfedee0e6329edb735      (commit object)
    10f32aca7ba78e2cd95dcfedee0e6329edb735.d/
      1038e8b8e04b287ec876594cbab9df4af09ce131 ->
                        ../../1038e8b8e04b287ec876594cbab9df4af09ce131
  10/
    38e8b8e04b287ec876594cbab9df4af09ce131     (assertion object)


There's no reason you can't point to assertions from
multiple places, which would make them cheap to find when needed.

One problem with symlinks is that some dopey filesystems
don't support them :-(.  In this case, though, if they got copied
multiple times they'd just waste space & not interfere
with meaning, since they'd all be static read-only.
An alternative would be 0-length files whose names are the hashes.

...
>  Somehting like
> 
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
> 
> 	This is my official original 2.6.12-rc2 release
> 
> 	-----BEGIN PGP SIGNATURE-----
> 	....
> 	-----END PGP SIGNATURE-----

--- David A. Wheeler
