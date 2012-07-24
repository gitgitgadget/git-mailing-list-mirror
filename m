From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Tue, 24 Jul 2012 13:54:02 +0200
Message-ID: <87d33lqsrp.fsf@thomas.inf.ethz.ch>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
	<7vwr23zb65.fsf@alter.siamese.dyndns.org>
	<20120717082452.GC1849@tgummerer.surfnet.iacbox>
	<500C1AA9.4000306@dewire.com>
	<7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
	<87629fvaxz.fsf@thomas.inf.ethz.ch>
	<7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
	<500DD05D.8030708@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stdgq-0000bN-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 13:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab2GXLyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 07:54:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:31302 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2GXLyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 07:54:05 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 24 Jul
 2012 13:54:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 24 Jul
 2012 13:54:02 +0200
In-Reply-To: <500DD05D.8030708@dewire.com> (Robin Rosenberg's message of "Tue,
	24 Jul 2012 00:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202029>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Junio C Hamano skrev 2012-07-22 23.08:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> What is the status quo?  I take it JGit does not have any of ctime, dev,
>>> ino etc., and either leaves the existing value or puts a 0....
>>> an argument in favor of splitting stat_crc into its fields again?
>>
>> A difference is that JGit already has such code, and we would be
>> adding a burden to do so yet again.  It also may not just be JGit,
>> but anything that wants to be "compatible" with systems whose
>> filesystem interface does not give enough data by omitting fields
>> the current index pays attention to.
>>
>> It isn't really a discussion about splitting again, but more about
>> not squishing them into a new field in the first place---IIUC, even
>> outside Windows, ctime is already problematic on some systems where
>> background processes muck with extended attributes Git does not pay
>> attention to. If the patch makes us lose the ability to selectively
>> ignore changes to certain fields (e.g. changes to dev and ino are
>> noticed but ctime are ignored) by squishing them into one new field,
>> wouldn't removing them without adding such a useless field a simpler
>> way to go?
> 
> I wasnt't thinking of splitting, but now I read it again, I do think
> it should split.

Aren't you two going off in different directions?  I read Junio as
implying that if size/ctime/dev/ino are a pain to deal with, we should
just drop them altogether.  You seem to be saying the opposite:

> Having size accessible is a good thing, and even
> better if it a 64-bit value so we don't have the modulo-4G problem
> when looking at it. Current size is 4G + 33 bytes, index says 33. Did
> the
> file change or not?
>
> Having access to size make the need for actually
> invoking the racy git logic and comparing file content less likely.

I don't think this is true.  Racy git logic is needed every time that
the file *looks* unchanged, but isn't.  In the case where the file is
certified (by mtime) unchanged, we don't go checking.  But in the case
where it *looks* changed, we still have to go and read it to know if,
perhaps, the only thing the user did was hit "save" again.

Not to mention that this really hurts in terms of index size.  Our
benchmark for index-v5 is the Webkit project, which stands at 180k
files.  So every 6B/entry is about an MB of final size, which needs to
be loaded, hashed (or crc'd), then hashed/crc'd again and written.
Junio's index-v4 was a speed boost mainly because it cuts down on the
size of the index.  Do we want to throw that out?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
