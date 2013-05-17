From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] for-each-ref: introduce color format
Date: Fri, 17 May 2013 20:25:52 +0530
Message-ID: <1368802552-16024-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 16:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdM30-0006RM-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 16:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab3EQOyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 10:54:14 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63908 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab3EQOyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 10:54:13 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3396146pdj.38
        for <git@vger.kernel.org>; Fri, 17 May 2013 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=P/40VPFY6rplolb6o4mfgrKc7/lqPbAUdvVJyOszBZM=;
        b=lxRkTq86Laq91rsr6nNZHxuceXeh+ksV246lh+wuTgJ0itBqVcnwm8NAReyY2YXnk4
         3a0IbNcpsk8ajEuybrDrP95g8S9/GRfQuMvu1/XqtV4gGX9AwaGAxUUjoBdFVXD0Nv3v
         TcAqQsR0Ti6JKe2BQBct0rZe/3aIjbwlSfQhZGoFtxNFGmLM8R3mLGcTwLOuoCpBHT51
         TYHhOmsASsJdZY0Hrga75v5szak4t+g1BvEjeGUEkgfGhMqOW2j01VGjMDQLzYqIxkJT
         cutP27RdsIK2f5dH3u5APphbr2HIKUKkMAJtaG2ttm3T0SzL75T1/AmBNAnayM8esDTC
         Yj/Q==
X-Received: by 10.68.129.10 with SMTP id ns10mr49003923pbb.13.1368802453275;
        Fri, 17 May 2013 07:54:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm11514111pbc.22.2013.05.17.07.54.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 07:54:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.13.g629b60a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224692>

You can now do something like

$ git for-each-ref --format='%C(red)%(refname:short)%C(reset)
%C(blue)%(upstream:diff)%C(reset)' --count 5 --sort='-committerdate'
refs/heads

To get output that's much more customizable 'git branch' output.  Future
patches will attempt unify the semantics of 'git branch' and 'git
for-each-ref'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 So my evil plan is to keep extending this format until it's on par
 with pretty-formats.  Then, we can move towards unifying 'git branch'
 and 'git for-each-ref'.  This will involve deprecating badly
 thought-out options like '-v', and replacing it with the more
 powerful '--format'.

 I just have one major doubt: in the above output, how do I align all
 the upstream branches to the same column?  How can I achieve it with
 pretty-formats?  Something like %*d?  But * is already taken to mean
 deref in for-each-ref's --format.

 By the way, the main motivation for all this comes from the fact that
 git for-each-ref is very nicely written :) Look at how it breaks
 everything up into atoms and lazily gets the information it needs to
 display.

 builtin/for-each-ref.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7f059c3..1563b25 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "color.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -155,10 +156,13 @@ static const char *find_next(const char *cp)
 	while (*cp) {
 		if (*cp == '%') {
 			/*
+			 * %C( is the start of a color;
 			 * %( is the start of an atom;
 			 * %% is a quoted per-cent.
 			 */
-			if (cp[1] == '(')
+			if (cp[1] == 'C' && cp[2] == '(')
+				return cp;
+			else if (cp[1] == '(')
 				return cp;
 			else if (cp[1] == '%')
 				cp++; /* skip over two % */
@@ -180,8 +184,12 @@ static int verify_format(const char *format)
 		const char *ep = strchr(sp, ')');
 		if (!ep)
 			return error("malformed format string %s", sp);
-		/* sp points at "%(" and ep points at the closing ")" */
-		parse_atom(sp + 2, ep);
+		/*
+		 * Ignore color specifications: %C(
+		 * sp points at "%(" and ep points at the closing ")"
+		 */
+		if (prefixcmp(sp, "%C("))
+			parse_atom(sp + 2, ep);
 		cp = ep + 1;
 	}
 	return 0;
@@ -928,12 +936,22 @@ static void emit(const char *cp, const char *ep)
 static void show_ref(struct refinfo *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	char color[COLOR_MAXLEN];
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		print_value(info, parse_atom(sp + 2, ep), quote_style);
+
+		/* Do we have a color specification? */
+		if (!prefixcmp(sp, "%C("))
+			color_parse_mem(sp + 3,
+					ep - sp - 3,
+					"--format ", color);
+		else {
+			printf("%s", color);
+			print_value(info, parse_atom(sp + 2, ep), quote_style);
+		}
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-- 
1.8.3.rc2.13.g629b60a.dirty
