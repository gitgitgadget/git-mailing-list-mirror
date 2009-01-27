From: David Abrahams <dave@boostpro.com>
Subject: Re: "malloc failed"
Date: Tue, 27 Jan 2009 10:32:46 -0500
Message-ID: <87hc3k69y9.fsf@mcbain.luannocracy.com>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
	<20090127152915.GA1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpzS-0001Jh-38
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbZA0PfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZA0PfH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:35:07 -0500
Received: from main.gmane.org ([80.91.229.2]:50349 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZA0PfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:35:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LRpxv-0001F1-8T
	for git@vger.kernel.org; Tue, 27 Jan 2009 15:35:03 +0000
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:35:03 +0000
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:35:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:Cc881Tk3LcR9lNNnTbYFkH2/96E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107355>


on Tue Jan 27 2009, "Shawn O. Pearce" <spearce-AT-spearce.org> wrote:

> David Abrahams <dave@boostpro.com> wrote:
>> I've been abusing Git for a purpose it wasn't intended to serve:
>> archiving a large number of files with many duplicates and
>> near-duplicates.  Every once in a while, when trying to do something
>> really big, it tells me "malloc failed" and bails out (I think it's
>> during "git add" but because of the way I issued the commands I can't
>> tell: it could have been a commit or a gc).  This is on a 64-bit linux
>> machine with 8G of ram and plenty of swap space, so I'm surprised.
>> 
>> Git is doing an amazing job at archiving and compressing all this stuff
>> I'm putting in it, but I have to do it a wee bit at a time or it craps
>> out.  Bug?
>
> No, not really.  Above you said you are "abusing git for a purpose
> it wasn't intended to serve"...

Absolutely; I want to be upfront about that :-)

> Git was never designed to handle many large binary blobs of data.

They're largely text blobs, although there definitely are a fair share
of binaries.

> It was mostly designed for source code, where the majority of the
> data stored in it is some form of text file written by a human.
>
> By their very nature these files need to be relatively short (e.g.
> under 1 MB each) as no human can sanely maintain a text file that
> large without breaking it apart into different smaller files (like
> the source code for an operating system kernel).
>
> As a result of this approach, the git code assumes it can malloc()
> at least two blocks large enough for each file: one of the fully
> decompressed content, and another for the fully compressed content.
> Try doing git add on a large file and its very likely malloc
> will fail due to ulimit issues, or you just don't have enough
> memory/address space to go around.

Oh, so maybe I'm getting hit by ulimit; I didn't think of that.  I could
raise my ulimit to try to get around this.

> git gc likewise needs a good chunk of memory, but it shouldn't
> usually report "malloc failed".  Usually in git gc if a malloc fails
> it prints a warning and degrades the quality of its data compression.
> But there are critical bookkeeping data structures where we must be
> able to malloc the memory, and if those fail because we've already
> exhausted the heap early on, then yea, it can fail too.

Thanks much for that, and for reminding me about ulimit.

Cheers,

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
