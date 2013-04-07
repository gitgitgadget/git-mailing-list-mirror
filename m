From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 1/2] fmt-merge-msg: respect core.commentchar in people credits
Date: Sun,  7 Apr 2013 17:25:43 +0200
Message-ID: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrTh-0000HW-0z
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912Ab3DGPZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:25:53 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:50482 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907Ab3DGPZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 11:25:52 -0400
Received: by mail-ea0-f172.google.com with SMTP id z7so1900450eaf.17
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VJBYKsLR5ttZskfdoMA8ud+4OBmhYAM9T/txEmTgsRw=;
        b=AXpdPKa41yltq9UBUHvcOM1MkNv29GNnAhMnOfpPS7ZPp75I0moIsVChs1w6GY6ghJ
         Y+K8/ZACzgazyCvK+ga72EB6nbyxMWMmRYsmt52ECQMIIPEomHktON3aP6id/5zoDHoJ
         8CQ+Lfk4QuV5AwQN1udarWcdarJsuYXuj99z4doAgRHFS0Ggg6/84Q079pft2I9DaGkM
         Wj4mgwRs6n7Uhm7CUzzumJ4YjFs6/PkBv2Ss83UckDwKtvzSi762MBfhh4ODXSpFlmDe
         gIrlX4J5g6DlNg4Pgxm8RqafeO8p3MlFzZ1odtbdC5v5yJxtfpARZDB048aFowAufrMg
         0GPw==
X-Received: by 10.15.32.67 with SMTP id z43mr30206567eeu.24.1365348351168;
        Sun, 07 Apr 2013 08:25:51 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPS id bc1sm26809791eeb.11.2013.04.07.08.25.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 08:25:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.470.g21ccebe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220317>

Commit eff80a9 (Allow custom "comment char") introduced a custom
comment character for commit messages but forgot to use it in
people credits which can be a part of a commit message.

With this commit, the custom comment character is also used
in people credits.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/fmt-merge-msg.c  |  6 +++---
 t/t6200-fmt-merge-msg.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 265a925..88df93a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -287,10 +287,10 @@ static void credit_people(struct strbuf *out,
 	const char *me;
 
 	if (kind == 'a') {
-		label = "\n# By ";
+		label = "By";
 		me = git_author_info(IDENT_NO_DATE);
 	} else {
-		label = "\n# Via ";
+		label = "Via";
 		me = git_committer_info(IDENT_NO_DATE);
 	}
 
@@ -300,7 +300,7 @@ static void credit_people(struct strbuf *out,
 	     (me = skip_prefix(me, them->items->string)) != NULL &&
 	     skip_prefix(me, " <")))
 		return;
-	strbuf_addstr(out, label);
+	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
 	add_people_count(out, them);
 }
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 992c2a0..84e10fd 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -180,6 +180,24 @@ test_expect_success 'merge.log=5 shows all 5 commits' '
 	test_cmp expected actual
 '
 
+test_expect_success '--log=5 with custom comment character' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	/ By Another Author (3) and A U Thor (2)
+	/ Via Another Committer
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'merge.log=0 disables shortlog' '
 	echo "Merge branch ${apos}left${apos}" >expected
 	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
-- 
1.8.2.470.g21ccebe
