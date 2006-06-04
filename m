From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git clone takes ages on a slow link
Date: Sun, 4 Jun 2006 10:48:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041046340.5498@g5.osdl.org>
References: <20060604010145.GC986@krispykreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 04 19:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmwiQ-0004Jp-2M
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 19:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFDRsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWFDRsi
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 13:48:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWFDRsh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 13:48:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54HmW2g001793
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 10:48:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54HmV5s020605;
	Sun, 4 Jun 2006 10:48:31 -0700
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060604010145.GC986@krispykreme>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21270>



On Sun, 4 Jun 2006, Anton Blanchard wrote:
> 
> I think the ticker is over anxious.

It is indeed. It's _meant_ to only tick once a second or when the 
percentage changes, but I think it forgot to clear the "once a second 
happened" flag, so instead of updates the percentage output for every 
file it checks out after the first second has passed.

So something like this should help... Can you verify?

		Linus
---
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 716f792..80c9320 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -336,6 +336,7 @@ static void check_updates(struct cache_e
 					fprintf(stderr, "%4u%% (%u/%u) done\r",
 						percent, cnt, total);
 					last_percent = percent;
+					progress_update = 0;
 				}
 			}
 		}
