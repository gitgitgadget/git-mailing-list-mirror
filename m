From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending
 line
Date: Tue, 23 May 2006 19:08:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
 <7vd5e4z2je.fsf@assigned-by-dhcp.cox.net> <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 04:08:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiinL-0004fm-On
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEXCIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWEXCIK
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:08:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWEXCIJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:08:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4O283tH008365
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 19:08:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4O2815k029653;
	Tue, 23 May 2006 19:08:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20656>



On Tue, 23 May 2006, Junio C Hamano wrote:
> 
> Come to think of it, the above argument is bogus.  We _would_
> want to make EOF just like any other context lines.
> 
> The issue is if we can reliably tell if there is such an EOF
> context by looking at the diff.  Not having the same number of
> lines that starts with ' ' in the hunk is not really a nice way
> of doing so (you could make a unified diff that does not have
> trailing context at all), and I do not offhand think of a good
> way to do so.

We can. Something like this should do it.

(The same thing could be done for "match_beginning", perhaps).

Totally untested, of course.

(It might be better to pass in "match_end" to find_offset(), so that it 
could do the "look forwards" pass to see if it finds a better line offset 
that is at the end - as it is, this will _fail_ the patch if it could 
apply better at a non-end thing, even if it would _also_ have applied at 
the end of the file).

		Linus
---
diff --git a/apply.c b/apply.c
index 0ed9d13..905bf34 100644
--- a/apply.c
+++ b/apply.c
@@ -1333,6 +1333,7 @@ static int apply_line(char *output, cons
 
 static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag)
 {
+	int match_end;
 	char *buf = desc->buffer;
 	const char *patch = frag->patch;
 	int offset, size = frag->size;
@@ -1395,10 +1396,20 @@ #endif
 	newlines = new;
 	leading = frag->leading;
 	trailing = frag->trailing;
+
+	/*
+	 * If we don't have any trailing data in the patch,
+	 * we want to match the final ending '\0' byte in
+	 * the file too..
+	 */
+	match_end = !trailing;
+
 	lines = 0;
 	pos = frag->newpos;
 	for (;;) {
 		offset = find_offset(buf, desc->size, oldlines, oldsize, pos, &lines);
+		if (match_end && offset + oldsize != desc->size)
+			offset = -1;
 		if (offset >= 0) {
 			int diff = newsize - oldsize;
 			unsigned long size = desc->size + diff;
@@ -1428,6 +1439,10 @@ #endif
 		/* Am I at my context limits? */
 		if ((leading <= p_context) && (trailing <= p_context))
 			break;
+		if (match_end) {
+			match_end = 0;
+			continue;
+		}
 		/* Reduce the number of context lines
 		 * Reduce both leading and trailing if they are equal
 		 * otherwise just reduce the larger context.
