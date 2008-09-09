From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 9 Sep 2008 09:02:36 +0000 (UTC)
Message-ID: <loom.20080909T085002-376@post.gmane.org>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> <48C61F94.3060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 11:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcz8j-0005xl-44
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 11:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYIIJCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYIIJCy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 05:02:54 -0400
Received: from main.gmane.org ([80.91.229.2]:32953 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbYIIJCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 05:02:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kcz7W-0002BI-Ix
	for git@vger.kernel.org; Tue, 09 Sep 2008 09:02:49 +0000
Received: from 137.204.201.149 ([137.204.201.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 09:02:46 +0000
Received: from sergio.callegari by 137.204.201.149 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 09:02:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.201.149 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080715 Ubuntu/7.10 (gutsy) Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95362>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> 
> Peter Krefting schrieb:
> > Since OpenOffice doucuments are just zipped xml files, I wondered how
> > difficult it would be to create some hooks/hack git to track the files
> > inside the archives instead?
> 
> You could write a "clean" filter that "recompresses" the archive with
> level 0 upon git-add.
> 


A couple of notes:

1) For Openoffice documents whose size is dominated by embed images and other
large objects, the git delta mechanism already performs reasonably well, since
OO files are Zip archives where each file is compressed separately.  If you do
not change an image, then that image remains stored in the same way and the
delta can be done.

2) For OO documents whose size is dominated by plain content, the git delta
mechanism cannot work, since the zip compression introduces "mixing" and a small
change in the document is converted into a very large change in the zip file.

It could be possible to write a clean filter to uncompress before commit.
However there is a trick with the complementary smudge filter to be used at
checkout. If you do not smudge properly, git always shows the file as changed
wrt the index.  Smudging correctly would mean using the very same compression
ratio and compress method that OO uses, which can be a little tricky. I have
tried using the zip binary both in the clean and the smudge phases and it does
not work nicely. The smudged file is always different from the original one. One
should probably work at a lower level to have a finer control on what is
happening (libzip) and prepend to the uncompressed file the compression
parameters to be restored on smudging.

The bigger issue is however that the clean/smudge thing can be really slow when
dealing with large OO files.
