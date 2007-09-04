From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 12:53:55 +0200
Message-ID: <46DD3943.8040403@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <46DD3153.8060805@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISW2n-0005Vi-3Z
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbXIDKyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXIDKyA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:54:00 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7153 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXIDKx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:53:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISW2e-00019C-5q; Tue, 04 Sep 2007 12:53:58 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 980B66B7; Tue,  4 Sep 2007 12:53:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DD3153.8060805@trolltech.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.364, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57550>

Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 04.09.2007 09:41:
>> Thanks a lot! I've pushed it out in mingw.git's master.
> 
> Ops, already in master branch?

Yes, it looked so polished ;)

> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=f15974add93bdfa92775c77c00e7c65aefd42127 

Looks good, although you should now handle INVALID_HANDLE_VALUE at the 
beginning of git_fstat() like this:

	HANDLE fh = (HANDLE)_get_osfhandle(fd);
	if (fh == INVALID_HANDLE_VALUE)
		return -1;	/* errno has been set */

	if (GetFileInformationByHandle(...

> Ok, I can give it a performance test, but I tend to agree with David 
> Kastrup there. It would be better if we rather fix the places where we 
> check with the local timestamp instead; depending of course on how many 
> places we actually do this.
> We'll see how much the timezone conversion in the custom stat functions 
> actually hurt us performance wise.

I'd make the decision on the grounds of a perfomance test. If it turns out 
that the penalty is bearable, we should keep this stuff private to the MinGW 
build. Otherwise, we would need MinGW specific code at the call sites 
(unless we can hide the opposite conversion in some other wrapper function).

... time passes ...

Ok, I just tested FileTimeToLocalFileTime() in a tight loop, and I can run 
it 100,000,000 times per second. So I'm confident that there won't be any 
noticable degradation with my proposed change.

-- Hannes
