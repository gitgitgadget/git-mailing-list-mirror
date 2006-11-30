X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 17:58:15 -0800
Message-ID: <456E3AB7.1030306@midwinter.com>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>	<87bqmswm1e.wl%cworth@cworth.org>	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>	<87ac2cwha4.wl%cworth@cworth.org>	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>	<878xhwwdyj.wl%cworth@cworth.org>	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>	<871wnnwi3k.wl%cworth@cworth.org>	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 01:58:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=APvEIulYE3+RWBc0k7CxAEP37RbEfwzsI1tJqUNmmCuPCOCI1WESOex4p2mZiXOl  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32694>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpbC5-0001AH-GQ for gcvg-git@gmane.org; Thu, 30 Nov
 2006 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758998AbWK3B6R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758997AbWK3B6R
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 20:58:17 -0500
Received: from tater.midwinter.com ([216.32.86.90]:20707 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S1758996AbWK3B6Q (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 20:58:16 -0500
Received: (qmail 30367 invoked from network); 30 Nov 2006 01:58:15 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 30 Nov 2006 01:58:15 -0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Side note.  I think the above "Until..." is an overstatement,
> and maybe the readers of the tutorial can be taught a lot
> earlier how the index can help them.  Maybe the following
> sequence can be added to an early part of the tutorial sequence?
>
>  $ edit hello.c
>  $ make test
>  $ git diff
>  $ git update-index hello.c; # ok, that is good so far.
>  $ edit hello.c; # hack more
>  $ make test; # oops, does not work
>  $ git diff; # ah, that overeager edit broken what was good
>  $ git checkout hello.c; # get the last good one back
>   

That actually points out one of the things I think isn't so hot about 
using update-index for checkpointing your work. Here's a longer 
development session:

$ edit hello.c
$ make test
$ git update-index hello.c; # so far so good
$ edit hello.c
$ make test
$ git update-index hello.c; # looks good too
$ edit hello.c
$ make test
$ git update-index hello.c; # sure, seems okay
$ edit hello.c
$ make test; # oops! design flaw in the second edit uncovered!
$ ???; # how do I back out the last three edits but not the first?

If you know for certain that you will only ever want to back out the 
most recent edit during your development, or back out all the way to 
HEAD, then update-index is fine, but if (like me) you want to checkpoint 
your work frequently so you can step back in a very fine-grained 
fashion, then it's less than ideal to have only one checkpoint that 
keeps getting overwritten.

For frequent checkpointing, as far as I can tell I pretty much need to 
commit (to a development branch, of course) every time. I do that 
because I never know beforehand whether I'll need to go back by more 
than one step later on; 99% of the time I don't have to, of course, but 
the remaining 1% is pretty painful if I can't.

Am I missing some magic index command that would support multi-level 
backing out? Obviously StGIT is an option as well, but that seems like 
overkill when all I want is to checkpoint my work. The above is why, 
even though (I think) I know enough about the index to use it as you 
describe, I often don't bother and just run "commit -a" during 
development instead. When I merge, I usually fold all my checkpoint 
commits together and merge the change as a logical unit.

But I'm still a relative n00b and would appreciate knowing if I'm just 
missing some big obvious technique.

