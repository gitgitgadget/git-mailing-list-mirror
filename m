From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V2 1/3] strbuf: add tests
Date: Mon, 06 Jun 2016 18:11:55 +0200
Message-ID: <vpq7fe2guus.fsf@anie.imag.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-2-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:12:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9x8a-0002mL-AA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcFFQMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:12:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36808 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbcFFQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:12:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u56GBrKW008122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 18:11:53 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56GBtaX003400;
	Mon, 6 Jun 2016 18:11:55 +0200
In-Reply-To: <20160606151340.22424-2-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 6 Jun 2016 17:13:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 06 Jun 2016 18:11:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56GBrKW008122
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465834315.61839@orNmszuNgTJf4JXXjBLITQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296523>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> --- a/Makefile
> +++ b/Makefile
> @@ -613,6 +613,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
>  TEST_PROGRAMS_NEED_X += test-sha1
>  TEST_PROGRAMS_NEED_X += test-sha1-array
>  TEST_PROGRAMS_NEED_X += test-sigchain
> +TEST_PROGRAMS_NEED_X += test-strbuf
>  TEST_PROGRAMS_NEED_X += test-string-list
>  TEST_PROGRAMS_NEED_X += test-submodule-config
>  TEST_PROGRAMS_NEED_X += test-subprocess
> diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
> new file mode 100644
> index 0000000..271592e
> --- /dev/null
> +++ b/t/helper/test-strbuf.c
> @@ -0,0 +1,101 @@
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "parse-options.h"
> +#include "builtin.h"
> +
> +/*
> + * Check behavior on usual use cases
> + */
> +static int strbuf_check_behavior(struct strbuf *sb)
> +{
> +	char *str_test = xstrdup("test"), *res, *old_buf;
> +	size_t size, old_alloc;
> +
> +	strbuf_grow(sb, 1);
> +	old_alloc = sb->alloc;
> +	strbuf_grow(sb, sb->alloc - sb->len + 1000);
> +	if (old_alloc == sb->alloc)
> +		die("strbuf_grow does not realloc the buffer as expected");
> +	old_buf = sb->buf;
> +	res = strbuf_detach(sb, &size);
> +	if (res != old_buf)
> +		die("strbuf_detach does not return the expected buffer");
> +	free(res);
> +
> +	str_test = xstrdup("test");
> +	strbuf_attach(sb, str_test, strlen(str_test), strlen(str_test) + 1);
> +	res = strbuf_detach(sb, &size);
> +	if (size != strlen(str_test)) 
> +		die ("size is not as expected");

Space before '('. Also, it's nice for the guy debugging that to say
"incorrect size. Expected %d, got %d" or so.

> diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
> new file mode 100755
> index 0000000..6a579a3
> --- /dev/null
> +++ b/t/t0082-strbuf.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +test_description='Test the strbuf API.'

The '.' is usually omitted.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
