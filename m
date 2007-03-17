From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Make trivial wrapper functions around delta base generation
 and freeing
Date: Sat, 17 Mar 2007 12:42:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171240210.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSenV-0001J6-Lb
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 20:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbXCQTmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbXCQTmf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 15:42:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42799 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbXCQTme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 15:42:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HJgGcD008793
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 12:42:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HJgFOF008783;
	Sat, 17 Mar 2007 11:42:15 -0800
In-Reply-To: <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42449>


This doesn't change any code, it just creates a point for where we'd
actually do the caching of delta bases that have been generated.
    
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Done this way to make all the changes as obvious as possible.


diff --git a/sha1_file.c b/sha1_file.c
index 110d696..f11ca3f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1352,6 +1352,18 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
+static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+	unsigned long *base_size, enum object_type *type)
+{
+	return unpack_entry(p, base_offset, type, base_size);
+}
+
+static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
+	void *base, unsigned long base_size, enum object_type type)
+{
+	free(base);
+}
+
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
 				off_t curpos,
@@ -1365,7 +1377,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
-	base = unpack_entry(p, base_offset, type, &base_size);
+	base = cache_or_unpack_entry(p, base_offset, &base_size, type);
 	if (!base)
 		die("failed to read delta base object"
 		    " at %"PRIuMAX" from %s",
@@ -1378,7 +1390,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	if (!result)
 		die("failed to apply delta");
 	free(delta_data);
-	free(base);
+	add_delta_base_cache(p, base_offset, base, base_size, *type);
 	return result;
 }
 
