From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [POSSIBLE REGRESSION] Spurious revs after patch "revision.c:
 --full-history fix"
Date: Sun, 2 Jul 2006 10:14:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607021012180.12404@g5.osdl.org>
References: <e5bfff550607020519k6007f41bne34d10c0e919f3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 19:14:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx5Wv-0005Vv-1g
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 19:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGBROm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWGBROm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 13:14:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932126AbWGBROl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 13:14:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k62HEanW016613
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Jul 2006 10:14:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k62HEZNI011711;
	Sun, 2 Jul 2006 10:14:36 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550607020519k6007f41bne34d10c0e919f3c8@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23107>



On Sun, 2 Jul 2006, Marco Costalba wrote:
> 
> What it seems is that with --parents  option two more spurious revs
> are printed out. This revs have nothing to do with builtin-add.c, the
> file is newer then both of them.

Gaah. Does this trivial patch fix it for you?

It had the wrong test for whether a commit was a merge. What it did was to 
say that a non-merge has exactly one parent (which sounds almost right), 
but the fact is, initial trees have no parent at all, but they're 
obviously not merges.

So the test for non-merge should be "!parents || !parents->next", not 
"parents && !parents->next".

		Linus

----
diff --git a/revision.c b/revision.c
index 1cf6276..880fb7b 100644
--- a/revision.c
+++ b/revision.c
@@ -997,7 +997,7 @@ struct commit *get_revision(struct rev_i
 				if (!revs->parents)
 					continue;
 				/* non-merge - always ignore it */
-				if (commit->parents && !commit->parents->next)
+				if (!commit->parents || !commit->parents->next)
 					continue;
 			}
 			if (revs->parents)
