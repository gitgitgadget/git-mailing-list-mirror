From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support
 symbolic links.
Date: Fri, 2 Mar 2007 22:35:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022219360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703022211.30322.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Mar 02 22:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNFPG-0005oc-9g
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 22:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbXCBVfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbXCBVfG
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 16:35:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:38645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030179AbXCBVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 16:35:04 -0500
Received: (qmail invoked by alias); 02 Mar 2007 21:35:03 -0000
X-Provags-ID: V01U2FsdGVkX19mxs0eUiNm3kLeIaq5GmZ64H5xathFFLhnbDLfHh
	cpQ1areyTWUr1o
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703022211.30322.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41249>

Hi,

BTW since git.git's RelNotes is a symlink this patch is needed for MinGW. 
I tried to commit something yesterday, and had to use cygwin to do it, 
since MinGW Git always complained about "invalid tree d5e055...". For 
those who don't know: try "git show d5e055" in your Git repository.

On Fri, 2 Mar 2007, Johannes Sixt wrote:

> diff --git a/cache.h b/cache.h
> index 04f8e63..6f932fe 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -108,7 +108,10 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>  }
>  static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
>  {
> -	extern int trust_executable_bit;
> +	extern int trust_executable_bit, has_symlinks;

Would it not be better to move the global variables before this function?
I.e. these:

> @@ -202,6 +205,7 @@ extern int delete_ref(const char *, unsigned char *sha1);
>  /* Environment bits from configuration mechanism */
>  extern int use_legacy_headers;
>  extern int trust_executable_bit;
> +extern int has_symlinks;
>  extern int assume_unchanged;
>  extern int prefer_symlink_refs;
>  extern int log_all_ref_updates;
>
> [...]
>
> diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
> new file mode 100644
> index 0000000..969ef89
> --- /dev/null
> +++ b/t/t2102-update-index-symlinks.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Johannes Sixt
> +#
> +
> +test_description='git-update-index on filesystem w/o symlinks test.
> +
> +This tests that git-update-index keeps the symbolic link property
> +even if a plain file is in the working tree if core.symlinks is false.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success \
> +'preparation' '
> +git-config core.symlinks false &&
> +l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
> +echo "120000 $l	symlink" | git-update-index --index-info'
> +
> +test_expect_success \
> +'modify the symbolic link' '
> +echo -n new-file > symlink &&
> +git-update-index symlink'
> +
> +test_expect_success \
> +'the index entry must still be a symbolic link' '
> +case "`git-ls-files --stage --cached symlink`" in
> +120000" "*symlink) echo ok;;
> +*) echo fail; git-ls-files --stage --cached symlink; (exit 1);;
> +esac'

Please test also what happens if you replace a supposed symlink with a 
directory and vice versa.

Ciao,
Dscho
