From: David Kastrup <dak@gnu.org>
Subject: Re: A question about git-rev-list
Date: Mon, 16 Jul 2007 23:16:00 +0200
Message-ID: <85bqecm4mn.fsf@lola.goethe.zz>
References: <86wsx0wwvs.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0707161258560.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXvo-0000vQ-UN
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762741AbXGPVQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759778AbXGPVQI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:16:08 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:46603 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762609AbXGPVQD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 17:16:03 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 475FA97B46;
	Mon, 16 Jul 2007 23:16:02 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 3A5FB13ED64;
	Mon, 16 Jul 2007 23:16:02 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-090-188.pools.arcor-ip.net [84.61.90.188])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 118A137646C;
	Mon, 16 Jul 2007 23:16:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 33ABA1CE30E9; Mon, 16 Jul 2007 23:16:00 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707161258560.20061@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 16 Jul 2007 13\:05\:34 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91/3682/Mon Jul 16 18:05:30 2007 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52723>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 16 Jul 2007, David Kastrup wrote:
>> 
>> if I do
>> 
>> git-rev-list --remove-empty HEAD --not some-commit -- filename | tail -1
>> 
>> do I have any guarantee that the commit id I get (if any) is a direct
>> descendant of some-commit?
>
> No. You get the guarantee that
>
>  - it's some kind of parent of HEAD
>  - it's *not* a parent of some-commit
>
> But the trivial case is a simple history like
>
> 	 /-B-\
> 	A     D
>        \-C-/
>
> (where "A" is the root commit, and "D" is the current HEAD, and there are 
> two development lines from A to  D).
>
> If you now do
>
> 	git-rev-list HEAD --not C
>
> you would generally see B on the list of commits, even though it's 
> obviously not a direct descendant of C.

Ok, thanks.  As explained in a different posting, I try to tackle this
now with the equivalent of

git-rev-list HEAD --parents --not B -- somefile.c | awk '/ B/{print $1}'

This will give me one descendant if there is one.  The problem I have
with that is that "somefile.c" renders commits uninteresting, but
not if they have interesting parents (what do their parents have to do
with it?).  So if I have

A -> B -> B1 -> C -> HEAD

where somefile.c does not change between B and B1, then
git-rev-list HEAD --not B -- somefile.c
spews out
HEAD
C
and that's it.  Quite as expected.  However, 
git-rev-list HEAD --not B --parents -- somefile.c
spews out
HEAD C
C B1
B1 B

and look and behold, B1 became interesting because of its unlisted
parent B.

There is something wrong with that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
