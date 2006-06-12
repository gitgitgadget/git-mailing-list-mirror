From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cvsps wierdness
Date: Mon, 12 Jun 2006 14:27:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121406200.5498@g5.osdl.org>
References: <200606122247.02727.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 23:27:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fptwc-00019a-Gk
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWFLV1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWFLV1b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 17:27:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbWFLV1a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 17:27:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CLRGgt002664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 14:27:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CLRFNe004133;
	Mon, 12 Jun 2006 14:27:16 -0700
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <200606122247.02727.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21740>



On Mon, 12 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> 
> The script creates a small CVS repo with three commits on two files. What's 
> odd is that cvsps lists revision 1.2 of the file v.txt *before* version 1.1, 
> like this:

What seems to happen is that the two changes to v.txt are broken up into 
separate changesets (because they touch the same file), but then the 
_first_ one is merged with the changeset that contains the k.txt change 
(because they have the same log message, and roughly the same date).

Then, because it has the earlier date, that combined changeset ends up 
being considered to be "before" the later one, even though it contains a 
version of v.txt that is newer.

Does this patch fix it for you (untested - it could result in tons of 
other trouble, but it basically just says that time ordering is less 
important than member revision ordering).

I don't think this is strictly correct, btw. I suspect you can still get 
into strange situations where the changeset merging has resulted in one 
file ordering one way, and another file ordering the other way. 

I really don't think cvsps is really very good about this.

		Linus

---
diff --git a/cvsps.c b/cvsps.c
index 2695a0f..daa93a3 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -1662,14 +1662,14 @@ static int compare_patch_sets_bytime(con
      * know that insertions are unique at this point.
      */
 
-    diff = ps1->date - ps2->date;
-    if (diff)
-	return (diff < 0) ? -1 : 1;
-
     ret = compare_patch_sets_by_members(ps1, ps2);
     if (ret)
 	return ret;
 
+    diff = ps1->date - ps2->date;
+    if (diff)
+	return (diff < 0) ? -1 : 1;
+
     ret = strcmp(ps1->author, ps2->author);
     if (ret)
 	return ret;
