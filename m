From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2] Add --exclude to git-clean.
Date: Mon, 19 Jul 2010 12:18:08 -0400
Message-ID: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279556172.git.jaredhance@gmail.com>
References: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279554580.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 18:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oat2r-000311-IW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936363Ab0GSQSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 12:18:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62512 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936338Ab0GSQSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 12:18:14 -0400
Received: by qyk35 with SMTP id 35so1794455qyk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qtpS1hZH64IP2PH6Uosm2cdYBrg58TyommMw+vizP+w=;
        b=aBgBLsEj3wSztJD5BzRbW/wtvPf6mutcKxE96akfTd8KspYEEaEGgiOFZUhTgMGXHf
         G3c63I0HJEGxlcGsSXUMoBsid1b2qPVZ/PxMqy7otYw7+ccyc8tlIAhlrHO/VwZgJJVK
         9tzk8ym0W7z+4Kdfe8ukEEw1lIVOkyAhM0/Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        b=s2R3dBxvYENxBhQUZe9B52YGaYGFM90fsfhkxVA2dqq4dbox+mqrgMQWtN+N8bazL+
         CKyuHMyo1aNioFhrE/SX7pKBeMXmoGLrp3XaBA3XHew8qJl5cymNbdztVpmNsL7afV/V
         CfuCdW+vMed2gwPbDLPZtJv8b/hqI7jvdlcPA=
Received: by 10.224.60.211 with SMTP id q19mr5027596qah.160.1279556292784;
        Mon, 19 Jul 2010 09:18:12 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id e32sm26145430qcg.22.2010.07.19.09.18.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 09:18:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279554580.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151255>

With the -e/--exclude option for git-clean, a user can specify files
that they haven't yet told git about, but either need for a short amount
of time or plan to tell git about them later. This allows one to still
use git-clean while these files are around without losing data.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 Documentation/git-clean.txt |    6 +++++-
 builtin/clean.c             |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a81cb6c..2bf9cf2 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-q] [-e] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -45,6 +45,10 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
+-e::
+--exclude::
+	Specify special exceptions to not be cleaned. Separate with colon.
+
 -x::
 	Don't use the ignore rules.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
diff --git a/builtin/clean.c b/builtin/clean.c
index fac64e6..aa3eed8 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,6 +13,7 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static char *excludes;
 
 static const char *const builtin_clean_usage[] = {
 	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
@@ -36,6 +37,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf excludes_buf = STRBUF_INIT;
+	struct strbuf **excludes_split;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -44,6 +47,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
+		OPT_STRING('e', "exclude", &excludes, "EXCLUDES", "specify files not to clean"),
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),
@@ -81,6 +85,17 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
+	if (excludes) {
+		strbuf_addstr(&excludes_buf, excludes);
+		excludes_split = strbuf_split(&excludes_buf, ':');
+		for (i = 0; excludes_split[i]; i++) {
+			if (excludes_split[i]->buf[excludes_split[i]->len - 1] == ':') {
+				strbuf_remove(excludes_split[i], excludes_split[i]->len - 1, 1);
+			}
+			add_exclude(excludes_split[i]->buf, "", 0, dir.exclude_list);
+		}
+	}
+
 	pathspec = get_pathspec(prefix, argv);
 
 	fill_directory(&dir, pathspec);
@@ -167,5 +182,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	free(seen);
 
 	strbuf_release(&directory);
+	if (excludes) {
+		strbuf_release(&excludes_buf);
+		for (i = 0; excludes_split[i]; i++) {
+			strbuf_release(excludes_split[i]);
+		}
+	}
 	return (errors != 0);
 }
-- 
1.7.1.1
