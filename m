From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 13:37:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
References: <20081107200126.GA20284@toroid.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:39:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZ2k-0006kX-6I
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 22:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbYKGVhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYKGVhq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:37:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44284 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898AbYKGVhq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 16:37:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7LbVN0004127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Nov 2008 13:37:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7LbT1Q004716;
	Fri, 7 Nov 2008 13:37:30 -0800
In-Reply-To: <20081107200126.GA20284@toroid.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100335>


On Sat, 8 Nov 2008, Abhijit Menon-Sen wrote:
>
> If anyone's interested, the files are http://toroid.org/misc/1 and
> http://toroid.org/misc/2

Btw, you can see this by just doing

	git diff 1 2

without even doing "git init" or doing any actual git repository.

> Does anyone understand why this slowdown might happen or have
> suggestions about where I should look for it?

Sure. It's actually fairly simple. You're hitting a O(n^2) thing (possibly 
higher), and it's triggered by the fact that almost all your lines are 
identical, ie you have a file that basically has 40,000 lines of each of

	xxxx: xxx, xx xxx xxxx xx:xx:xx +xxxx
	xx: xxxx xxxxxxxxxxx <xxxx@xxxx.xxx>
	xxxx: xxxx xxxxxxxxxxx <xxxx@xxxx.xxx>

and 30,000 of 

	* xxxxx xxxxx (xxxxxx.xxxx xxx xxxxx (\Xxxxxx) xxxxxx.xxxxxx {xxx}

with a smattering of others. And this is a case where the internal git 
implementation does really badly. And nobody has really cared before, 
because nobody has ever had a case that mattered.

There's a number of different 'diff' algorithms, and it looks like GNU 
diff has one that avoids the O(n^2) case for this case.

I'm adding Davide as the original author of the diff library to the cc. 
I'm also adding Pierre, since he was talking about trying to implement
another diff algorithm (although I'm not at all sure that the patience 
diff really would help this case at all).

		Linus
