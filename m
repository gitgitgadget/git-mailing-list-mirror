From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sun, 26 Feb 2006 19:05:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261900370.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
 <Pine.LNX.4.63.0602270257110.4147@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 04:05:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDYhf-0004TU-Bu
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 04:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWB0DFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 22:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWB0DFX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 22:05:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWB0DFW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 22:05:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1R35CDZ026255
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 19:05:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1R358wv004086;
	Sun, 26 Feb 2006 19:05:10 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602270257110.4147@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16822>



On Mon, 27 Feb 2006, Johannes Schindelin wrote:
> 
> beware of that patch. It breaks at least one thing: cloning a repository 
> with a tag pointing to a tag object (the tag is cloned, but not the tag 
> object).
> 
> Sorry to not fix it right away, but I am just too tired.

Ahh. I know what it is.

I'm pretty sure this trivial and stupid patch on top of the patch I sent 
out should fix it.

Duh. I moved "pending_objects" into the "revs" structure, but didn't 
remove the stale one, along with its use.

		Linus

---
diff --git a/rev-list.c b/rev-list.c
index d1c52a6..e9e371c 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -214,8 +214,6 @@ static struct object_list **process_tree
 	return p;
 }
 
-static struct object_list *pending_objects = NULL;
-
 static void show_commit_list(struct commit_list *list)
 {
 	struct object_list *objects = NULL, **p = &objects, *pending;
@@ -226,7 +224,7 @@ static void show_commit_list(struct comm
 		if (process_commit(commit) == STOP)
 			break;
 	}
-	for (pending = pending_objects; pending; pending = pending->next) {
+	for (pending = revs.pending_objects; pending; pending = pending->next) {
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
