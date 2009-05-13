From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 11:37:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905131131240.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>  <20090512151403.GS30527@spearce.org>  <20090512161638.GB29566@coredump.intra.peff.net>  <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>  <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
  <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain> <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 20:40:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JNU-0008Ud-8D
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbZEMSkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZEMSkR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:40:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37101 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754398AbZEMSkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 14:40:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DIbSfr002386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 11:38:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DIbSVl022407;
	Wed, 13 May 2009 11:37:28 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <46a038f90905131126s79e5b8e1qd0c6c100ec836127@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119086>



On Wed, 13 May 2009, Martin Langhoff wrote:
> 
> Do we need to take the real solution to the core of git?

Well, I suspect that if we really want to support it, then we'd better.

> What I am wondering is whether we can keep this simple in git
> internals and catch problem filenames at git-add time.

I can almost guarantee that it will just cause more problems than it 
solves, and generate some nasty cases that just aren't solvable.

Because it really isn't just "git add". It's every single thing that does 
a lstat() on a filename inside of git.

Now, the simple OS X case is not a huge problem, since the lstat will 
succeed with the fixed-up filename too. But as mentioned, the OS X case is 
the thing that doesn't need a lot of infrastructure _anyway_ - I can 
almost guarantee that my posted patch (with the added setup.c stuff for 
get_pathspec()) is going to be _fewer_ lines than some wrapper logic.

Note: in all of the above, I assume that people care more about just plain 
UTF characters (and the insane NFD form OS X uses) than about worrying 
about the _really_ subtle issues of case-independence. Those are a major 
pain, but they will need even more "internal" support, because there 
simply isn't any sane wrapping method.

(You could wrap everything to force lower-casing of all filesystem ops or 
something, but that would not be acceptable to any sane environment. So in 
reality you need to accept mixed-case things, and then there is no way to 
know from the "outside" whether one external mixed-case thing matches some 
internal index mixed-case thing).

			Linus
