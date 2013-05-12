From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 20:14:06 +0300
Message-ID: <518FCDDE.9040707@bracey.fi>
References: <cover.1368274689.git.john@keeping.me.uk> <518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan> <20130512163317.GL2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 12 19:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZqh-0006qq-V8
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab3ELROM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:14:12 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:51710 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754586Ab3ELROL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:14:11 -0400
Received: from mail615.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 48536FF9004
	for <git@vger.kernel.org>; Sun, 12 May 2013 19:14:09 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 12 May 2013 19:14:32 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 12 May 2013 19:14:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <20130512163317.GL2299@serenity.lan>
X-Ovh-Tracer-Id: 14841049623956525057
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.50001/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224055>

On 12/05/2013 19:33, John Keeping wrote:
> On Sun, May 12, 2013 at 05:28:24PM +0100, John Keeping wrote:
>> You're right (and I was wrong in my reply to Junio's parallel message)
>> ancestry path does seem to be what I want:
>>
>>      $ git rev-list --ancestry-path --left-right --count \
>>              master...git-gui/master
>>      2056    5
>>
>> However, this doesn't seem to make a difference to the time taken when I
>> add in --cherry-mark (which is why I was partially correct in the
>> parallel thread - it doesn't have the effect on cherry-mark that I want
>> it to):
>>
>> This seems to be caused by the code in revision.c::limit_list() which
>> does the cherry detection then limits to left/right and only then
>> applies the ancestry path.  I haven't looked further than that, but is
>> there any reason not to apply the ancestry path restriction before
>> looking for patch-identical commits?

That certainly sounds like it's doing it the wrong way round. At first 
sight, it seems obviously suboptimal.

> No I didn't.  I forgot to update my $PATH when I built on master - those
> results are from pu.  master says:
>
>      fatal: --ancestry-path given but there are no bottom commits

Well, then it looks like we have a user for that particular syntax. 
Seemed a bit esoteric to me :)  Although I realised after sending my 
mail you could also use

    git log --ancestry-path --left-right E...F --not $(git merge-base 
--all E F)

which looks like we're having to repeat ourselves because it's not 
paying attention...

I hit it because one of my optimisations relies on knowing the bottom 
commits, and I made absolutely sure I was using the exactly same 
definition of "bottom" as --ancestry-path. And then I found that my 
optimisations didn't work properly with "..."

I suggest we pull my patch out from the more complex optimisation series 
so it can proceed to next faster. It shouldn't have to wait for all my 
new fancy stuff - it's fixing something that appears to be a clear bug.

Although Junio did have a comment about the implementation - I'll 
revisit it tomorrow and send a revised version separately, if everyone 
thinks that's sensible.

>
>>> On this subject, is there any way to exclude a path from a log query? Is
>>> there a "not" operator for paths? Might be another way of doing this -
>>> disjoint histories probably have disjoint paths...
>> That relates to another idea I had about optimizing the detection of
>> patch-identical commits.  If the smaller side of a symmetric difference
>> is quite small (as it is likely to be if it's a topic branch), would it
>> be a good idea to calculate the set of paths touched by commits on that
>> side and then skip calculating the patch ID for any commits that touch
>> paths outside that set.  The tree comparison is a lot cheaper than doing
>> a diff on all of the files.
>>
Sounds cute. Go for it :)

Kevin
