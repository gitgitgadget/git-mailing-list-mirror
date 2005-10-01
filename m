From: Linus Torvalds <torvalds@osdl.org>
Subject: Flag empty patches as errors
Date: Fri, 30 Sep 2005 23:25:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509302320560.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Oct 01 08:26:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELaoN-0003u6-TY
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 08:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVJAGZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVJAGZ3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 02:25:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbVJAGZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 02:25:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j916PO4s006418
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Sep 2005 23:25:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j916PN2J008492;
	Fri, 30 Sep 2005 23:25:23 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9587>


A patch that contains no actual diff, and that doesn't change any 
meta-data is bad. It shouldn't be a patch at all, and git-apply shouldn't 
just accept it.

This caused a corrupted patch to be silently applied as an empty change in 
the kernel, because the corruption ended up making the patch look empty.

An example of such a patch is one that contains the patch header, but 
where the initial fragment header (the "@@ -nr,.." line) is missing, 
causing us to not parse any fragments.

The real "patch" program will also flag such patches as bad, with the 
message

	patch: **** Only garbage was found in the patch input.

and we should do likewise.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -723,6 +723,16 @@ static int parse_single_patch(char *line
 	return offset;
 }
 
+static inline int metadata_changes(struct patch *patch)
+{
+	return	patch->is_rename > 0 ||
+		patch->is_copy > 0 ||
+		patch->is_new > 0 ||
+		patch->is_delete ||
+		(patch->old_mode && patch->new_mode &&
+		 patch->old_mode != patch->new_mode);
+}
+
 static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
@@ -733,6 +743,9 @@ static int parse_chunk(char *buffer, uns
 
 	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
 
+	if (!patchsize && !metadata_changes(patch))
+		die("patch with only garbage at line %d", linenr);
+
 	return offset + hdrsize + patchsize;
 }
 
