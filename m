From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 13:58:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702101347350.8424@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <eqldhe$h7i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 22:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG0Fd-0008Dy-S4
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 22:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbXBJV7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 16:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbXBJV7F
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 16:59:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59096 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbXBJV7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 16:59:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1ALx0UI026819
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 13:59:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1ALwxEe022643;
	Sat, 10 Feb 2007 13:59:00 -0800
In-Reply-To: <eqldhe$h7i$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39261>



On Sat, 10 Feb 2007, Jakub Narebski wrote:
> 
> One of the solutions, used in git.git repository, is to put public key
> as a out-of-tree blob using git-hash-object, then tag it using singed tag
> with instruction about how to extract key in the tag message (tag comment).

No. That's horrible. Yes, it's what Junio did, but if you don't trust the 
archive, the _last_ thing you should do is to depend on a blob in the 
archive itself to contain the thing to make you trust it more.

So you want to get the gpg public key from somewhere else to be able to 
_independently_ verify that it's ok.

Otherwise, somebody could just totally replace the object with one of 
their own, and then _claim_ that the public key they made is 
"junio-gpg-pub", and fool people into thinkign it's signed by Junio.

So to get a valid chain of trust, you really have to have some sideband 
channel to get you started. There's a lot of infrastructure for that 
elsewhere (ie the whole "sign other peoples keys" thing that is so central 
to pgp), but even if you don't have a key to start with, you're actually 
better off getting a key (even with no other validation) from an 
independent source than have it be in the repository itself. Because at 
least then any attacker has to fake _two_ things, rather than just a 
single repo.

Of course, in *practice* this is not a problem. And, in fact, thanks to 
git's SHA1 setup, you obviously don't have to really verify the key itself 
in git, you really only want to verify that yes, the object name is 
correct (ie if you get some sideband information from Junio that the 
"object 0246401b5d117e01717149c413aa2f8702a83d4f" really is Junio's key, 
that's sufficient in itself).

(The "sideband channel" can be something as simple as google. For example, 
if you just google for the SHA1 of the tag itself, you'll actually get a 
lot of hits for it - a0e7d36193b96f552073558acf5fcc1f10528917 (which is 
not the key itself, but it is the tag that points to it, which in turn is 
signed with the key) shows up in manyplaces, and that very fact in itself 
is "interesting" as a sideband information. It's not "proof", but it's 
certainly one piece of information that may make you more comfortable with 
that tag not being something recent and fake - it's been around and been 
quoted by me in email archives, so if it's faked, it's fooled a number of 
people).

		Linus
