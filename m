From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 2/2] test-config: Add tests for the config_set API
Date: Sun, 06 Jul 2014 21:57:11 +0200
Message-ID: <vpqk37q2rc8.fsf@anie.imag.fr>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
	<1404631162-18556-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3sZF-0007QS-QP
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 21:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbaGFT50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 15:57:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44116 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbaGFT5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 15:57:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s66Jv8U9008005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jul 2014 21:57:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s66JvBtl021100;
	Sun, 6 Jul 2014 21:57:11 +0200
In-Reply-To: <1404631162-18556-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Sun, 6 Jul 2014 00:19:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Jul 2014 21:57:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s66Jv8U9008005
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405281433.32609@6Jw6bHySLuYbMjhUP5zkYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252942>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/test-config.c b/test-config.c
> new file mode 100644
> index 0000000..45ccd0a
> --- /dev/null
> +++ b/test-config.c
> @@ -0,0 +1,127 @@
> +#include "cache.h"
> +#include "hashmap.h"

Useless include, you're not using the hashmap directly.

> +int main(int argc, char **argv)
> +{
> +	int i, no_of_files;

Unused no_of_files.

With

CFLAGS += -Wdeclaration-after-statement -Wall -Werror

in config.mak, my git.git refuses to compile with your patch. You should
have similar options for hacking on git.git.

> +	if (argc == 3 && !strcmp(argv[1], "get_value")) {

You should do something like

if (argc < 2) {
	fprintf(stderr, "Please, provide a command name on the command-line\n");
	return 1;
}

before this. Otherwise, some argv[1] below are invalid on mis-use. No
need for thorough checks since it's just a test program, but better
avoid undefined behavior and segfaults anyway...

> +		if (!git_config_get_value(argv[2], &v)) {
> +			if (!v)
> +				printf("(NULL)\n");
> +			else
> +				printf("%s\n", v);
> +			return 0;
> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;

Avoid returning negative values from main. Your shell's $? won't see -1,
but most likely 255 or so, but I think it even depends on the OS.

You don't seem to use main's return for anything but error, so 0 =
everything OK; 1 = some error is the common convention.

> +		} else {
> +			printf("Value not found for \"%s\"\n", argv[2]);
> +			return -1;
> +		}
> +
> +	} else if (!strcmp(argv[1], "configset_get_value_multi")) {

Why a blank line before this "else if" and not before other "else if"s?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
