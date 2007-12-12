From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 18:20:52 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111816220.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
 <7vwsrkbuje.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 03:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2HE4-0005tY-9m
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 03:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXLLCVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 21:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXLLCVK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 21:21:10 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38316 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560AbXLLCVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 21:21:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2Kr0F011725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 18:20:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2Kqom020700;
	Tue, 11 Dec 2007 18:20:52 -0800
In-Reply-To: <7vwsrkbuje.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67984>



On Tue, 11 Dec 2007, Junio C Hamano wrote:
> 
> I suspect that this optimization has an interesting corner case, though.
> What happens if you chomp at the middle of the last line that is
> different between the two files?  xdiff will report the line number but
> wouldn't its (now artificial) "No newline at the end of the file" affect
> the blame logic?

It shouldn't. I thought about it, but there doesn't seem to be any reason 
why blame could possibly care - the message can come at the end of a 
_real_ file, of course, so if the extra message confuses the blame logic, 
there's already a bug there. 

But no, I didn't create a test-case.

> Besides, "prepend only" (or "append only") files would be good
> candidates for the original -S"pickaxe" search, I would imagine, and
> unless you are looking at that ChangeLog-2000 consolidated log, isn't
> blame way overkill?

Actually, I suspect that this makes a difference for totally normal files 
too. I bet it cuts the size of the files to be tested for the common case 
(ie just a few small changes) down by 30-50% even on average. The fact 
that it cuts it down by 99.9% on ChangeLog files is just an added bonus.

As Davide mentioned, xdiff actually does something like that hack for the 
beginning and end of files internally _anyway_, the problem with that is 
that it does it so late that it's already done a fairly expensive hash for 
the file (and allocated space for it based on guesses that are in turn 
based on the original size) that it doesn't actually get the full effect 
of the optimization.

			Linus
