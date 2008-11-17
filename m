From: crquan@gmail.com
Subject: [PATCH 2/2] git-remote: add verbose mode
Date: Mon, 17 Nov 2008 17:12:30 +0800
Message-ID: <1226913150-26088-2-git-send-email-crquan@gmail.com>
References: <1226913150-26088-1-git-send-email-crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 10:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L20Ap-0008St-Pa
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 10:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYKQJMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 04:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYKQJMA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 04:12:00 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:43244 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbYKQJL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 04:11:58 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1477357tic.23
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 01:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C+j/vNL4/uCEUVPzcXtbqYIx2R0IVF03hNl7clmxnFc=;
        b=BdrZ/3D1/alL/0dh9iiFCZ74YPCPcG6+ucBOI/flzrwnNnA2X2fmIKWtDNTZeNeD9w
         qygGlqZzM0606TrodMyeWRsugx38D7rgC7lG8etmq8J1BdNObZWWd00Q5aBJIbd5D0l1
         f1/VLN3pZoipeqS1jsdibXDdv8GUOfpzxjDwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aWl6SNRGtCFq8zYHhf5TZBHfX98TWII/HvGi7/2yfSEta9rJ+ACwRQJCXmFALoXoWM
         GxpF3UYfYfmsTqRdyvT4mmQYedJdFMQLxU2JoR6rwPQpPkotHDxEEYjncXoLGlsCiN8V
         leLLF2e8KMbzav5BHInjBZH5bFrtv8BTWt+EY=
Received: by 10.110.49.6 with SMTP id w6mr4889108tiw.9.1226913117952;
        Mon, 17 Nov 2008 01:11:57 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id y5sm158550tia.13.2008.11.17.01.11.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 01:11:56 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 17 Nov 2008 17:12:41 +0800
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1226913150-26088-1-git-send-email-crquan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101202>

From: Denis ChengRq <crquan@gmail.com>

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 builtin-remote.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d032f25..8a9f4b5 100644
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
 
@@ -40,10 +40,13 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
-static int fetch_remote(const char *name)
+static int fetch_remote(const char *name, const char *url)
 {
 	const char *argv[] = { "fetch", name, NULL };
-	printf("Updating %s\n", name);
+	if (verbose)
+		printf("Updating %s (%s)\n", name, url);
+	else
+		printf("Updating %s\n", name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
 		return error("Could not fetch %s", name);
 	return 0;
@@ -117,7 +120,7 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
-	if (fetch && fetch_remote(name))
+	if (fetch && fetch_remote(name, url))
 		return 1;
 
 	if (master) {
@@ -769,8 +772,12 @@ static int prune(int argc, const char **argv)
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
 
@@ -818,7 +825,7 @@ static int update(int argc, const char **argv)
 		result = for_each_remote(get_one_remote_for_update, &list);
 
 	for (i = 0; i < list.nr; i++)
-		result |= fetch_remote(list.items[i].string);
+		result |= fetch_remote(list.items[i].string, list.items[i].util);
 
 	/* all names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
-- 
1.6.0.2
