From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:56:05 -0800
Message-ID: <7vwsrkbuje.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	<alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
	<7vprxcdhis.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Fu3-0000Of-Lb
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXLLA40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbXLLA4Z
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:56:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXLLA4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 19:56:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D29915D56;
	Tue, 11 Dec 2007 19:56:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A9E835D4F;
	Tue, 11 Dec 2007 19:56:12 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 11 Dec 2007 16:02:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67979>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 11 Dec 2007, Linus Torvalds wrote:
>> 
>> and while I suspect xdiff could be optimized a bit more for the cases 
>> where we have no changes at the end, that's beyond my skills.
>
> Ok, I lied.
>
> Nothing is beyond my skills. My mad k0der skillz are unbeatable.
>
> This speeds up git-blame on ChangeLog-style files by a big amount, by just 
> ignoring the common end that we don't care about, since we don't want any 
> context anyway at that point. So I now get:
>
> 	[torvalds@woody gcc]$ time git blame gcc/ChangeLog > /dev/null
>
> 	real    0m7.031s
> 	user    0m6.852s
> 	sys     0m0.180s
>
> which seems quite reasonable, and is about three times faster than trying 
> to diff those big files.

Funny.  I did not understand what you were talking about "no changes at
the end" when I read it ('cause I am at work and do not have the data
you are looking at handy), but now I see what you meant.  It is a cute
hack that optimizes for a very special case of "prepend only" files (aka
"ChangeLog").

I suspect that this optimization has an interesting corner case, though.
What happens if you chomp at the middle of the last line that is
different between the two files?  xdiff will report the line number but
wouldn't its (now artificial) "No newline at the end of the file" affect
the blame logic?

Besides, "prepend only" (or "append only") files would be good
candidates for the original -S"pickaxe" search, I would imagine, and
unless you are looking at that ChangeLog-2000 consolidated log, isn't
blame way overkill?
