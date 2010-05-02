From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v4 2/3] pretty: add infrastructure to allow format aliases
Date: Sun,  2 May 2010 12:00:43 +0100
Message-ID: <1272798044-10487-3-git-send-email-wmpalmer@gmail.com>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 13:01:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8WvF-0002Dl-T8
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab0EBLBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:01:11 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34160 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab0EBLBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:01:08 -0400
Received: by wwb34 with SMTP id 34so1083012wwb.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nLQjXL3LrCw9eDuZjE2qF5fOia/eGUY6FK638eGp3wE=;
        b=m6WF4PoTORmeEeuhefwdtiwykWgIMS+ECKV4kHZAKBrQM6jeeil+YQmoLIscO1PX6i
         Lu9SlUeJbcok+GfxmgAbbz4mTH5sCg8Yg4lwlN0JJVm2LGPF7RBI9rOze+V4zgzfztfE
         OX2zHsW1nIY70xkEJQ12pBC0kX3z4NYPuOMOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YnX3Q+LzhOrldM4B2i19P3aTqdjive4/2RE7+HPtLmBktEYutXEyA/F2jeHym/nBjf
         oVZwAXQouEZk7y2Qcon9dN4Z5mv/IIiHhADgj6AAvgUFt+xvTq1W6fHnq7OGgLpQftan
         scLxpiClRUP5JSTueINoPGF9oEaPiS54SYaAk=
Received: by 10.216.87.18 with SMTP id x18mr4194012wee.85.1272798066814;
        Sun, 02 May 2010 04:01:06 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id b2sm25456649wbb.14.2010.05.02.04.01.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 04:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146159>

here we modify the find_commit_format function to make it recursively
dereference aliases when they are specified. At this point, there are
no aliases specified and there is no way to specify an alias, but the
support is there for any which are added.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 pretty.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index ecac8f5..4029cc8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -15,6 +15,8 @@ static struct cmt_fmt_map {
 	const char *name;
 	enum cmit_fmt format;
 	int is_tformat;
+	int is_alias;
+	const char *user_format;
 } *commit_formats;
 static size_t commit_formats_len;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
@@ -46,14 +48,19 @@ static void setup_commit_formats(void)
 	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
 }
 
-static struct cmt_fmt_map *find_commit_format(const char *sought)
+static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
+							const char *original,
+							int num_redirections)
 {
 	struct cmt_fmt_map *found = NULL;
 	size_t found_match_len;
 	int i;
 
-	if (!commit_formats)
-		setup_commit_formats();
+	if (num_redirections >= commit_formats_len) {
+		die("invalid --pretty format: '%s' references an alias which "
+		    "points to itself", original);
+		return NULL;
+	}
 
 	for (i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
@@ -67,9 +74,24 @@ static struct cmt_fmt_map *find_commit_format(const char *sought)
 			found_match_len = match_len;
 		}
 	}
+
+	if (found && found->is_alias) {
+		found = find_commit_format_recursive(found->user_format,
+						     original,
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
+	return find_commit_format_recursive(sought, sought, 0);
+}
+
 void get_commit_format(const char *arg, struct rev_info *rev)
 {
 	struct cmt_fmt_map *commit_format;
-- 
1.7.1.rc1.13.gbb0a0a.dirty
