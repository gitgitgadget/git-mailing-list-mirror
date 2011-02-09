From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 1/3] Add setup_merge_commit function to merge/builtin.c.
Date: Tue,  8 Feb 2011 19:23:46 -0500
Message-ID: <1297211028-14382-2-git-send-email-jaredhance@gmail.com>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 01:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmxqy-0001Po-5j
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab1BIAYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:24:10 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45295 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab1BIAYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:24:08 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so5311853qyk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=58J8kbNDlp++rogMdDlOv05uhgHa6tXf69Re+VJb9Pg=;
        b=p+kJlasz5nlgw2eCT+nIn2kYmAgV2P8xZSTuBeFCAToy90uE+8khN2LYGH7TVTuU9f
         h4bppUin9zSB+MSIW7LZ67hK3L8lwSlNm1qHfA5iavJgvVp/ANZIlFqEPVd8tllfNONU
         ZCSHqFD9jNV5aiUVhK5neU8gie9Q1ZvmMJ9N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=skVW9ODqOGIXDHsjrgooJXdgTSmjxwDqcdBaPjFbZMbvR1Bnvn6JTnsbYGwbs6REaJ
         QOxqujkNfWdZ69gLuq/CqcXn0GWD4Csv9vstYskwHlrbx3lvWWsTHSxKV0MMzHmodNI0
         Qo4MCP544pd7BGRevxvw60zDkEkmQtMJlcSBA=
Received: by 10.229.79.135 with SMTP id p7mr3922598qck.154.1297211048418;
        Tue, 08 Feb 2011 16:24:08 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id nb15sm35516qcb.26.2011.02.08.16.24.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 16:24:07 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166378>

Adds a new function that will be used in a later patch as well as the
current code to reduce redundancy.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..bc1ae94 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -911,6 +911,24 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+static void setup_merge_commit(struct strbuf *buf,
+	struct commit_list ***remotes, const char *s)
+{
+	struct object *o;
+	struct commit *commit;
+
+	o = peel_to_type(s, 0, NULL, OBJ_COMMIT);
+	if (!o)
+		die("%s - not something we can merge", s);
+	commit = lookup_commit(o->sha1);
+	commit->util = (void *)s;
+	*remotes = &commit_list_insert(commit, *remotes)->next;
+
+	strbuf_addf(buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+	setenv(buf->buf, s, 1);
+	strbuf_reset(buf);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1059,19 +1077,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
-		struct object *o;
-		struct commit *commit;
-
-		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
-		if (!o)
-			die("%s - not something we can merge", argv[i]);
-		commit = lookup_commit(o->sha1);
-		commit->util = (void *)argv[i];
-		remotes = &commit_list_insert(commit, remotes)->next;
-
-		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
-		setenv(buf.buf, argv[i], 1);
-		strbuf_reset(&buf);
+		setup_merge_commit(&buf, &remotes, argv[i]);
 	}
 
 	if (!use_strategies) {
-- 
1.7.4
