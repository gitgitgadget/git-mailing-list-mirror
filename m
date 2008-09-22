From: Andreas Ericsson <ae@op5.se>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 13:53:45 +0200
Message-ID: <48D78749.3030509@op5.se>
References: <19596152.post@talk.nabble.com> <19599905.post@talk.nabble.com> <48D74B1C.6020408@panasas.com> <20080922085200.GI21650@dpotapov.dyndns.org> <48D77643.1090908@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, mwolfe38 <mwolfe38@gmail.com>,
	git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 13:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khk0c-0000Xx-Ks
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 13:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbYIVLxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 07:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbYIVLxy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 07:53:54 -0400
Received: from mail.op5.se ([193.201.96.20]:39626 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbYIVLxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 07:53:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 627461B80079;
	Mon, 22 Sep 2008 13:44:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.924
X-Spam-Level: 
X-Spam-Status: No, score=-3.924 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.475, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x8J-56PJGIHm; Mon, 22 Sep 2008 13:44:17 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DC3D51B80078;
	Mon, 22 Sep 2008 13:44:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48D77643.1090908@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96474>

Boaz Harrosh wrote:
> Dmitry Potapov wrote:
>> On Mon, Sep 22, 2008 at 10:37:00AM +0300, Boaz Harrosh wrote:
>>> I have 1.6.0.1 I compiled here, and it has the same problem. So it is
>>> a very recent fix
>> I certainly tested 1.6.0.1 and does not have this problem, and it was
>> fixed a long time ago:
>>
>> ===
>> commit d6b8fc303b389b026f2bf9918f6f83041488989b
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Thu Jan 31 01:17:48 2008 -0800
>>
>>     gitignore(5): Allow "foo/" in ignore list to match directory "foo"
>>
>>     A pattern "foo/" in the exclude list did not match directory
>>     "foo", but a pattern "foo" did.  This attempts to extend the
>>     exclude mechanism so that it would while not matching a regular
>>     file or a symbolic link "foo".  In order to differentiate a
>>     directory and non directory, this passes down the type of path
>>     being checked to excluded() function.
>>
>>     A downside is that the recursive directory walk may need to run
>>     lstat(2) more often on systems whose "struct dirent" do not give
>>     the type of the entry; earlier it did not have to do so for an
>>     excluded path, but we now need to figure out if a path is a
>>     directory before deciding to exclude it.  This is especially bad
>>     because an idea similar to the earlier CE_UPTODATE optimization
>>     to reduce number of lstat(2) calls would by definition not apply
>>     to the codepaths involved, as (1) directories will not be
>>     registered in the index, and (2) excluded paths will not be in
>>     the index anyway.
>> ===
>>
>> The patch is included in 1.5.5.
>>
>> Dmitry
>> --
> 
> Ok I found it. Regular subdirectories it works as you said,
> but soft-link to a folder does not. Sorry for the noise i didn't
> realize that in my test it was a simlink and not a full directory.
> 
> Please don't fix it if it will hurt performance, I'm happy with
> current solution as it is. Just maybe a small addition to the
> .gitignore documentation perhaps.
> 

It wouldn't hurt performance (noticeably) to change the lstat()
call to a stat() call. It's slightly more work for the kernel,
but assuming you don't have tens of thousands of symlinks it
really won't make a difference. I'm not sure what other things
would break from using stat() instead of lstat() in the exclude
matching code though, so it's not so simple as just replacing
it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
