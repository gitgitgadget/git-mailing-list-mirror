From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 16:42:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031632400.26698@ppc970.osdl.org>
References: <1115145234.21105.111.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
 <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
 <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org> <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
 <42780185.7010204@zytor.com> <7v1x8nuchr.fsf@assigned-by-dhcp.cox.net>
 <427806CA.6030302@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:34:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6ty-0001wo-2V
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVECXkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVECXkU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:40:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:64719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261921AbVECXkL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:40:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43Ne0s4032754
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 16:40:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43NdxhZ025553;
	Tue, 3 May 2005 16:39:59 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427806CA.6030302@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, H. Peter Anvin wrote:
> 
> No, the tree object *ALREADY* records these.

Not ownership.

Yes, the permissions are there, but if you actually want to track 
ownership (or things like "mtime" etc), you really do have to track it 
outside the tree object.

Also, right now git will actually ignore most of the permission bits too.  
We can change that, and make it a dynamic setting somewhere (some flag in
a ".git/settings" file or something), but it does boil down to the fact
that a software development tree tracker wants different things than
something that tracks system settings.

For example, generating different trees just because different users had
different umask settings clearly didn't work out. Which means that right
now git really only tracks the "owner execute" bit of the permissions, and
always resets the other bits to 0755 or 0644 depending on that _one_ bit.

And similarly, tracking actual uid/gid information would _really_ not work 
for a distributed kernel source management system, so that's not even in 
the tree.

So if you want to track system files, right now "raw git" is _not_ the way 
to do it. You'd want something else. 

Of course, that's actually true largely even of normal /dev contents.  
That's why we've moved towards udev, and having things like device
permissions and ownership not be "filesystem attributes", but really
_rules_ in a udev database. So the fact that git doesn't track them isn't
necessarily a problem for /dev - since modern /dev really wants to track
them at a higher level _anyway_ (and you'd use git to track the _rules_,
not the ownership things themselves).

But if you'd want to track other system directories with git, you'd
probably need to either (a) do serious surgery on git itself, or (probably
preferable) by (b) track the extra things you want "manually" using a file
(that is tracked in git) that describes the ownership and permission data.

Whether git is really suitable for tracking non-source projects is
obviously debatable. It's not what it was designed for, and it _may_ be 
able to do so partly just by luck.

			Linus
