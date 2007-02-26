From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 10:43:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 19:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLkof-0008CB-Md
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 19:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbXBZSmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 13:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbXBZSmv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 13:42:51 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56442 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030428AbXBZSmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 13:42:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QIglhB002063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 10:42:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QIgkqd027697;
	Mon, 26 Feb 2007 10:42:47 -0800
X-Spam-Status: No, hits=-0.449 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40639>


I'm not proud of this patch, and I think we should do this better, but I 
just had trouble with an email that Eric Biederman sent me for the kernel, 
and this is the simplest and most obvious fix..

What happened is that Eric's email had a long and complex "References:" 
line in his email headers, and the way git-mailinfo parses email headers, 
it will combine these multi-line headers into one single long line (which 
is appropriate for things like Subject lines etc, where everybody really 
wants to just have one long subject rather than know about rfc822 email 
message rules).

However, with the extensive references, the end result was longer than the 
one thousand character line limit we had, and what git-mailinfo did was to 
just stop parsing header lines. The end result: it never parsed the 
"Date:" line at all, and it left all subsequent email header lines as 
"commit info" contents instead. Very ugly.

Arguably that is the real bug (we should continue with header parsing), 
but the trivial work-around is to just make the line buffer bigger.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I'll look at making the parsing more robust too, but thought I'd send this 
out asap.

		Linus

---
 builtin-mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6ee6b0b..3f0e08a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -10,7 +10,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 
 static int keep_subject;
 static const char *metainfo_charset;
-static char line[1000];
+static char line[10000];
 static char date[1000];
 static char name[1000];
 static char email[1000];
