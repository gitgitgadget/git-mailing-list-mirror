From: David Kastrup <dak@gnu.org>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 08:23:22 +0200
Message-ID: <85odht3xd1.fsf@lola.goethe.zz>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	<20070730222028.GE64467@nowhere>
	<alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 08:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFl9e-0000T0-Rk
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 08:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXGaGYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 02:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXGaGYI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 02:24:08 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:32939 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbXGaGYH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 02:24:07 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id C3504183AF4;
	Tue, 31 Jul 2007 08:24:03 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id AFE00279402;
	Tue, 31 Jul 2007 08:24:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-103.pools.arcor-ip.net [84.61.0.103])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 5F089225123;
	Tue, 31 Jul 2007 08:24:03 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 90F791D58B8F; Tue, 31 Jul 2007 08:23:22 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 30 Jul 2007 16\:30\:22 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3828/Tue Jul 31 06:33:48 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54323>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Jul 2007, Craig Boston wrote:
>> 
>> # On branch cvs_RELENG_4
>> nothing to commit (working directory clean)
>> git: 67.65 seconds
>
> So I _seriously_ hope that about 65 of those 67 seconds was the "cvs 
> update -d" or something like that. 
>
> Anything that takes a minute in git is way way *way* too slow. Any 
> half-way normal git operations should take less than a second.

I tried a git-add . on a TeX live tree (lots of itsy files).  About
80% of the processor time was wait.

I think that SHA1 is costly enough that the processor(s) could get
saturated when enough is done in parallel.

Potential for multithreading is here enough to make any Summer of Code
student weep with joy:

a) one thread for opendir/readdir at every directory level
b) one thread for stating the files in readdir order (more likely to
   correspond to the disk layout than sorted order)
c) one thread on each directory level doing a mergesort on a different
   link field (some merge passes could be parallelized even, but let's
   not get overexcited)
d) asynch I/O requesting the data for all files to be submitted to
   SHA1
e) one thread (but no more threads than there are CPUs) per
   independent file/tree for doing SHA1
f) asynch I/O reading the index sequentially
g) one thread doing a merge pass of already sorted stuff (this can
   start once the top level directory has been read and sorted
   completely, possibly having to stop until a complete subdirectory
   comes in).
h) asynch I/O writing out the results of the merge sequentially

In fact, git-ls-files|git-add --stdin is already exploiting a bit of
parallelism (and will probably profit from CFS by making much more use
of the buffering capacity of the pipe).  It is counterintuitive that
hand-built chains work more efficiently than explicit git commands.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
