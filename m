From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned
 repositories
Date: Fri, 4 Nov 2005 14:07:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511041359050.28804@g5.osdl.org>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de>
 <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net> <20051104210820.GM1431@pasky.or.cz>
 <7voe50rskh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 23:09:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9jM-0006d9-GU
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVKDWIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVKDWIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:08:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751008AbVKDWIC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 17:08:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA4M7onO012324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Nov 2005 14:07:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA4M7mF6024010;
	Fri, 4 Nov 2005 14:07:49 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe50rskh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11165>



On Fri, 4 Nov 2005, Junio C Hamano wrote:
> 
> I agree with you violently.  I just do not know what is the
> right convention to tell which is private and which is not.

I don't like the dot idea, but it certainly _would_ make sense to have a 
local prefix.

We could even make it a _totally_ different namespace:

	.git/refs/local/heads
	.git/refs/local/tags

which means that even if you call a local head the same thing as a global 
one, both can still exist.

Then, make "origin" always be a local head.

That avoids the issue of the remote repo _also_ having an "origin" branch.

Locally, the "local" heads would always take precedence, with this trivial 
patch making sure of that.. 

If you want to access a global tag or head, you can always do so by using 
the full path ("refs/tags/tagname" is the global one, but "tags/tagname" 
or "tagname" would be the local one if one exists).

		Linus

---
diff --git a/sha1_name.c b/sha1_name.c
index be1755a..5daaa11 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -231,6 +231,8 @@ static int get_sha1_basic(const char *st
 	static const char *prefix[] = {
 		"",
 		"refs",
+		"refs/local/tags",
+		"refs/local/heads",
 		"refs/tags",
 		"refs/heads",
 		NULL
