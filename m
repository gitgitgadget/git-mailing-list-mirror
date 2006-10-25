X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Tue, 24 Oct 2006 17:10:17 -0700
Message-ID: <7vu01tfe6u.fsf@assigned-by-dhcp.cox.net>
References: <451A30E4.50801@freedesktop.org>
	<7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
	<453C96C9.4010005@freedesktop.org>
	<Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
	<453D17B5.6070203@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 00:10:36 +0000 (UTC)
Cc: Josh Triplett <josh@freedesktop.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453D17B5.6070203@freedesktop.org> (Josh Triplett's message of
	"Mon, 23 Oct 2006 12:27:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30017>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWLf-0005NK-QI for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161295AbWJYAKU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 20:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWJYAKU
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:10:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4484 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1161295AbWJYAKS
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:10:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025001018.GYNA16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Tue, 24
 Oct 2006 20:10:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eQA11V00E1kojtg0000000 Tue, 24 Oct 2006
 20:10:01 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josh Triplett <josh@freedesktop.org> writes:

> Linus Torvalds wrote:
>> 
>> And yes, that's done by the core revision parsing code, so when you do
>> 
>> 	git log --full-history --parents -- $project
>> 
>> you do get the rewritten parent output (of course, it's not actually 
>> _simplified_, so you get a fair amount of duplicate parents etc which 
>> you'd still have to simplify and which don't do anything at all).
>> 
>> Without the "--full-history", you get a simplified history, but it's 
>> likely to be _too_ simplified for your use, since it will not only 
>> collapse multiple identical parents, it will also totally _remove_ parents 
>> that don't introduce any new content.
>
> Considering that git-split does exactly that (remove parents that don't
> introduce new content, assuming they changed things outside the
> subtree), that might actually work for us.  I just checked, and the
> output of "git log --parents -- $project" on one of my repositories
> seems to show the same sequence of commits as git log --parents on the
> head commit printed by git-split $project (apart from the rewritten
> sha1s), including elimination of irrelevant merges.

So one potential action item that came out from this discussion
for me is to either modify --pretty=raw (or add --pretty=rawish)
that gives the rewritten parents instead of real parents?  With
that, you can drop the code to simplify ancestry by hand in your
loop, and also you do not have to do the grafts inforamation
yourself either?

If that is the case I'd be very happy.

The only thing left for us to decide is if reporting the true
parenthood like the current --pretty=raw makes sense (if so we
need to keep it and introduce --pretty=rawfish).

The only in-tree user of --pretty=raw seems to be git-svn but it
only looks at path-unlimited log/rev-list from one given commit,
so the only difference between dumping what is recorded in the
commit object and listing what parents we _think_ the commit has
is what we read from grafts.  I think we are safe to just "fix"
the behaviour of --pretty=raw

Comments?
