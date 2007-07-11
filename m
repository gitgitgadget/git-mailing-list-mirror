From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git log FILE' slow
Date: Wed, 11 Jul 2007 14:03:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707111354150.20061@woody.linux-foundation.org>
References: <f36b08ee0707111333q38004cb5x152f25e2055e2796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jLr-000363-9W
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933968AbXGKVDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934049AbXGKVDR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:03:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51417 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934045AbXGKVDP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2007 17:03:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6BL3D7g030159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2007 14:03:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6BL37ss016801;
	Wed, 11 Jul 2007 14:03:07 -0700
In-Reply-To: <f36b08ee0707111333q38004cb5x152f25e2055e2796@mail.gmail.com>
X-Spam-Status: No, hits=-2.615 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52201>



On Wed, 11 Jul 2007, Yakov Lerner wrote:
> 
> 'git-log FILE' takes 10-13 sec.  What can I do to identify
> the reason ? 'git log >/dev/null' takes 0.1 sec (cached).

"git log FILE" is simply *fundamnentally* much more expensive than "git 
log".

There's nothing to "identify". Both go through the whole log of the 
project, but "git log file" has to look at every tree, and see where the 
file actually changed.

However, "fundmanetally more expensive" doesn't actually mean that it 
should be that slow. I suspect that your archive is not packed, so you 
have probably thousands of individual objects in the filesystem, and are 
slowing down your git usage totally needlessly.

So do

	git gc

on the archive, and you'll probably be happy.

That said, 10-13 seconds *can* be valid for a really big archive, ie 
that's the kinds of times you might eventually expect for something like 
the full KDE archive (if they don't split the subprojects up).

I doubt that's it.

> On the cloned copy, the times are approximately same.

This is a big clue. Cloning will generate a new pack.

> The 'git-count-objects -v' shows:
> 
> count: 9830
> size: 241412
> in-pack: 12080
> packs: 18
> prune-packable: 188
> garbage: 0

Tons of packs, and lots of unpacked objects.

Just get used to doing "git gc" once a week (or maybe once a month - I 
guess you've not done it at all?)

> The strace shows only thousands of sbrk during the 10-13 sec time
> (after some initial I/O). Ltrace, I was not able to complete, takes too much.

Hmm. I'd have expected to see some "stat()/open()" calls if it was really 
just about packing, so I'm a bit surprised, but I really do think you 
should just garbage collect your packs. Having 12k objects in 18 packs is 
ridiculous - each pack must be pitifully small.

Here's my kernel archive:

	[torvalds@woody linux]$ git count-objects -v
	count: 364
	size: 2328
	in-pack: 506495
	packs: 12
	prune-packable: 5
	garbage: 0

ie I have forty times the objects, in fewer packs than you do (and most of 
it is in one big one). After a "git gc", it looks like

	[torvalds@woody linux]$ git count-objects -v
	count: 0
	size: 0
	in-pack: 506090
	packs: 1
	prune-packable: 0
	garbage: 0

and everything is happier (not that it was unhappy before either, but 
mine was much better packed than yours was).

		Linus
