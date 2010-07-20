From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 1/2] Add -e/--exclude to git-clean.
Date: Tue, 20 Jul 2010 15:35:56 -0400
Message-ID: <8f454efeb3aa4acd0e0c420b197d0269dc53db34.1279654370.git.jaredhance@gmail.com>
References: <cover.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 21:36:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIbu-0005zK-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab0GTTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:36:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33283 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab0GTTgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:36:01 -0400
Received: by vws14 with SMTP id 14so652057vws.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=I7FGT8TLoS2vQ9fFbgoZKFcwpea/TlCoFM/IQ8Lz1fM=;
        b=l5atRIF0Mqn8JsEozAoLd4nGNdXvaCOJyae0E39AA2WEnTmo+GS9jpl9UzdMtDUdh1
         XcbEPW6eSvw9E16nGtSfl+AhC0CRB95MlkuJgKR5ckoaIJj9UOfQ5KQxbIKBvbkHYul7
         GlSW8n8kGDUYN+mwyw73S0TGIpSrRb2TDNlbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OXgYQzDqObrsYFF5QA+3Ic4MEPZ7r85RGZIigmYc+bYfbWv34kniJ8m9lNLZmMEpjZ
         H+IuJLru7VyuK14fuoT+ZjtCLJ98PC4Ti7j6Nsdpn/JaCdqNow+nM8EOL4Vv0VwRiAuf
         DMO0ulxxtEveK6kd3Ht/mdHS0Bcn0waONy3z8=
Received: by 10.220.122.71 with SMTP id k7mr3869025vcr.117.1279654559398;
        Tue, 20 Jul 2010 12:35:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id i40sm1734557vcr.32.2010.07.20.12.35.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:35:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1279654370.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151355>

With the -e/--exclude option for git-clean, a user can specify files
that they haven't yet told git about, but either need for a short amount
of time or plan to tell git about them later. This allows one to still
use git-clean while these files are around without losing data.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 Documentation/git-clean.txt |    8 +++++++-
 builtin/clean.c             |   17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a81cb6c..60e38e6 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -45,6 +45,12 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
+-e <pattern>::
+--exclude=<pattern>::
+	Specify special exceptions to not be cleaned.  Each <pattern> is
+	the same form as in $GIT_DIR/info/excludes and this option can be
+	given multiple times.
+
 -x::
 	Don't use the ignore rules.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
diff --git a/builtin/clean.c b/builtin/clean.c
index fac64e6..841ac26 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -10,12 +10,13 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "string-list.h"
 #include "quote.h"
 
 static int force = -1; /* unset */
 
 static const char *const builtin_clean_usage[] = {
-	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
 	NULL
 };
 
@@ -26,6 +27,13 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int exclude_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *exclude_list = (struct string_list *)opt->value;
+	string_list_append(exclude_list, arg);
+	return 0;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -36,6 +44,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
+	struct string_list exclude_list = { NULL, 0, 0, 0 };
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -44,6 +53,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
+		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
+		  "exclude <pattern>", PARSE_OPT_NONEG, exclude_cb },
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),
@@ -81,6 +92,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
+	for (i = 0; i < exclude_list.nr; i++)
+		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
+
 	pathspec = get_pathspec(prefix, argv);
 
 	fill_directory(&dir, pathspec);
@@ -167,5 +181,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	free(seen);
 
 	strbuf_release(&directory);
+	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
-- 
1.7.1.1
