From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 15:03:51 +0200
Message-ID: <46DD57B7.9090206@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <Pine.LNX.4.64.0709041324420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISY4X-0000m8-PY
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXIDND6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 09:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbXIDND5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:03:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16016 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbXIDND5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 09:03:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISY4R-0005wK-Gw; Tue, 04 Sep 2007 15:03:56 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 43F906B7; Tue,  4 Sep 2007 15:03:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041324420.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.378, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57562>

Johannes Schindelin schrieb:
> On Tue, 4 Sep 2007, Johannes Sixt wrote:
>> Reading the implementation of time(), it starts with GetLocalTime(), 
>> determines whether daylight saving is in effect, and continues with 
>> another round of timezone adjustment - mind you: _not_ a timezone 
>> reversal (!!). Doesn't this look extremely bogus?
>>
>> It seems we really need a wrapper for time().
> 
> I absolutely concur.  Something like this (most of it is blatantly copied 
> from Marius' patch)?

Well, I don't think it'll make a difference. The tiny test program below 
prints twice the same number. My analysis of the time() implementation is 
obviously flawed.

-- Hannes

#include <windows.h>
#include <stdio.h>
#include <time.h>

int main()
{
	time_t t = time(NULL);
	FILETIME ft;

	GetSystemTimeAsFileTime(&ft);
	long long winTime = ((long long)ft.dwHighDateTime << 32)
		+ ft.dwLowDateTime;
	winTime -= 116444736000000000LL;
	winTime /= 10000000;

	printf("%d %d\n", t, (int) winTime);
	return 0;
}
