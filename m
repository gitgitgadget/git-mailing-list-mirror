From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 10:12:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261006570.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
 <20070626090605.GA4349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 19:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3EcV-0004Ng-R6
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 19:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbXFZROM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 13:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbXFZROM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 13:14:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54506 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756796AbXFZROK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 13:14:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QHD3IS020261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 10:13:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QHCwUe030497;
	Tue, 26 Jun 2007 10:12:58 -0700
In-Reply-To: <20070626090605.GA4349@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.609 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50967>



On Tue, 26 Jun 2007, Jeff King wrote:
> 
> I think flushing here is a good change regardless of the error checking.
> Sometimes, when you are severely limiting commits, the whole output is
> smaller than the buffer, and you end up waiting a long time for any
> output even though your answer may have been found immediately.

Exactly. That's why it was done in git-rev-list, and why it's good to do 
in "git log" too.

The slowdown worries me a bit, but it's only noticeable with *lots* of 
output - ie no path limiting (and no diffs - the diff generation becomes 
the bottleneck if you do diffs). So the flushing slows down a case that we 
do ridiculously well right now, so I doubt anybody will really care.

It's more a benchmarking issue: "we can show the whole log of the kernel 
in under two seconds", and it didn't slow down *that* much.

> For example, 'git-whatchanged -Sfoo' when 'foo' was introduced in the
> last couple of commits (but wasn't referenced before) will have to
> calculate diffs on all of history before producing output. Flushing
> after every commit restores the illusion that git provides your answer
> instaneously. :)

On that note, it should probably also do it for the incremental output of 
git blame.

		Linus
---

diff --git a/builtin-blame.c b/builtin-blame.c
index f7e2c13..86ab6c7 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1459,6 +1459,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 				printf("boundary\n");
 		}
 		write_filename_info(suspect->path);
+		flush_or_die(stdout, "stdout");
 	}
 }
 
