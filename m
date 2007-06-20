From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: blame follows renames, but log doesn't
Date: Thu, 21 Jun 2007 00:11:34 +0200
Organization: At home
Message-ID: <f5c8mm$jaj$1@sea.gmane.org>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com> <20070619071916.GC9177@thunk.org> <4677A7EF.500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 00:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I18Oy-000470-DK
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 00:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXFTWLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbXFTWLr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 18:11:47 -0400
Received: from main.gmane.org ([80.91.229.2]:57539 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbXFTWLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 18:11:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I18Oq-0004xQ-WD
	for git@vger.kernel.org; Thu, 21 Jun 2007 00:11:41 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 00:11:40 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 00:11:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50575>

Steven Grimm wrote:

> What git doesn't handle, but BitKeeper does, is applying directory 
> renames to newly created files. I rename the "lib" directory to "util", 
> you create a new file lib/strings.c and update lib/Makefile to compile 
> it. I pull from you. Under BitKeeper, I will get util/strings.c and the 
> change will be applied to my util/Makefile. git will create a brand-new 
> "lib" directory containing nothing but the new file, but since the 
> Makefile existed before, it will (correctly) apply your change to my 
> util/Makefile, which will then break my build because it will refer to a 
> file that doesn't exist in the Makefile's directory.
> 
> This has bitten me a few times in real life, e.g. in cases where I'm 
> importing a third-party source tarfile and reorganizing it a little to 
> fit it into my local build system. Every time they add a new source 
> file, I have to go manually clean up after it rather than just merging 
> the vendor branch into mine like I can do when they don't add anything. 
> It is not frequent enough to be a major hassle for me but it sure is 
> annoying when it happens (especially since sometimes the build *doesn't* 
> break and it takes a while to notice a newly created file isn't where it 
> should be.)

I think git can at least try to detect this situation, and perhaps
even resolve this automatically. Namely, if we add file with the
following <path>: <dirname>/<basename>, and <dirname> tree does exists in
the ancestor but does not exist in the other branch, this is CONFLICT(add)
(or something like that), with appropriate explanation.

One way to resolve this CONFLICT(add) automatically would be to check where
all the files in no longer existing <dirname> moved to, and if they all are
of the form <newdir>/<somename> then we should add the <dirname>/<basename>
file under <newdir>/<basename>. If some of them were moved to other
directory, for example contents of one directory got split into two
directories, this is conflict which cannot be resolved automaticaly
(CONFLICT(add/multiple) or something like that perhaps?). And I guess that
SCM which _track_ renaming of directories, like Bazaar-NG, would NOT detect
this as a conflict, and happily add to perhaps wrong directory.

Or we could reuse rename detection, taking modes+filenames as tree contents,
or perhaps set of file contents as tree contents, for our content based
rename detection.


P.S. Allow me to remind you rename _detection_ success story, send here some
time ago by Johannes Schindelin in the "Rename handling" thread:
  Message-ID: <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  http://permalink.gmane.org/gmane.comp.version-control.git/42770

JS> By now, there have been enough arguments _for_ automatic rename detection, 
JS> but I'll add another one.
JS> 
JS> A colleague of mine worked on a certain file in a branch, where he copied 
JS> the file to another location, and heavily modified it. He did that in a 
JS> branch, and when he was satisfied with the result, he deleted the old 
JS> file, since he liked the new location better.
JS> 
JS> Now, when I pulled, imagine my surprise (knowing the history of the file), 
JS> when the pull reported a rename with a substantial similarity!
JS> 
JS> So, the automatic renamer did an awesome job.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
