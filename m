From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v3] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 22:44:59 -0800
Message-ID: <35C5BEA0-0D6C-4D2E-85E7-1B78FB0BEADA@midwinter.com>
References: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com> <20071128221403.GA3256@midwinter.com> <20071128230355.GB13964@coredump.intra.peff.net> <7vve7m0wfo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 07:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixd9Q-0005QG-8j
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 07:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXK2GpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 01:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbXK2GpF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 01:45:05 -0500
Received: from tater.midwinter.com ([216.32.86.90]:32924 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751277AbXK2GpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 01:45:03 -0500
Received: (qmail 1734 invoked from network); 29 Nov 2007 06:45:01 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=bP/f06QJF9/xbY4Upzs7oE0eDeWhXJ2IkL1H3Jnuu4SKXx+J0NYxpSuxy4eMXhaz  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 29 Nov 2007 06:45:01 -0000
In-Reply-To: <7vve7m0wfo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66506>

On Nov 28, 2007, at 3:42 PM, Junio C Hamano wrote:
> I do not think reporting back the rewritten object name makes much  
> sense
> nor adds any value; it won't be useful information until you fetch the
> object.

Right, this was mostly in anticipation of doing an automatic fetch, so  
that I would avoid fetching anything but the rewritten revisions; if I  
just fetched the remote ref as normal, then I'd potentially pick up  
unrelated changes that happened to hit just after my pack was  
accepted, which wouldn't maintain the "update the tracking ref to  
point to what I just pushed" semantics.

Since it sounds like that's a nonstarter, I agree this part of the  
patch isn't useful.

> I do not think reporting back _anything_ other than "ok" adds much  
> value
> at all.  Sure, if the update hook did something funky you would get  
> such
> a report, but the situation is not any different if some warm body is
> sitting on the other end and building on top of what you pushed
> immediately he sees any push into the repository, and in such a case
> your git-push would not get any such reporting anyway.

I disagree that it's the same. In this case the updated ref happens as  
a component of the push operation (which of course includes running  
update hooks and at the very least looking at their exit codes to see  
if a change should be rejected), not as a result of some other process  
that happens to occur at nearly the same time. Reporting back the new  
ref, at the very least, tells you that it's not useful to update the  
tracking ref since it's 100% guaranteed to be wrong by the time the  
push finishes.

> We do not even have to worry about this reporting at all if we do not
> allow munging the refs in the update hook.  In a sense, this patch is
> creating a problem that does not need to be solved.  Perhaps modifying
> update hook to allow so makes it possible to munge refs while  
> holding a
> lock, but is it really worth this hassle?  Isn't there a better way, I
> wonder?

If there is, I'm happy to hear it; for me this patch is a means, not  
an end. What I actually want is to be able to have a particular set of  
branches in a particular git repository be as-transparent-as-possible  
conduits to corresponding branches in an svn repository.

I arrived at this approach by following this train of thought:

1. The update hook is the only hook that allows me to reject the push,  
which I need to do if svn refuses to accept the change.
2. To tell whether svn accepts a change, I need to run git-svn  
dcommit; thanks to #1, I need to do that from inside the update hook.
3. When I commit, git-svn needs to track that the git revision now  
corresponds to an svn revision. It does that by modifying the commit  
message to add its git-svn-id: line.
4. Modifying the commit comment causes the revision's SHA1 to change.
5. Out-of-the-box push thinks a push has failed if the ref's SHA1  
changes in the update hook.
6. Therefore push needs to be modified to not do that.

If any one of #1-5 wasn't true or was solvable in a different way,  
then #6 wouldn't be needed. For example, if git-svn kept its mapping  
of git revisions to svn revisions somewhere else it could leave the  
commit messages untouched, meaning the SHA1s wouldn't change.

-Steve
