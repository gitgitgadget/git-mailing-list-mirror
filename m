From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 4/9] transport-helper: fix push without refspec
Date: Sat, 24 Nov 2012 04:25:15 +0100
Message-ID: <1353727520-26039-5-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nh-0006y1-Gz
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604Ab2KXDZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:48 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab2KXDZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:47 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dbXzDnHq4c3PGF2DJ24uuM0QXl8dy27F+MahNIGeei8=;
        b=jjssf8BYbyjWgYheH6QyRTn6wd193FSALV+vIw1pGYPyafP8l6LqcA0DoAjhrUygFJ
         rxZvix3zclB9Fyk4UyzpeKltu4nPRIX3hnPIoIJGJPgaD60KvyKoKRQnLAPqRoFk9ll9
         UNw8gLdaO1EN4rHe+FIWRBUMRpTG3kqgzkVlMdQw4ZT3NVTWFEBpbO6WGPbMW8qdRBBG
         adyoN4K/qHARmC0/QTDeT9FOSdyE28qsyXzWQgLG8tHQlj2oc3r8WlF4ZKIg+ms4TZI6
         AjBEHXlQw2JZa5qu5VOf3asa1zAABG8uqkdhISlSC1lNuQQXVj0umI+nv5p5eCtF4KYR
         aRgg==
Received: by 10.204.147.143 with SMTP id l15mr1760676bkv.28.1353727546948;
        Fri, 23 Nov 2012 19:25:46 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id j16sm4403544bkv.1.2012.11.23.19.25.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:46 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210303>

The refspec feature is not mandatory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2e027c8..b268cd2 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -111,7 +111,7 @@ test_expect_success 'pulling without refspecs' '
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pushing without refspecs' '
+test_expect_success 'pushing without refspecs' '
 	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
diff --git a/transport-helper.c b/transport-helper.c
index 0c95101..899eb36 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -778,6 +778,9 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->deletion)
 			die("remote-helpers do not support ref deletion");
 
+		if (ref->peer_ref)
+			string_list_append(&revlist_args, ref->peer_ref->name);
+
 		if (!data->refspecs)
 			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
@@ -787,9 +790,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->peer_ref)
-			string_list_append(&revlist_args, ref->peer_ref->name);
-
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-- 
1.8.0
