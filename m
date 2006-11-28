X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 11:58:26 -0800
Message-ID: <456C94E2.6010708@midwinter.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281029.11918.andyparkins@gmail.com> <ekh45n$rfc$1@sea.gmane.org> <200611281335.38728.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 19:59:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dK6Dh8U/qvi6TAIQJUaI95gafBQTVSC+a5hUcQuH5qfigbSvHTQWmgnvntBhvdpo  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <200611281335.38728.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32570>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp96l-0005wS-EW for gcvg-git@gmane.org; Tue, 28 Nov
 2006 20:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936078AbWK1T6m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 14:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936000AbWK1T6m
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 14:58:42 -0500
Received: from tater.midwinter.com ([216.32.86.90]:16003 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S936078AbWK1T62 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 14:58:28 -0500
Received: (qmail 28211 invoked from network); 28 Nov 2006 19:58:28 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 28 Nov 2006 19:58:28 -0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Unfortunately, during development, you've switched libsubmodule1 to 
> branch "development", but supermodule isn't tracking libsubmodule1/HEAD it's 
> tracking libsubmodule1/master.  Your supermodule commit doesn't capture a 
> snapshot of the tree you're using.
>   

How about if the supermodule commit errors out by default if you commit 
a different submodule branch than the one you committed the previous 
time? Require the user to explicitly acknowledge that yes, they want to 
check in the contents of "development" now, even though the supermodule 
was tracking "master" before.

Otherwise I think you could easily end up with just the opposite 
situation, where you forget you've checked out "development" for a 
moment to look at something, and end up inadvertently committing a bunch 
of stuff that's not ready for prime time yet. In a standalone git 
setting, that's no big deal since the commit only updates the current 
branch and doesn't touch the master branch, but (as I understand the 
proposal) in a supermodule setting you'd actually end up essentially 
doing a merge between your development branch and the previously 
committed master. Or maybe not a merge, but worse, you'd *replace* the 
previously committed master with what's in your dev branch.

I think wanting to commit a submodule on a different branch than last 
time is probably not a typical day-to-day use case, so we should make 
sure the user really wants to do it (but allow it if so.)

On a related note, it would be great from a usability point of view if 
there were a way to say "I always want to be on the same branch in all 
submodules and the supermodule." I think a common scenario will be that 
you are doing development that touches a couple of different 
applications and your development effort is really a single set of 
changes even though it happens to cross submodule boundaries. If this 
branches-in-sync option is turned on, I'd want "git checkout 
development" to check out the development branch in the entire set of 
repositories.

More generally, while I 100% agree that it's very useful to be able to 
operate independently on each submodule, I think it's also going to be 
common to use submodules to selectively clone different pieces of a 
larger project. Say your current development effort needs server A, 
library B, and documentation C, and you want to have *just* those pieces 
in your environment. You don't particularly care about the details of 
how the system has assembled the pieces you want; you want to be able to 
make your changes and push them when you're done. They are really just 
pieces of a larger code base, not independent entities that happen to be 
pulled together into a composite workspace temporarily.

For that use case, I don't want the system to act differently depending 
on whether server A and library B are in the same submodule or separate 
ones; I want to treat the supermodule as the repository, and the system 
should take care of the details of managing the submodules. When I do 
"git commit -a" I want it to give me one editor to write one commit 
comment that covers all of the changes I've made, and when I do "git 
checkout -b" I want a new branch to apply across all the files I'm 
working with.

It is entirely possible that the above is a matter best left to the 
porcelain layer, and that's fine with me. But I think the Perforce-style 
"compose a single workspace out of different bits of a larger project" 
model is hugely useful and whatever submodule system Git ends up with, 
it should be able to emulate as much of that feature as possible.

