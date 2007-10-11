From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 08:16:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710110807170.20690@woody.linux-foundation.org>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> 
 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> 
 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> 
 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> 
 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> 
 <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
 <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Oct 11 17:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzmX-0008Fi-5G
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 17:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbXJKPQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXJKPQv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 11:16:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50575 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835AbXJKPQu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 11:16:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9BFGmYu023022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Oct 2007 08:16:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9BFGlpM002823;
	Thu, 11 Oct 2007 08:16:47 -0700
In-Reply-To: <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60609>



On Wed, 10 Oct 2007, Han-Wen Nienhuys wrote:
> 
> I recall reading a few months ago that it was "clone -l" that gave you
> the jeebies, rather than "clone -s".

Yes, "clone -l" gives me the jeebies, because I'm a totally anal person 
when it comes to disk corruption and a worry-wart. I've just had it happen 
too many times (usually because a disk simply goes bad), and "git clone 
-l" basically means that if one repository gets corrupted, then so does 
the other one.

But clone -s gives me even *more* jeebies, although I think it's in some 
respect also more useful. The alternates thing is really useful for 
servers in particular, where you basically want to have multiple 
"branches" maintained by lots of people, but all based on some expected 
base version.

So if you think of alternates as a "kernel.org" or "repo.or.cz" thing, 
where you might have a hundred different repositories all based on the 
same "standard" version, then I think you basically have the right model. 
In that situation, "git clone -l" doesn't work that well, since the 
repositories just start out sharing data, but don't do it long term.

So "git clone -l" (which is the default now - my jeebies really are my 
personal psychological problem) is really useful for latency reasons for a 
local clone, and has basically no real downsides. It's not useful for 
*backups*, but it's useful for development.

> > So the rule really is: never *ever* do anything but fast-forward in a repo
> >[..]
> 
> Methinks this is all too difficult. I will use clone -l henceforth. Is
> there any reason to prefer -s over -l?

Good. And no, for actual *development* there is no reason to prefer -s 
over -l (and as mentioned, '-l' is the default in modern versions).

For a git *server* setup, -s is better, since it's more long-term. But in 
that situation, it also requires that the server maintainer have some 
rules (ie only use "-s" for stable base trees and/or use extra care when 
repacking the base).

> Given your lengthy exposition on the dangers of alternates, I would say 
> this is a features that deserves to be buried or at least deemphasized 
> in the documentation.

I do agree. We should make the dangers very clear.

> For cherrypicking convenience, I would still appreciate it if there
> was a mechanism similar to alternates that would allow me to view
> objects from an alternate repo; objects found through this mechanism
> should never be assumed to be present in the database, of course.

Well, the way that really should work is that you "git fetch remote" and 
work on the end result in a "remote branch".

That *will* make the objects present in the database, but not in your 
actual branches (until you cherry-pick), but there really are no real 
downsides. If the remote is truly related to your local tree, it all 
delta's so well that the disk space issues should basically be none.

		Linus
