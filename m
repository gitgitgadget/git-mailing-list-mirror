From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 14/14] fast-export: don't handle uninteresting refs
Date: Fri,  2 Nov 2012 03:02:18 +0100
Message-ID: <1351821738-17526-15-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bl-0001Ne-Le
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992666Ab2KBCD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:28 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992649Ab2KBCDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:24 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SKG/FG10UG/4ckppM4q2o/My9ehuXfWchB0iGgIHrHA=;
        b=hSH0KdoEGx4ji7vNGsc1jdCV5Cliymo6aXAriOScnshDVv0VG7XogZv2gZTHpkhEKy
         WgtJ7UhcGVkC1rxPi0M+8YBajxwjOhaGC/vMvXLa7Ddb5vH0Mube3TQZ3tM5GstVTl/s
         bs+sRJutN3tjOzPabjrxnwk7YCS1yXahVGcrJTvY6saCoFmTj+DJmswZYnoUFboRQnNS
         y1YhTUEkNHFyyvfCldwajAT2uZvjL7lEpLT9aiYjNdpqE8esHOV9zut79U8iG/vzOUnL
         vJ7E/jMj1uzGZjLeIWDxG3D+hA4A1+ycqXKT3D8DBdM7KNO+X7SYIQGaaj6hyvU1PlMg
         AyQQ==
Received: by 10.204.128.155 with SMTP id k27mr26584bks.26.1351821804005;
        Thu, 01 Nov 2012 19:03:24 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id e13sm5774164bkw.12.2012.11.01.19.03.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208908>

They have been marked as UNINTERESTING for a reason, lets respect that.

Currently the first ref is handled properly, but not the rest, so:

 % git fast-export master ^master

Would currently throw a reset for master (2nd ref), which is not what we
want.

 % git fast-export master ^foo ^bar ^roo
 % git fast-export master salsa..tacos

Even if all these refs point to the same object; foo, bar, roo, salsa,
and tacos would all get a reset, and to a non-existing object (invalid
mark :0).

And even more, it would only happen if the ref is pointing to exactly
the same commit, but not otherwise:

 % git fast-export ^next next
 reset refs/heads/next
 from :0

 % git fast-export ^next next^{commit}
 # nothing
 % git fast-export ^next next~0
 # nothing
 % git fast-export ^next next~1
 # nothing
 % git fast-export ^next next~2
 # nothing

The reason this happens is that before traversing the commits,
fast-export checks if any of the refs point to the same object, and any
duplicated ref gets added to a list in order to issue 'reset' commands
after the traversing. Unfortunately, it's not even checking if the
commit is flagged as UNINTERESTING. The fix of course, is to do
precisely that.

The current behavior is most certainly not what we want. After this patch,
nothing gets exported, because nothing was selected (everything is
UNINTERESTING).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 4 +++-
 t/t9350-fast-export.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 26f6d1c..7a310e4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -529,7 +529,9 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		 * sure it gets properly upddated eventually.
 		 */
 		if (commit->util || commit->object.flags & SHOWN)
-			string_list_append(extra_refs, full_name)->util = commit;
+			if (!(commit->object.flags & UNINTERESTING))
+				string_list_append(extra_refs, full_name)->util = commit;
+
 		if (!commit->util)
 			commit->util = full_name;
 	}
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 67a7372..9b53ba7 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -469,4 +469,10 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
 	test_cmp expected actual
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
