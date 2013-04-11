From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] transport-helper: improve push messages
Date: Wed, 10 Apr 2013 19:07:11 -0500
Message-ID: <1365638832-9000-2-git-send-email-felipe.contreras@gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 02:08:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ54A-0001Ae-63
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 02:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937721Ab3DKAIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 20:08:22 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:34430 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937299Ab3DKAIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 20:08:19 -0400
Received: by mail-qa0-f44.google.com with SMTP id o13so4238qaj.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=X85H5gg+KPkcfQjdY0fqhmSkY9PvYLfYywp8XaHlPrA=;
        b=dcOaBce9c9lpa138677FsCZQYIUUGg2PRny5lHNZyHjag2ocsMVZgl/qNajLeChhrh
         xZCrAXS7L9cYJQwlcd1o+GCFlr/HQ5xFKF6UFptQp5DUToJPxy18UCp770P2RjUBSJ48
         ypE8s2k1IsireCAhLv1sfS0XbfL0O+dqKref0WGOQKI+B3xbqI9Ww4quYiAbMzImVSB1
         hf4ZXDDTVKo7kbZpWhoLFEa5JkXWDktDWYsWLRWQlsfw2WrvuW+B1rWeGNvUcyPz9/ha
         SLIx78nXFCWxTqrTI+jbnNEaG0OtUCeYdPampmbpWIV2sTTObhNiknKnIHca7S4zg0aL
         MZVQ==
X-Received: by 10.224.78.147 with SMTP id l19mr4983996qak.28.1365638898906;
        Wed, 10 Apr 2013 17:08:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id g6sm4027212qav.6.2013.04.10.17.08.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 17:08:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220798>

If there's already a remote-helper tracking ref, we can fetch the SHA-1
to report proper push messages (as opposed to always reporting
[new branch]).

The remote-helper currently can specify the old SHA-1 to avoid this
problem, but there's no point in forcing all remote-helpers to be aware
of git commit ids; they should be able to be agnostic of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 14 ++++++++++++++
 transport-helper.c        |  1 +
 2 files changed, 15 insertions(+)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..214aa40 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,18 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'push messages' '
+	(cd local &&
+	git checkout -b new_branch master &&
+	echo new >>file &&
+	git commit -a -m new &&
+	git push origin new_branch &&
+	git fetch origin &&
+	echo new >>file &&
+	git commit -a -m new &&
+	git push origin new_branch 2> msg &&
+	! grep "\[new branch\]" msg
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d..2257025 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -801,6 +801,7 @@ static int push_refs_with_export(struct transport *transport,
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
+			hashcpy(ref->old_sha1, sha1);
 		}
 		free(private);
 
-- 
1.8.2.1
