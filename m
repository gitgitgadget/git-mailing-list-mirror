From: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Subject: Memory of past repositories in git remote?
Date: Wed, 25 Mar 2009 12:47:42 +0100
Message-ID: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Christophe de Dinechin <christophe@dinechin.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 12:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRei-0001KD-Rd
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029AbZCYLuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 07:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756347AbZCYLuv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:50:51 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:46802 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbZCYLuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 07:50:50 -0400
Received: by gxk4 with SMTP id 4so7458170gxk.13
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=AN9+peXTK1MHY62yzge932TcXatGlB5ZNhBmscPPW4c=;
        b=YLj+pdB5wFLFjnJDi2TP83SqpmwCUTJHeLRo08SmlVx9cfAZYXM4i9g1jDNK1g2Mlc
         LE7xhLCtYod1iCI5xSwvKtSwcKFHRweOgDlP4i52L0C4qrWfxQqu60DPNnWoSZqmnl9K
         KFLI7OddoH8YKdUcmHkBa0pTavyKPE3xGayuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=KXRpvq16du/pR+nHN5P0Ui8vrTAU5kX2baxgRufz9AMWudG9X7TyxeekPWw+gY9fw/
         B+htTkooLMQHLMMQ+QJAeoMgN3+9CEGJGcoHn9LN4XcJVcUhzXSxAcNvWbivu+sYwlNn
         mU2S8FyCkoQPzAH3u6cK8q248trvAK4ABWkkE=
Received: by 10.90.115.13 with SMTP id n13mr5020016agc.6.1237981847739;
        Wed, 25 Mar 2009 04:50:47 -0700 (PDT)
Received: from ?10.10.10.22? (val06-1-88-182-161-34.fbx.proxad.net [88.182.161.34])
        by mx.google.com with ESMTPS id 25sm11607012aga.5.2009.03.25.04.50.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 04:50:46 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114592>

I ran into a peculiar issue running git 1.6.1.2 on HP-UX: it looks  
like something has remembered an old repository and insists on  
providing that to "git fetch" instead of the new repository. Appending  
"/." at the end of the remote repository fixes the problem.

Here are the details. I created a git repository in /home/ddd/vmm,  
impored some Subversion history, and started working with that. I  
created a few branches, e.g. one called "perrier". Then, I realized  
that there was a better way to track Subversion changes, and so I  
moved the old repository as /home/ddd/vmm.git, and created a new one  
that I populated with "git svn clone svn+ssh://path/to/repot -T trunk - 
b branches -t users". That new repository has no branch named  
"perrier" in it.

Now, when I'm on another machine, create a new repository with the  
same "git svn clone", then do a "git remote add ddd ssh://name@mymachine/home/ddd/vmm 
", I would expect to pick up the repository that is actually under / 
home/ddd/vmm on mymachine. But when I do a "git svn fetch", the output  
contains:

warning: no common commits
remote: Counting objects: 66874, done.
remote: Compressing objects: 100% (14626/14626), done.
remote: Total 66874 (delta 51668), reused 66589 (delta 51418)
Receiving objects: 100% (66874/66874), 96.41 MiB | 187 KiB/s, done
Resolving deltas: 100% (51668/51668), done.
 From ssh://name@mymachine/home/ddd/vmm
* [new branch] perrier -> ddd/perrier
...

as well as all branches from /home/ddd/vmm.git (not /home/ddd/vmm). I  
tried doing an "ssh name@mymachine ls /home/ddd/vmm" to check that  
this was indeed the new repository. If instead of "/home/ddd/vmm", I  
specify "/home/ddd/vmm/.", then I do get the branches in the new  
repository, e.g in that case I get:

  * [new branch] tot -> ddd-good/tot

This is not just a name dependency, though, because if I specify / 
home/./ddd/vmm, then I get the old repository again. So what seems to  
matter is the dot at the end of the repository name.

I'm really puzzled by this behavior, and I have been unable to find  
anything in the git documentation explaining it. I tried to find  
references to vmm.git anywhere on either machines, but I couldn't.

This is easily reproduced, so I'm willing to run experiments to try  
and debug the problem.


Thanks
Christophe
