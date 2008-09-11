From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 14:31:48 +0200
Message-ID: <20080911123148.GA2056@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 14:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdlM1-0001Nx-5Y
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 14:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYIKMbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 08:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYIKMbu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 08:31:50 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:57045 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYIKMbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 08:31:49 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 77C935465; Thu, 11 Sep 2008 14:31:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809111020.55115.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95604>

Jakub Narebski wrote:
>Stephen R. van den Berg wrote:
>[...]
>> Please focus on the semantics and on the *non*-made up use case of
>> development of several stable branches with backports between them.
>> Discussing made-up use cases is wasting energy at this point.

>By the way, I would really consider trying first to host 'origin' links 
>not in repository database itself, but in some extra database inside 
>git repository, like reflog or index.  Git community is _very_ 
>reluctant to modifying / extending format of persistent objects.  From 

Rightfully so, of course.

>So I think you should go the route of externally (outside 'commit' 
>objects) maintaing 'origin'/'changeset'/'cset' links (like XLink 
>extended links ;-)) as a prototype to examine consequences of the idea. 
>That was the way _submodule_ support was added to Git, by the way.  
>First there were (at least) two implementations maintaining submodules 
>outside object database (see http://git.or.cz/gitwiki/SubprojectSupport
>especially "References" section), then it was officially added first at 
>the level of plumbing support, as extension of a 'tree' object (and 
>index format, I think).

Well, the train of thought here goes as follows:
1. Sure, why not add a field (zero or more) at the bottom of the free-form
   commit message reading like:

   Origin: bbb896d8e10f736bfda8f587c0009c358c9a8599 ee837244df2e2e4e9171f508f83f353730db9e53

2. Add support to cherry-pick/revert to actually generate the field upon
   demand.

3. Then add support to prune/gc/fsck/blame/log --graph to take the field
   into account.

4. Add support to filter-branch/rebase to renumber the field if necessary.

5. Add support to --topo-order to use the field if present and reachable.

6. For bonus points: add support to log to suppress the display of the
   field at the end of the commit message, and redisplay the field
   as Origin: bbb896d..ee83724
   next to the Parent/Merge fields.

Well, and after having done steps 1 to 5, the net result is that it
works almost as if the field is present in the header, except that:
- It is now at the end of the body in the commit message.
- It takes more time to find and parse it.

So that gives two minuses, and no pluses.
So short-circuiting the reasoning suggests that since the only thing
that actually changes now is the position of the field (at the top or
end of the commit message), we might as well do it right and put it in
the top, that gets rid of the two minuses.

Anything I missed?

Basically it means that:

a. If there is a better solution to tracking the backports, I'll gladly
   use that instead, but simply using the current really freeform
   approach doesn't cut it (it currently refers to a single commit,
   instead of a pair of commits, and takes too long to parse out in a
   --top-order or blame command).  Better solutions I haven't heard so
   far.

b. I need the integrity protection of a commit to make sure that the
   origin fields cannot be altered later; blame would be too easy to fool
   otherwise.  So using the notes solution seems to be out (it would also
   be quite a performance hit again).

c. I consider the Origin: field at the end of the commit message a
   workable solution, but it smells like X-header-extension-messes as in
   E-mail headers, and it incurs a small performance hit (in case of
   --topo-order/blame/prune/fsck), but maybe this performance hit can be
   minimised by making sure that the fields are *always* at the end
   of the commit message.

d. Using the proposed origin header in the standard commit header has
   close to zero overhead (in most commits the field is not present), yet
   codecomplexitywise it is almost identical with the Origin: field at
   the end of the commit message.

I find it remarkable though that people are dragging their feet at
solution d, yet are quite ok with solution c.  IMO solution c and d are
almost identical, except that solution c is ugly, and solution d is
elegant.  But if it makes it easier to prove the usefulness by
implementing the ugly solution first, that's fine.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
