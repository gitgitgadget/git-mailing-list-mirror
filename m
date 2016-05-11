From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 54/94] builtin/apply: make parse_chunk() return a negative integer on error
Date: Wed, 11 May 2016 15:17:05 +0200
Message-ID: <20160511131745.2914-55-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3w-0003ZN-1q
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbcEKNUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35238 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbcEKNUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9408969wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=04Ur22F6hzwCP66qXd632OCshEzQZoxRT6qcw3Kpt/s=;
        b=pf6L8P0y5dvP5Q3SpjVtohjBGs2hCT5seROIF8JcZr6d0IfRilVeCwkwTW63zC1Eex
         miREbEUwcUlIvULOtW/7MD5E44+JsTxxZEUrbIC3SwhjGxkOiehQ4vjy1n+iakShT5qz
         yzyvKjRN/ZV0VdiWaGrLRdtwtKLc5IwCjEkbEUB8F8IkHmIN8sQ9Vi0SK8uAp3VczD3U
         7kdYDrbXe5xQOHUZO2LxYHPKxpuukCYHOjXMBDfj/K2tR10l97a4E5vqN5LDAajXoW4E
         uM+HLeQ5yOpT53Ct+la7bgwLCiskmBNeKqbJLb84hIcq4f5pAeiVev6+RaIiVCAkN+h8
         TJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=04Ur22F6hzwCP66qXd632OCshEzQZoxRT6qcw3Kpt/s=;
        b=C4dEfAG4ETJ44KurYf3cDDdE/ghZw1RVjaiy9KF0aeECgaw2FNoRekgJwulJEMo6Y4
         wdhCvwJ1L+m8zeszBmNeJIEISknXIfA6ErHmdRTThiInqNR+DoBWXIuFqoCrQ4Ykwry2
         td1Ki+zI1HAfkEyb7/AnfBRZzlEwdNqTpigU3NnfFLHT1IGIkO0T9lZm8NceMoUGUXov
         Pi1jp+4AcXK+LxiLEvKYRg74KM/LeNjY+Jgp4WkoUReMDMSkadQj1Is+jhLJKTR5zNE0
         pwUbhFn9AwnutclScrJrDYGM9rgyKQlJ+RYo976M5sqKiOZt3Zyb6JR+D9DVKGe5yzZO
         Afeg==
X-Gm-Message-State: AOPr4FXnGIR4c55NAKQJ89bSJHni8FmIRby3Yjv74ljmh87vY4DGkbgo0YuuinSh6mPg5Q==
X-Received: by 10.194.85.161 with SMTP id i1mr4056619wjz.95.1462972817380;
        Wed, 11 May 2016 06:20:17 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294278>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing or exit()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, find_header() should return -1 instead of calling
die() or exit().

As parse_chunk() is called only by apply_patch() which already
returns -1 when an error happened, let's make apply_patch() return -1
when parse_chunk() returns -1.

If find_header() returns -2 because no patch header has been found, it
is ok for parse_chunk() to also return -2. If find_header() returns -1
because an error happened, it is ok for parse_chunk() to do the same.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4212705..2380472 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2101,22 +2101,22 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	return !state->has_include;
 }
 
-
 /*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
- * Return the number of bytes consumed, so that the caller can call us
- * again for the next patch.
+ *
+ * Returns:
+ *   -1 on error,
+ *   -2 if no header was found,
+ *   the number of bytes consumed otherwise,
+ *     so that the caller can call us again for the next patch.
  */
 static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
-	if (offset == -1)
-		exit(1);
-
 	if (offset < 0)
 		return offset;
 
@@ -2176,8 +2176,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * empty to us here.
 		 */
 		if ((state->apply || state->check) &&
-		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state->linenr);
+		    (!patch->is_binary && !metadata_changes(patch))) {
+			return error(_("patch with only garbage at line %d"), state->linenr);
+		}
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4557,6 +4558,10 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
+			if (nr == -1) {
+				res = -1;
+				goto end;
+			}
 			break;
 		}
 		if (state->apply_in_reverse)
-- 
2.8.2.490.g3dabe57
