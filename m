From: Andreas Ericsson <ae@op5.se>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 09:18:20 +0200
Message-ID: <48D8983C.7070506@op5.se>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2BH-0006Sd-QQ
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 09:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYIWHSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 03:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYIWHSX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 03:18:23 -0400
Received: from mail.op5.se ([193.201.96.20]:33550 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbYIWHSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 03:18:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BEEFD1B80048;
	Tue, 23 Sep 2008 09:08:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.162
X-Spam-Level: 
X-Spam-Status: No, score=-4.162 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.238, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zATEIXke57kb; Tue, 23 Sep 2008 09:08:51 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 256AC1B80005;
	Tue, 23 Sep 2008 09:08:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96529>

Mario Pareja wrote:
> Hi,
> 
> For one and a half years, I have been keeping my eyes on the git
> community in hopes of making the switch away from SVN.  One particular
> issue holding me back is the inability to lock binary files.
> Throughout the past year, I have yet to see developments on this
> issue.  I understand that locking files goes against the fundamental
> principles of distributed source control, but I think we need to come
> up with some workarounds.  For Linux kernel development this is may
> not be an issue; however, for application development this is a major
> issue. How else can one developer be sure that time spent editing a
> binary file will not be wasted because another developer submitted a
> change?
> 

Because they will cause merge conflicts when you try to bring the
histories together. Some binary formats can be edited by multiple
users at the same time, while others can't, so git will try to merge
those binary files for you. For images, that almost certainly won't
go so well so it will result in a conflict.

> To achieve the effects of locking, a "central" repository must be
> identified.

To achieve distributedness no central repository must exist. Locking
can be done by some other means.

>  Regardless of the distributed nature of git, most
> _companies_ will have a "central" repository for a software project.

Actually, all projects with some sort of userbase will probably have
some official "here's the published code suitable for production use"
repository. To say that it's the "central" one is a bit off though.
It's merely a public place that can be referred to for convenience.

> We should be able to mark a file as requiring a lock from the
> governing git repository at a specified address.  Is this made
> difficult because git tracks file contents not files?
> 
> In any case, I think this is a crucial issue that needs to be
> addressed if git is going to be adopted by companies with binary file
> conflict potential. I don't see how a web development company can take
> advantage of git to track source code and image file changes.  Any
> advice would be great!
> 

Try and find out.

mkdir foo && cd foo && git init
cp /random/binary/file.png image.png
git add image.png && git commit -m"first commit"
git checkout -b A
cp /other/random/binary/file.png image.png
git add image.png && git commit -m"conflicting commit"
git checkout -b B master
cp /third/random/binary/file.png image.png
git add image.png && git commit -m"non-conflicting commit"
git checkout master
cp /third/random/binary/file.png image.png
git add image.png && git commit -m"master says 'so be it'"

git merge B; # works, since the binary files are the same
git merge A; # produces a conflict message


In which way is that not exactly the right behaviour?
How would locking have helped?

If your colleagues are replacing files you committed so
that your code suddenly fails, you have a communication
(and QA) issue at work. Adding locking to git is not the
solution to that problem. Introducing a sort of builtin
notion of a central repository is, frankly, disgusting.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
