From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re:
Date: Fri, 8 May 2009 10:17:03 +0200
Message-ID: <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
	 <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
	 <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
	 <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
	 <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
	 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
	 <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
	 <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 10:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LH3-0007MB-DT
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbZEHIRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbZEHIRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:17:09 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:42356 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbZEHIRF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:17:05 -0400
Received: by bwz22 with SMTP id 22so1213521bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1HCh3u8l9cMc5wOSZwp/Tzw1ymkdpLHxRhw+yy2dxt4=;
        b=x2WtSzKlD5P27XCEXSzqF0ly+4ardG+BvTbPYc4a84pn1xifQP7R6VLa2ccmUehV7q
         dx/MqadaNPZdXddZ9jWkgvr5FiUzVwvYfLHa29+qoZKDUlHjtfDbkWdML1UJbPJWaLKL
         d8yXOkLtIuq6ds9NVpJHejIPtnanRKK8VcnLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lfp5ncQKQGB7R7J1yVMJBiYsl5LN+a+3ruMe4xzcPzH8Jkap1w0pr6vPYXVYmNgVjt
         1B7Xt2Do4B4hP3jz9E7EqWV7WAj5ewL1WfyoEN/OZlF5zjPEIfKTFn9SdgHosFycFnJf
         nfouJNG+PtJAW13GZEzYUr4pZGZAtzcgvGJjA=
Received: by 10.204.103.203 with SMTP id l11mr3326597bko.71.1241770624884; 
	Fri, 08 May 2009 01:17:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118584>

2009/5/7 Linus Torvalds <torvalds@linux-foundation.org>:
>
> Somebody should check. It would be interesting to hear about whether this
> makes a performance impact, especially with slow filesystems and/or other
> operating systems that have a relatively higher cost for 'lstat()'.
>

I did (cygwin). My guess, the improvement is completely dwarfed by the
other overheads (like starting git and writing files).

# Without the patch
real    11m22.338s
user    0m54.629s
sys     8m33.638s

# With checkout index preload
real    11m14.361s
user    0m46.609s
sys     7m56.300s

The script:

#!/bin/sh

if [ "$1" = setup ]; then
    for i in 1 2 3 4
    do
        n=$(date)
        for f in `seq 1 10000`
        do
            echo "$n" >file$f
        done
        git add .
        printf "Commit $i:"
        git commit -m"$n"
    done
    exit
fi

export GIT_EXEC_PATH=/d/git-win
time for f in `seq 1 10`
do
    $GIT_EXEC_PATH/git checkout master~3 &&
    $GIT_EXEC_PATH/git checkout master~2 &&
    $GIT_EXEC_PATH/git checkout master~1 &&
    $GIT_EXEC_PATH/git checkout master
done
exit
