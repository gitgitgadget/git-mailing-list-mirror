From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/4] make it possible to skip away from broken commits
Date: Tue, 02 Jun 2009 20:14:13 -0700
Message-ID: <4A25EA85.5090208@zytor.com>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org> <7vmy8qe4ru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 05:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBgwR-0002r2-So
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbZFCDOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 23:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbZFCDOc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 23:14:32 -0400
Received: from terminus.zytor.com ([198.137.202.10]:46138 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZFCDOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 23:14:32 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n533EGsD003465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 20:14:19 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id n533EGPc008925;
	Tue, 2 Jun 2009 20:14:16 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n533EDsR018163;
	Tue, 2 Jun 2009 20:14:13 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vmy8qe4ru.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.94.2/9416/Tue Jun  2 16:48:42 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120579>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> This patch series adds a "--ratio=x/y" option to "git bisect skip" so
>> that it is possible to skip away from an area were the commits cannot
>> be tested.
>>
>> Note that in this series "--ratio=4" means the same as "--ratio=1/4".
>> But I am not sure if this shortcut is worth it.
> 
> Actually my gut feeling is that a tweakable knob itself is worth it,
> because the user can never tell what the right value should be.
> 
> Especially without any documentation updates that explains what this ratio
> refers to ;-), but I suspect, unless the user is very familiar with how
> the revision graph bisection internally works, such an explanation would
> not help him find a skip ratio that is closer to the optimum than a random
> guess.  Why not use a constant ratio (or perhaps a pair of alternating
> ratios) on "bisect skip" without any new options?
> 

I would agree with this assessment.  It's hard enough to teach a user
how to use "git bisect" as it is... and being able to have a *user*
bisect a problem is worth its weight in gold.

If the algorithm I proposed earlier is too complex, here is a very
simple approximation:

start:
	num = 1
	den = 2

again:
	run test (num/den)
	if (!skip)
		goto start

	num = num + 2
	if (num > den)	
		num = 1
		den = den * 2

	goto again


This creates test ratios in the following sequence:

1/2 1/4 3/4 1/8 3/8 5/8 7/8 1/16 3/16 ...

When one gets down to a small number of points this could get weird, but
as long as skip points are filtered (which looks like it's already being
 done) it should converge.

This is almost certainly suboptimal, because there are at least two
possibilities as to which is better, and this isn't either:

a) one should seek points closer to the periphery, because the
likelihood of a contiguous skip region goes down.

1/2 1/4 3/4 1/8 7/8 1/16 15/16 ...

b) one should seek points closer to the center in the hope of getting
more information; this is better on the assumption that skip points are
generally scattered:

1/2 1/4 3/4 3/8 5/8 1/8 7/8 7/16 9/16 5/16 11/16 ...

However, as before, I think there is every reason to believe something
like that should be plenty good enough.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
