From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Thu, 28 Oct 2010 20:45:40 -0500
Message-ID: <20101029014540.GB28984@burratino>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
 <1288303712-14662-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 03:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBe2T-0007x2-GZ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 03:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759289Ab0J2Bps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 21:45:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38967 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127Ab0J2Bpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 21:45:47 -0400
Received: by qwf7 with SMTP id 7so1798888qwf.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qT+ABQ1DVF46dDoMRWzBBgdncA4j0YmUaBWxP85MgW8=;
        b=UppFMSz6rqvhEa59LHYpYA03kxEdTaUEBy+XEJtaXYO2oThk0E6oPm956XYsrejDHG
         xZV9Y/dGE3B9gL/xLw6PHkW3MyHu0hfu3JHXLQSDH8+ddNaAoHRn9UJfP0s3cRYT22Wk
         73489uNGfUm+gmj9E8A4SbwUyLW/rPixJ9v9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=STG5aI4XMKoTKcqr6s2W/MeR2RbEdl+s7aNiVbGV0cekQ7X3QjCxdZLKu39ILaVnVd
         6loRR0/KMv6t0n6asqMP2PQbKyVwxYR5VErQN8hUNQ1QKktz/4iJD/eqqLjRF0UoNW71
         9EiLYRKbaHm+k1Bu+dCnOWWptdAW3m+t6k6C8=
Received: by 10.224.186.143 with SMTP id cs15mr1274298qab.259.1288316746637;
        Thu, 28 Oct 2010 18:45:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm1722214qco.6.2010.10.28.18.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 18:45:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288303712-14662-2-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160260>

Yann Dirson wrote:

> Possible optimisations to this code include:
> * avoid use of i_am_not_single by using a separate list

I think that would help code clarity, too. It is tempting to try to
split this patch into micropatches:

1. introduce DETECT_DIRECTORY_RENAMES flag and hidden UI for it.

2. if detecting bulk relocations, do not simplify input for
   diffcore by omitting unchanged files (just like when
   finding copies harder).

3. introduce "rename target candidate" flag in rename_dsts.
    - if detecting copies, all diff targets are potential rename
      targets

    - if detecting bulk relocations but not copies, all diff
      targets are rename_dsts, but only file creation diff
      targets are potential rename targets

    - if detecting neither bulk reloc nor copies, only file
      creation diff targets are rename_dsts (and all are
      potential rename targets).

   Alternatively, rename_dsts that are not potential rename targets
   could be put in a different list (which is simpler and probably
   faster, while using a little more memory).

4. honor rename_target_candidate flag (not needed if the
   non-candidates get their own list).

5. introduce a list of potential directory relocations and functions
   to manipulate it.

6. pass the (empty) list of relocated directories back to diffcore.

7. populate the list of directory relocation candidates.  If a file
   has been renamed to go from directory a/ to directory b/, we have a
   directory rename candidate.

8. disqualify directories with stragglers left behind.

9. disqualify directories for which the contents are not unanimous
   about where to go.

10. add documentation and stop hiding the UI.

Trivial comments on the patch:

[...]
> +++ b/diffcore-rename.c
> @@ -6,14 +6,34 @@
>  #include "diffcore.h"
>  #include "hash.h"
>  
> +#define DEBUG_BULKMOVE 0
> +
> +#if DEBUG_BULKMOVE
> +#define debug_bulkmove(args) __debug_bulkmove args
> +void __debug_bulkmove(const char *fmt, ...)
> +{
> +	va_list ap;
> +	va_start(ap, fmt);
> +	fprintf(stderr, "[DBG] ");
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +}
> +#else
> +#define debug_bulkmove(args) do { /*nothing */ } while (0)
> +#endif

Is the debugging output infrequent enough to just use a function
unconditionally?

[...]
> + * Supports in-place modification of src by passing dst == src.
> + */
> +static const char *copy_dirname(char *dst, const char *src)
[...]
> +	end = mempcpy(dst, src, slash - src + 1);

I suppose this should read:

	if (dst != src)
		memcpy(dst, src, slash - src + 1);
	dst[slash - src + 1] = '\0';
	return dst;

[...]
> +static int discard_if_outside(struct diff_bulk_rename *candidate,
> +			 struct diff_bulk_rename *seen) {

Style: '{' for functions goes in column 0.

> +	if (!prefixcmp(candidate->two->path, seen->two->path)) {
> +		debug_bulkmove((" 'dstpair' conforts 'seen'\n"));
> +		return 0;
> +	} else {

Can get some depth reduction by dropping the else here (since in
the trivial case we have already returned).

> +static void diffcore_bulk_moves(void)
> +{
> +	int i;
> +	for (i = 0; i < rename_dst_nr; i++)
> +		check_one_bulk_move(rename_dst[i].pair);
> +}

Yay. :)
