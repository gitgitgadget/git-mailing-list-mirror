From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Mon, 05 Mar 2007 18:17:40 -0800
Message-ID: <7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
	<7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 03:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOPGR-0004oN-Ie
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 03:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757AbXCFCRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 21:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965756AbXCFCRo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 21:17:44 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47741 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965757AbXCFCRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 21:17:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306021742.EAJZ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 21:17:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XEHh1W00j1kojtg0000000; Mon, 05 Mar 2007 21:17:42 -0500
In-Reply-To: <Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 03:05:34 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41529>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 5 Mar 2007, Junio C Hamano wrote:
>
>> This removes the flag internally used by revision traversal to
>> decide which commits are indeed boundaries and renames it to
>> CHILD_SHOWN.  builtin-bundle uses the symbol for its
>> verification, but I think the logic it uses it is wrong.  The
>> flag is still useful but it is local to the git-bundle, so it is
>> renamed to PREREQ_MARK.
>
> The idea was to bail out of revision walking when that prerequisite was 
> found, _even_ if it happened to be uninteresting.
>
> Just marking the parents uninteresting unless they are prerequisites would 
> be better, probably.
>
>>  
>>  	i = req_nr;
>>  	while (i && (commit = get_revision(&revs)))
>> -		if (commit->object.flags & BOUNDARY_SHOW)
>> +		if (commit->object.flags & PREREQ_MARK)
>>  			i--;
>
> The above-mentioned idea, then would be: instead of just i--; do

I explicitly wanted to avoid that.  If the generated bundle had
prereqs that are not independent of each other, doing that would
hide some prereqs.

> This should help performance, as not all reachable commits are traversed 
> any more.

You prevented that with "while (i &&" part already, didn't you?

> Wasn't --skip meant for something like gitweb, where you just want to skip 
> the first <n> commits from the list, but do not want to change the list 
> otherwise?

Yes, but does the patch change that?

>
>> @@ -1305,6 +1309,9 @@ struct commit *get_revision(struct rev_info *revs)
>>  	case -1:
>>  		break;
>>  	case 0:
>> +		/* Although we grabbed it, it is not shown. */
>> +		if (c)
>> +			c->object.flags &= ~SHOWN;
>>  		c = NULL;
>
> Is this really relevant in practice?

Absolutely.  But I have further updates on this series.
