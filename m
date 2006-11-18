X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 17:11:34 -0800
Message-ID: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
References: <20061117182157.GC11882@fieldses.org>
	<20061118001355.23488.qmail@science.horizon.com>
	<7virhdh9j8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 01:11:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7virhdh9j8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 17 Nov 2006 16:40:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31745>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlEk7-0001Ww-KE for gcvg-git@gmane.org; Sat, 18 Nov
 2006 02:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753568AbWKRBLg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbWKRBLg
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 20:11:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44269 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1753568AbWKRBLf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 20:11:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118011135.YOWD9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 20:11:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o1Bh1V00z1kojtg0000000; Fri, 17 Nov 2006
 20:11:42 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> (Are there any octopus merges in git's history?  If not, could I ask
>> for one for pedagogical value?)
>
> git.git itself is full of them, but the very first octopus (it
> actually is a pentapus) is rather nice to watch in gitk:
>
> 	211232bae64bcc60bbf5d1b5e5b2344c22ed767e

Having said that, I think it is not a good idea to talk about
octopus in introductory documents.  The 'feature' may be unique
to git and some people might even find it cool, but new people
should not be encouraged to use it until they understand the
ramifications.

The first ever octopus merge was just a bundle of five forked
development branches, each of which had only one commit since it
forked from the common parent.

           .-a-.  
          .--b--.
         O---c---X
          '--d--'
           '-e-' 

They were independent, un-overlapping changes.  "diff-tree -c"
would not show anything, and there was no inherent reason that
one change should come before the others, so in that sense,
presenting this as an octopus was making the history more
truthful than pretending one happened before another.

But octopus has a negative effect on bisecting performance.
Suppose commit X was bad and commit O was good.  Because X
bundles five branches into one, and we know one of them
(hopefully) is what introduced the regression, our task is to
find the guilty one commit among five commits.  But in order to
do so, we would end up having to test four commits.  That is,
knowing that a, b and c are Ok does not give us any useful
information to determine which of d or e is the bad one (after
learning that a, b and c are Ok, we still need to test d and if
it turns out to be Ok then we can finally say e is the bad one).

If I did not do an octopus and laid out the commit ancestry
graph this way when I gave them to Linus:

    O--a--b--c--d--e--X

the same bisect would have asked us check c first.  If it is
good, then we do not even have to test a or b.  The linear part
of the history is what bisect takes advantage of to cut the
search space efficiently, and an octopus actively defeats that.

So doing an octopus is a wrong thing to do, if there is a
possibility that something wrong is found later.  So people
should not do an octopus unless the component changes are all
truely trivial.

If you want an esoteric topic for an introductory documentation,
it would be more useful to talk about evil merges (an evil merge
is a merge commit whose result does not match any of its
parents).  A good example is found in

	git show v1.0.0
