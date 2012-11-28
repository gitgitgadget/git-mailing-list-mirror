From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p2 1/2] fast-export: don't handle uninteresting refs
Date: Wed, 28 Nov 2012 23:23:59 +0100
Message-ID: <1354141440-26534-2-git-send-email-felipe.contreras@gmail.com>
References: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:24:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdq3d-0007Ck-6A
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab2K1WYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:24:23 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58508 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab2K1WYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:24:23 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5975572bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oXrTaxZUfzHAfiGH4wV2tInYmam4x5nvSO2hAHfGLAI=;
        b=TUU2D4iXqD2HECdxfpGqRcc4tIWQSB91Cex/DGgoHgE0fDj0azG8/GvqTz7dUdD9cW
         WKTPXB1zRSvNzVm/TnEwBsoG1BsIMEvfKCJzYOocE0Bv67oVIwqstZGoTV2hGg3EqM6l
         MRm0MbSrnteyJhMRjyl0UphXqGNe+T9K23kbL4VMpDJyCbzBBIQAydxE9BXtrkgtefxU
         UVKsPbrecJt1sGHRYVkjt5IkFwQkuHnmN0L+w1Nhyjy60MTyVR/cwrn2JW8s9w2cdoaZ
         p8zf2mZEcGZT3M3lolnBfPFocML5SaoDp1cqkQSGWaBsjyIUIRMI50kY3v2uAeO6dLfa
         sERw==
Received: by 10.204.148.154 with SMTP id p26mr3756156bkv.31.1354141461510;
        Wed, 28 Nov 2012 14:24:21 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id u3sm13793635bkw.9.2012.11.28.14.24.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:24:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210799>

They have been marked as UNINTERESTING for a reason, lets respect that.

Currently the first ref is handled properly, but not the rest:

  % git fast-export master ^uninteresting ^foo ^bar
  reset refs/heads/bar
  from :0

  reset refs/heads/foo
  from :0

  reset refs/heads/uninteresting
  from :0

  % git fast-export ^uninteresting ^foo ^bar master
  reset refs/heads/master
  from :0

  reset refs/heads/bar
  from :0

  reset refs/heads/foo
  from :0

Clearly this is wrong; the negative refs should be ignored.

After this patch:

  % git fast-export ^uninteresting ^foo ^bar master
  # nothing
  % git fast-export master ^uninteresting ^foo ^bar
  # nothing

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

However, in order to do it properly we need to get the UNINTERESTING flag
from the command line ref, not from the commit object. Fortunately we
can simply use revs.pending, which contains all the information we need
for get_tags_and_duplicates(), plus the ref flag. This way the rest of
the positive refs will remain untouched; it's only the negative ones
that change in behavior.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c     | 11 +++++++----
 t/t5801-remote-helpers.sh |  8 ++++++++
 t/t9350-fast-export.sh    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 191936c..2547e6c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -474,18 +474,21 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)message_size, (int)message_size, message ? message : "");
 }
 
-static void get_tags_and_duplicates(struct object_array *pending,
+static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 				    struct string_list *extra_refs)
 {
 	struct tag *tag;
 	int i;
 
-	for (i = 0; i < pending->nr; i++) {
-		struct object_array_entry *e = pending->objects + i;
+	for (i = 0; i < info->nr; i++) {
+		struct rev_cmdline_entry *e = info->rev + i;
 		unsigned char sha1[20];
 		struct commit *commit;
 		char *full_name;
 
+		if (e->flags & UNINTERESTING)
+			continue;
+
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
 			continue;
 
@@ -681,7 +684,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
 
-	get_tags_and_duplicates(&revs.pending, &extra_refs);
+	get_tags_and_duplicates(&revs.cmdline, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 12ae256..ece8fd5 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -162,4 +162,12 @@ test_expect_failure 'pushing without marks' '
 	compare_refs local2 HEAD server HEAD
 '
 
+test_expect_success 'push all with existing object' '
+	(cd local &&
+	git branch dup2 master &&
+	git push origin --all
+	) &&
+	compare_refs local dup2 server dup2
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1f59862..c8e41c1 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -454,4 +454,34 @@ test_expect_success 'test bidirectionality' '
 	git fast-import --export-marks=marks-cur --import-marks=marks-cur
 '
 
+cat > expected << EOF
+blob
+mark :13
+data 5
+bump
+
+commit refs/heads/master
+mark :14
+author A U Thor <author@example.com> 1112912773 -0700
+committer C O Mitter <committer@example.com> 1112912773 -0700
+data 5
+bump
+from :12
+M 100644 :13 file
+
+EOF
+
+test_expect_success 'avoid uninteresting refs' '
+	> tmp-marks &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks master > /dev/null &&
+	git tag v1.0 &&
+	git branch uninteresting &&
+	echo bump > file &&
+	git commit -a -m bump &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks ^uninteresting ^v1.0 master > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.0.1
