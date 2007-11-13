From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: Fix error message if clean.requireForce is not set.
Date: Mon, 12 Nov 2007 21:11:37 -0800
Message-ID: <7v8x52zq46.fsf@gitster.siamese.dyndns.org>
References: <47380E77.9040205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iro47-0005Yh-Md
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 06:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbXKMFLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 00:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbXKMFLo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 00:11:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47220 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbXKMFLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 00:11:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 890902F2;
	Tue, 13 Nov 2007 00:12:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EF40292237;
	Tue, 13 Nov 2007 00:12:00 -0500 (EST)
In-Reply-To: <47380E77.9040205@viscovery.net> (Johannes Sixt's message of
	"Mon, 12 Nov 2007 09:27:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64754>

Johannes Sixt <j.sixt@viscovery.net> writes:

> It was distracting to see this error message:
>
>     clean.requireForce set and -n or -f not given; refusing to clean
>
> even though clean.requireForce was not set at all. This patch distinguishes
> the cases and gives a different message depending on whether the
> configuration variable is not set or set to true.

And this will be the counterpart for 'pu'...

---

 builtin-clean.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 55658e7..01fb887 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -11,7 +11,7 @@
 #include "dir.h"
 #include "parse-options.h"
 
-static int force;
+static int force = -1; /* unset */
 
 static const char *const builtin_clean_usage[] = {
 	"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
@@ -29,7 +29,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int j;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, baselen = 0;
+	int ignored_only = 0, baselen = 0, config_set = 0;
 	struct strbuf directory;
 	struct dir_struct dir;
 	const char *path, *base;
@@ -49,6 +49,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	git_config(git_clean_config);
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
+	if (force < 0)
+		force = 0;
+	else
+		config_set = 1;
+
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only) {
 		dir.show_ignored =1;
@@ -59,7 +64,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		die("-x and -X cannot be used together");
 
 	if (!show_only && !force)
-		die("clean.requireForce set and -n or -f not given; refusing to clean");
+		die("clean.requireForce%s set and -n or -f not given; "
+		    "refusing to clean", config_set ? "" : " not");
 
 	dir.show_other_directories = 1;
 
