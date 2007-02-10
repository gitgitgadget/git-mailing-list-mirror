From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 09:56:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 10 18:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFwSk-00034u-Um
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 18:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbXBJR4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 12:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXBJR4g
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 12:56:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53438 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbXBJR4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 12:56:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1AHuRUI020064
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 09:56:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1AHuPFR018155;
	Sat, 10 Feb 2007 09:56:26 -0800
In-Reply-To: <20070210142322.GB25607@thunk.org>
X-Spam-Status: No, hits=-0.434 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39247>



On Sat, 10 Feb 2007, Theodore Tso wrote:
> 
> This brings up another question which I've been looking for, but for
> which I haven't found a good answer in the git documentation.  A
> google search shows a suggestion by hpa (and a brief discussion from
> sct) about how to handle conflicting tags back in 2005, but as far as
> I can tell it didn't go anywhere.

I don't think we've ever had a conflicting tag.

> 1) Suppose I do a "git tag" of a release, and then realize that I
> messed up, and I need to do some additional release work (i.e.,
> editing a debian changelog file, etc.) before really doing another
> release, what do I do to tag a later revision as the "real" version
> v1.2?

Well, if you never pushed anything out, just re-tag it. Use "-f" to 
replace the old one. And you're done.

But if you have pushed things out (or others could just read your 
repository directly), then others will have already seen the old tag. In 
that case you can do one of two things:

 - The sane thing.

   Just admit you screwed up, and use a different name. Others have 
   already seen one tag-name, and if you keep the same name, you may be in 
   the situation that two people both have "version X", but they actually 
   have _different_ "X"'s.

   So just call it "X.1" and be done with it. 

 - The insane thing.

   You really want to call the new version "X" too, _even_though_ others 
   have already seen the old one. So just use "git tag -f" again, as if 
   you hadn't already published the old one.

   HOWEVER!

   Git does *not* (and in my very very strong opinion, MUST NOT!) change 
   tags behind users back. So if somebody already got the old tag, doing a 
   "git pull" on your tree shouldn't just make them overwrite the old one. 

And I really think that git does the right thing. If somebody got a 
release tag from you, you cannot just change the tag for them by updating 
your own one. I think this is a BIG security issue, in that people MUST be 
able to trust their tag-names. If I got a particular tag, NO WAY IN HELL 
must git just replace it for me because you happened to have a newer one!

So if you really want to do the insane thing, you need to just fess up to 
it, and tell people that you messed up. You can do that by making a very 
public announcement saying

  "Ok, I messed up, and I pushed out an earlier version tagged as X. I 
   then fixed somethign, and retagged the *fixed* tree as X again.

   If you got the wrong tag, and want the new one, you'll have to delete 
   the old one and fetch the new one:

	git tag -d X
	git fetch origin X

   to get my updated tag.

   You can test which tag you have by doing

	git rev-parse X

   which should return 0123456789abcdef.. if you have the new version".

Does this seem a bit complicated? HELL YES. But it *should* be. There is 
no way in hell that it would be correct to just "fix" it behind peoples 
backs. People need to know that their tags might have been changed.

> 3) The git-tag man page talks about GPG signing tags, but it doesn't
> talk about how a GPG-signed tag is validated.  Does this happen
> manually or automatically?

Use "git verify-tag X" to see something like this:

	[torvalds@woody linux]$ git-verify-tag v2.6.17
	gpg: Signature made Sat 17 Jun 2006 06:49:59 PM PDT using DSA key ID 76E21CBB
	gpg: Good signature from "Linus Torvalds (tag signing key) <torvalds@osdl.org>"

but you obviously need to have the public key in question available to 
you.

We could verify tags automatically, of course, but the question is, what 
would the policy be? 

(Side note: the 'monotone' people do the trust thing very deep in 
monotone, AND IT IS A COMPLETE DISASTER! I'm surprised they are not only 
continuing with it, they are adding more and more infrastructure exactly 
because once you do it automatically, you need to be able to handle any 
possible policy. It's insane. It's also really sad, because monotone gets 
so many things right. Their security model is just *totally* broken, and 
makes the whole thing be just a steaming pile of shit. Sad. Not that the 
whole C++/boost/STL crap exactly "helps" either, but the security thing 
is probably the more fundamental problem.)

			Linus
