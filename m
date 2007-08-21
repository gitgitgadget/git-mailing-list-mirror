From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: va_copy is not available on all systems.
Date: Mon, 20 Aug 2007 23:38:14 -0400
Message-ID: <20070821033813.GF27913@spearce.org>
References: <46C99448.2AB33DFF@eudaptics.com> <20070820191509.GB5544@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 05:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INKZy-0005s0-Mb
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 05:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbXHUDiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 23:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbXHUDiX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 23:38:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50486 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXHUDiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 23:38:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INKZ9-0002e8-Tc; Mon, 20 Aug 2007 23:38:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4D79C20FBAE; Mon, 20 Aug 2007 23:38:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070820191509.GB5544@steel.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56275>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Johannes Sixt, Mon, Aug 20, 2007 15:16:56 +0200:
> > Since va_copy() must be provided by the compiler, we don't have a
> > reasonable chance to provide a working definition in git_compat_util.h.
> 
> Maybe we don't have to:
> 
> Subject: [PATCH] Avoid using va_copy in fast-import: it seem to be unportable

Thanks Alex.  This feels more like the right solution to the problem.
I made a few minor edits, any comment?
 
-->8--
From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Avoid using va_copy in fast-import: it seems to be unportable.

[sp: minor change to use fputs, thus reducing the patch size]

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2d5224c..078079d 100644
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
@@ -397,7 +397,7 @@ static void write_crash_report(const char *err, va_list params)
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
-	vfprintf(rpt, err, params);
+	fputs(err, rpt);
 	fputc('\n', rpt);
 
 	fputc('\n', rpt);
@@ -442,18 +442,17 @@ static void write_crash_report(const char *err, va_list params)
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
-	va_list x_params;
+	char message[2 * PATH_MAX];
 
-	va_copy(x_params, params);
+	vsnprintf(message, sizeof(message), err, params);
 	fputs("fatal: ", stderr);
-	vfprintf(stderr, err, params);
+	fputs(message, stderr);
 	fputc('\n', stderr);
 
 	if (!zombie) {
 		zombie = 1;
-		write_crash_report(err, x_params);
+		write_crash_report(message);
 	}
-	va_end(x_params);
 	exit(128);
 }
 
-- 
1.5.3.rc5.40.g2f82

-- 
Shawn.
