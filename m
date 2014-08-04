From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 08/11] pager.c: replace `git_config()` with `git_config_get_value()`
Date: Mon, 04 Aug 2014 22:36:37 +0200
Message-ID: <vpqsilc9elm.fsf@anie.imag.fr>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-9-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOzx-0004pu-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaHDUgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:36:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36872 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaHDUgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:36:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s74KaarJ010465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 22:36:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74Kabvs006176;
	Mon, 4 Aug 2014 22:36:38 +0200
In-Reply-To: <1407177229-30081-9-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 4 Aug 2014 11:33:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Aug 2014 22:36:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74KaarJ010465
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407789399.43173@VTCrxLrXBGqpknLRUtkKNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254778>

Tanay Abhra <tanayabh@gmail.com> writes:

> Use `git_config_get_value()` instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  pager.c | 40 +++++++++++++---------------------------

I find the patch more readable with --histogram, cut-and-pasted below in
case other reviewers find it better too.

diff --git a/pager.c b/pager.c
index 8b5cbc5..b7eb7e7 100644
--- a/pager.c
+++ b/pager.c
@@ -6,12 +6,6 @@
 #define DEFAULT_PAGER "less"
 #endif
 
-struct pager_config {
-	const char *cmd;
-	int want;
-	char *value;
-};
-
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -155,30 +149,22 @@ int decimal_width(int number)
 	return width;
 }
 
-static int pager_command_config(const char *var, const char *value, void *data)
-{
-	struct pager_config *c = data;
-	if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
-		int b = git_config_maybe_bool(var, value);
-		if (b >= 0)
-			c->want = b;
-		else {
-			c->want = 1;
-			c->value = xstrdup(value);
-		}
-	}
-	return 0;
-}
-
 /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
 int check_pager_config(const char *cmd)
 {
-	struct pager_config c;
-	c.cmd = cmd;
-	c.want = -1;
-	c.value = NULL;
-	git_config(pager_command_config, &c);
-	if (c.value)
-		pager_program = c.value;
-	return c.want;
+	int want = -1;
+	struct strbuf key = STRBUF_INIT;
+	const char *value = NULL;
+	strbuf_addf(&key, "pager.%s", cmd);
+	if (!git_config_get_value(key.buf, &value)) {
+		int b = git_config_maybe_bool(key.buf, value);
+		if (b >= 0)
+			want = b;
+		else {
+			want = 1;
+			pager_program = xstrdup(value);
+		}
+	}
+	strbuf_release(&key);
+	return want;
 }


I first wondered why you were not using git_config_get_maybe_bool(), but
you want to interpret non-boolean values as command-names, so you do
need this two-steps get_value -> maybe_bool.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
