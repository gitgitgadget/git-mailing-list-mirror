From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/13] rerere: report autoupdated paths only after actually updating them
Date: Tue, 30 Jun 2015 23:04:51 -0700
Message-ID: <1435730699-9124-6-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9C-0004Kz-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbbGAGFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:21 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35456 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbGAGFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:08 -0400
Received: by iecuq6 with SMTP id uq6so27808913iec.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=VjKbx4ZFv/oF9hKcvFcjvuvC8BYi20HS/iCX5Nub55Q=;
        b=f/beyODNf0Ii6YJRpuX2CT4OAhI0HJguUkS48amAjwmZJkbm8Od5+CZwMZrtBog7ym
         Mw+qsFT1QDEMWThiOtq95vu5DYLOi7obyTA/k53pfACCu7mSEeDKtHGR3jLGoSBGADSa
         iWTvrfd3cpIHBkaqW4bfTbjd32SIPbeaPFFYdatyXn7ccPpb2YT3YClZxJ6NBJZW044C
         pw24M7Dk2Y1nDgU6olWVNdbHMtHuTLGJ0ZMTWGdZDD1ldFQeN1mShPNeRJijZqXlPADG
         lrOtgpj+5xxr6eyVpS7dhyeW7V2kMBv1wSLh9mGYOTztnY8MZkILRlZG/yhe7DtbudBl
         xLuw==
X-Received: by 10.107.5.1 with SMTP id 1mr10026206iof.88.1435730708025;
        Tue, 30 Jun 2015 23:05:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id i185sm679661ioi.24.2015.06.30.23.05.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273121>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 27b287d..304df02 100644
--- a/rerere.c
+++ b/rerere.c
@@ -482,6 +482,8 @@ static void update_paths(struct string_list *update)
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_cache(item->string, 0))
 			exit(128);
+		fprintf(stderr, "Staged '%s' using previous resolution.\n",
+			item->string);
 	}
 
 	if (active_cache_changed) {
@@ -536,16 +538,16 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, path)) {
-				const char *msg;
-				if (rerere_autoupdate) {
-					string_list_insert(&update, path);
-					msg = "Staged '%s' using previous resolution.\n";
-				} else
-					msg = "Resolved '%s' using previous resolution.\n";
-				fprintf(stderr, msg, path);
-				goto mark_resolved;
-			}
+			if (merge(name, path))
+				continue;
+
+			if (rerere_autoupdate)
+				string_list_insert(&update, path);
+			else
+				fprintf(stderr,
+					"Resolved '%s' using previous resolution.\n",
+					path);
+			goto mark_resolved;
 		}
 
 		/* Let's see if we have resolved it. */
-- 
2.5.0-rc0-209-g5e1f148
