From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] parse-options: make OPT_NUMBER's argh explicit
Date: Wed,  3 Jun 2009 00:49:27 -0700
Message-ID: <1244015367-16998-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 09:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBlEB-0005Ji-9Z
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 09:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbZFCHtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 03:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbZFCHta
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 03:49:30 -0400
Received: from mail-px0-f182.google.com ([209.85.216.182]:39486 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZFCHta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 03:49:30 -0400
Received: by pxi12 with SMTP id 12so559776pxi.33
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=LfvGgT2ggVz89WP7X3vecHmQNZEXk7fLO7JEPXh6o3w=;
        b=JatsCv+BXZWrP0Jv0BzMwNP7fnAWoxht3NutBwppJLokwZG0bxWCXdnBHJcr+gAYiB
         THpWsGU+OybH66208P/sYsf/4ojPmpvawKQEyzyQTJwOJMPiJlJCBeQbwJKQUu2FTsmx
         I0Xz1dGi/E0VIIa222tORj8nKJm6+3LaTEGHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TnCEfpHZKVGrzhkMH+3Q6/Q/SDyDO83mk6ad8LsBiKgDabMdqth/ddgdCHwcs9lYJv
         yDyE9iGdmpSvSqOHd66Bv8IJdaizYSKeKP/sBycb6FNbw+eYbbNNhpAntV9yNhVlMFW+
         kBAIkDN7lhGepOaiiN40jvQIhnPqI3ZaVa0Ik=
Received: by 10.141.29.16 with SMTP id g16mr584753rvj.92.1244015371347;
        Wed, 03 Jun 2009 00:49:31 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id g31sm21969695rvb.43.2009.06.03.00.49.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 00:49:30 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 03 Jun 2009 00:49:27 -0700
X-Mailer: git-send-email 1.6.3.1.244.gf9275
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120591>

OPTION_NUMBER hard codes its argh member to be "n", but the decision is
hidden deep in usage_with_options_internal(). Make "n" the default argh
for the OPT_NUMBER macro while leaving it undecided for the OPTION_NUMBER
enum.

This make it less surprising to users that argh is "n" when using the
OPT_NUMBER macro.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-tag.c   |    4 ++--
 parse-options.c |   11 ++---------
 parse-options.h |    2 +-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index dc3db62..080e04a 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -376,8 +376,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
-		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
-				"print n lines of each tag message",
+		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
+				"print <n> lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
 		OPT_BOOLEAN('d', NULL, &delete, "delete tags"),
 		OPT_BOOLEAN('v', NULL, &verify, "verify tags"),
diff --git a/parse-options.c b/parse-options.c
index b85cab2..48ba62b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -503,19 +503,12 @@ int usage_with_options_internal(const char * const *usagestr,
 		switch (opts->type) {
 		case OPTION_ARGUMENT:
 			break;
-		case OPTION_INTEGER:
-			if (opts->flags & PARSE_OPT_OPTARG)
-				if (opts->long_name)
-					pos += fprintf(stderr, "[=<n>]");
-				else
-					pos += fprintf(stderr, "[<n>]");
-			else
-				pos += fprintf(stderr, " <n>");
-			break;
 		case OPTION_CALLBACK:
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
 			/* FALLTHROUGH */
+		case OPTION_INTEGER:
+			/* FALLTHROUGH */
 		case OPTION_FILENAME:
 			/* FALLTHROUGH */
 		case OPTION_STRING:
diff --git a/parse-options.h b/parse-options.h
index b374ade..b141ae6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -108,7 +108,7 @@ struct option {
 #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, (h) }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, (h), 0, NULL, (i) }
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, (h), 0, NULL, (p) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), NULL, (h) }
+#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
-- 
1.6.3.1.244.gf9275
