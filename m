From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 10:05:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
 <20070710062104.GA22603@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8JA9-0001jk-VI
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbXGJRGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbXGJRGG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:06:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34272 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754745AbXGJRGE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 13:06:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6AH5xC6003893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2007 10:06:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6AH5rDj016154;
	Tue, 10 Jul 2007 10:05:53 -0700
In-Reply-To: <20070710062104.GA22603@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-2.634 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52095>



On Tue, 10 Jul 2007, martin f krafft wrote:
> 
> also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.07.10.0435 +0200]:
> > I really _think_ that what you want is to just use separate
> > branches, if I understand correctly. That makes it really easy to
> > just have both lines of development (both the "trunk" and your
> > "debian" one) in one git repository.
> 
> It does mean, however, that I duplicate the upstream into my repo,
> and thus into the published repo at git.debian.org, because I cannot
> just publish a single branch ('debian') in such a way that people
> could clone it and still be able to build the package against
> upstream (which they'd have to obtain for themselves), right?

Well, I think you have two cases:

 - the git users

   These would get both branches (including all of the upstream, of 
   course), but that's ok, since git will share all the common objects 
   *anyway*, so there is no "duplication". You can have a hundred 
   branches, and they won't use one whit more memory of bandwidth (apart 
   from the branch refs themselves being sent over, of course), and only 
   the actual *differences* between branches will take up space.

 - the non-git users

   Here, I don't really know how the debian package management is supposed 
   to work, but since they obviously aren't using git, they must be using 
   something else. A tar-ball or just a series of patches? Both would be 
   trivial to implement as just an "export" from your git tree. Or you'd 
   export the "debian" branch as a separate SVN repo (I've not used the 
   "export back into a SVN" thing, so I don't know how well that works).

In particular, if all your "debian-specific" stuff is almost all in the 
"debian" subdirectory, then you can trivially make a tar-file by just 
using

	git archive --prefix=upstream- HEAD debian > upstream-debian.tar

and git will literally generate the tar-file of that directory for you.

> The way I tend to think about a pair of branches is that one depends
> on the other, or rather, one stems from the other.

.. and no, that's not really how git works from a technical angle: in the 
the git model, all branches are technically 100% equal, and no branch 
"depends" on anything else, they are all equally first-class citizens.

But while *technically* all branches are equal in git, at the same time 
there's no reason not to _think_ of branches as having a hierarchy if you 
want to. In particular:

 - it's how people tend to use git anyway (ie the "origin" branch is 
   what you're tracking, and you have your own changes in your local 
   branches)

 - and git will never duplicate information for branches that have a 
   common history or contents anyway. So while git branches are totally 
   "independent" in the technical sense, the data structures are all 
   designed so that they will share everything that they can possibly 
   share (in fact, thanks to the "delta-against-anything" model, different 
   branches will share much more than in something like CVS/SVN)

> So if I made changes to the debian branch, I'd check it out first,
> then return to the upstream branch when done.

It sounds like you would actually be fairly comfy with the git "switch 
branches within one repository" model, and you might not even need to make 
it look like two different trees.

> Okay, this is beginning to make sense. However, the debian branch
> tracks changes mostly to ./debian/*. To check it out separately,
> I need a directory. If usptream is checked out to ., then if I'd
> check out the debian branch do ./debian, I'd end up with
> ./debian/debian. Do you suggest the use of a symlink then?

No, I'm suggesting that you have the upstream thing checked out in ".", 
and you have the "debian" branch IN THE SAME PLACE. So when you do

	git checkout debian

it will just check out all the debian stuff in the same directory, so now 
you'll get a ./debian/ directory with all your debian stuff.

When you do

	git checkout upstream

the files in that directory just go away, because it doesn't exist in 
the "upstream" branch

But I don't want to fool you - I do think you'll have to change *some* of 
how you work. But it sounds like your workflow is *fairly* close to a very 
natural git flow.

		Linus
