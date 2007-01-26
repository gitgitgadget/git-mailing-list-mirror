From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 16:51:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 01:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAFJR-0008OZ-PB
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 01:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbXAZAv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 19:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030690AbXAZAv0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 19:51:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39060 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030688AbXAZAv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 19:51:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0Q0pNgP016260
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Jan 2007 16:51:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0Q0pM8M003471;
	Thu, 25 Jan 2007 16:51:22 -0800
X-Spam-Status: No, hits=-0.501 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37789>


Do *NOT* try this on a repository you care about:

	git pack-refs --all --prune
	git pack-refs

because while the first "pack-refs" does the right thing, the second 
pack-refs will totally screw you over.

Why? 

The default for "git pack-refs" is to pack just tags. Which is a HORRIBLE 
MISTAKE. Becuase it means that if you actually had any packed non-tags, 
they now get removed entirely.

I'd call whoever made that decision a complete crack-addict and total 
idiot, but it might be me, so I'll just tread carefully and call the 
choice "interesting".

This should fix it.

		Linus
----
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 6de7128..3de9b3e 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -37,7 +37,9 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	if ((flags & REF_ISSYMREF))
 		return 0;
 	is_tag_ref = !strncmp(path, "refs/tags/", 10);
-	if (!cb->all && !is_tag_ref)
+
+	/* ALWAYS pack refs that were already packed or are tags */
+	if (!cb->all && !is_tag_ref && !(flags & REF_ISPACKED))
 		return 0;
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
