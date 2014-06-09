From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 4/5] fast-import.c: cleanup using strbuf_set operations
Date: Mon,  9 Jun 2014 01:36:28 -0700
Message-ID: <b64218c4f2a188c5aeb48a07da01972ef4d0ca33.1402301816.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv5L-0007GJ-Im
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbaFIIhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:40 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33380 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbaFIIhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:39 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so4709646pbc.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XDCIEw5GMzthXTAQtc7W5U6nrpJILJNTSdJ5DYRbetI=;
        b=ZTwc2j1N/IkiH/LzedhcifjDHitLkTlk+dSsJRsDT5ta1QhFSMAkpo0L9ZGaInhjB6
         LAVyVnMG9DfEmccXQ2W0q6YUCb9CNANYY7RoLUUONw5Cxk+MceljeQdfAh++/z6/UxJx
         xE3LxbKWkBadYskQHKhtHj7WqPXLlB4s7Bu3gEUTE5h3Qbi4UrgvhZOdx+S2mT62llvm
         hEndpTJuiNK4SiyvA8jLXRfJajnN4zwuLOA03HszSNwRSMi/Chz3lObOdTkTM8QHkqTp
         FppPqRbFA5K7vTKIP1TuWS+AqhjRvvjXJHyGSPQdNSJT+z6T4sWuIYm/MWy4ZkQ87r6l
         yE1w==
X-Received: by 10.68.253.73 with SMTP id zy9mr3018194pbc.114.1402303059020;
        Mon, 09 Jun 2014 01:37:39 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vx10sm9013591pac.17.2014.06.09.01.37.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:37 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:35 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251062>

Simplified cases where a strbuf_reset was immediately followed by a
strbuf_add using the new strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 fast-import.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e8ec34d..c23935c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2741,8 +2741,7 @@ static void parse_new_commit(void)
 	hashcpy(b->branch_tree.versions[0].sha1,
 		b->branch_tree.versions[1].sha1);
 
-	strbuf_reset(&new_data);
-	strbuf_addf(&new_data, "tree %s\n",
+	strbuf_setf(&new_data, "tree %s\n",
 		sha1_to_hex(b->branch_tree.versions[1].sha1));
 	if (!is_null_sha1(b->sha1))
 		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
@@ -2829,9 +2828,7 @@ static void parse_new_tag(void)
 	parse_data(&msg, 0, NULL);
 
 	/* build the tag object */
-	strbuf_reset(&new_data);
-
-	strbuf_addf(&new_data,
+	strbuf_setf(&new_data,
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
@@ -2898,8 +2895,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	 * Output based on batch_one_object() from cat-file.c.
 	 */
 	if (type <= 0) {
-		strbuf_reset(&line);
-		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		strbuf_setf(&line, "%s missing\n", sha1_to_hex(sha1));
 		cat_blob_write(line.buf, line.len);
 		strbuf_release(&line);
 		free(buf);
@@ -2910,8 +2906,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	if (type != OBJ_BLOB)
 		die("Object %s is a %s but a blob was expected.",
 		    sha1_to_hex(sha1), typename(type));
-	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+	strbuf_setf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
 						typename(type), size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
@@ -3034,14 +3029,12 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 
 	if (!mode) {
 		/* missing SP path LF */
-		strbuf_reset(&line);
-		strbuf_addstr(&line, "missing ");
+		strbuf_setstr(&line, "missing ");
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	} else {
 		/* mode SP type SP object_name TAB path LF */
-		strbuf_reset(&line);
-		strbuf_addf(&line, "%06o %s %s\t",
+		strbuf_setf(&line, "%06o %s %s\t",
 				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
-- 
2.0.0.573.ged771ce.dirty
