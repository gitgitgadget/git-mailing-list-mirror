From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: file disappears after git rebase (missing one commit)
Date: Sat, 18 Aug 2007 13:01:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org>
References: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMUV2-00080d-31
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 22:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbXHRUBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759038AbXHRUBh
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 16:01:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34602 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759022AbXHRUBb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2007 16:01:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IK1Aja021390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2007 13:01:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IK15nF009697;
	Sat, 18 Aug 2007 13:01:05 -0700
In-Reply-To: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com>
X-Spam-Status: No, hits=-2.452 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56110>



On Sat, 18 Aug 2007, Torgil Svensson wrote:
>
> $ git rebase devel
> First, rewinding head to replay your work on top of it...
> HEAD is now at 57aa840... Add disk summarize tool (du.exe)
> Nothing to do.

Ok. "git rebase" really does believe that there's nothing to do.

The reason, I think, is that I suspect that the newly added file is a 
binary file, no? That, in turn, will mean that the *patch* will have no 
patch ID (or rather, it will have an empty patch ID) - which in turn will 
make it invisible to "--ignore-if-in-upstream" if there are already some 
*other* patches that also just adds a binary file (which I think there is: 
I think upstream has "Add disk summarize tool (du.exe)" which I assume has 
exactly the same patch fingerprint).

In other words, "git rebase" really is just a series of cherry-picks, but 
it avoids patches that have the same patch ID as something that is already 
upstream. That helps *enormously*, but it so happens that the patch ID's 
don't work really well for binary diffs.

Try this patch - see if it helps. Totally untested! It will enable patch 
ID's on binary diffs too, which should avoid this issue.

		Linus

---
diff --git a/patch-ids.c b/patch-ids.c
index a288fac..4a3432e 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -122,6 +122,7 @@ int init_patch_ids(struct patch_ids *ids)
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	ids->diffopts.recursive = 1;
+	ids->diffopts.binary = 1;
 	if (diff_setup_done(&ids->diffopts) < 0)
 		return error("diff_setup_done failed");
 	return 0;
