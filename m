From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/5] Teach 'git config' to rewrite URLs according to current
 url.*.insteadOf rules
Date: Mon, 04 Aug 2008 01:01:01 +0200
Message-ID: <200808040101.01082.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 01:03:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmbp-0001NE-3Q
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbYHCXCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758307AbYHCXCY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:02:24 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45289 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758236AbYHCXCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:02:23 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100L35RZYVR00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100HTTRXTZ340@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:01:05 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CB3RXTUR4N@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:01:05 +0200 (CEST)
In-reply-to: <200808040057.00221.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91287>

This patch adds the --rewrite-url option to 'git config'. The option takes
exactly one argument; a URL that is to be rewritten according to the longest
matching url.*.insteadOf rule in the current config. The resulting URL is
printed on stdout, and 0 is returned.

The rationale for this patch is to enable access to Git's URL rewriting
functionality from shell scripts.

The URL rewriting functionality is implemented by piggybacking on the
existing URL rewriting code in remote.c.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-config.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 91fdc49..977e6cb 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -1,9 +1,10 @@
 #include "builtin.h"
 #include "cache.h"
 #include "color.h"
+#include "remote.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] 
[--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color 
var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] 
[--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color 
var [default] | --get-colorbool name [stdout-is-tty] | --rewrite-url url";
 
 static char *key;
 static regex_t *key_regexp;
@@ -281,6 +282,24 @@ static int get_colorbool(int argc, const char **argv)
 	}
 }
 
+static int rewrite_url(int argc, const char **argv)
+{
+	/*
+	 * git config --rewrite_url <url>
+	 *
+	 * returns <url> after rewriting it according to url.*.insteadOf rules.
+	 */
+
+	if (argc > 1)
+		usage(git_config_set_usage);
+
+	struct remote *remote = remote_get(argv[0]);
+	if (remote->url_nr != 1)
+		die("Expected exactly one URL from remote_get()!");
+	printf("%s\n", remote->url[0]);
+	return 0;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
@@ -362,6 +381,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--rewrite-url")) {
+			return rewrite_url(argc-2, argv+2);
 		} else
 			break;
 		argc--;
-- 
1.6.0.rc1.34.g0fe8c
