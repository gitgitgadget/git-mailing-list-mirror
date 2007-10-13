From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sun, 14 Oct 2007 00:14:50 +0200
Message-ID: <20071013221450.GC2875@steel.home>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <20071013191655.GA2875@steel.home> <20071013205404.GK7110@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 00:15:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgpGC-0001J2-0Y
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 00:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389AbXJMWOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbXJMWOy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 18:14:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:54230 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791AbXJMWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 18:14:53 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo25) (RZmta 13.4)
	with ESMTP id 202d90j9DJYAQD ; Sun, 14 Oct 2007 00:14:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9458C277AE;
	Sun, 14 Oct 2007 00:14:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6102D56D22; Sun, 14 Oct 2007 00:14:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071013205404.GK7110@artemis.corp>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60781>

Pierre Habouzit, Sat, Oct 13, 2007 22:54:04 +0200:
> On Sat, Oct 13, 2007 at 07:16:55PM +0000, Alex Riesen wrote:
> > Pierre Habouzit, Sat, Oct 13, 2007 15:29:03 +0200:
> > BTW, if you just printed the usage message out (it is about usage of a
> > program, isn't it?) and called exit() everyone would be just as happy.
> > And you wouldn't have to include strbuf (it is the only use of it),
> > less code, too. It'd make simplier to stea^Wcopy your implementation,
> > which I like :)
> 
>   the reason is that usage() is a wrapper around a callback, and I
> suppose it's used by some GUI's or anything like that.

It is not. Not yet. What could they use a usage text for?
Besides, you could just export the callback (call_usage_callback or
something) from usage.c and call it.

>   FWIW you can rework the .c like this:

on top of yours:

From: Alex Riesen <raa.lkml@gmail.com>
Date: Sun, 14 Oct 2007 00:10:51 +0200
Subject: [PATCH] Rework make_usage to print the usage message immediately

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 parse-options.c |   60 ++++++++++++++++++++++++------------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 07abb50..1e3940f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
-#include "strbuf.h"
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -171,57 +170,52 @@ int parse_options(int argc, const char **argv,
 
 void make_usage(const char * const usagestr[], struct option *opts, int cnt)
 {
-	struct strbuf sb;
-
-	strbuf_init(&sb, 4096);
-	do {
-		strbuf_addstr(&sb, *usagestr++);
-		strbuf_addch(&sb, '\n');
-	} while (*usagestr);
+	fprintf(stderr, "usage: ");
+	while (*usagestr)
+		fprintf(stderr, "%s\n", *usagestr++);
 
 	if (cnt && opts->type != OPTION_GROUP)
-		strbuf_addch(&sb, '\n');
+		fputc('\n', stderr);
 
 	for (; cnt-- > 0; opts++) {
 		size_t pos;
 
 		if (opts->type == OPTION_GROUP) {
-			strbuf_addch(&sb, '\n');
+			fputc('\n', stderr);
 			if (*opts->help)
-				strbuf_addf(&sb, "%s\n", opts->help);
+				fprintf(stderr, "%s\n", opts->help);
 			continue;
 		}
 
-		pos = sb.len;
-		strbuf_addstr(&sb, "    ");
-		if (opts->short_name) {
-			strbuf_addf(&sb, "-%c", opts->short_name);
-		}
-		if (opts->long_name) {
-			strbuf_addf(&sb, opts->short_name ? ", --%s" : "--%s",
-						opts->long_name);
-		}
+		pos = fprintf(stderr, "    ");
+		if (opts->short_name)
+			pos += fprintf(stderr, "-%c", opts->short_name);
+		if (opts->long_name)
+			pos += fprintf(stderr,
+				       opts->short_name ? ", --%s" : "--%s",
+				       opts->long_name);
 		switch (opts->type) {
 		case OPTION_INTEGER:
-			strbuf_addstr(&sb, " <n>");
+			fputs(" <n>", stderr);
+			pos += 4;
 			break;
 		case OPTION_STRING:
-			if (opts->argh) {
-				strbuf_addf(&sb, " <%s>", opts->argh);
-			} else {
-				strbuf_addstr(&sb, " ...");
+			if (opts->argh)
+				pos += fprintf(stderr, " <%s>", opts->argh);
+			else {
+				fputs(" ...", stderr);
+				pos += 4;
 			}
 			break;
 		default:
 			break;
 		}
-		if (sb.len - pos <= USAGE_OPTS_WIDTH) {
-			int pad = USAGE_OPTS_WIDTH - (sb.len - pos) + USAGE_GAP;
-			strbuf_addf(&sb, "%*s%s\n", pad, "", opts->help);
-		} else {
-			strbuf_addf(&sb, "\n%*s%s\n", USAGE_OPTS_WIDTH + USAGE_GAP, "",
-						opts->help);
-		}
+		if (pos <= USAGE_OPTS_WIDTH) {
+			int pad = USAGE_OPTS_WIDTH - pos + USAGE_GAP;
+			fprintf(stderr, "%*s%s\n", pad, "", opts->help);
+		} else
+			fprintf(stderr, "\n%*s%s\n",
+				USAGE_OPTS_WIDTH + USAGE_GAP, "", opts->help);
 	}
-	usage(sb.buf);
+	exit(129);
 }
-- 
1.5.3.4.232.ga843
