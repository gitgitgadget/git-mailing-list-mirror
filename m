From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should we discuss Windows-related changes on git@vger.kernel.org?
Date: Fri, 11 Jul 2008 15:14:01 -0700
Message-ID: <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de>
 <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness>
 <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de>
 <alpine.DEB.1.00.0807111652170.8950@racer>
 <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
 <alpine.DEB.1.00.0807111930160.8950@racer>
 <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org>
 <alpine.DEB.1.00.0807112037220.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jul 12 00:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQtY-0007Ma-EI
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbYGKWON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbYGKWON
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:14:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbYGKWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:14:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D3A728FF5;
	Fri, 11 Jul 2008 18:14:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1325A28FED; Fri, 11 Jul 2008 18:14:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807112037220.8950@racer> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 20:40:46 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF9E6F5A-4F96-11DD-BB50-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88191>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 11 Jul 2008, Linus Torvalds wrote:
>
>>  - It may well be good to explain to the _real_ git people (eg me) what 
>>    the problems in Windows land are, so that we get a first-hand view 
>>    into hell, and can maybe take it into account when we make changes 
>>    for other things.
>
> Wow.  I did not think that you were a masochist.

It is not being masochist, but being practical by trying to know what to
avoid in advance.

>> IOW, I think that since 1.6.0 is supposed to have native support for 
>> windows, we should have patches discussed on the regular git list. The 
>> ghetto that is windows can be useful for _user_ discussions, where a lot 
>> of the core git people simply cannot help. But having development 
>> discussions there is bad, I think.
>
> We do have development discussions there that do not belong to git@vger.  

Hannes did a great job with help from msysGit people to contain platform
specific stuff in compat/ layer.  A good rule of thumb to decide what not
to talk about here is:

 - If it is purely about implementation inside compat/ layer, such as
   creating spawn() using Windows specific API, it is probably better done
   on the msysGit list, where presumably more people whose has expertise
   on the particular platform would hang around;

 - If it is about "I downloaded msysgit prepackaged binary and this and
   that does not work as I expect, I haven't bothered trying to build it
   from source on POSIX systems and see if it is broken in the upstream",
   the RFH does not belong here but platform specific forum.  This applies
   not just to Windows but to various distro binary distributions on Linux
   as well.

On the other hand, even if it is related to porting to Windows, discussing
what the compat/ abstraction should look like is very relevant to this
list.

For example, I like is_absolute_path() abstraction you and Hannes pushed
for, but I have a slight distaste against has_dos_drive_prefix().  Some
uses of that macro is about telling if a string is a local file pathname
(e.g. connect()), and some other uses of that macro is about the fact that
on Windows you cannot necessarily make one path relative to another but
our code largely assume that any path can be made relative to any other
path (i.e. on traditional UNIX without "//", you can always make a path
relative by prefixing enough number of "../" to go up, even to root if
needed, but you cannot make C:\foo relative to D:\bar).  We may be able to
find a better abstraction than what has_dos_drive_prefix() offers, and I
think that discussion belongs to here.

Another example that has already happened was our move away from direct
use of fork/exec but abstracting it out to run_command() layer.  This
would not have settled in a shape usable by both Windows and POSIX if
people from both camps did not participate in the design and review.
