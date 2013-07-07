From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] name-rev: fix assumption about --name-only usage
Date: Sun,  7 Jul 2013 18:13:14 +0530
Message-ID: <1373200996-9753-2-git-send-email-artagnon@gmail.com>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoN7-0007XY-H3
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab3GGMrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 08:47:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32810 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3GGMrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:47:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so3499343pad.19
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PTvol7PLXultyhO5LF2teSiTMp6/YHkqBPYlkps4K9I=;
        b=eUDTiO3UJ8mPBv8ZzN/lUjqQhAN8pe+6APzGHV0sGYMVHz+kgqnaJp1WgCcpRW/hhz
         ePN5KB3s3yFgHzZBguflb4hC4XBlNwgxXgDs1N8+zs7+vtlRgRCz+4ApFdEUcbmiae/1
         Za2auS+hPahXA8oF0PPohC4FqRqTn8JFjcgxHG7z344R6p6ADFSU63Z7Qqubq/F437Zm
         6rPvBionrryJxMHa5JBeZfGgRJs+62pHg/7A2V1XckNX1uSbQbfvIufnOVOldgyLz0I+
         R74YVpaV7lciHktDSu6RjbsWvW7S4OQMIbiJeNKiEreCcebn6KbWkYdlKoGQpL6rLZiT
         5iwA==
X-Received: by 10.66.144.199 with SMTP id so7mr18473387pab.99.1373201234905;
        Sun, 07 Jul 2013 05:47:14 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id eq5sm17024014pbc.15.2013.07.07.05.47.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:47:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.737.gcbc076a.dirty
In-Reply-To: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229769>

236157 (Teach git-describe how to run name-rev, 2007-05-21) introduced
`git name-rev --name-only`, with the intent of using it to implement
`git describe --contains`.  According to the message, users wanted to
use describe to figure out which tags contains a specific commit.
name-rev already did this, but didn't print out in the same format as
describe:

  $ git describe v1.8.3~1
  v1.8.3-rc3-8-g5e49f30

  $ git name-rev v1.8.3~1
  v1.8.3~1 tags/v1.8.3~1

There are two problems with using the output of name-rev in describe:
first, it prints out the given argument before describing it.  Second,
it prefixes "tags/" to the tag description.  To eliminate these two
problems, 236157 proposed that the --name-rev option would strip these
things when used with --tags, to match the describe output more closely:

  $ git name-rev --name-only --tags v1.8.3~1
  v1.8.3~1

236157 did not anticipate a problem with always combining --name-rev
with --tags, because it was primarily intended to be used from describe,
where it hard-coded these two arguments in the execv() of name-rev.

Later, 3f7701 (make 'git describe --all --contains' work, 2007-12-19)
noticed that describe didn't work with --contains and --all.  This is
because --contains implied a call to --name-rev (in with --tags was
hard-coded), but --all implied that any ref should be used to describe
the given argument (not just tags).  3f7701 took the band-aid approach,
and made --all disable --tags when calling name-rev.  As a result, while

  $ git describe --contains v1.8.3~1
  v1.8.3~1

would get name-rev to print output in the same format as describe,

  $ git describe --contains --all v1.8.3~1
  tags/v1.8.3~1

would not strip the leading "tags/".

The bug exists in git to this day.  Fix it by removing the assumption
that name-rev --name-only is only intended to be used with --tags.  Also
update some tests.

Users and scripts have learnt to live with 3f7701, and it will continue
to be a small quirk.  Even after this patch, notice

  $ git checkout -b foom v1.8.3
  $ git describe --contains @~1
  v1.8.3~1
  $ git describe --contains --all @~1
  foom~1

In other words, --contains implies --tags in name-rev, which gives
precedence to tags; --all cancels that effect thereby giving precedence
to branches in the case of a tie.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-name-rev.txt       |  6 +++---
 builtin/name-rev.c                   |  3 +++
 t/t4202-log.sh                       |  8 ++++----
 t/t6007-rev-list-cherry-pick-file.sh | 32 ++++++++++++++++----------------
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 6b0f1ba..7cde4b3 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -37,9 +37,9 @@ OPTIONS
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
-	the name.  If given with --tags the usual tag prefix of
-	"tags/" is also omitted from the name, matching the output
-	of `git-describe` more closely.
+	the name.  The usual tag prefix of "tags/" is also omitted
+	from the name, matching the output of `git-describe` more
+	closely.
 
 --no-undefined::
 	Die with error code != 0 when a reference is undefined,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 87d4854..37207a9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -138,6 +138,9 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 			path = shorten_unambiguous_ref(path, 0);
 		else if (!prefixcmp(path, "refs/heads/"))
 			path = path + 11;
+		else if (data->name_only
+		    && !prefixcmp(path, "refs/tags/"))
+			path = path + 10;
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cb03d28..9bec360 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -302,7 +302,7 @@ cat > expect <<\EOF
 | |
 | |     side-2
 | |
-| * commit tags/side-1
+| * commit side-1
 | | Author: A U Thor <author@example.com>
 | |
 | |     side-1
@@ -327,17 +327,17 @@ cat > expect <<\EOF
 |
 |       fourth
 |
-* commit tags/side-1~1
+* commit side-1~1
 | Author: A U Thor <author@example.com>
 |
 |     third
 |
-* commit tags/side-1~2
+* commit side-1~2
 | Author: A U Thor <author@example.com>
 |
 |     second
 |
-* commit tags/side-1~3
+* commit side-1~3
   Author: A U Thor <author@example.com>
 
       initial
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b..5a8175e 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -49,8 +49,8 @@ test_expect_success setup '
 '
 
 cat >expect <<EOF
-<tags/B
->tags/C
+<B
+>C
 EOF
 
 test_expect_success '--left-right' '
@@ -70,7 +70,7 @@ test_expect_success '--cherry-pick foo comes up empty' '
 '
 
 cat >expect <<EOF
->tags/C
+>C
 EOF
 
 test_expect_success '--cherry-pick bar does not come up empty' '
@@ -88,8 +88,8 @@ test_expect_success 'bar does not come up empty' '
 '
 
 cat >expect <<EOF
-<tags/F
->tags/E
+<F
+>E
 EOF
 
 test_expect_success '--cherry-pick bar does not come up empty (II)' '
@@ -100,10 +100,10 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 '
 
 cat >expect <<EOF
-+tags/F
-=tags/D
-+tags/E
-=tags/C
++F
+=D
++E
+=C
 EOF
 
 test_expect_success '--cherry-mark' '
@@ -114,10 +114,10 @@ test_expect_success '--cherry-mark' '
 '
 
 cat >expect <<EOF
-<tags/F
-=tags/D
->tags/E
-=tags/C
+<F
+=D
+>E
+=C
 EOF
 
 test_expect_success '--cherry-mark --left-right' '
@@ -128,7 +128,7 @@ test_expect_success '--cherry-mark --left-right' '
 '
 
 cat >expect <<EOF
-tags/E
+E
 EOF
 
 test_expect_success '--cherry-pick --right-only' '
@@ -146,8 +146,8 @@ test_expect_success '--cherry-pick --left-only' '
 '
 
 cat >expect <<EOF
-+tags/E
-=tags/C
++E
+=C
 EOF
 
 test_expect_success '--cherry' '
-- 
1.8.3.2.737.gcbc076a.dirty
