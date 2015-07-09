From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Thu, 09 Jul 2015 14:58:33 +0200
Message-ID: <vpq380x8p3a.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:58:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBPZ-0006Di-QF
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbbGIM6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:58:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37817 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbbGIM6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:58:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t69CwWAt028813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 14:58:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t69CwXDu017604;
	Thu, 9 Jul 2015 14:58:33 +0200
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 15:57:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Jul 2015 14:58:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t69CwWAt028813
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437051512.76745@temewZySYxSgEAUs/0UZ2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273748>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add support for %(refname:shortalign=X) where X is a number.
> This will print a shortened refname aligned to the left
> followed by spaces for a total length of X characters.
> If X is less than the shortened refname size, the entire
> shortened refname is printed.

Not really an issue, but you're wrapping your text at ~60 characters.
The common use is to wrap around 70 to 80. Using Emacs, auto-fill-mode
or M-q does this automatically. If you use another text editor, it can
probably do that for you too.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 19 ++++++++++++++++++-

I think this would deserve a test and documentation. Even though your
motivation is for an internal implementation, some users may want to use
the feature in 'git for-each-ref --format=...'.

>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index dd0709d..3098497 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -10,6 +10,7 @@
>  #include "quote.h"
>  #include "ref-filter.h"
>  #include "revision.h"
> +#include "utf8.h"
>  
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  
> @@ -695,7 +696,23 @@ static void populate_value(struct ref_array_item *ref)
>  			int num_ours, num_theirs;
>  
>  			formatp++;
> -			if (!strcmp(formatp, "short"))
> +			if (starts_with(formatp, "shortalign=")) {
> +				const char *valp, *short_refname = NULL;
> +				int val, len;
> +
> +				skip_prefix(formatp, "shortalign=", &valp);
> +				val = atoi(valp);

You're silently accepting %(refname:shortalign=foo) and
%(refname:shortalign=). I think it would be better to reject such cases
explicitly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
