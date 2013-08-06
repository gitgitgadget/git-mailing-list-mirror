From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/16] blame: inline one-line function into its lone caller
Date: Tue,  6 Aug 2013 09:59:37 -0400
Message-ID: <1375797589-65308-5-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hpC-0003t2-1b
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab3HFOBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:01:14 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:59463 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab3HFOAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:39 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so752483oag.16
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCQekMO0HXMoV3BkrgIxGw613yVEPerLIrUCFu+N1ik=;
        b=izk9QCF1JQyMOzcXSUGXIYlcCq+AM2tR3Hnwe1bn0DlCQCa7p/MBM6hL8wPGBFXce7
         TYi45LaTiMTp6tXO2xpZ31mI+oeTLkHXL+P8Ddq/oahxdGh2XC/omENEkzoa0Oe3Hl7d
         ASvS1zHM2Bc0MKJqs+/4ScOsLqN6aWlJ0K2Rg0MSt/4RyTwfMPkTWUV9nao+1D5YcKMi
         yn46DjkB+VoFCsQdyfr3VF41vfwCE4QRUnpb3a2kAgEwSuhTF+0t3lMxt27ELGHwegy1
         myiWvAsaL4MchpyjCUauGd8033ejaaSqQayB+jnm571e5KZipvdoKSOoi2+19Z3NUq/m
         Svmw==
X-Received: by 10.182.227.227 with SMTP id sd3mr1089888obc.68.1375797632742;
        Tue, 06 Aug 2013 07:00:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231755>

As of 25ed3412 (Refactor parse_loc; 2013-03-28),
blame.c:prepare_blame_range() became effectively a one-line function
which merely passes its arguments along to another function. This
indirection does not bring clarity to the code. Simplify by inlining
prepare_blame_range() into its lone caller.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/blame.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e70b089..9db01b0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1937,18 +1937,6 @@ static const char *add_prefix(const char *prefix, const char *path)
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
-/*
- * Parsing of -L option
- */
-static void prepare_blame_range(struct scoreboard *sb,
-				const char *bottomtop,
-				long lno,
-				long *bottom, long *top)
-{
-	if (parse_range_arg(bottomtop, nth_line_cb, sb, lno, bottom, top, sb->path))
-		usage(blame_usage);
-}
-
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
@@ -2493,8 +2481,9 @@ parse_done:
 	lno = prepare_lines(&sb);
 
 	bottom = top = 0;
-	if (bottomtop)
-		prepare_blame_range(&sb, bottomtop, lno, &bottom, &top);
+	if (bottomtop && parse_range_arg(bottomtop, nth_line_cb, &sb, lno,
+					 &bottom, &top, sb.path))
+		usage(blame_usage);
 	if (lno < top || ((lno || bottom) && lno < bottom))
 		die("file %s has only %lu lines", path, lno);
 	if (bottom < 1)
-- 
1.8.4.rc1.409.gbd48715
