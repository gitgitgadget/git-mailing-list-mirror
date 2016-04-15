From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 17:07:30 -0700
Message-ID: <20160415000730.26446-1-sbeller@google.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Cc: peff@peff.net, davidel@xmailserver.org, jacob.keller@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 15 02:08:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrIl-0004jU-Qm
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbcDOAH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:07:56 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33365 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcDOAHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:07:55 -0400
Received: by mail-pf0-f177.google.com with SMTP id 184so50981191pff.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwDriSW9Xi6yMfh6AzD9E3nJbhLAcg3K20uWYVUHKCc=;
        b=pPCMN9YyUGCVHaF/DRqA1pTGcBQAxcJQbke1n1o+JFiD+VWId23/yuVPFAImgEA/+D
         3zXF2+wmYCJPLOieRlND5cTvuWqR0fUOQYAZI1iH5SBv8+e4GVEqaD7nZta+I728SL/L
         fMJx2HrN/x/yT8W1tgqoiBYgPmW0absDS56oLbxP1m9cVa8VAlmGVs5MKVUZgoxE7flv
         8xG2xNLBr04endF3YXu1q7sDVDb4TTUvbM3vx+tekTXiH+1zZZC4z/vN1qogmhrG+v+P
         PxMsNUQ7cS0iBophktIg9FjD9w5RhkyxgNXqKElAjmIhUehUkD0V/Etdo9Z91g9RLlqa
         957A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwDriSW9Xi6yMfh6AzD9E3nJbhLAcg3K20uWYVUHKCc=;
        b=ZQzjDkIZZ4I7uoez2uwlXTuYdzD9FLIIMfyUAICR2d1S2MazmsKBKUVU/MXa46S1Uv
         t/lu15zD7o4hV312ke9G7fcZu/UQOJVZTeHFBcLeLcQojjZZvH2R5R/ESUzUNBnXwFJT
         4xB3CVRnd8Fqsoo7HK9qzX9oMN1afUv/bTYkDKOML7Y67MlDx9s8kLaqHpHHmF6N/THa
         tK8xBxH8dO+p/0wtX07kI8PzLc2W4n1cAtbY4ALMj5aQid5cxCIr6vcjnEsHuUhqHkmr
         5FDAY0gWCAUkC84J5XZbOgGN8kEVwmPy6q2PC3/ePCptrZsQuIkgDqgsncQ1PNvymfEs
         fPjg==
X-Gm-Message-State: AOPr4FXckqjSG2Rmv3WKK47iE272GuALJLRmSscD1qQ0P8cMbCiVSTeJQQ9JVkuiy3x9E1Dk
X-Received: by 10.98.25.69 with SMTP id 66mr3415646pfz.60.1460678874225;
        Thu, 14 Apr 2016 17:07:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:74d2:d897:f991:78d5])
        by smtp.gmail.com with ESMTPSA id d12sm60377506pfb.61.2016.04.14.17.07.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Apr 2016 17:07:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.474.gffdc890.dirty
In-Reply-To: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291581>

TODO(sbeller):
* describe the discussion on why this is better
* see if this can be tested?

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiffi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 2358a2d..24eb9a0 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,9 +400,16 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int starts_with_emptyline(const char *recs)
+{
+	return recs[0] == '\n'; /* CRLF not covered here */
+}
+
+
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
+	unsigned char has_emptyline;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -436,6 +443,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
+			has_emptyline = 0;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -447,6 +455,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
+				has_emptyline |=
+					starts_with_emptyline(recs[ix]->ptr);
 				/*
 				 * This change might have joined two change groups,
 				 * so we try to take this scenario in account by moving
@@ -475,6 +485,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
+				has_emptyline |=
+					starts_with_emptyline(recs[ix]->ptr);
+
 				/*
 				 * This change might have joined two change groups,
 				 * so we try to take this scenario in account by moving
@@ -498,6 +511,32 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			rchg[--ix] = 0;
 			while (rchgo[--ixo]);
 		}
+
+		/*
+		 * If a group can be moved back and forth, see if there is an
+		 * empty line in the moving space. If there is an empty line,
+		 * make sure the last empty line is the end of the group.
+		 *
+		 * As we shifted the group forward as far as possible, we only
+		 * need to shift it back if at all.
+		 */
+		if (has_emptyline) {
+			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
+			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
+			       !starts_with_emptyline(recs[ix - 1]->ptr)) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+
+				/*
+				 * This change did not join two change groups,
+				 * as we did that before already, so there is no
+				 * need to adapt the other-file, i.e.
+				 * running
+				 *     for (; rchg[ixs - 1]; ixs--);
+				 *     while (rchgo[--ixo]);
+				 */
+			}
+		}
 	}
 
 	return 0;
-- 
2.8.1.474.gffdc890.dirty
