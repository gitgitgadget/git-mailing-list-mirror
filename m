From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Don't ever return corrupt objects from "parse_object()"
Date: Tue, 20 Mar 2007 10:05:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703200953250.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HThmH-0004r6-Eq
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 18:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965489AbXCTRFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 13:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXCTRFa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 13:05:30 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48026 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965489AbXCTRF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 13:05:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2KH5NcD013652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Mar 2007 10:05:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2KH5Kcv006017;
	Tue, 20 Mar 2007 09:05:22 -0800
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42754>


Looking at the SHA1 validation code due to the corruption that Alexander 
Litvinov is seeing under Cygwin, I notice that one of the most central 
places where we read objects, we actually do end up verifying the SHA1 of 
the result, but then we happily parse it anyway.

And using "printf" to write the error message means that it not only can 
get lost, but will actually mess up stdout, and cause other strange and 
hard-to-debug failures downstream.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Of course, messing up stdout is actually a good way to make sure that 
anything that pipes stdout to another process will cause a failure in the 
reading process, which is likely why we did it that way in the first 
place. But any pipeline really *should* check the source process exit 
status anyway, and it looks rather dangerous to return a valid object as 
if nothing bad had happened!

NOTE! A lot of things don't do a "parse_object" at all, but use the raw 
"read_sha1_file()" interface. So this won't catch all corrupted objects 
when they are used, but since we already did the check there, we should at 
least do the right thing.

		Linus

---
 object.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 5b46889..78a44a6 100644
--- a/object.c
+++ b/object.c
@@ -184,8 +184,10 @@ struct object *parse_object(const unsigned char *sha1)
 
 	if (buffer) {
 		struct object *obj;
-		if (check_sha1_signature(sha1, buffer, size, typename(type)) < 0)
-			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
+		if (check_sha1_signature(sha1, buffer, size, typename(type)) < 0) {
+			error("sha1 mismatch %s\n", sha1_to_hex(sha1));
+			return NULL;
+		}
 
 		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
