From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Sun, 11 Nov 2012 14:59:52 +0100
Message-ID: <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6Z-00080m-St
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2KKOBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2KKOB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yVDlxZF+xoSnCJHEJmHsgEksoJNAT7dCiIvfX6JZNPg=;
        b=OnYJt8gz1AVQrj9ESh57TSiyCDyXTrb7cImLCjb8HobSlE5VRuLXXIPGwNGrlCvsJ4
         jOXc7poLwxTGSKwvqbelp1LyxE2Y3QUbgqxEr43mhZBe95sCKd3zYPRIfHkyAg77rsUT
         QFF8fmhqPT93otaH2Vs47ysRtqzepZo23ItPGLVeG3IK8ophr2F/XJCrHLjf9/2MoXVC
         lIhqWr8Sd67mTkybXgta5f6FP+xtVZ9ktH/rjK2h8+g+lG2e00mNntzi7lkyXSweKoJ2
         AT3AqSg2JbRmujvAIpQXTSv7Y66IvA9lE39BUJ9KTrfmIFXHSoc/Dmfiq5HSXSzciKVi
         FasA==
Received: by 10.204.150.211 with SMTP id z19mr5986345bkv.60.1352642488956;
        Sun, 11 Nov 2012 06:01:28 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id 9sm1487066bkq.13.2012.11.11.06.01.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:28 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209370>

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

The current behavior is most certainly not what we want. After this
patch, nothing gets exported, because nothing was selected (everything
is UNINTERESTING).

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
