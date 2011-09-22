From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/2] fast-import: don't allow to note on empty branch
Date: Fri, 23 Sep 2011 01:47:05 +0600
Message-ID: <1316720825-32552-3-git-send-email-divanorama@gmail.com>
References: <1316720825-32552-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:40:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6p8X-0004iT-TC
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735Ab1IVTkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 15:40:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44362 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab1IVTkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:40:19 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2807782bkb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tnxH4C2qGueozidUt+ViehYLoFZgztTY/fMSP6tFlgY=;
        b=lo6lm0YgPz6en8j3R40ANLbzGLEGXPF08+z7s8/hx09PoHsru/frjbNdE1OqYa8aWt
         p5X0PVrjwsgZGKiQqpjABDzTejAd9B5O+GZG+qNREvKgzVJ7rI97UqZ4zgAFcRuRZ14P
         TRw5vZz0+eM9fOEpel6EgQKAJ/0AzV7VAzBMA=
Received: by 10.204.152.201 with SMTP id h9mr1810987bkw.147.1316720419196;
        Thu, 22 Sep 2011 12:40:19 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id j16sm3857428bks.3.2011.09.22.12.40.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 12:40:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316720825-32552-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181916>

'reset' command makes fast-import start a branch from scratch. It's name
is kept in lookup table but it's sha1 is null_sha1 (special value).
'notemodify' command can be used to add a note on branch head given it's
name. lookup_branch() is used it that case and it doesn't check for
null_sha1. So fast-import writes a note for null_sha1 object instead of
giving a error.

Add a check to deny adding a note on empty branch and add a corresponding
test.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |    2 ++
 t/t9300-fast-import.sh |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c44cc11..a8a3ad1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2416,6 +2416,8 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 	/* <committish> */
 	s = lookup_branch(p);
 	if (s) {
+		if (is_null_sha1(s->sha1))
+			die("Can't add a note on empty branch.");
 		hashcpy(commit_sha1, s->sha1);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = strtoumax(p + 1, NULL, 10);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0b97d7a..bd32b91 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1987,6 +1987,23 @@ test_expect_success \
 	'Q: verify second note for second commit' \
 	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
 
+cat >input <<EOF
+reset refs/heads/Q0
+
+commit refs/heads/note-Q0
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+Note for an empty branch.
+COMMIT
+
+N inline refs/heads/Q0
+data <<NOTE
+some note
+NOTE
+EOF
+test_expect_success \
+	'Q: deny note on empty branch' \
+	'test_must_fail git fast-import <input'
 ###
 ### series R (feature and option)
 ###
-- 
1.7.3.4
