From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 15:48:31 +0200
Message-ID: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 15:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCrjX-0005Gz-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 15:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab3HWNs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 09:48:56 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:59705 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab3HWNsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 09:48:55 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so560980wes.38
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jEcxSOwT7XroPrFAzVCY2J8TPIrwCAhmy30Y1aU2rEE=;
        b=BKHXtTniRrjXw0ciUbF1d0pZxP3CNys+zYMHISCNwneg7CtCTAuVHQ9erlaIZEX9A8
         szBzXPtWqLF1Crzpax16J9N+RB/AlA5TkhXEnslBDITR0URn/q7o1ryU63pvil5LKN97
         1eSav2O/V+eo/IkmaRMa256BJobgPnFLS6NndrvnNZvDXAcPQS8lj3NZ1eJoAiRH8Rf8
         FILAiND39PN43mtBPuhIzWjU8rFe2YBCWsMHhlvzB1O60MCrc9wslCM/xri4wQo5pLTy
         RUCFoyFxap8O5mUX5SJgo63Kplv5ZAog6YkxRrIMHyvzPzxl8uVl+VUsjfBWVayUiIpc
         Cgqg==
X-Received: by 10.194.19.5 with SMTP id a5mr1362520wje.48.1377265733948;
        Fri, 23 Aug 2013 06:48:53 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id jc18sm4112914wic.5.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 06:48:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.1.g0d8beaa.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232809>

When committing for someone else, using the --author option, it can be
nice to use the mailmap file to find the correct name spelling and email
address.

Currently, you would have to find the correct mapping in mailmap file
first, and then use the full ident form when committing.

Let's allow git-commit to find if an entry exists in mailmap file for
that pattern, and use that instead.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hi,
I would use that feature at work where I happen to commit some work for
other colleagues, while we heavily rely on mailmap file to have decent indents.

On the other hand, I'm kind of embarrassed to add this new option to
git-commit.

 Documentation/git-commit.txt |  6 +++++-
 builtin/commit.c             | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..9e3fe04 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--use-mailmap] [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]

 DESCRIPTION
@@ -131,6 +131,10 @@ OPTIONS
 	commit by that author (i.e. rev-list --all -i --author=<author>);
 	the commit author is then copied from the first such commit found.

+--use-mailmap::
+	When used with `--author=<author>`, match the <author> pattern
+	against mapped name and email. See linkgit:git-shortlog[1].
+
 --date=<date>::
 	Override the author date used in the commit.

diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..fbd0664 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "notes-utils.h"
+#include "mailmap.h"

 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -87,6 +88,7 @@ static enum {
 } commit_style;

 static const char *logfile, *force_author;
+static int mailmap;
 static const char *template_file;
 /*
  * The _message variables are commit names from which to take
@@ -945,13 +947,24 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = buf.buf;
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
+	if (mailmap) {
+		revs.mailmap = xcalloc(1, sizeof(struct string_list));
+		read_mailmap(revs.mailmap, NULL);
+	}
 	prepare_revision_walk(&revs);
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
+		const char *format;
+
+		if (mailmap)
+			format = "%aN <%aE>";
+		else
+			format = "%an <%ae>";
+
 		ctx.date_mode = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
+		format_commit_message(commit, format, &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
 	}
 	die(_("No existing author found with '%s'"), name);
@@ -1428,6 +1441,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
 		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
+		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mailmap file when searching for author")),
 		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
--
1.8.4.rc4.1.g0d8beaa.dirty
