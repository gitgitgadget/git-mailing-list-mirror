From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit / jgit] Implementation of a file tree iteration using ignore rules.
Date: Sat, 10 May 2008 20:12:31 -0400
Message-ID: <20080511001231.GI29038@spearce.org>
References: <48244F88.8060109@web.de> <20080510001132.GF29038@spearce.org> <4825BB3F.4060006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Sun May 11 02:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuzBt-00017N-51
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 02:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYEKAMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 20:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYEKAMg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 20:12:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34712 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYEKAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 20:12:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuzAs-0002H7-Qk; Sat, 10 May 2008 20:12:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5685520FBAE; Sat, 10 May 2008 20:12:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4825BB3F.4060006@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81718>

Florian Kberle <FloriansKarten@web.de> wrote:
> | This is an interesting start.  Did you see the existing "Main" class
> | in org.spearce.jgit/src/org/spearce/jgit/pgm?  It sets up and invokes
> | a TextBuiltin, which is sort of like the "Command" class you added in
> | your first patch.  Though TextBuiltins are created on-the-fly and thus
> | are harder/impossible to use to format a "jgit help".
>
> I noticed that the class appeared after a rebase, but didn't have a
> closer look to it yet.

I guess you started working on an older version, only to later find
out that I had also done a lot of work in the mean-time.  :-)

My jgit contributions come in huge bursts.  RevWalk/TreeWalk was one
back in March; the transport API (almost 10,000 lines of code itself)
is the most recent from late April/early May.  Once its fully into
the mainline I'll probably have to slow down for a couple of months.
I have to move in July and have a lot of things to do between now
and then.
 
> | Please note that jgit is restricted to Java 5 APIs only right now.
> | The "MainProgram" class you introduced uses Arrays.copyOfRange()
> | which does not compile under Java 5.  I guess it is new in Java 6?
>
> Yes it is new in Java 6. A patch fixing this is contained in the patch
> set I send to the mailing list.

To keep the history bisectable as much as possible it is better
if you use `git rebase -i` to squash these two changes together,
so that we never introduce the Java 6 usage into the codebase.

> I had a look at the WorkingTreeIterator and it seems to me that it is
> possible to reuse my Rules class there.
> 
> We could simply give the iterator a member variable of type Rule.
> 
> The method loadEntries of WorkingTreeIterator could then use the rules
> class to filter out unwanted files and directories.

Yea, that sounds right.
 
> Also note that my Rules implementation would ignore the directory a in
> the case of "/a\n!/a/b.txt". This means that a directory may not appear
> in the list entries, but must be used to create another iterator.

Ouch.  I forgot about that fun corner case.  In the context of a
TreeWalk directory "a" must actually still be reported as an entry so
that the TreeWalk main loop knows to enter into the subtree iterator.
However the subtree iterator needs to only have entry "b.txt" within
its entry list.
 
> I suggest to put all the classes from the package
> org.spearce.jgit.treewalk and the package
> org.spearce.jgit.lib.fileiteration into one package. Please tell me
> which package and I will send a patch, or do it yourself. I don't have
> any outstanding changes.

The treewalk package is already established so I would say add
them there.  Since you are the original developer and your code is
not yet in mainline I would ask that you perform the renames.

> I don't see a easy way of porting my Rules implementation to the
> TreeFilter framework, but as you may noticed it is may not necessary to
> do so.

The TreeFilter framework is perhaps not the right API for ignore
rules, that is likely true.  It also works with paths as byte[] and
not as String, because we get byte[] (generally UTF-8 encoded) data
from canonical tree objects when reading from the object database.
Avoiding the conversion for most entries is a huge performance
improvement for us.

I still won't give up my silly dream for `jgit log -- 'foo/*.c'`,
but maybe we do need two different implementations to make things
work out well.

-- 
Shawn.
