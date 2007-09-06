From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git's database structure
Date: Thu, 06 Sep 2007 11:14:06 -0700
Message-ID: <46E0436E.9030504@midwinter.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>  <7vtzqany0z.fsf@gitster.siamese.dyndns.org>  <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>  <20070904212507.GA24434@thunk.org>  <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>  <46DE5861.4050201@op5.se>  <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>  <46DEC26E.7030809@op5.se>  <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>  <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk> <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com> <Pine.LNX.4.64.0709061354180.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLrr-0002hm-Bh
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbXIFSOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 14:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbXIFSOI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:14:08 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:52959 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755683AbXIFSOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 14:14:07 -0400
Received: (qmail 8544 invoked from network); 6 Sep 2007 18:14:07 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=j6kh7VPhi0eemKQ9ijMCDGgvNVHp43X62fAUkBY04vzuqe1wqhl0yKI88Z6kxGOb  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Sep 2007 18:14:07 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0709061354180.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57921>

Johannes Schindelin wrote:
> But you can add _yet another_ index to it, which can be generated on the 
> fly, so that Git only has to generate the information once, and then reuse 
> it later.  As a benefit of this method, the underlying well-tested 
> structure needs no change at all.
>   

And in fact, you can do this today, without modifying git-blame at all, 
by (ab)using its "-S" option (which lets you specify a custom ancestry 
chain to search). By coincidence, I was just showing some people at my 
office how to do this yesterday. I'll cut-and-paste from the email I 
sent them. I am not claiming this is nearly as desirable as a built-in, 
auto-updated secondary index, but it proves the concept, anyway.

Fast-to-generate version:

git-rev-list HEAD -- main.c | awk '{if (last) print last " " $0; 
last=$0;}' > /tmp/revlist

This speeds things up a lot, because git blame doesn't have to examine 
other revisions:

time git blame main.c
   1.56s user 0.30s system 99% cpu 1.868 total
time git blame -S /tmp/revlist main.c
   0.21s user 0.03s system 96% cpu 0.249 total

The bad news is that generating that revision list is a bit slow, and if 
you do it the naive way I suggested above, you can't use the rev list 
with the -M option (to follow renames). The good news is that it's 
possible to have that too if you generate a list of revisions that 
includes the renames:

# Generate a list of all revisions in the right order (only need to do 
this once, not once per file)
git rev-list HEAD > /tmp/all-revs
# Generate a list of the revisions that touched this file, following 
copies/renames.
# Could do this in fewer commands but this is hopefully easier to follow.
git blame --porcelain -M main.c | \
   egrep '^[0-9a-f]{40}' | \
   cut -d' ' -f1 | \
   fgrep -f - /tmp/all-revs | \
   awk '{if (last) print last " " $0; last=$0;}' > /tmp/revlist

Then -M is fast too:

time git blame -M main.c
   1.72s user 0.27s system 89% cpu 2.219 total
time git blame -M -S /tmp/revlist main.c
   0.29s user 0.03s system 93% cpu 0.341 total

Oddly, if you use the -S option, "git blame -C" actually gets 
significantly *slower*. I am not sure why.

-Steve
