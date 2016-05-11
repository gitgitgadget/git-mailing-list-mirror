From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 31/94] builtin/apply: move 'has_include' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:42 +0200
Message-ID: <20160511131745.2914-32-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3F-0002jQ-2u
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbcEKNTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35724 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcEKNTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9404424wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgo/pp9ENEb1xcu0eLjy8BjywsE7mhLEiHN/Kjp7LcU=;
        b=UU0FcKz1Bs/S4D9XMiVvW5f/hSv+IZLJU1k12483s5gW1vjF2PCo28dqhIRYZ7qmGe
         Osrdi1k9ZDfZo3N/fbrL20gOnjzrnju3yY/sOxvc7j1zO43sg2g27b6HIe1PNWzK4LBe
         bxLDCSUTTFptlq4uyNqYXtP2Zjv6hAmFnL3bvTq8wHVI8eiD+rdk4Y45w80u5TF+BkN3
         7EEnVqrb7WlkAGE9HEHJC5zJ4Y5+tTcbkFIM4eRT6XoKR5qyTAFMSNvQy5J0bzKxfsDk
         snERzTPPKM3EGJ35BJCprG9Yq0oc4ii38Hb1tQE4AzEyefKOto5e7o228o8hDH+E89Ki
         yrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgo/pp9ENEb1xcu0eLjy8BjywsE7mhLEiHN/Kjp7LcU=;
        b=T5L8fv5B6uEFOGGPAKFg8wBLbXn1cLTjTY2zRgKIa2FjopEtTvwZU0bRFlS75THfnq
         zep6u2k1wMVQfmjjH72YOkPsRMih9qNzmmKhSprVkVsEAjSIC9Yux9cLBTtr9yAcZZto
         d0tLHoaYbW6EbAp2SsIwijwN4VKtmboI0C/Y3Nr1yn6EkvC4Yw8flrKfhp8WvAmx7FCA
         Gox12weuG53UohHQPfnF2pRPOk0kxHCP3K5h8xAnsHnZEXjWXWqrzt22Yd06Si193cd1
         /6AgILtpp5R0iIbsq6E+SmiDtVCMFXI9Ka2iRJugOeTYu/o9HxZF52jmcWnx31fnuXhy
         4/4Q==
X-Gm-Message-State: AOPr4FXH9FsvZudTxzGol+eYOxPrRbiAXUUJKDSs3p7zSEmMLy2kg8N3kkxOGTW4HtCkuA==
X-Received: by 10.28.230.137 with SMTP id e9mr53594wmi.90.1462972769173;
        Wed, 11 May 2016 06:19:29 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294265>

To libify the apply functionality the 'has_include' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14bbcc2..f2ee8bf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -46,6 +46,7 @@ struct apply_state {
 	const char *fake_ancestor;
 	const char *patch_input_file;
 	struct string_list limit_by_name;
+	int has_include;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -1968,7 +1969,6 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static int has_include;
 static void add_name_limit(struct apply_state *state,
 			   const char *name,
 			   int exclude)
@@ -2004,7 +2004,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
 	 * and such a path is used.
 	 */
-	return !has_include;
+	return !state->has_include;
 }
 
 
@@ -4541,7 +4541,7 @@ static int option_parse_include(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
-	has_include = 1;
+	state->has_include = 1;
 	return 0;
 }
 
-- 
2.8.2.490.g3dabe57
