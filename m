From: David Kastrup <dak@gnu.org>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 18:17:50 +0200
Message-ID: <85tzhwv6tt.fsf@lola.goethe.zz>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
	<alpine.LFD.1.10.0804191341210.2779@woody.linux-foundation.org>
	<alpine.LFD.1.10.0804191422480.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:18:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JncFf-0000uM-M3
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbYDTQSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYDTQSD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:18:03 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:44292 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbYDTQSB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 12:18:01 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 7DC7284458;
	Sun, 20 Apr 2008 18:18:00 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 6563D51081C;
	Sun, 20 Apr 2008 18:18:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-002-239.pools.arcor-ip.net [84.61.2.239])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 2B1E531D8E9;
	Sun, 20 Apr 2008 18:18:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C39D91C39587; Sun, 20 Apr 2008 18:17:51 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0804191422480.2779@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 19 Apr 2008 14:29:56 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6848/Sun Apr 20 16:54:16 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79963>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 19 Apr 2008, Linus Torvalds wrote:
>> 
>> Notice how this patch doesn' actually change the fundamental O(n^2) 
>> behaviour, but it makes it much cheaper by generally avoiding the 
>> expensive 'fnmatch' and 'strlen/strncmp' when they are obviously not 
>> needed.
>
> Side note: on the kenrel tree, it makes the (insane!) operation 
>
> 	git add $(git ls-files)
>
> go from 49 seconds down to 17 sec. So it does make a huge difference
> for me, but I also want to point out that this really isn't a sane
> operation to do (I also think that 17 sec is totally unacceptable, but
> I cannot find it in me to care, since I don't think this is an
> operation that anybody should ever do!)

It is my opinion that git should likely presort the patterns (not just
here), and should traverse the trees alphabetically.  In that case, a
merge-like algorithm will pretty much do the trick in O(n), with O(n lg
n) preprocessing cost.

Presorting can only be done approximately in the case of wildcards: for
those, we have two relevant points in the sort order: one where it can
start matching, one where it can't match anymore.

The easiest way to make this more efficient would be to retain the
O(n*m) algorithm, but presort the patterns and let them trickle
head-first into the O(m) pattern list only when they start having a
chance of matching, and remove them from the O(m) list once a non-match
has passed them alphabetically for good.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
