From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] rerere: migrate to parse-options API
Date: Tue, 3 Aug 2010 22:22:16 -0500
Message-ID: <20100804032216.GE19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUZz-0000Nt-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508Ab0HDDXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:23:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59367 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab0HDDXg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:23:36 -0400
Received: by gwb20 with SMTP id 20so1811579gwb.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dFutsDW5aRPEPzaXsqr/ekP7K1dAPwnULzcm/bY0ZC8=;
        b=O4YTTffijc+ZTYXND//JLMLwIHq2wMCyLM0V8ngbwxm2mtNP9Xl8VuPWBoou8V4LYc
         OLzHpyjBj3TmxaGZubV4heSkTPy+mwuWfQtEjPK1CdcbuYb6k9Lln0mWVKEIinAc1Z18
         nRqFJDCXGmZm1AgOO1RWGBi5FJO4SVDo0nbmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EHa9vd4PIL8IcdTtvW4W4vejdKUMo/LS/1rP/lW66tK/xVlh1zNAEcpoY3SSUV525z
         dbN9EU7KeigOA9KUbrfmUnrNhpAFHIIEkAFhiDICucU/cPWs6GAZtpK1J9EpNbkEsCNE
         EAjjvi1u0HU+1QE9MvdJ3hH6S4fC7vtu7GY3U=
Received: by 10.100.244.1 with SMTP id r1mr5802732anh.96.1280892214399;
        Tue, 03 Aug 2010 20:23:34 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id x33sm12461961ana.13.2010.08.03.20.23.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:23:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152559>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/rerere.c |   52 ++++++++++++++++++++++++++++------------------------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..295fe75 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,13 +1,16 @@
 #include "builtin.h"
 #include "cache.h"
 #include "dir.h"
+#include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
-static const char git_rerere_usage[] =
-"git rerere [clear | status | diff | gc]";
+static const char * const rerere_usage[] = {
+	"git rerere [clear | status | diff | gc]",
+	NULL,
+};
 
 /* these values are days */
 static int cutoff_noresolve = 15;
@@ -103,25 +106,26 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
-	int i, fd, flags = 0;
-
-	if (2 < argc) {
-		if (!strcmp(argv[1], "-h"))
-			usage(git_rerere_usage);
-		if (!strcmp(argv[1], "--rerere-autoupdate"))
-			flags = RERERE_AUTOUPDATE;
-		else if (!strcmp(argv[1], "--no-rerere-autoupdate"))
-			flags = RERERE_NOAUTOUPDATE;
-		if (flags) {
-			argc--;
-			argv++;
-		}
-	}
-	if (argc < 2)
+	int i, fd, autoupdate = -1, flags = 0;
+
+	struct option options[] = {
+		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
+			"register clean resolutions in index", 1),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+
+	if (autoupdate == 1)
+		flags = RERERE_AUTOUPDATE;
+	if (autoupdate == 0)
+		flags = RERERE_NOAUTOUPDATE;
+
+	if (argc < 1)
 		return rerere(flags);
 
-	if (!strcmp(argv[1], "forget")) {
-		const char **pathspec = get_pathspec(prefix, argv + 2);
+	if (!strcmp(argv[0], "forget")) {
+		const char **pathspec = get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
 
@@ -129,26 +133,26 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (fd < 0)
 		return 0;
 
-	if (!strcmp(argv[1], "clear")) {
+	if (!strcmp(argv[0], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *name = (const char *)merge_rr.items[i].util;
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
 		unlink_or_warn(git_path("rr-cache/MERGE_RR"));
-	} else if (!strcmp(argv[1], "gc"))
+	} else if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
-	else if (!strcmp(argv[1], "status"))
+	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
-	else if (!strcmp(argv[1], "diff"))
+	else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
-		usage(git_rerere_usage);
+		usage_with_options(rerere_usage, options);
 
 	string_list_clear(&merge_rr, 1);
 	return 0;
-- 
1.7.2.1.544.ga752d.dirty
