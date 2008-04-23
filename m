From: Adam Roben <aroben@apple.com>
Subject: [PATCH 03/11] git-cat-file: Make option parsing a little more flexible
Date: Wed, 23 Apr 2008 15:17:45 -0400
Message-ID: <1208978273-98146-4-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokV0-00058u-GB
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbYDWTSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbYDWTSE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:04 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:50296 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYDWTR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:17:59 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 3F1B02A6A256;
	Wed, 23 Apr 2008 12:17:59 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 261372807F;
	Wed, 23 Apr 2008 12:17:59 -0700 (PDT)
X-AuditID: 1180711d-a9b93bb000000ed7-28-480f8b66cf3a
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 581E828099;
	Wed, 23 Apr 2008 12:17:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-3-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80246>

This will make it easier to add newer options later.

Signed-off-by: Adam Roben <aroben@apple.com>
---
Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> > index 34a63d1..3a0be4a 100644
> > --- a/builtin-cat-file.c
> > +++ b/builtin-cat-file.c
> > @@ -143,23 +143,41 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> >     return 0;
> >  }
> >  
> > +static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
> > +
> >  int cmd_cat_file(int argc, const char **argv, const char *prefix)
> >  {
> > -   int opt;
> > -   const char *exp_type, *obj_name;
> > +   int i, opt = 0;
> > +   const char *exp_type = 0, *obj_name = 0;
> 
> NULL pointer constants in git sources are spelled "NULL", not
> "0".

Fixed.

 builtin-cat-file.c |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 34a63d1..a76bb16 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -143,23 +143,41 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
+static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
+
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int opt;
-	const char *exp_type, *obj_name;
+	int i, opt = 0;
+	const char *exp_type = NULL, *obj_name = NULL;
 
 	git_config(git_default_config);
-	if (argc != 3)
-		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	exp_type = argv[1];
-	obj_name = argv[2];
-
-	opt = 0;
-	if ( exp_type[0] == '-' ) {
-		opt = exp_type[1];
-		if ( !opt || exp_type[2] )
-			opt = -1; /* Not a single character option */
+
+	for (i = 1; i < argc; ++i) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "-t") || !strcmp(arg, "-s") || !strcmp(arg, "-e") || !strcmp(arg, "-p")) {
+			exp_type = arg;
+			opt = exp_type[1];
+			continue;
+		}
+
+		if (arg[0] == '-')
+			usage(cat_file_usage);
+
+		if (!exp_type) {
+			exp_type = arg;
+			continue;
+		}
+
+		if (obj_name)
+			usage(cat_file_usage);
+
+		obj_name = arg;
+		break;
 	}
 
+	if (!exp_type || !obj_name)
+		usage(cat_file_usage);
+
 	return cat_one_file(opt, exp_type, obj_name);
 }
-- 
1.5.5.1.152.g9aeb7
