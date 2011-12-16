From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 2/3] grep: enable threading with -p and -W using lazy
 attribute lookup
Date: Fri, 16 Dec 2011 09:22:07 +0100
Message-ID: <4EEAFFAF.8030003@viscovery.net>
References: <cover.1323723759.git.trast@student.ethz.ch> <138b930c0c96029f2fb9a816e73e70a4d5bce1de.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 16 09:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbT3b-0000gt-Jv
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 09:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266Ab1LPIWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 03:22:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10453 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751215Ab1LPIWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 03:22:14 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RbT3Q-0001KI-9j; Fri, 16 Dec 2011 09:22:08 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E62371660F;
	Fri, 16 Dec 2011 09:22:07 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <138b930c0c96029f2fb9a816e73e70a4d5bce1de.1323723759.git.trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187266>

Am 12/12/2011 22:16, schrieb Thomas Rast:
> diff --git a/grep.h b/grep.h
> index a652800..15d227c 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -115,6 +115,7 @@ struct grep_opt {
>  	int show_hunk_mark;
>  	int file_break;
>  	int heading;
> +	int use_threads;
>  	void *priv;
>  
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
> @@ -131,4 +132,10 @@ struct grep_opt {
>  extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
>  extern int grep_threads_ok(const struct grep_opt *opt);
>  
> +#ifndef NO_PTHREADS
> +/* Mutex used around access to the attributes machinery if
> + * opt->use_threads.  Must be initialized/destroyed by callers! */
> +extern pthread_mutex_t grep_attr_mutex;
> +#endif
> +
>  #endif

This is the first time we use pthread_mutex_t in a header file. We need at
least the following squashed in. An alternative would be to include
"thread-utils.h", but thread-utils is really more about implementation
helpers functions, not about types, and therefore does not look right to
be #included in a header.

---
 grep.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/grep.h b/grep.h
index 15d227c..754b270 100644
--- a/grep.h
+++ b/grep.h
@@ -133,6 +133,7 @@ extern struct grep_opt *grep_opt_dup(const struct
grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);

 #ifndef NO_PTHREADS
+#include <pthread.h>
 /* Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers! */
 extern pthread_mutex_t grep_attr_mutex;
-- 
1.7.8.1436.gb3021
