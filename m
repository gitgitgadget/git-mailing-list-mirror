From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull" throws away dirty state
Date: Sun, 16 Mar 2008 13:50:23 -0700
Message-ID: <7vprtuieb4.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161434450.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:51:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JazpE-0000c2-Uc
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 21:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYCPUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYCPUup
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 16:50:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYCPUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 16:50:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D77524C0;
	Sun, 16 Mar 2008 16:50:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 20D7E24BF; Sun, 16 Mar 2008 16:50:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803161434450.2947@xanadu.home> (Nicolas
 Pitre's message of "Sun, 16 Mar 2008 14:37:34 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77382>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 16 Mar 2008, Linus Torvalds wrote:
>
>> On Sun, 16 Mar 2008, Linus Torvalds wrote:
>> > 
>> > Ok, this is distressing, and I suspect it's another bug of mine due to 
>> > unpack-trees changes, but before I delve into it deeper I thought I'd 
>> > report it here and see if others see it too, and maybe it's due to 
>> > something else..
>> 
>> Nope, I bisected it down to
>> 
>> 	34110cd4e394e3f92c01a4709689b384c34645d8 is first bad commit
>> 
>> 	Make 'unpack_trees()' have a separate source and destination index
>> 
>> and I'm trying to figure out what part of that triggered this bug.
>
> We really should have more tests to cover all those bugs that were 
> introduced and fixed lately.
>
> Given that Git should work fine in some cases even with a dirty work 
> tree by design, I'm a bit surprised that we don't have any test case 
> covering that.

Yeah, I was wondering why these are not covered by
t/t1000-read-tree-m-3way:

  "git read-tree -m O A B"

       O       A       B         result      index requirements
  -------------------------------------------------------------------
    12  exists  O!=A    O!=B      take A      must match A, if exists.
                        A==B
    ------------------------------------------------------------------
    13  exists  O!=A    O==B      take A      must match A, if exists.
    ------------------------------------------------------------------
    14  exists  O==A    O!=B      take B      if exists, must either (1)
                                             match A and be up-to-date,
                                             or (2) match B.
   ------------------------------------------------------------------

But this one tests only "read-tree -m", not "read-tree -m -u".  The tests
for "-m -u" we have in t1004 is not about being comprehensive like t1000
(which covers all cases in the case table) but seems to be more about
randomly selected cases.

Patches?
