From: Bobby Powers <bobbypowers@gmail.com>
Subject: [PATCH] cherry-pick: Add an option to prepend a string to the commit message
Date: Fri, 11 Jun 2010 22:07:17 -0700
Message-ID: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 12 07:07:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONIwX-0006cV-SR
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 07:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0FLFHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 01:07:37 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52301 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0FLFHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 01:07:36 -0400
Received: by pxi8 with SMTP id 8so1157098pxi.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Kr3rp6/SXgNZVDQSjt+Uhb7Ndg0wY4IA/caWC0MX4wc=;
        b=BwVRYQOgXp4/6P+MOJPrjvQLTIEBp8m1iOptvOBb4qMDqiO7z/rj/J9TYKiO5iCt+P
         clNgikqsGHqzUuzQInGSSn1v/MkkPn7bHwsYyXDuUH71jCJVZK9WzdUCjkS2GsKWcuHq
         rR9Q6cjZmK0nbJ2V4CBexGZpzOm5AB8FWYB0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pzc75OkGWJLgXJyGkE8+tSsmQUJ3lUBpXeF3ee9wynDzOyxjFowSuMy9IGoCR1CDNb
         K0XPRhml70yvaIqOLvNlTQt2qP6wmsuWcabDIomEBFjg7DsNpPcHk6n2+d+2iLA93P0R
         zZL2n01g6uNl5rx+XQsOv+vgD6xd06j73zliE=
Received: by 10.141.3.1 with SMTP id f1mr2178376rvi.148.1276319255739;
        Fri, 11 Jun 2010 22:07:35 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-195-105.hsd1.ca.comcast.net [98.210.195.105])
        by mx.google.com with ESMTPS id t1sm2040228rvl.21.2010.06.11.22.07.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 22:07:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148987>

This can be useful situations where you have a batch of commits to
cherry-pick and need to prefix each new commit message with similar
information (such as the subversion revision, when used in conjunction
with git-svn).

Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
---
 Documentation/git-cherry-pick.txt |    7 +++++++
 builtin/revert.c                  |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d71607a..2526e13 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -62,6 +62,13 @@ OPTIONS
 	option is used, your index does not have to match the
 	HEAD commit.  The cherry-pick is done against the
 	beginning state of your index.
+
+--prepend::
+	Specify a string to prepend to the commit message.  This
+	can be useful situations where you have a batch of commits
+	to cherry-pick and need to prefix each new commit message
+	with similar information (such as the subversion revision,
+	when used in conjunction with git-svn).
 +
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
diff --git a/builtin/revert.c b/builtin/revert.c
index 7976b5a..45091ac 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -44,6 +44,7 @@ static int allow_rerere_auto;
 
 static const char *me;
 static const char *strategy;
+static const char *prepend;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -64,7 +65,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
-		OPT_END(),
+		OPT_STRING(0, "prepend", &prepend, "message", "string to prepend to the commit message"),
 		OPT_END(),
 		OPT_END(),
 	};
@@ -392,6 +393,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die("cherry-pick --ff cannot be used with -x");
 		if (edit)
 			die("cherry-pick --ff cannot be used with --edit");
+		if (prepend)
+			die("cherry-pick --ff cannot be used with --prepend");
 	}
 
 	if (read_cache() < 0)
@@ -482,6 +485,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		next = commit;
 		next_label = msg.label;
 		set_author_ident_env(msg.message);
+		if (prepend) {
+			strbuf_addstr(&msgbuf, prepend);
+		}
 		add_message_to_msg(&msgbuf, msg.message);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
-- 
1.7.1.251.g92a7.dirty
