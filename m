From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC] Revert "git am/mailinfo: Don't look at in-body headers when rebasing"
Date: Tue, 16 Jun 2015 17:03:12 +0800
Message-ID: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Lukas=20Sandstr=C3=B6m?= <luksan@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 11:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4mmT-00043L-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757244AbbFPJDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 05:03:37 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35209 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbbFPJD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:03:26 -0400
Received: by pacyx8 with SMTP id yx8so8934253pac.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wn25f9AYw1E/PAGgkNLOs14Ap9pTRN2/uszsq/ICBcQ=;
        b=VlUHUytL1xgyZ9E24RT/XahSRwFr3PvTvzmonf7SVwZu5bP/al8NpUjofLK4/v6rDJ
         xcCqN3q8gx34T76xVFYuK84zZ6WPovUrM2eXIc/raUOa5v7JttrXkTS3501VrU4cJlH8
         E9IgLiKPA9FnQ4XYLnjdLC1z9sfXOBmSxWzULjAnYdV1K3vxr0KWenJS0576eQyiQ8uG
         8fcLu9KnjYrStQ0GTpf9U2s/oVdTs4x3SQhfkQez7p5E9LiQH7i4RI1fxOlDlA3MGARA
         KeABgtAE9pPJM83bRdkdNQcUYFgBwY7CDP6n+AcGeUfNxJBqzVrAEAnHzMZ8LqToIa4I
         Cj1A==
X-Received: by 10.68.98.133 with SMTP id ei5mr56773692pbb.51.1434445405077;
        Tue, 16 Jun 2015 02:03:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id fk4sm554981pbb.80.2015.06.16.02.03.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 02:03:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271741>

This reverts commit d25e51596be9271ad833805a3d6f9012dc24ee79, removing
git-mailsplit's --no-inbody-headers option.

While --no-inbody-headers was introduced to prevent commit messages from
being munged by git-mailinfo while rebasing, the need for this option
disappeared since 5e835ca (rebase: do not munge commit log message,
2008-04-16), as git-am bypasses git-mailinfo and gets the commit message
directly from the commit ID in the patch.

git-am is the only user of --no-inbody-headers, and this option is not
documented. As such, it should be removed.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    The other direction, of course, is to turn --no-inbody-headers into a
    supported, documented option in both git-mailsplit and git-am.
    
    I do also wonder if we should just ensure that git-format-patch does not
    generate a message that start with "From" or "Date".

 builtin/mailinfo.c                   | 12 +-----------
 git-am.sh                            |  9 +--------
 t/t5100-mailinfo.sh                  |  4 ----
 t/t5100/info0015--no-inbody-headers  |  5 -----
 t/t5100/info0016--no-inbody-headers  |  5 -----
 t/t5100/msg0015--no-inbody-headers   |  3 ---
 t/t5100/msg0016--no-inbody-headers   |  4 ----
 t/t5100/patch0015--no-inbody-headers |  8 --------
 t/t5100/patch0016--no-inbody-headers |  8 --------
 9 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 t/t5100/info0015--no-inbody-headers
 delete mode 100644 t/t5100/info0016--no-inbody-headers
 delete mode 100644 t/t5100/msg0015--no-inbody-headers
 delete mode 100644 t/t5100/msg0016--no-inbody-headers
 delete mode 100644 t/t5100/patch0015--no-inbody-headers
 delete mode 100644 t/t5100/patch0016--no-inbody-headers

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 999a525..34ea160 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -26,7 +26,6 @@ static int patch_lines;
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
 static int add_message_id;
-static int use_inbody_headers = 1;
 
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
@@ -795,17 +794,10 @@ static int handle_commit_msg(struct strbuf *line)
 	if (still_looking) {
 		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
 			return 0;
-	}
-
-	if (use_inbody_headers && still_looking) {
 		still_looking = check_header(line, s_hdr_data, 0);
 		if (still_looking)
 			return 0;
-	} else
-		/* Only trim the first (blank) line of the commit message
-		 * when ignoring in-body headers.
-		 */
-		still_looking = 0;
+	}
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
@@ -1062,8 +1054,6 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
 			use_scissors = 0;
-		else if (!strcmp(argv[1], "--no-inbody-headers"))
-			use_inbody_headers = 0;
 		else
 			usage(mailinfo_usage);
 		argc--; argv++;
diff --git a/git-am.sh b/git-am.sh
index 761befb..df403b0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -372,7 +372,7 @@ split_patches () {
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
-messageid= resolvemsg= resume= scissors= no_inbody_headers=
+messageid= resolvemsg= resume= scissors=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
@@ -579,7 +579,6 @@ Use \"git am --abort\" to remove it.")"
 	echo "$keep" >"$dotest/keep"
 	echo "$messageid" >"$dotest/messageid"
 	echo "$scissors" >"$dotest/scissors"
-	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
@@ -644,12 +643,6 @@ t)
 f)
 	scissors=--no-scissors ;;
 esac
-if test "$(cat "$dotest/no_inbody_headers")" = t
-then
-	no_inbody_headers=--no-inbody-headers
-else
-	no_inbody_headers=
-fi
 if test "$(cat "$dotest/quiet")" = t
 then
 	GIT_QUIET=t
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e97cfb2..b2b5be6 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -31,10 +31,6 @@ do
 		then
 			check_mailinfo $mail --scissors
 		fi &&
-		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--no-inbody-headers
-		then
-			check_mailinfo $mail --no-inbody-headers
-		fi &&
 		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--message-id
 		then
 			check_mailinfo $mail --message-id
diff --git a/t/t5100/info0015--no-inbody-headers b/t/t5100/info0015--no-inbody-headers
deleted file mode 100644
index c4d8d77..0000000
--- a/t/t5100/info0015--no-inbody-headers
+++ /dev/null
@@ -1,5 +0,0 @@
-Author: A U Thor
-Email: a.u.thor@example.com
-Subject: check bogus body header (from)
-Date: Fri, 9 Jun 2006 00:44:16 -0700
-
diff --git a/t/t5100/info0016--no-inbody-headers b/t/t5100/info0016--no-inbody-headers
deleted file mode 100644
index f4857d4..0000000
--- a/t/t5100/info0016--no-inbody-headers
+++ /dev/null
@@ -1,5 +0,0 @@
-Author: A U Thor
-Email: a.u.thor@example.com
-Subject: check bogus body header (date)
-Date: Fri, 9 Jun 2006 00:44:16 -0700
-
diff --git a/t/t5100/msg0015--no-inbody-headers b/t/t5100/msg0015--no-inbody-headers
deleted file mode 100644
index be5115b..0000000
--- a/t/t5100/msg0015--no-inbody-headers
+++ /dev/null
@@ -1,3 +0,0 @@
-From: bogosity
-  - a list
-  - of stuff
diff --git a/t/t5100/msg0016--no-inbody-headers b/t/t5100/msg0016--no-inbody-headers
deleted file mode 100644
index 1063f51..0000000
--- a/t/t5100/msg0016--no-inbody-headers
+++ /dev/null
@@ -1,4 +0,0 @@
-Date: bogus
-
-and some content
-
diff --git a/t/t5100/patch0015--no-inbody-headers b/t/t5100/patch0015--no-inbody-headers
deleted file mode 100644
index ad64848..0000000
--- a/t/t5100/patch0015--no-inbody-headers
+++ /dev/null
@@ -1,8 +0,0 @@
----
-diff --git a/foo b/foo
-index e69de29..d95f3ad 100644
---- a/foo
-+++ b/foo
-@@ -0,0 +1 @@
-+content
-
diff --git a/t/t5100/patch0016--no-inbody-headers b/t/t5100/patch0016--no-inbody-headers
deleted file mode 100644
index ad64848..0000000
--- a/t/t5100/patch0016--no-inbody-headers
+++ /dev/null
@@ -1,8 +0,0 @@
----
-diff --git a/foo b/foo
-index e69de29..d95f3ad 100644
---- a/foo
-+++ b/foo
-@@ -0,0 +1 @@
-+content
-
-- 
2.1.4
