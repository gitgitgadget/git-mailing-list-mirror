From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] revision traversal: --author, --committer, and
 --grep.
Date: Mon, 18 Sep 2006 10:07:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609181001361.4388@g5.osdl.org>
References: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
 <20060918060552.GA2833@coredump.intra.peff.net> <7vslipsm4x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Kai Blin <kai.blin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 18 19:08:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPMbF-0003Se-SP
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 19:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWIRRIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWIRRIB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 13:08:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965287AbWIRRIA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 13:08:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8IH7qnW001648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Sep 2006 10:07:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8IH7puQ013936;
	Mon, 18 Sep 2006 10:07:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslipsm4x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-1.007 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27251>



On Sun, 17 Sep 2006, Junio C Hamano wrote:
> 
> I wanted to default it to left anchored, so this was somewhat
> deliberate, but this is probably subject to taste.

I know that I'd prefer a rule where

 "--author=^Junio"

would result in the grep-pattern being "^author Junio", but without the 
initial '^' it would be "^author .*Junio".

So something like this, perhaps? It allows the regular left anchoring 
syntax ('^' at the start of a pattern), but defaults to the default grep 
behaviour ("anywhere in the line").

		Linus

---
diff --git a/revision.c b/revision.c
index 26dd418..bca1229 100644
--- a/revision.c
+++ b/revision.c
@@ -677,6 +677,7 @@ int handle_revision_arg(const char *arg,
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
 {
 	char *pat;
+	const char *prefix;
 	int patlen, fldlen;
 
 	if (!revs->header_filter) {
@@ -689,8 +690,13 @@ static void add_header_grep(struct rev_i
 
 	fldlen = strlen(field);
 	patlen = strlen(pattern);
-	pat = xmalloc(patlen + fldlen + 3);
-	sprintf(pat, "^%s %s", field, pattern);
+	pat = xmalloc(patlen + fldlen + 10);
+	prefix = ".*";
+	if (*pattern == '^') {
+		prefix = "";
+		pattern++;
+	}
+	sprintf(pat, "^%s %s%s", field, prefix, pattern);
 	append_grep_pattern(revs->header_filter, pat,
 			    "command line", 0, GREP_PATTERN);
 }
