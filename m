From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 4/5] pretty: add infrastructure to allow format aliases
Date: Fri, 30 Apr 2010 20:35:27 +0100
Message-ID: <1272656128-2002-5-git-send-email-wmpalmer@gmail.com>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2v-0008Of-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934312Ab0D3Tgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:36:31 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64000 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933177Ab0D3Tfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:35:43 -0400
Received: by mail-ww0-f46.google.com with SMTP id 34so446899wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y6JCGC0gBYKWkEDz5kNyDA++4o0ezRAwz324qNaaujo=;
        b=fKYF/K6c9x8p5rnHFIioCwXf8FsgP6uTiT3xO4FlIYBnU/Tw64tCtYMC9AkcviHQOe
         AJFR+YnmOJcuCjvshOkG2zpwlNV8+o+V/8D4OWmJtG9dAGr5izEAazBSFp/kckggqt6C
         hJKpkQi1Y5vLA4zQFGcZgKmisTKFq8jMGET9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rB3IL224vNYNfbymK4VGwC4blYi0f0oYgNHXX33pME04WwjpZxxbAFgOuM9NDvfW5m
         tKgCN/kQm1NoQShhLutdRKUrVOtDg4uCmB4G57BkqIyZ1R6OG/mIUhyepOWbBqZdJU72
         aXV4Hv9u8NjwUHgT4jft/Xsh87nQzLwOaZRqo=
Received: by 10.216.90.202 with SMTP id e52mr2960372wef.150.1272656142154;
        Fri, 30 Apr 2010 12:35:42 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146055>

here we modify the find_commit_format function to make it recursively
dereference aliases when they are specified. At this point, there are
no aliases specified and there is no way to specify an alias, but the
support is there for any which are added.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 pretty.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 55d5721..3d1c4a9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -15,6 +15,8 @@ static struct cmt_fmt_map {
 	const char *name;
 	enum cmit_fmt format;
 	int is_tformat;
+	int is_alias;
+	const char *user_format;
 } *commit_formats = NULL;
 static size_t commit_formats_len = 0;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
@@ -46,14 +48,15 @@ static void setup_commit_formats(void)
 	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
 }
 
-static struct cmt_fmt_map *find_commit_format(const char *sought)
+static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
+							int num_redirections)
 {
 	struct cmt_fmt_map *found = NULL;
 	size_t found_match_len;
 	int i;
 
-	if (!commit_formats)
-		setup_commit_formats();
+	if (num_redirections >= commit_formats_len)
+		return NULL;
 
 	for (i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
@@ -67,9 +70,23 @@ static struct cmt_fmt_map *find_commit_format(const char *sought)
 			found_match_len = match_len;
 		}
 	}
+
+	if (found && found->is_alias) {
+		found = find_commit_format_recursive(found->user_format,
+						     num_redirections+1);
+	}
+
 	return found;
 }
 
+static struct cmt_fmt_map *find_commit_format(const char *sought)
+{
+	if (!commit_formats)
+		setup_commit_formats();
+
+	return find_commit_format_recursive(sought, 0);
+}
+
 void get_commit_format(const char *arg, struct rev_info *rev)
 {
 	struct cmt_fmt_map *commit_format;
-- 
1.7.1.rc1.13.gbb0a0a.dirty
