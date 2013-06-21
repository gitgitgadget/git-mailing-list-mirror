From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] apply: carefully strdup a possibly-NULL name
Date: Fri, 21 Jun 2013 13:38:00 +0200
Message-ID: <76659b15f0a52d9e94143bee803f5cf45de1e6cc.1371814540.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:38:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzfP-00089r-8P
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956Ab3FULiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:38:07 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:15974 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870Ab3FULiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:38:06 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 21 Jun
 2013 13:37:58 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 21 Jun
 2013 13:38:02 +0200
X-Mailer: git-send-email 1.8.3.1.664.gae9f72a
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228611>

2901bbe (apply: free patch->{def,old,new}_name fields, 2012-03-21)
cleaned up the memory management of filenames in the patches, but
forgot that find_name_traditional() can return NULL as a way of saying
"I couldn't find a name".

That NULL unfortunately gets passed into xstrdup() next, resulting in
a segfault.  Use null_strdup() so as to safely propagate the null,
which will let us emit the correct error message.

Reported-by: DevHC on #git
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 builtin/apply.c         |  2 +-
 t/t4111-apply-subdir.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index faf8e30..0e9b631 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -906,7 +906,7 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 			patch->old_name = name;
 		} else {
 			patch->old_name = name;
-			patch->new_name = xstrdup(name);
+			patch->new_name = null_strdup(name);
 		}
 	}
 	if (!name)
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index 7c39843..1618a6d 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -86,6 +86,20 @@ test_expect_success 'apply --index from subdir of toplevel' '
 	test_cmp expected sub/dir/file
 '
 
+test_expect_success 'apply half-broken patch from subdir of toplevel' '
+	(
+		cd sub/dir &&
+		test_must_fail git apply <<-EOF
+		--- sub/dir/file
+		+++ sub/dir/file
+		@@ -1,0 +1,0 @@
+		--- file_in_root
+		+++ file_in_root
+		@@ -1,0 +1,0 @@
+		EOF
+	)
+'
+
 test_expect_success 'apply from .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
-- 
1.8.3.1.664.gae9f72a
