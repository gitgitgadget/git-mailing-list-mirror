From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Wed, 16 Apr 2014 13:58:58 -0700
Message-ID: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 22:59:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaWvI-0003Ru-Nt
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 22:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbaDPU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 16:59:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36220 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbaDPU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 16:59:06 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so11370087pad.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LUFkxNLTjQujHXd4S3ExkJSdkgK3JcSoIKdT5044Nug=;
        b=J6tOh/N/g2gGyN1y62RYVRqleC+IL5Kjcwo4f+44mqGDdnTvRWSbbgARWd3TlcFrt+
         R+zLjs3OZ+zmvS4OLD2PuGFLrmIeoBj9wTvTcI8G6WsPc6mChJRtuJdvH9SgjqAQUC45
         OnAlSG9c+MmFwzxHihWzoAIq5dQdZoTazQwxPqzHq3vTXHcDc5Nf1MjixeMpqY4PkCkC
         x/IRDzr3S0SZlWi0ckHU+elmkQZNNdyQw5fPugkehvgjMLZ1oiXz4ZrYamMyQQlnjTSa
         Ck664AyOwNsS/w17EgSt0Dr0hFw6IVj5XMfdi/ZLRUBNxsyEbMmaI7F4lI7vjwr4MSwZ
         k5Lg==
X-Received: by 10.66.146.105 with SMTP id tb9mr4617382pab.157.1397681945264;
        Wed, 16 Apr 2014 13:59:05 -0700 (PDT)
Received: from mcgrof@gmail.com (c-98-234-145-61.hsd1.ca.comcast.net. [98.234.145.61])
        by mx.google.com with ESMTPSA id pl10sm48937225pbb.56.2014.04.16.13.59.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 13:59:03 -0700 (PDT)
Received: by mcgrof@gmail.com (sSMTP sendmail emulation); Wed, 16 Apr 2014 13:59:00 -0700
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246381>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Upstream Linux kernel commit c5905afb was introduced on v3.4 but
git describe --contains yields v3.5 while if we use git to look
for the first parent with git describe --first-parent yields
v3.3. The reason for this seems to be that the merge commit that
introduced c5905afb was based on v3.3. At least for --contains
its unclear to me why we get v3.5, the result is not intuitive,
as for --first-parent the issue is that the first parent actually
*is* v3.3. The easiest way to address this it to rely on on the
git tag --contains implmenetation and add a modifier that specifies
you want the tag that first introduced the specified commit.

mcgrof@ergon ~/linux (git::master)$ git tag -i --contains c5905afb
v3.4

mcgrof@ergon ~/linux (git::master)$ git tag --introduced --contains c5905afb
v3.4

Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Andreas Schwab <schwab@suse.de>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 builtin/tag.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6c7c6bd..65a939b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -21,7 +21,7 @@
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] "
+	N_("git tag -l [-n[<num>]] [--contains <commit>] [ -i | --introduced --contains <commit> ] [--points-at <object>] "
 		"\n\t\t[<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
@@ -195,13 +195,18 @@ static int sort_by_version(const void *a_, const void *b_)
 }
 
 static int list_tags(const char **patterns, int lines,
-		     struct commit_list *with_commit, int sort)
+		     struct commit_list *with_commit, int sort,
+		     int introduced)
 {
 	struct tag_filter filter;
 
 	filter.patterns = patterns;
 	filter.lines = lines;
-	filter.sort = sort;
+	if (introduced) {
+		sort = VERCMP_SORT;
+		filter.sort = sort;
+	} else
+		filter.sort = sort;
 	filter.with_commit = with_commit;
 	memset(&filter.tags, 0, sizeof(filter.tags));
 	filter.tags.strdup_strings = 1;
@@ -216,8 +221,11 @@ static int list_tags(const char **patterns, int lines,
 			for (i = filter.tags.nr - 1; i >= 0; i--)
 				printf("%s\n", filter.tags.items[i].string);
 		else
-			for (i = 0; i < filter.tags.nr; i++)
+			for (i = 0; i < filter.tags.nr; i++) {
 				printf("%s\n", filter.tags.items[i].string);
+				if (introduced)
+					break;
+			}
 		string_list_clear(&filter.tags, 0);
 	}
 	return 0;
@@ -493,6 +501,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
 	int cmdmode = 0, sort = 0;
+	int introduced = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -511,6 +520,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			     N_("tag message"), parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
+		OPT_BOOL('i', "introduced", &introduced, N_("print the first tag that introduced the commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
@@ -576,7 +586,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		}
 		if (lines != -1 && sort)
 			die(_("--sort and -n are incompatible"));
-		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, sort);
+		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit,
+				sort, introduced);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
-- 
1.9.0
