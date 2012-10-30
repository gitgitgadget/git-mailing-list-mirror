From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 20:06:26 +0100
Message-ID: <1351623987-21012-4-git-send-email-felipe.contreras@gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH9Y-00030w-8t
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837Ab2J3TGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:06:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52686 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2J3TGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:06:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so340997bkc.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1L5S5KxiH+CoQUqWdVAj1XlA42o2+HU1NKEkm/3txPY=;
        b=vRCmQj/64WMksd6tnOMF+mdiiNB4Q94a0gTStt7Q2g6ot48tvpwYsE592jGL0XmXM8
         Up8O6qYwnL/8tzSKDjC64ZSYhZ+shi2kQq6fGC3XshU8ckTg6BmC1alUZYyDlD9AIbiL
         zcS/kog4mdGXiwKBLfd9/VWNYdsV30ZqdQ0rCEtbU5fpmlcc/h2KsgYtURZYL3R90N9V
         9N99PYgj/WRiy29aFLvCQidqkRU4T5FRSX3qvHsOgYRctLYUuBgZKt7iam6jU9GXd5ma
         VtT13edkh1tArGNRbSLMYuPW7PqbTm6/kqeLq41jVQvudDxeGR25xyr5wQXO4Qt0l1CO
         x58A==
Received: by 10.204.128.201 with SMTP id l9mr10378278bks.66.1351624013505;
        Tue, 30 Oct 2012 12:06:53 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id 1sm1978107bks.3.2012.10.30.12.06.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 12:06:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208729>

They have been marked as UNINTERESTING for a reason, lets respect that.

Currently the first ref is handled properly, but not the rest, so:

 % git fast-export master ^master

Would currently throw a reset for master (2nd ref), which is not what we
want.

 % git fast-export master ^foo ^bar ^roo
 % git fast-export master salsa..tacos

Even if all these refs point to the same object; foo, bar, roo, salsa,
and tacos would all get a reset.

This is most certainly not what we want. After this patch, nothing gets
exported, because nothing was selected (everything is UNINTERESTING).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 7 ++++---
 t/t9350-fast-export.sh | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 065f324..7fb6fe1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -523,10 +523,11 @@ static void get_tags_and_duplicates(struct object_array *pending,
 				typename(e->item->type));
 			continue;
 		}
-		if (commit->util)
+		if (commit->util) {
 			/* more than one name for the same object */
-			string_list_append(extra_refs, full_name)->util = commit;
-		else
+			if (!(commit->object.flags & UNINTERESTING))
+				string_list_append(extra_refs, full_name)->util = commit;
+		} else
 			commit->util = full_name;
 	}
 }
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 49bdb44..6ea8f6f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -440,4 +440,10 @@ test_expect_success 'fast-export quotes pathnames' '
 	)
 '
 
+test_expect_success 'proper extra refs handling' '
+	git fast-export master ^master master..master > actual &&
+	echo -n > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.0
