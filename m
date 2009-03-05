From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Thu, 05 Mar 2009 10:55:07 -0800
Message-ID: <7v4oy7241g.fsf@gitster.siamese.dyndns.org>
References: <cover.1236187259.git.barvik@broadpark.no>
 <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
 <49AF9745.8050207@viscovery.net> <49AFBDAD.5040501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 19:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfIkQ-0001lP-9e
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 19:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbZCESzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZCESzS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 13:55:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbZCESzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 13:55:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01E139FCCA;
	Thu,  5 Mar 2009 13:55:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 84E549FCC9; Thu,
  5 Mar 2009 13:55:09 -0500 (EST)
In-Reply-To: <49AFBDAD.5040501@viscovery.net> (Johannes Sixt's message of
 "Thu, 05 Mar 2009 12:55:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29095CEE-09B7-11DE-A39A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112326>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Yes, it breaks. You can test this on Linux by commenting out these two
> lines in git-compat-util.h:
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index dcf4127..ab4b615 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -44,8 +44,8 @@
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
>  #define _ALL_SOURCE 1
> -#define _GNU_SOURCE 1
> -#define _BSD_SOURCE 1
> +/*#define _GNU_SOURCE 1*/
> +/*#define _BSD_SOURCE 1*/
>
>  #include <unistd.h>
>  #include <stdio.h>
>
> The result even passes the test suite (as long as I don't merge
> kb/checkout-optim, of course).

Isn't it better to separate "do we want to use that information if we can
nanosecocond timestamps" and "is the API available for reading nanosecond
timestamps" into separete switches, like this partial patch on top of the
patch we are discussing, then?  It is partial because it shows the way to
convert only one call site as an example and of course you need to update
the Makefile and autoconf.

diff --git a/git-compat-util.h b/git-compat-util.h
index 079cbe9..910aa03 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -384,4 +384,12 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 # define FORCE_DIR_SET_GID 0
 #endif
 
+#ifdef HAS_NSEC
+#define ST_CTIME_NSEC(st) ((unsigned ing)((st).st_ctim.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned ing)((st).st_mtim.tv_nsec))
+#else
+#define ST_CTIME_NSEC(st) 0
+#define ST_MTIME_NSEC(st) 0
+#endif
+
 #endif
diff --git a/read-cache.c b/read-cache.c
index 91f1d03..bb5cb2b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -69,13 +69,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-#ifdef USE_NSEC
-	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
-	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
-#else
-	ce->ce_ctime.nsec = 0;
-	ce->ce_mtime.nsec = 0;
-#endif
+	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
+	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
