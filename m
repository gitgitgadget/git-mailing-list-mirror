From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: va_copy is not available on all systems.
Date: Mon, 20 Aug 2007 21:15:09 +0200
Message-ID: <20070820191509.GB5544@steel.home>
References: <46C99448.2AB33DFF@eudaptics.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INCie-0003SN-NH
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761177AbXHTTPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760923AbXHTTPP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:15:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:58727 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760663AbXHTTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:15:13 -0400
Received: from tigra.home (Fab03.f.strato-dslnet.de [195.4.171.3])
	by post.webmailer.de (mrclete mo4) (RZmta 11.0)
	with ESMTP id h011fbj7KFk7we ; Mon, 20 Aug 2007 21:15:09 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 842F4277BD;
	Mon, 20 Aug 2007 21:15:09 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1F6A0BDFC; Mon, 20 Aug 2007 21:15:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46C99448.2AB33DFF@eudaptics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJAI
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56240>

Johannes Sixt, Mon, Aug 20, 2007 15:16:56 +0200:
> Since va_copy() must be provided by the compiler, we don't have a
> reasonable chance to provide a working definition in git_compat_util.h.

Maybe we don't have to:

Subject: [PATCH] Avoid using va_copy in fast-import: it seem to be unportable

diff --git a/fast-import.c b/fast-import.c
index 2d5224c..04948e9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -375,7 +375,7 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 	fputc('\n', rpt);
 }
 
-static void write_crash_report(const char *err, va_list params)
+static void write_crash_report(const char *err)
 {
 	char *loc = git_path("fast_import_crash_%d", getpid());
 	FILE *rpt = fopen(loc, "w");
@@ -396,9 +396,7 @@ static void write_crash_report(const char *err, va_list params)
 	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
 	fputc('\n', rpt);
 
-	fputs("fatal: ", rpt);
-	vfprintf(rpt, err, params);
-	fputc('\n', rpt);
+	fprintf(rpt, "fatal: %s\n", err);
 
 	fputc('\n', rpt);
 	fputs("Most Recent Commands Before Crash\n", rpt);
@@ -442,18 +440,15 @@ static void write_crash_report(const char *err, va_list params)
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
-	va_list x_params;
+	char message[BUFSIZ];
 
-	va_copy(x_params, params);
-	fputs("fatal: ", stderr);
-	vfprintf(stderr, err, params);
-	fputc('\n', stderr);
+	vsnprintf(message, sizeof(message), err, params);
+	fprintf(stderr, "fatal: %s\n", message);
 
 	if (!zombie) {
 		zombie = 1;
-		write_crash_report(err, x_params);
+		write_crash_report(message);
 	}
-	va_end(x_params);
 	exit(128);
 }
 
