From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] sequencer: write useful reflog message for fast-forward
Date: Wed, 19 Jun 2013 13:07:09 +0530
Message-ID: <1371627429-24819-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpD0E-0004gE-2r
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab3FSHkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:40:20 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53346 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3FSHkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 03:40:19 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so4790381pdi.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sGnladsDjUeFYXAmVti9cWu4dIUXcefL6MYyFCOGPgM=;
        b=0I0dTczVnUpCj3S9f3j5jk7otR0lYRlpilecUGWTdf78WFv0Q/hxyPlh1BxxxJWy3A
         kopNJiczErIHlxRlY482AFqytvbGPiNJLNsfcynb9Ss8cA1a1w9WYSay5upYjVK7kH4v
         rbN8+bzWnvm3fSzeS76+eC909uJ4ff+XSyv+GPKTuJ1RRLhhswvdipaI2y9iFpmHu+Xv
         bqwlyYuoJQ54dnaYUixJlU9+dVHNT3M7ickJpU1iRQ3MF0HPAzos2hUvh7+j7KZna5kj
         E4zO513Ui/O+1WNsB8dgrFW+i79W7sRq2e2RjKmBNB9dRlr+RiQyL0VfwtoYHj7xRo8M
         UbKg==
X-Received: by 10.68.175.33 with SMTP id bx1mr1646291pbc.21.1371627618259;
        Wed, 19 Jun 2013 00:40:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ty8sm23598851pac.8.2013.06.19.00.40.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 00:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228355>

The following command

  $ git cherry-pick --ff b8bb3f

writes the following uninformative message to the reflog

  cherry-pick

Improve it to

  cherry-pick: fast-forward

Avoid hard-coding "cherry-pick" in fast_forward_to(), so the sequencer
is generic enough to support future actions.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Changes since v1:

 - fast_forward_to() now takes opts to determine action_name()
 - strbuf_release() to free memory

 sequencer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..423c1f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -270,15 +270,20 @@ static int error_dirty_index(struct replay_opts *opts)
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
-			   int unborn)
+			int unborn, struct replay_opts *opts)
 {
 	struct ref_lock *ref_lock;
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from, 0);
-	return write_ref_sha1(ref_lock, to, "cherry-pick");
+	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
+	ret = write_ref_sha1(ref_lock, to, sb.buf);
+	strbuf_release(&sb);
+	return ret;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
@@ -523,7 +528,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (opts->allow_ff &&
 	    ((parent && !hashcmp(parent->object.sha1, head)) ||
 	     (!parent && unborn)))
-	     return fast_forward_to(commit->object.sha1, head, unborn);
+		return fast_forward_to(commit->object.sha1, head, unborn, opts);
 
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
-- 
1.8.3.1.449.g41b32a4.dirty
