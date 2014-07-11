From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 2/2] test-config: add tests for the config_set API
Date: Fri, 11 Jul 2014 16:24:40 +0200
Message-ID: <vpqwqbk0y8n.fsf@anie.imag.fr>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5blF-00039W-C2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 16:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbaGKOZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 10:25:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34676 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857AbaGKOZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 10:25:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEOdpE018697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2014 16:24:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEOfWZ024164;
	Fri, 11 Jul 2014 16:24:41 +0200
In-Reply-To: <1405049655-4265-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 10 Jul 2014 20:34:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Jul 2014 16:24:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6BEOdpE018697
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405693482.56532@y9PdlYYVV8haniuxT0m2yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253278>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/test-config.c b/test-config.c
> new file mode 100644
> index 0000000..dc313c2
> --- /dev/null
> +++ b/test-config.c

> +int main(int argc, char **argv)
> +{
> +	int i, val;
> +	const char *v;
> +	const struct string_list *strptr;
> +	struct config_set cs;
> +	git_configset_init(&cs);

The configset is initialized, but never cleared.

As a result, valgrind --leak-check=full complains with "definitely lost"
items.

I think it would make sense to apply something like this to get a
valgrind-clean test-config.c (I checked, it now passes without
warnings):

diff --git a/test-config.c b/test-config.c
index dc313c2..07b61ef 100644
--- a/test-config.c
+++ b/test-config.c
@@ -41,17 +41,17 @@ int main(int argc, char **argv)
 
 	if (argc < 2) {
 		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		return 1;
+		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			return 0;
+			goto exit0;

[...]
 
 	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
+	goto exit1;
+
+exit0:
+	git_configset_clear(&cs);
+	return 0;
+
+exit1:
+	git_configset_clear(&cs);
 	return 1;
+
+exit2:
+	git_configset_clear(&cs);
+	return 2;
 }

I'll resend as a proper "git am"-able patch right after.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
