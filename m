From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git apply behaves differently from patch(1)
Date: Thu, 17 Jan 2008 11:58:41 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171142230.14959@woody.linux-foundation.org>
References: <200801162358.48723.zander@kde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Zander <zander@kde.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:59:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFaty-0000vt-2O
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYAQT7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYAQT7T
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:59:19 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55350 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752323AbYAQT7S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 14:59:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HJwgRU024578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 11:58:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HJwf9n010219;
	Thu, 17 Jan 2008 11:58:42 -0800
In-Reply-To: <200801162358.48723.zander@kde.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70912>



On Wed, 16 Jan 2008, Thomas Zander wrote:
>
> In the following usecase git apply (git version 1.5.4.rc3.15.g785f9) 
> doesn't do what I expect it should do. I expect it to do the same as 
> patch does in the same situation.

There's actually a lot of cases where git-apply doesn't really do what 
patch does.

There's one really obvious difference, in that git-apply only does unified 
diffs and doesn't support any of the traditional ones: that may be seen as 
a downside, but I was never interested in them, so it's a "limitation" 
only in the sense that git-apply just doesn't do the ass-backwards old 
formats.

But this definitely means that "git-apply" doesn't really _replace_ patch 
per se.

There's also the very explicit differences, ie git-apply has all the 
extensions for renaming etc.

But in addition to those limitations and extensions there are the much 
subtler ones, which tend to come down to different interpretations of what 
is "safe".

What you hit is one such difference. There are others. They all boil down 
to "I'm not sure enough I can apply this correctly, so I won't":

 - (the one you hit): zero context at the end means "end-of-file"

   There's no other valid reason to have zero context in git-apply's 
   opinion, because without the context, there's no way to verify that 
   we're applying things in the right place.

 - git doesn't guess how deep the path is by default.

 - git does not accept any fuzz by default

In other words, git-apply simply doesn't want to apply unsafe patches. 
Yes, they often (probably 99% of the time) would apply in the right place, 
but partly *because* they often work, people are so used to doing them 
that then the few cases where they silently apply incorrectly are even 
more painful and often aren't noticed.

So no, git-apply really isn't a straight replacement for GNU patch. 

You can't really get exactly the same behaviour with any flags (there is 
no "guess filename path depth" mode at all, for example), but you can get 
fairly close with

	git-apply -C1 --unidiff-zero

where that -C1 matches GNU patches (INSANE!) default fuzz of 2, and the 
--unidiff-zero thing disables the stricter git-apply rules for no context.

I would actually suggest you go the other way: rather than try to make 
git-apply mimic the unsafe defaults of GNU patch, try to teach yourself to 
use the stricter rules. It's not always practical, but generally, the 
things git-apply refuses to do by default really *are* rather likely to 
mis-apply a patch occasionally.

(Even with git-apply's strict defaults, there is obviously no *guarantee* 
that a patch will always apply correctly, but at least git-apply will 
strictly check as much of the information that is available in the patch)

			Linus
