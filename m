From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2] blame: honor core.abbrevguard
Date: Mon,  7 Mar 2011 14:22:15 +0900
Message-ID: <1299475335-8436-1-git-send-email-namhyung@gmail.com>
References: <1299472540-6066-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 06:22:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwStu-00078m-K2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 06:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab1CGFWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 00:22:19 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61373 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1CGFWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 00:22:19 -0500
Received: by pzk35 with SMTP id 35so673076pzk.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 21:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0YNOhGkIuCI8MufALqq5pI1V/0E4mf2Gola0A8kmsF0=;
        b=SjINCOUqe2dj87HpMloJcO7QYyUN0pTlxdw03crsifvOAPrVw4ZXhEDQGeL/Z8E+5W
         xFAhC/WI/M9QIbG9o//uULtUF/ZO0ZyuQ33pjEVK1O9VVsll7N4sEW4+I1X1zl595sxv
         dRaS6WEdrJLrnxa4YyPtbTtv2EWzNYGoCZ8R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S7Q2geiIdNgm7orkbEftq2Zx4+fLCHlVR3Zxw0ZawdnBRAIodKX8+7VOEjnLHWrRgD
         YijsdDHwakVtdo5t9nhL8Zya9wTyZUO7BuWH3ZFKzhKy10Uuq0LvMOlpgku95xEVZsaq
         iJlDLFBqNE5wfX+MVmChhoN7OiRFe5nQRR3fs=
Received: by 10.142.5.23 with SMTP id 23mr3008612wfe.249.1299475338488;
        Sun, 06 Mar 2011 21:22:18 -0800 (PST)
Received: from localhost.localdomain ([118.176.73.109])
        by mx.google.com with ESMTPS id d35sm3872424wfj.9.2011.03.06.21.22.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 21:22:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299472540-6066-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168570>

Commit 72a5b561 ("core.abbrevguard: Ensure short object names stay
unique a bit longer") introduced this config variable to make object
name unambiguously. Use it.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
v2:
 - re-init 'length' in every loop

 builtin/blame.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec52692..cecfceea45f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1664,14 +1664,23 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	struct commit_info ci;
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int uniq_length;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
+	if (opt & OUTPUT_LONG_OBJECT_NAME)
+		uniq_length = 40;
+	else {
+		uniq_length = 8 + unique_abbrev_extra_length;
+		if (uniq_length > 40)
+			uniq_length = 40;
+	}
+
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+		int length = uniq_length;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
-- 
1.7.4
