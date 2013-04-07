From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/6] format-patch: improve head calculation for cover-letter
Date: Sun,  7 Apr 2013 12:46:20 -0500
Message-ID: <1365356784-24872-3-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOth7-0003OL-7e
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934199Ab3DGRrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:47:49 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:40935 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934156Ab3DGRrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:47:48 -0400
Received: by mail-ob0-f172.google.com with SMTP id eh20so1708584obb.31
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LNwQyw6O3G23/efcKdSwUGOFTG607HNEhnl9np3LBAw=;
        b=iEZU935asUVzSt0BJMEfNM4eo9TkkS6C9iylu69jbv46jAhS2iBBxvwhqyPQMmXpAU
         3BnwcbGD8jaw8MsDYatgkIkXVS93zVlAZgmZ2peXpJBiil5P3LggCLFGY9O31nYha0Tr
         AiJPDzoKVBezN0RZimbnwQqk7jPQqRps5cIMCE/3TZuV78CTalh/aEVxUcEJ8iXpu61v
         IEIsgUguin5cbD/jmMMT9hpLiNU5P3kUL2xklsxn7hzzkNQETTn8jokf8BtiqS9+R40R
         Dw3i78n307jmUlXfP+7UxZJSyUwhI1yXVM5E9idv0DxjDn72As2D947gU93D4n2vDhbJ
         yjiw==
X-Received: by 10.60.36.231 with SMTP id t7mr13150774oej.3.1365356867782;
        Sun, 07 Apr 2013 10:47:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id be1sm20669798obb.11.2013.04.07.10.47.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:47:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220341>

If we do it after the revision traversal we can be sure that this is
indeed a commit that will be processed (i.e. not a merge) and it's the
top most one (thus removing the NEEDSWORK comment, at least we show the
same as 'git diff --stat').

While we are at it, since we know there's nothing to generate, exit
sooner in all cases, like --cover-letter currently does.

Also, if there's nothing to generate and cover-letter is specified, a
different code-path might be triggered that is not currently covered in
the test-case, so add a test for it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c           | 22 ++++------------------
 t/t4014-format-patch.sh |  5 +++++
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..e0c8b6f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1319,24 +1319,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.show_root_diff = 1;
 
 	if (cover_letter) {
-		/*
-		 * NEEDSWORK:randomly pick one positive commit to show
-		 * diffstat; this is often the tip and the command
-		 * happens to do the right thing in most cases, but a
-		 * complex command like "--cover-letter a b c ^bottom"
-		 * picks "c" and shows diffstat between bottom..c
-		 * which may not match what the series represents at
-		 * all and totally broken.
-		 */
-		int i;
-		for (i = 0; i < rev.pending.nr; i++) {
-			struct object *o = rev.pending.objects[i].item;
-			if (!(o->flags & UNINTERESTING))
-				head = (struct commit *)o;
-		}
-		/* There is nothing to show; it is not an error, though. */
-		if (!head)
-			return 0;
 		if (!branch_name)
 			branch_name = find_branch_name(&rev);
 	}
@@ -1372,6 +1354,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
+	if (nr == 0)
+		/* nothing to do */
+		return 0;
+	head = list[0];
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7fa3647..71b35e7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1021,4 +1021,9 @@ test_expect_success 'cover letter using branch description (6)' '
 	grep hello actual >/dev/null
 '
 
+test_expect_success 'cover letter with nothing' '
+	git format-patch --stdout --cover-letter >actual &&
+	test_line_count = 0 actual
+'
+
 test_done
-- 
1.8.2
