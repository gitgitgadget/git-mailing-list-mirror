From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: git-gc "--aggressive" somewhat broken
Date: Fri, 6 Jul 2007 13:19:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707061310390.8278@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:20:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6uIN-0007jX-Mn
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 22:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760828AbXGFUUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 16:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760499AbXGFUUt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 16:20:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41783 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759828AbXGFUUs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 16:20:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66KK2AE006774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 13:20:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66KJf8h017784;
	Fri, 6 Jul 2007 13:19:49 -0700
X-Spam-Status: No, hits=-2.642 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51786>


This flag seems misdesigned as-is.

It makes the window bigger (good, and aggressive), but it also enabled 
"-f".

Which sometimes causes _worse_ packing.

In particular, there's a gcc import at

	git://git.infradead.org/toolchain/gcc.git

which apparently packs down quite nicely to a 450MB pack, but when it gets 
repacked "aggressively", it blows up to 1.4GB. The reason? That pack was 
generated using --depth=100 --window=100 (I think).

So under certain circumstances, "--aggressive" is anything _but_ 
aggressive, and actually causes much worse packing.

If we want to be really aggressive, we migth decide to pass a new flag to 
pack-objects that does something closer to what "aggressive" was meant to 
do: it would use existing delta's if they exist, but _despite_ existing it 
could look if there are even better choices.

So right now we have:

 - default behaviour:

   always re-use existing deltas, don't look at alternatives at all.

   This is optimal for CPU/memory/IO usage, and is generally a good idea

 - "-f" (and as a result, the current bad "git gc --aggressive"):

   never re-use existing deltas, always look for new ones.

   This is good if you have reason to believe that the old choices are 
   bad, or you need to force re-generation of deltas (because you want to 
   force a new pack-file format, for example)

and the missing piece might be

 - "git pack-objects --aggressive":

   re-use existing deltas _and_ look for even better ones.

   This is good if all you're looking for is better packing.

Hmm?

		Linus
