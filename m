From: Thomas <th.acker66@arcor.de>
Subject: Re: Large repo and pack.packsizelimit
Date: Wed, 9 May 2012 11:46:13 +0000 (UTC)
Message-ID: <loom.20120509T131228-943@post.gmane.org>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net> <20120508203137.GA15707@sigill.intra.peff.net> <alpine.LFD.2.02.1205081709010.21030@xanadu.home> <20120508212012.GA20044@sigill.intra.peff.net> <alpine.LFD.2.02.1205081751011.21030@xanadu.home> <loom.20120509T113505-740@post.gmane.org> <CACsJy8BhSn+PB5tXME-w_cq4DVd2BULNRNLV-vk1_6yWKy+fNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 13:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS5Lm-0007Pe-3C
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 13:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090Ab2EILq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 07:46:29 -0400
Received: from plane.gmane.org ([80.91.229.3]:42854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756083Ab2EILq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 07:46:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SS5Lf-0007Mx-Lp
	for git@vger.kernel.org; Wed, 09 May 2012 13:46:27 +0200
Received: from proxy31.sbs.de ([194.138.39.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2012 13:46:27 +0200
Received: from th.acker66 by proxy31.sbs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2012 13:46:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.138.39.61 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197467>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> 
> On Wed, May 9, 2012 at 4:36 PM, Thomas <th.acker66 <at> arcor.de> wrote:
> > To be exact I did the clone locally on the same machine and so the clone 
itself
> > worked
> > but I got the OOM during the first fetch. I "fixed" this by setting
> > transfer.unpacklimit=100000
> > which caused only loose objects to be transfered.
> > So in this case I think the OOM was on the remote side. But there is another 
OOM
> > if I try to repack locally.
> > It seems to me that neither pack-objects nor index-pack respekt
> > pack.packsizelimit and always
> > try to pack all objects to be transferred resp. all local loose objects in 
one
> > pack.
> > I could live wth the transfer.unpacklimit=100000 but the local OOM stops me 
from
> > using the cloned repo.
> 
> I have some patches to make index-pack work better with large blobs
> but they're not ready yet. I think pack-objects works fine with large
> blobs as long as they are all in packs. Are there any loose objects on
> the source repo?
> 
> It's strange that you chose "256mb" as the upper limit for small
> objects in your first mail. Do you have a lot of >=10mb files? By
> default, files smaller than 512mb will be put in memory for delta. A
> lot of big (but smaller than 512mb) files can quickly consume all
> memory. If it's the case, maybe you can lower core.bigFileThreshold
> 
> Also maybe try remove the 1.2GB file from the source repo and see if
> it works better. That could give us some hints where the problem is.

I am using core.bigFileThreshold=256MB already; so the large file/s should not 
be the problem (most of the files in the repo are "standard" source code files;
I tried even smaller numbers for bigFileThreshold and packsizelimit but with no 
success). 
As long as I worked with the original repo which was updated regularily all 
worked well as soon as pack.packsizelimit was set to 1024MB (even with the 1.2GB 
file). Repack seems not to increase a pack further as soon as packsizelimit is 
exceeded (so my packs are all slightly larger than 1024MB) BUT it also seems to 
try to put everything in one pack regardless of packsizelimit in the following 
cases:
(1) all objects to be transferred to another repo 
(2) all loose objects when starting a local repack
Case (1) can be fixed by transfer.unpacklimit but there is no fix for (2).
---
Thomas
