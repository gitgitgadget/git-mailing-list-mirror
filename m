From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 15:04:22 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:05:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyaOl-0001T4-7e
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYKGXE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYKGXE1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:04:27 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:60456 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbYKGXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 18:04:26 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2B7C0A> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 7 Nov 2008 18:04:23 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100358>

On Fri, 7 Nov 2008, Linus Torvalds wrote:

> On Sat, 8 Nov 2008, Abhijit Menon-Sen wrote:
> >
> > If anyone's interested, the files are http://toroid.org/misc/1 and
> > http://toroid.org/misc/2
> 
> Btw, you can see this by just doing
> 
> 	git diff 1 2
> 
> without even doing "git init" or doing any actual git repository.
> 
> > Does anyone understand why this slowdown might happen or have
> > suggestions about where I should look for it?
> 
> Sure. It's actually fairly simple. You're hitting a O(n^2) thing (possibly 
> higher), and it's triggered by the fact that almost all your lines are 
> identical, ie you have a file that basically has 40,000 lines of each of
> 
> 	xxxx: xxx, xx xxx xxxx xx:xx:xx +xxxx
> 	xx: xxxx xxxxxxxxxxx <xxxx@xxxx.xxx>
> 	xxxx: xxxx xxxxxxxxxxx <xxxx@xxxx.xxx>
> 
> and 30,000 of 
> 
> 	* xxxxx xxxxx (xxxxxx.xxxx xxx xxxxx (\Xxxxxx) xxxxxx.xxxxxx {xxx}
> 
> with a smattering of others. And this is a case where the internal git 
> implementation does really badly. And nobody has really cared before, 
> because nobody has ever had a case that mattered.
> 
> There's a number of different 'diff' algorithms, and it looks like GNU 
> diff has one that avoids the O(n^2) case for this case.
> 
> I'm adding Davide as the original author of the diff library to the cc. 
> I'm also adding Pierre, since he was talking about trying to implement
> another diff algorithm (although I'm not at all sure that the patience 
> diff really would help this case at all).

That should be an easy fix. Just need to limit the window by which 
xdl_clean_mmatch() scans the current position.



- Davide
