From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/16] blame: teach -L/RE/ to search from end of previous -L range
Date: Tue,  6 Aug 2013 09:59:42 -0400
Message-ID: <1375797589-65308-10-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hor-0003fH-7C
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab3HFOAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:47 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:52238 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab3HFOAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:44 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so762580oag.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e86sRUMFDF2olYzGQdlxnuoo2+vh5un/7Uk898/uvG4=;
        b=ztxnKFh1G/vMCX/lmPpybcp4V7a384oJkVO3cctvVIbwYPCPMfi1GdFso+6iHmcQRT
         62d3qbkptXs/mkY3Jugsx5Kg8XXo6bXpIwGngmtWqGFXGr2mfiYdZ67rVFtOa6n+BUQr
         ih9sAWwSfzRKgkzLha9g0/Qa5PFhujcahBe8abkh19Jd5aTsath1YTZDIDamO/KGaX2q
         SikMTZWeZctf+e0xmovzISrZstJGwXc1qBPx87li5srBikolYMT+k5cAa19VRk61B90C
         nC8dRw1HVXtA1hKkgsrlfcBgraHD1Yj+6bTj1GW+15kg6Q5q9O5ltJPHuaD1BDZ7iXfc
         lB8w==
X-Received: by 10.60.162.103 with SMTP id xz7mr1127393oeb.33.1375797643773;
        Tue, 06 Aug 2013 07:00:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231744>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/blame.c     |  5 ++++-
 t/annotate-tests.sh | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7b084d8..1bf8056 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2280,6 +2280,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
 	struct range_set ranges;
 	unsigned int range_i;
+	long anchor;
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
@@ -2475,11 +2476,12 @@ parse_done:
 	if (lno && !range_list.nr)
 		string_list_append(&range_list, xstrdup("1"));
 
+	anchor = 1;
 	range_set_init(&ranges, range_list.nr);
 	for (range_i = 0; range_i < range_list.nr; ++range_i) {
 		long bottom, top;
 		if (parse_range_arg(range_list.items[range_i].string,
-				    nth_line_cb, &sb, lno, 1,
+				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
@@ -2490,6 +2492,7 @@ parse_done:
 			top = lno;
 		bottom--;
 		range_set_append_unsafe(&ranges, bottom, top);
+		anchor = top + 1;
 	}
 	sort_and_merge_range_set(&ranges);
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 77083d9..b963d36 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -303,6 +303,26 @@ test_expect_success 'blame -L multiple (superset/subset: unordered)' '
 	check_count -L3,5 -L2,8 A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
 '
 
+test_expect_success 'blame -L /RE/ (relative)' '
+	check_count -L3,3 -L/fox/ B1 1 B2 1 C 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/ (relative: no preceding range)' '
+	check_count -L/dog/ A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/ (relative: adjacent)' '
+	check_count -L1,1 -L/dog/,+1 A 1 E 1
+'
+
+test_expect_success 'blame -L /RE/ (relative: not found)' '
+	test_must_fail $PROG -L4,4 -L/dog/ file
+'
+
+test_expect_success 'blame -L /RE/ (relative: end-of-file)' '
+	test_must_fail $PROG -L, -L/$/ file
+'
+
 test_expect_success 'setup -L :regex' '
 	tr Q "\\t" >hello.c <<-\EOF &&
 	int main(int argc, const char *argv[])
-- 
1.8.4.rc1.409.gbd48715
