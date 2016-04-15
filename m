From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] xdiff: add recs_match helper function
Date: Fri, 15 Apr 2016 16:01:45 -0700
Message-ID: <1460761306-18794-2-git-send-email-sbeller@google.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Jens.Lehmann@web.de, davidel@xmailserver.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stefan Beller <sbeller@google.com>
To: jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 16 01:01:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCkN-0006DH-TN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbcDOXBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:01:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34593 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcDOXBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:01:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id c20so60944816pfc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GbsTX4SXwz8zjYdjLrN1Nr6v4c3vfCTl/mxWyzY2BCY=;
        b=H/TqgRERB557cRegwxBGP9P08AyuauwPKbVkHC4W9uuJfNWFtZyevA8Mv2EkaR/KXJ
         iJbeS7T5nkl3PDEUVKnzxtCk4TDyOWAqt73ZQTDMn/4AD8lJ8lnTn6AJmy4bVr0ro/ot
         1JDwRv0A2UVRVatvLK1WiaO8yqo3cYOyPvTKFQgYspLLIE7ZaIJ/FNHOVtMXzhEU1Rb2
         dmGuoHyXhCBlc9yMIDn6rtYColCbLvKRk2lBwRESJWJOKeQU0U7Tov/0V84kc9rK2XXM
         YXQs0Q9mh4LEyZh1If65b8ZutZdg9kkJWWslFNhFZo/lYmu36cMwjUa3pXYYzC7ktDjr
         YTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GbsTX4SXwz8zjYdjLrN1Nr6v4c3vfCTl/mxWyzY2BCY=;
        b=ZqbwoakX3n6hJSzRgp5MuwuHFj7EXKtkPkHhoeztOQiHce2PUt/GXV00QLtrzktwTk
         30OtGAeR32aJueW23mYsC6Wh1CP40damD14PqenRUMJIjjJ95UJ8DECdT3Prk68yO9gX
         TT0VKQn9iJ2z5hJkk8+7EOFdOHAFeASotr3f9hAVdZG4WlQK1eqxGBqM5HDL55HVIanZ
         RwSk6GFopSWZq/njkh6oSydLYHjjREuRryvsaH1awpsEUhWiGSLkZBrMeMiFBuVWOJbo
         JdoWJIRygMppqr6MUhTqo8ExQbYZdAWfpgQAGJf5DlBLMx7b8o7OfW2B9S7ZfV7n+7aa
         OLjA==
X-Gm-Message-State: AOPr4FVdbxndcy3WrguZmUZz5cHuTJc4jSeRRWT+9RCiSAKWu5UB4zUSNu+KVpdc5E64h+c8
X-Received: by 10.98.0.77 with SMTP id 74mr1401665pfa.158.1460761310362;
        Fri, 15 Apr 2016 16:01:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id h5sm67139799pat.0.2016.04.15.16.01.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 16:01:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.189.gd13d43c
In-Reply-To: <1460761306-18794-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291694>

From: Jacob Keller <jacob.keller@gmail.com>

It is a common pattern in xdl_change_compact to check that hashes and
strings match. The resulting code to perform this change causes very
long lines and makes it hard to follow the intention. Introduce a helper
function recs_match which performs both checks to increase
code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiffi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 2358a2d..748eeb9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,14 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
+{
+	return (recs[ixs]->ha == recs[ix]->ha &&
+		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
+			     recs[ix]->ptr, recs[ix]->size,
+			     flags));
+}
+
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
@@ -442,8 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
-			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
+			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -470,8 +477,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
-			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
+			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
-- 
2.8.1.189.gd13d43c
