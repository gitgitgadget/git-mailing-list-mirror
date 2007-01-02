From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Tue, 02 Jan 2007 14:06:10 +0000
Message-ID: <459A66D2.3000804@shadowen.org>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net>	<7vzm96latb.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0612291307520.4473@woody.osdl.org> <7vlkkql0na.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 15:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1kHj-0005PJ-Vn
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 15:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbXABOGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 09:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbXABOGU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 09:06:20 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3508 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbXABOGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 09:06:17 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H1kGU-0000Bg-ST; Tue, 02 Jan 2007 14:05:19 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkkql0na.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35787>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> On Fri, 29 Dec 2006, Junio C Hamano wrote:
>>> I really need a sanity checking on this one.  I think I got the
>>> botched pipeline fixed with the patch I am replying to, but I do
>>> not understand the waitpid() business.  Care to enlighten me?
>> I think it was a beginning of a half-hearted attempt to check the exit 
>> status of the rev-list in case something went wrong.
>>
>> Which we simply don't do, so if git-rev-list ends up with some problem 
>> (due to a corrupt git repo or something), it will just send a partial 
>> pack.
>>
>> For some reason I thought we had fixed that by just generating the object 
>> list internally, but I guess we don't do that. That's just stupid. We 
>> should make "send-pack.c" use
>>
>> 	list-heads | git pack-objects --revs
>>
>> 	list-heads | git-rev-list --stdin | git-pack-objects
>>
>> because as it is now, I think send-pack is more fragile than it needs to 
>> be.
>>
>> Or maybe I'm just confused.
> 
> Dont' worry, you are no more confused than I am ;-).
> 
> "I thought we've done the 'pack-objects --revs' for the
> upload-pack side but haven't done so on the send-pack side." was
> what I initially wrote, but apparently we haven't.  On the other
> hand, I think upload-pack gets error termination from rev-list
> right.
> 
> It seems that repack is the only thing that uses the internal
> rev-list.

>From what I can see in next/pu (by the time I stopped stuffing food and
booze into myself and remembered how to turn on the computer) you have
ripped all this code out and started using the builtin rev-list
functions.  So what I can see in there now looks sane, and seems to work
in some limited testing here.

Reading the code does highlight a weakness in the face of incomplete
writes in the ref list send, which has always been in there.  Now we may
never see these on Linux, but as we do not know what OS is under us and
the relevant standards say they can occur we should cope me thinks.

I have just been testing a patch for that which I will post in follow up
to this post.

-apw
