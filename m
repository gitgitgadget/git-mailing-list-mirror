From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Create USE_ST_TIMESPEC and turn it on for Darwin
Date: Sun, 08 Mar 2009 13:51:33 -0700
Message-ID: <7vhc23kaay.fsf@gitster.siamese.dyndns.org>
References: <1236542668-83333-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPzk-00030M-Ve
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZCHUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 16:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbZCHUvl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:51:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbZCHUvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 16:51:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F44B4B3E;
	Sun,  8 Mar 2009 16:51:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9A0A4B3C; Sun, 
 8 Mar 2009 16:51:34 -0400 (EDT)
In-Reply-To: <1236542668-83333-1-git-send-email-benji@silverinsanity.com>
 (Brian Gernhardt's message of "Sun, 8 Mar 2009 16:04:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EABE7492-0C22-11DE-BED8-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112641>

Brian Gernhardt <benji@silverinsanity.com> writes:

> This also turns it on by default for OS X (Darwin) machines.  Likely
> this is a sane default for other BSD kernels as well, but I don't have
> any to test that assumption on.

Yeah, that was my initial reaction.  Any BSDers?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 83d8389..1906253 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -393,8 +393,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #define ST_CTIME_NSEC(st) 0
>  #define ST_MTIME_NSEC(st) 0
>  #else
> +#ifdef USE_ST_TIMESPEC
> +#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
> +#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
> +#else
>  #define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
>  #define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
>  #endif
> +#endif

Thanks.

I think this patch moves things in the right direction, but there are
other uses of "st_[cm]tim.tv_nsec" that do not use the ST_[CM]TIME_NSEC
macro.

$ git grep -n -e 'st_[cm]tim\.' --cached -- '*.[ch]'
builtin-fetch-pack.c:810:				|| st.st_mtim.tv_nsec != mtime.nsec
git-compat-util.h:396:#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
git-compat-util.h:397:#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
read-cache.c:207:	if (ce->ce_mtime.nsec != (unsigned int)st->st_mtim.tv_nsec)
read-cache.c:209:	if (trust_ctime && ce->ce_ctime.nsec != (unsigned int)st->st_ctim.tv_nsec)

Probably we should apply the following patch as a fix, and then apply your
enhancement to support st_[cm]timespec systems?

 builtin-fetch-pack.c |    2 +-
 read-cache.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 59b0b0a..1d7e023 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -807,7 +807,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 				die("shallow file was removed during fetch");
 		} else if (st.st_mtime != mtime.sec
 #ifdef USE_NSEC
-				|| st.st_mtim.tv_nsec != mtime.nsec
+				|| ST_CTIME_NSEC(st) != mtime.nsec
 #endif
 			  )
 			die("shallow file was changed during fetch");
diff --git a/read-cache.c b/read-cache.c
index b819abb..7f74c8d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -204,9 +204,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != (unsigned int)st->st_mtim.tv_nsec)
+	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != (unsigned int)st->st_ctim.tv_nsec)
+	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
 
