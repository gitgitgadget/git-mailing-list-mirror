From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 20:18:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609102002300.27779@g5.osdl.org>
References: <20060910190332.17667.qmail@science.horizon.com>
 <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org> <17668.38032.20688.991295@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, jonsmirl@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 05:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMcKJ-0002VX-Sc
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 05:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIKDTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 23:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIKDTB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 23:19:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWIKDTA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 23:19:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8B3IonW005995
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Sep 2006 20:18:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8B3InD2028626;
	Sun, 10 Sep 2006 20:18:50 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.514 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26832>



On Sun, 10 Sep 2006, Linus Torvalds wrote:
> 
> If we did the same pack-file approach that we do for objects, the problem 
> ends up being that _updating_ things is really hard. What we could do (and 
> might work) is that a "git repack" would create a "packed representation 
> of the heads too".

To clarify: I'm _not_ suggesting actually using the "pack-file" 
representation itself for the references.

I'm saying that we could have something like a

	.git/refs-packed

file, which could be (for example) just a plain linear text-file, of the 
form

	19ed368b17abfb9ad5c7467ea74fd8a045d96b43	refs/heads/html
	60a6bf5f53635005f4f68d8b8a33172309193623	refs/heads/maint
	2d32e76f893b2ac432201ce7596c8bab691691e6	refs/heads/man
	a41fae9c46a4cb5e59cc1a17d19f6a3a6cbfbb2f	refs/heads/master
	61af0aaf26e003a61848e551bbd57e78e94eacdc	refs/heads/next
	585729203fef6ade64923277e7151b2e3a4ca330	refs/heads/pu
	997283a8e87179b5b87a909686869d7843c8e19a	refs/heads/todo
	a0e7d36193b96f552073558acf5fcc1f10528917	refs/tags/junio-gpg-pub
	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
	b3e9704ecdf48869f635f0aa99ddfb513f885aff	refs/tags/v0.99.4
	07e38db6a5a03690034d27104401f6c8ea40f1fc	refs/tags/v0.99.5
	f12e22d4c12c3d0263fa681f25c06569f643da0f	refs/tags/v0.99.6
	f8696fcd2abc446a5ccda3e414b731eff2a7e981	refs/tags/v0.99.7
	1094cf40f7029f803421c1dcc971238507c830c5	refs/tags/v0.99.7a
	da30c6c39cd3b048952a15929c5440acfd71b912	refs/tags/v0.99.7b
	9165ec17fde255a1770886189359897dbb541012	refs/tags/v0.99.7c
	02b2acff8bafb6d73c6513469cdda0c6c18c4138	refs/tags/v0.99.7d
	...

ie it would contain just a linear file with the "<hex></tab><refname>"
format.  Then, the way to look up a reference would be:

 - look it up in the traditional loose file
 - if it exists, and contains zeros (or not a hex value), it's considered 
   a "negative entry", and the branch doesn't exist
 - otherwise, if it's a good SHA1, that's the result
 - if it's not there, look it up in the ".git/refs-packed" file by just 
   doing a simple linear scan (trivial, and actually efficient - we're 
   talking about just a few kB of memory after all, and the _cost_ is 
   actually the IO, where "simple linear scan" is actually very good for 
   performance).

The end result would be that we'd probably have very few loose references 
(we'd get them whenever we change a ref, or delete one), making the lookup 
scale better. The big _bulk_ of the references tend to be very stable, 
notably they are tags that seldom - if ever - change, and would thus stay 
just in the packed refs file.

So the normal situation would be that you'd have a few hundred (maybe, for 
a bigger project) refs in the single .git/refs-packed file, totalling a 
few kB of disk-space, and then you might have a handful of "active" heads 
that are in the traditional single-file format .git/refs/<filename> 
because they are beign actively modified and have changed since the last 
repack.

I bet it would work fairly well. But somebody would need to implement it.

The good news is that the refs-handling code tends to be _fairly_ well 
abstracted out, because we already wanted that for the logging thing. So 
we hopefully already don't actually access the loose file objects by hand 
from shell scripts any more - we use git-rev-parse and git-update-ref etc 
to look up refnames, and that all goes back to git/refs.c.

So _most_ of the bulk of it would probably be in refs.c, but there's 
obviously also things like git-branch.sh that needs to be taught the new 
rules about deleting branches etc.

Anybody want to try the above rules out? I bet the _only_ real issue would 
be "for_each_ref()", where it's important to _first_ do the loose objects, 
and remember them all, so that you do _not_ show the refs that are in the 
.git/refs-packed file and already got shown because they were loose.

NOTE! It's important that whatever sceme used gets locking right. The 
above suggestion gets it right simply because it doesn't really _change_ 
anything. Any new or modified ref ends up using the old code, and using a 
".lock" file and renaming it automatically does the same thing it ever 
did.

		Linus
