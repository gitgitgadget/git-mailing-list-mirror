From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week
 13
Date: Tue, 24 Jul 2012 00:29:49 +0200
Message-ID: <500DD05D.8030708@dewire.com>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox> <7vwr23zb65.fsf@alter.siamese.dyndns.org> <20120717082452.GC1849@tgummerer.surfnet.iacbox> <500C1AA9.4000306@dewire.com> <7vfw8jsk5o.fsf@alter.siamese.dyndns.org> <87629fvaxz.fsf@thomas.inf.ethz.ch> <7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	JGit Developers list <jgit-dev@eclipse.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:30:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StR8f-0004VB-GK
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab2GWW37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:29:59 -0400
Received: from mail.dewire.com ([83.140.172.130]:8276 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822Ab2GWW37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:29:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7BEB68FC79;
	Tue, 24 Jul 2012 00:29:57 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-InYgpCpPz6; Tue, 24 Jul 2012 00:29:54 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id 97DE18FC78;
	Tue, 24 Jul 2012 00:29:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120717 Thunderbird/15.0
In-Reply-To: <7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201996>

Junio C Hamano skrev 2012-07-22 23.08:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Hum, I'm a bit lost now.
>>
>> What is the status quo?  I take it JGit does not have any of ctime, dev,
>> ino etc., and either leaves the existing value or puts a 0....
>> an argument in favor of splitting stat_crc into its fields again?
>
> A difference is that JGit already has such code, and we would be
> adding a burden to do so yet again.  It also may not just be JGit,
> but anything that wants to be "compatible" with systems whose
> filesystem interface does not give enough data by omitting fields
> the current index pays attention to.
>
> It isn't really a discussion about splitting again, but more about
> not squishing them into a new field in the first place---IIUC, even
> outside Windows, ctime is already problematic on some systems where
> background processes muck with extended attributes Git does not pay
> attention to. If the patch makes us lose the ability to selectively
> ignore changes to certain fields (e.g. changes to dev and ino are
> noticed but ctime are ignored) by squishing them into one new field,
> wouldn't removing them without adding such a useless field a simpler
> way to go?

I wasnt't thinking of splitting, but now I read it again, I do think
it should split. Having size accessible is a good thing, and even better 
if it a 64-bit value so we don't have the modulo-4G problem when looking 
at it. Current size is 4G + 33 bytes, index says 33. Did the
file change or not?

Having access to size make the need for actually
invoking the racy git logic and comparing file content less likely.

As for ctime it is accessible in Java7, though everyone aren't using it 
and JGit code has to run on Java5. An idea is to make an optional 
component, but that doesn't make ctime available everywhere.

-- robin
