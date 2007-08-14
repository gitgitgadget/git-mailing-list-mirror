From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH v4] git-apply: apply submodule changes
Date: Tue, 14 Aug 2007 10:39:40 +0200
Message-ID: <20070814083940.GN999MdfPADPa@greensroom.kotnet.org>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
 <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
 <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
 <20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
 <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net> <20070813093740.GA4684@liacs.nl>
 <20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
 <7vmywvfag3.fsf@assigned-by-dhcp.cox.net>
 <7vd4xqeilh.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKrwi-00046o-VI
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 10:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbXHNIjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 04:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbXHNIjp
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 04:39:45 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:56903 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbXHNIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 04:39:42 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMR00I2G9E469@psmtp08.wxs.nl> for git@vger.kernel.org; Tue,
 14 Aug 2007 10:39:41 +0200 (MEST)
Received: (qmail 5836 invoked by uid 500); Tue, 14 Aug 2007 08:39:40 +0000
In-reply-to: <7vd4xqeilh.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55815>

On Mon, Aug 13, 2007 at 11:27:38PM -0700, Junio C Hamano wrote:
>  * write_out_one_result() calls remove_file() and create_file()
>    to match the work tree to the result you prepared with
>    apply_data().
> 
>    - remove_file() is changed not to do any for gitlink.  We
>      _might_ want to try rmdir() if there is an otherwise empty
>      directory there, but currently we cannot do much to the
>      failure on that, so I did not bother with it.

We could at least warn about it, which is what my patch did.

>    - create_file() does three things:
>      - create a file in the work tree to match the result;
>      - update the index with the patch result;
>      - invalidate cache-tree entry for the path.
> 
>      For the first task, create_one_file() is usually used to
>      create a blob (either regular file or a symlink).  For
>      gitlinks, we do not affect the work tree for now, just like
>      checkout_entry().

It creates the subdirectory, though, and git-apply should do so
too since it expects the subdirectory to be there for subsequent
patches (at least in the --index case).

> diff --git a/builtin-apply.c b/builtin-apply.c

Did you remove the documentation on purpose ?

> +static int verify_index_match(struct cache_entry *ce, struct stat *st)
> +{
> +	if (!ce_match_stat(ce, st, 1))
> +		return 0;
> +	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
> +		if (S_ISDIR(st->st_mode))
> +			return 0;
> +	}

Not a big deal, but ce_match_stat already checks for that.
That's why I was checking for TYPE_CHANGED in its return
value.

> @@ -2096,16 +2142,22 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
>  				    lstat(old_name, &st))
>  					return -1;
>  			}
> -			if (!cached)
> -				changed = ce_match_stat(ce, &st, 1);
> -			if (changed)
> +			if (!cached && verify_index_match(ce, &st))
>  				return error("%s: does not match index",
>  					     old_name);
>  			if (cached)
>  				st_mode = ntohl(ce->ce_mode);
> +		} else if (stat_ret < 0) {
> +			if (errno == ENOENT && S_ISGITLINK(patch->old_mode))
> +				/*
> +				 * It is Ok not to have the submodule
> +				 * checked out at all.
> +				 */
> +				;
> +			else
> +				return error("%s: %s", old_name,
> +					     strerror(errno));
>  		}

Shouldn't you be consistent with the --index case and require the
subdirectory to exist?

skimo
