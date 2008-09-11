From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 17:32:02 +0200
Message-ID: <20080911153202.GD2056@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Sep 11 17:33:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoAX-0002go-V4
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYIKPcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbYIKPcH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:32:07 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42583 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYIKPcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:32:06 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A80E25465; Thu, 11 Sep 2008 17:32:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911135146.GE5082@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95610>

Theodore Tso wrote:
>On Thu, Sep 11, 2008 at 02:31:48PM +0200, Stephen R. van den Berg wrote:
>> Well, the train of thought here goes as follows:
>> 2. Add support to cherry-pick/revert to actually generate the field upon
>>    demand.

>"git cherry-pick -x" already generates the field you want.

Well, sort of.  In order for swift parsing it should be a real field,
i.e. it should not be an English sentence (in order to avoid people
accidentally translating it); and it should list a pair of hashes
(patches/changesets are defined by the difference between two tree
snapshots).  So it would be a -o option most likely, in order to provide
backward compatibility to the users of -x.

>> 3. Then add support to prune/gc/fsck/blame/log --graph to take the field
>>    into account.

>Um, why should "git fsck", or "git prune" or "git gc" need to
>understand about this field?  What were you saying about unclean
>semantics, again?  I thought you claimed that dangling origin links
>were OK?  So why the heck should git fsck care?  And why shouldn't
>gc/prune drop objects that are only referenced via the origin link.

Dangling origin links are ok only if the developer in charge of the
repository doesn't care about the commits/branches they point to.
The definition of a "caring developer" is formalised by the fact that
the offending commits are already present in the repository or not.

This implies that fsck will skip the field if the hashes in question are
unreachable in the current repository.
If they are reachable though, fsck will follow the link and check the
whole tree referenced by the origin link.  Obviously there are only two
conditions for an origin link: either the hash points to an unreachable
object or the hash points to a reachable object of type commit (and all
associated checks that go with any commit).

gc will preserve the commits the origin links point to once they are
reachable.  I.e. if the developer doesn't care about the commits the
origin links point to (i.e. if the branches are not reachable) then gc
just skips them, if the developer *does* care, the origin links are used
to keep those objects alive (and, of course, all their parenthood).

>> 4. Add support to filter-branch/rebase to renumber the field if necessary.

>As we discussed earlier in some cases renumbering the field is not the
>right thing to do, especially if the commit in question has already
>been cherry-picked --- and you don't know that.  Again, this is why
>prototyping it outside of the core git is so useful; it will show up
>some of these fundamental flaws in the origin link proposal.

I agree that the behaviour of especially rebase with respect to the
origin links is still something that needs to be thought through.
I'm not convinced you are right, but I'm not convinced you are wrong
either.

>> Well, and after having done steps 1 to 5, the net result is that it
>> works almost as if the field is present in the header, except that:
>> - It is now at the end of the body in the commit message.
>> - It takes more time to find and parse it.

>A proof of concept, even if it isn't fully performant, is useful to
>prove that an idea actually has merit --- which clearly not everyone
>believes at this point.

Quite.

>I'll also note that having a ***local*** database to cache the origin
>link is a great way of short-circuiting the performance difficulties.
>If it works, then it will be a lot easier to convince people that
>perhaps it should be done git-core, and by modifying core git functions.

Creating local databases for these kinds of structures feels kludgy
somehow, since the git hash objects essentially *are* a working
database.  I have not checked yet if git already has some kind of
ready-to-use local database lib inside which I could reuse for that.

>Alternatively, if you think this is such a great idea, why don't you
>grab a copy of the git repository, and start hacking the idea
>yourself?

Actually, in the first hour after posting the initial mail/proposal I
already had altered a local version of git to support the origin links
in commit.[ch], --topo-order and fsck.  Before hacking further I decided
to get some feedback first to see if someone would come up with
something better.  And they did, instead of the mainline number, I
decided that using two hashes is better.  Once the dust has settled,
I'll fill in the rest of the code.

>  If you have running code, it tends to make the idea much
>more concrete, and much easier to evaluate.

Agreed, but then again, most of the programming is done without touching
any code (the design phase), which is where we are now.  Once the design
is scrutinised (as far as possible), the coding can begin (continue).
The feedback so far was very helpful, and caused me to explore (and
dismiss) some of the alternate avenues to achieve the desired
functionality.

>  Or were you hoping to
>convince other people to do all of this programming for you?

I've never needed that so far, and will not need that here either.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
