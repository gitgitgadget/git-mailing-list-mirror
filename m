From: crquan@gmail.com
Subject: [PATCH 2/3] git-remote: add verbose mode to git remote update
Date: Mon, 17 Nov 2008 19:15:50 +0800
Message-ID: <1226920551-28303-2-git-send-email-crquan@gmail.com>
References: <1226920551-28303-1-git-send-email-crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 12:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L226I-0001aE-Tt
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 12:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbYKQLPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 06:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYKQLPf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 06:15:35 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:39452 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbYKQLPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 06:15:34 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1511274tic.23
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j4tHRIA38CgBvLmauDioUlJtnhELqP/tnjGxmk3q01M=;
        b=pXdUzYeMPCXkLerZP+dFd1T5Or91Y/bGz/6L1o4A89ZwXtJYltifwzgt81q7VL3q4t
         ebPKS0UYArs9FRFC+axkAKAyUt/TNqaYP50UcJZH0X62GEzLAWTYMgGCsq0OylT7yZ6p
         AjVb9ssGs4pzxDsLbSvDv3y8vEuXoc0SrEafU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dun+4PfRxxifdkmjGTagSx7Lwk00D3rq+qQcw8wRfM/7W3Lmkj0JlPZz6NBnf2nwLZ
         9aeCdyGEHgvwdcDSeorbiX6v8N65DhwBgqOPR72epaWtXvN95qGPfsLq1Ddk+erUReRJ
         Pi6vJorFimMnIfynqWC6nLINfchCXX+V+zAMI=
Received: by 10.110.20.15 with SMTP id 15mr5038460tit.12.1226920533573;
        Mon, 17 Nov 2008 03:15:33 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id u12sm387218tia.3.2008.11.17.03.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 03:15:32 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 17 Nov 2008 19:16:17 +0800
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1226920551-28303-1-git-send-email-crquan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101221>

From: Cheng Renquan <crquan@gmail.com>

Pass the verbose mode parameter to the underlying fetch command.

  $ ./git remote -v update
  Updating origin
  From git://git.kernel.org/pub/scm/git/git
   = [up to date]      html       -> origin/html
   = [up to date]      maint      -> origin/maint
   = [up to date]      man        -> origin/man
   = [up to date]      master     -> origin/master
   = [up to date]      next       -> origin/next
   = [up to date]      pu         -> origin/pu
   = [up to date]      todo       -> origin/todo

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 builtin-remote.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d032f25..fff9920 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote rm <name>",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote update [group]",
+	"git remote update [-v | --verbose] [group]",
 	NULL
 };
 
@@ -40,9 +40,13 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
-static int fetch_remote(const char *name)
+static int fetch_remote(const char *name, const char *url)
 {
-	const char *argv[] = { "fetch", name, NULL };
+	const char *argv[] = { "fetch", name, NULL, NULL };
+	if (verbose) {
+		argv[1] = "-v";
+		argv[2] = name;
+	}
 	printf("Updating %s\n", name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
 		return error("Could not fetch %s", name);
@@ -117,7 +121,7 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
-	if (fetch && fetch_remote(name))
+	if (fetch && fetch_remote(name, url))
 		return 1;
 
 	if (master) {
@@ -769,8 +773,12 @@ static int prune(int argc, const char **argv)
 static int get_one_remote_for_update(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
+
 	if (!remote->skip_default_update)
-		string_list_append(xstrdup(remote->name), list);
+		string_list_append(remote->name, list)->util =
+			remote->url_nr > 0
+			? (void *)remote->url[remote->url_nr-1] : NULL;
+
 	return 0;
 }
 
@@ -818,7 +826,7 @@ static int update(int argc, const char **argv)
 		result = for_each_remote(get_one_remote_for_update, &list);
 
 	for (i = 0; i < list.nr; i++)
-		result |= fetch_remote(list.items[i].string);
+		result |= fetch_remote(list.items[i].string, list.items[i].util);
 
 	/* all names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
-- 
1.6.0.2
