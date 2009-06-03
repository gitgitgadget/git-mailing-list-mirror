From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 02 Jun 2009 19:11:16 -0700
Message-ID: <7vab4qdq2j.fsf@alter.siamese.dyndns.org>
References: <200905122329.15379.jnareb@gmail.com>
	<200906022339.08639.jnareb@gmail.com>
	<20090602232724.GN30527@spearce.org>
	<200906030250.01413.jnareb@gmail.com>
	<20090603012940.GA3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 04:11:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfx3-0000HV-4F
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 04:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbZFCCL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 22:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbZFCCLZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 22:11:25 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52079 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbZFCCLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 22:11:25 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603021118.BHKI2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 2 Jun 2009 22:11:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zEBG1b0084aMwMQ04EBGrJ; Tue, 02 Jun 2009 22:11:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=1cH15jnNZHcA:10 a=8-WIN01VSTQA:10
 a=oAYF_C9AAAAA:8 a=cPXG5wd7WzBr1ePB-Y4A:9 a=rody2KUwl_kcx5WUdw4A:7
 a=iByEPhIOgIJUbvFZFgSWzGdHkP0A:4 a=R0wQ3QzoQ0IA:10 a=TTmna675lFCOVw_K:21
 a=-ur19RvV2miuOIrK:21
X-CM-Score: 0.00
In-Reply-To: <20090603012940.GA3355@spearce.org> (Shawn O. Pearce's message of "Tue\, 2 Jun 2009 18\:29\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120574>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> IIRC, without multi_ack, a client sends have lines in --date-order
> until the server has found a common base.  That means the client
> will send have lines that are already known by the server to be
> common, because they overlap in time with another branch that the
> server hasn't found a common base on yet.
>
> E.g. the client has things in caps that the server doesn't; server
> has things in lower case:
>
>      +---- u ---------------------- x
>     /             +----- y
>    /             /
>   a -- b -- c -- d -- E -- F
>    \
>     +--- Q -- R -- S
>
> If the client wants x,y and starts out by saying have F,S, the
> server doesn't know what F,S is.  Eventually the client says "have
> d" and the server sends "ACK d continue" to let the client know to
> stop walking down that line (so don't send c-b-a), but its not done
> yet, it needs a base for X.  The client keeps going with S-R-Q,
> until a gets reached, at which point the server has a clear base
> and it all ends.
>
> Without multi_ack the client would have sent that c-b-a chain anyway,
> interleaved with S-R-Q.
>
> Junio, am I right?

Correct.

>> >>  * thin-pack
>> 
>> Server can send thin packs, i.e. packs which do not contain base 
>> elements, if those base elements are available on clients side.
>> Client has thin-pack capability when it understand how to "thicken"
>> them adding required delta bases making them independent.
>
> Yes.
>  
>> Of course it doesn't make sense for client to use (request) this
>> capability for git-clone.
>
> No, no it doesn't.  But if the client does request it (and I think
> modern clients actually do request it, even on initial clone case)
> the server won't produce a thin pack. Why?  There is no common base,
> so there is no uninteresting set to omit from the pack.  :-)

There also is "clone --reference".

> Actually, it has to be, because that "\n" isn't there on the first
> line when the capability data appears either wedged behind the "\0"
> or after the " " at the end of the line.

Correct.

> Its ugly.  But basically you keep a running counter of each "flush"
> sent, and then you send a "done" out, and then you wait until
> you have the right number of ACK/NAK answers back, and then the
> stream changes format.

One thing that I did not see mentioned in this thread is that the
implementation is allowed to buffer non-flush packets and send multiple of
them out with a single write(2).  In other words, packet_write() could
buffer instead of directly calling safe_write(), while packet_flush() must
do safe_write() and make sure it drains.
