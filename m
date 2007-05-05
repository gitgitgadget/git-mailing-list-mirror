From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FFmpeg considering GIT
Date: Sat, 5 May 2007 15:18:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Hasselstr?m <kha@treskal.com>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 00:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkSaD-0006Rx-Kr
	for gcvg-git@gmane.org; Sun, 06 May 2007 00:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934045AbXEEWSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934048AbXEEWSZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 18:18:25 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52170 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934045AbXEEWSY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 18:18:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l45MI7CV015531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 May 2007 15:18:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l45MI3p9030126;
	Sat, 5 May 2007 15:18:03 -0700
In-Reply-To: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.982 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46288>



On Sat, 5 May 2007, Linus Torvalds wrote:
> 
> This patch may be worth applying regardless, since there is really no real 
> reason to use "git rev-list". In fact, I really like the ability to say
> 
> 	gitk --stat
> 
> and have the diffstat output visible in the commit window automatically ;)

Btw, testing this a bit more actually shows what I would consider a real 
buglet in "git log --boundary": the option would be honoured only if 
"left-right" was enabled.

This patch fixes "git log --boundary" to actually show the "-" in front of 
a commit name regardless of whether you _also_ asked for left-right.

(It also shows that my "gitk" patch was incorrectly getting the commit 
name from character 6 onward, even though it should have been 7, but I'll 
also try to make gitk understand the "<" and ">" markers, and make it 
possible to say

	gitk --left-right a...b

and have the commits colored appropriately. That would be cool, but it 
might need more tcl/tk knowledge than I actually possess).

		Linus

---
diff --git a/log-tree.c b/log-tree.c
index c679324..4bef909 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -244,10 +244,10 @@ void show_log(struct rev_info *opt, const char *sep)
 		      stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
 			fputs("commit ", stdout);
-		if (opt->left_right) {
-			if (commit->object.flags & BOUNDARY)
-				putchar('-');
-			else if (commit->object.flags & SYMMETRIC_LEFT)
+		if (commit->object.flags & BOUNDARY)
+			putchar('-');
+		else if (opt->left_right) {
+			if (commit->object.flags & SYMMETRIC_LEFT)
 				putchar('<');
 			else
 				putchar('>');
