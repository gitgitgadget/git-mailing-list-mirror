From: Steven Michalske <smichalske@gmail.com>
Subject: RFC: Make git bisect submodule aware.
Date: Wed, 9 Jun 2010 05:50:29 -0700
Message-ID: <6AC4E373-C28F-455E-93A6-6FA5A57723A2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:50:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKk2-00069t-4r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab0FIMuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 08:50:35 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47390 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0FIMue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 08:50:34 -0400
Received: by pxi8 with SMTP id 8so2142528pxi.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:content-type
         :message-id:date:to:content-transfer-encoding:mime-version:x-mailer;
        bh=qHM1n8HDzbAORTbAAtTNHrG3QAxIV6KRPFyCHIqu35I=;
        b=wVH7ts3ye038qGDfbHhifLoozhPk8Zfry0fvA9saBYkGIPgZ8Dv/i3p9pH9dGwbVun
         JU6rLIXLTu/TbPJEqdcpAeqKidjMNFujO2Z1Kp7kB7vk644FxJvr1HJbdxjDFI5ch5Cd
         Qq8WbL3yPcG32msmsRQMoxJnw0szW3iEx6SjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:message-id:date:to
         :content-transfer-encoding:mime-version:x-mailer;
        b=VjGoSJJPRUEcORlV6CgAYdEf3joxA7da881mM2+47jwhVbWstYQI9Adnk80jlRFuru
         01xEaa7fwaJDiolKH412DMOwDmgbegFnAEl4tzHiOzqpj0JmWQLmhj96pVJXPS/07g9Q
         vRhxlRlwVB2Ir5BCav3bOEBpH/zS9hP7Bzbdw=
Received: by 10.114.253.34 with SMTP id a34mr14219716wai.43.1276087833914;
        Wed, 09 Jun 2010 05:50:33 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id d16sm63978925wam.12.2010.06.09.05.50.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 05:50:33 -0700 (PDT)
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148767>

When git bisect discovers that the change set that creates the failure  
also contains a submodule change, that submodule should then be  
bisected starting with the good super modules code and working to a  
break in the sub module.  If the change contains submodule change and  
super code changes than the bisection gets trickier, so we need some  
ideas on how to solve that search.

Example:

Super: A-B-C-D-E
Sub:   s-s-y-y-z

Where s is not required to be a parent of y,  meaning that there might  
be 300 commits or just 1 between s and y in the submodule or they are  
disjoint then the bisecting should happen both routes into the  
submodule.

So the git bisect found that the offending commit is C

Now if the offending commit only changes 1 submodule than it is a  
normal bisect for the changed submodule.

If in commit C file foo.c changed and the submodule changed a bit more  
work is needed.

If foo.c is not dependent on a new feature from between s and y than  
we are good, otherwise I feel a bit of human intervention might be  
needed for marking a 'good' version in the submodule.  Otherwise we  
have to search for a 'good' starting point, a binary bisection  
probably won't help much but probably would not hurt, since you need a  
'good' commit to start the bisection from.

So for the not dependent on new feature/bugfix in the submodule.

B's foo.c and s -> good/bad?
B's foo.c and y -> good/bad?
C's foo.c and s -> good/bad?
C's foo.c and y -> good/bad?

have fun bisecting.....

It might be good to interactively ask, for this bisection will file  
foo.c have an affect?
If the file has an effect:
Ask if C's foo.c will work with range s..y, if not what is the  
expected range for operation, we know that we need version u of  
submodule to compile C's foo.c. Or we have to search (linear from s)  
to where we can work.
otherwise, just bisect the submodule.

Steve
