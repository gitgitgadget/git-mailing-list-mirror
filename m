From: Linus Torvalds <torvalds@osdl.org>
Subject: Add support for negative refs
Date: Mon, 11 Sep 2006 20:10:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609112008500.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 05:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMyfW-0007n2-2m
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 05:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWILDK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 23:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWILDK0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 23:10:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751193AbWILDKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 23:10:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8C3AKnW012243
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 20:10:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8C3AFo2005807;
	Mon, 11 Sep 2006 20:10:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.52 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26878>


You can remove a ref that is packed two different ways: either simply
repack all the refs without that one, or create a loose ref that has the
magic all-zero SHA1.

This also adds back the test that a ref actually has the object it
points to.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This one is trivial, and obviously depends on the previous series.

I'm sending it just because I have a much bigger cleanup that I'd _really_ 
like to go in, and I did this trivial one before that much more 
interesting one.

diff --git a/refs.c b/refs.c
index 5f80a68..72e2283 100644
--- a/refs.c
+++ b/refs.c
@@ -280,6 +280,12 @@ static int do_for_each_ref(const char *b
 		}
 		if (strncmp(base, entry->name, trim))
 			continue;
+		if (is_null_sha1(entry->sha1))
+			continue;
+		if (!has_sha1_file(entry->sha1)) {
+			error("%s does not point to a valid object!", entry->name);
+			continue;
+		}
 		retval = fn(entry->name + trim, entry->sha1);
 		if (retval)
 			return retval;
