From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 2/9] fast-export: don't handle uninteresting refs
Date: Sat, 24 Nov 2012 04:25:13 +0100
Message-ID: <1353727520-26039-3-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6NQ-0006my-EF
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab2KXDZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:42 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab2KXDZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hilBAR+i3y7cX7AjkwBmx0T1hYHt9KwW3+lFMAsKpas=;
        b=RCFa08YM5V8P+sTAOGuDXa0k42akH8C4cNw+/zSetUho3b1pvTaFDGYvf19IXCv/IU
         XSJaD8lz9Mu895Pc4/tn1QPJ+NoiaA09LCCqkcQGskSRY/O9aoZ2LO7V0XtLyR7MKpV5
         4Pcj9D2Odnr8IEZ1Tb9YKcmFWVA871AIIqA52eoUqeYnMHLOTzD6g1pvWVfjbz8nl15u
         Isc12yZte+PBDVssBiZBC2mvnzLX3okjRWguoDY4zOLKQbDgbYxpUQpjTuXP84x3ZlJN
         BHl/H+N4bLLPXQg0k/iGmyRjWeV2Nkd5RRujfQRx9NHYf7a/FYRuc1iKChUvkNNcMuK8
         MO0A==
Received: by 10.204.154.17 with SMTP id m17mr1737605bkw.89.1353727540291;
        Fri, 23 Nov 2012 19:25:40 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id hm8sm2496415bkc.10.2012.11.23.19.25.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210301>

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

The difference with the previous version is that now '^uninteresting ^bad
master new' would handle 'master' and 'new', while the previous one would not
do anything. The current behavior would handle 'bad', 'master', and 'new'.

 builtin/fast-export.c     | 11 +++++++----
 t/t5801-remote-helpers.sh |  8 ++++++++
 t/t9350-fast-export.sh    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 31bfbee..77dffd1 100644
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
 
@@ -685,7 +688,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
 
-	get_tags_and_duplicates(&revs.pending, &extra_refs);
+	get_tags_and_duplicates(&revs.cmdline, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index b2782a2..2e027c8 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -158,4 +158,12 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
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
index 237d2e5..2e7187e 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -469,4 +469,34 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
 	test_cmp expected actual
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
+test_expect_success 'refs are updated even if no commits need to be exported' '
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
1.8.0
