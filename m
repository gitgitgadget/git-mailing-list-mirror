From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 4/5] pathspec: move prefix check out of the inner loop
Date: Wed, 18 May 2016 18:09:34 -0700
Message-ID: <20160519010935.27856-5-sbeller@google.com>
References: <20160519010935.27856-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 03:09:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CTP-00057i-1g
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcESBJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:09:53 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36474 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcESBJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:09:52 -0400
Received: by mail-pf0-f173.google.com with SMTP id c189so24726553pfb.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HR+3DM1+1nBYkFpubX7CuztY4Ns+FUE8p475SQ98rF0=;
        b=A7nvmzgta4iZNlOCD78Fv/k+p3TfB/3PztWs1jisIydvl18WX5JWbGXS/8Xwv1mFRq
         eG3vpNkJmrs9pwMSWv2oXlINMe68VefFPMGXWxF6oVVaWMhFR+tn2XcL/hOy1w3sFoHp
         KzbERlTBzUk11BZNMPhg6vB37hOMYKPZj4i9AQ90uwIyI2NiPBcSQ6VBJctp+gHUhFUi
         lJWLkbp/8dAZFA0KvhArM0tExpfo0m1w87fmIfa0cMvlpmaxY4Bvg5q2N1OXhSu5+fKH
         TGjfen9qb7Ct3vUOKafgm/wniC/nuX5LFGdIzZ427YOr3U/dbkvtBIrHMYu90dOxXNXR
         i9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HR+3DM1+1nBYkFpubX7CuztY4Ns+FUE8p475SQ98rF0=;
        b=TT/GWFdAAJS4VUW+SEHUszuqeEhnuunBVxXyLeEtHfY2qAX5+276jH8M6mflnCSLNa
         JdOlCHArwoN0DcFx2d/WbZbofDZbyDEr9g8yEDCDHUTpPv9U25x1vAzEsNTnfxUQE+yP
         auLLqEOyBDq1suXl/0rNP+k98MqTeRVH0xnqgGBxgMTn56bmWxYqFUaJZdH22aJGcii5
         KffIqTRugnuR4dxh/Hj1UX83bN5kRhFAGw3ix5RvkTBjs5MV8WRpaYSVWUobwcPCJZ7B
         Pys2BDHlR9GPfX0kldvKCfEu+EdTlDQupT8F31mcLAKGos+f4rXVA8zHW45YSet4V9Ak
         G4KQ==
X-Gm-Message-State: AOPr4FWajZcWxlBBRcVQbuDqu8FGn6llQvSr9sY0QkHg3ZGsZUJByuD41x096EjBw9yUlrkt
X-Received: by 10.98.67.150 with SMTP id l22mr15325255pfi.85.1463620191425;
        Wed, 18 May 2016 18:09:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id u127sm14983384pfb.82.2016.05.18.18.09.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 18:09:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.g3bde101
In-Reply-To: <20160519010935.27856-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295036>

The prefix check is not related the check of pathspec magic; also there
is no code that is relevant after we'd break the loop on a match for
"prefix:". So move the check before the loop and shortcircuit the outer
loop.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index eba37c2..4dff252 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -107,21 +107,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			nextat = copyfrom + len;
 		if (!len)
 			continue;
+
+		if (starts_with(copyfrom, "prefix:")) {
+			char *endptr;
+			*pathspec_prefix = strtol(copyfrom + 7,
+						  &endptr, 10);
+			if (endptr - copyfrom != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 				*magic |= pathspec_magic[i].bit;
 				break;
 			}
-			if (starts_with(copyfrom, "prefix:")) {
-				char *endptr;
-				*pathspec_prefix = strtol(copyfrom + 7,
-							  &endptr, 10);
-				if (endptr - copyfrom != len)
-					die(_("invalid parameter for pathspec magic 'prefix'"));
-				/* "i" would be wrong, but it does not matter */
-				break;
-			}
 		}
 		if (ARRAY_SIZE(pathspec_magic) <= i)
 			die(_("Invalid pathspec magic '%.*s' in '%s'"),
-- 
2.8.2.123.g3bde101
