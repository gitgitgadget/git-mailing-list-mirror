From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv0 4/4] fast-import.c:note_change_n(): Rename commit_* to target_*
Date: Mon,  5 Jan 2015 04:39:38 +0100
Message-ID: <1420429178-20336-4-git-send-email-johan@herland.net>
References: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
 <1420429178-20336-1-git-send-email-johan@herland.net>
Cc: Git mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 04:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7yWh-0002T6-J6
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbbAEDkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 22:40:10 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:60542 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbbAEDkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:40:08 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so17651849lab.13
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BbD7luaKNU3liWIaGITvwljJFDEH04OdQYeJ3Qr2gsI=;
        b=VHehUn13GiBML7AJxp7XbpbwQMfoUUcBIheJkchG2POCgVTnPKDilXls35Env5lnGe
         E7k1emvG1Fz5KqJ104bv8WkExpA7n5fi5TX8v8mtKcMC13hGnIl2md2POzB6NjVgycyo
         MnTBoMOlzLpWv40aI3jvfFUgBDv2hnna5Yia/xJuzMrYQj7+BP01VhGLgxsiUqhGDhwh
         v/pT05Z/ajcIH4sfXnkpQ++V3D8fW2qYiDpEdI/walVRB9oaqxioxxC/72/8Fq8LIeu1
         s3Lk908rfvrzvIwsphrPCUf+dDi6ed8wTk6J0NW/B0ByKGz4uX/KuTv+bIxqEpxAAmcW
         haxw==
X-Received: by 10.152.3.195 with SMTP id e3mr89995030lae.8.1420429206556;
        Sun, 04 Jan 2015 19:40:06 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ya4sm4239978lbb.32.2015.01.04.19.40.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jan 2015 19:40:05 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1420429178-20336-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262012>

Since we now allow adding notes to any kind of object (not just commits),
rename the related variables from "commit_*" to "target_*".

TODO: Also replace "commit-ish" with something more suitable in the
documentation. However, the same needs to be done for the 'tag' command,
and we also the BNF at the top of fast-import.c needs corresponding updates.

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b6df00b..4ef7a95 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2451,7 +2451,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	static struct strbuf uq = STRBUF_INIT;
 	struct object_entry *oe;
 	struct branch *s;
-	unsigned char sha1[20], commit_sha1[20];
+	unsigned char sha1[20], target_sha1[20];
 	char path[60];
 	uint16_t inline_data = 0;
 	unsigned char new_fanout;
@@ -2489,19 +2489,19 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Missing space after SHA1: %s", command_buf.buf);
 	}
 
-	/* <commit-ish> */
+	/* <object> */
 	s = lookup_branch(p);
 	if (s) {
 		if (is_null_sha1(s->sha1))
 			die("Can't add a note on empty branch.");
-		hashcpy(commit_sha1, s->sha1);
+		hashcpy(target_sha1, s->sha1);
 	} else if (*p == ':') {
-		uintmax_t commit_mark = parse_mark_ref_eol(p);
-		struct object_entry *commit_oe = find_mark(commit_mark);
-		hashcpy(commit_sha1, commit_oe->idx.sha1);
-	} else if (!get_sha1(p, commit_sha1)) {
-		if (!find_object(commit_sha1)) {
-			if (sha1_object_info(commit_sha1, NULL) < 0)
+		uintmax_t target_mark = parse_mark_ref_eol(p);
+		struct object_entry *target_oe = find_mark(target_mark);
+		hashcpy(target_sha1, target_oe->idx.sha1);
+	} else if (!get_sha1(p, target_sha1)) {
+		if (!find_object(target_sha1)) {
+			if (sha1_object_info(target_sha1, NULL) < 0)
 				die("Not a valid object: %s", p);
 		}
 	} else
@@ -2527,7 +2527,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			    typename(type), command_buf.buf);
 	}
 
-	construct_path_with_fanout(sha1_to_hex(commit_sha1), *old_fanout, path);
+	construct_path_with_fanout(sha1_to_hex(target_sha1), *old_fanout, path);
 	if (tree_content_remove(&b->branch_tree, path, NULL, 0))
 		b->num_notes--;
 
@@ -2536,7 +2536,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 
 	b->num_notes++;
 	new_fanout = convert_num_notes_to_fanout(b->num_notes);
-	construct_path_with_fanout(sha1_to_hex(commit_sha1), new_fanout, path);
+	construct_path_with_fanout(sha1_to_hex(target_sha1), new_fanout, path);
 	tree_content_set(&b->branch_tree, path, sha1, S_IFREG | 0644, NULL);
 }
 
-- 
2.1.1.392.g062cc5d
