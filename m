From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 08:31:48 -0700
Message-ID: <20080923153148.GI3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 17:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki9so-00063u-8v
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 17:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbYIWPbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYIWPbt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 11:31:49 -0400
Received: from george.spearce.org ([209.20.77.23]:42475 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYIWPbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 11:31:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2465538360; Tue, 23 Sep 2008 15:31:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080923140144.GN21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96576>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> This patch introduces the GIT_FAST_STAT environment variable. If this
> variable is not set then Git will work as before. However, if it is set
> then the Cygwin version of Git will try to use a Win32 API function if
> it is possible to speed up stat/lstat.
> 
> This fast mode works only for relative paths. It is assumed that the
> whole repository is located inside one directory without using Cygwin
> mount to bind external paths inside of the current tree.
...
> +/*
> + * This are startup stubs, which choose what implementation of lstat/stat
> + * should be used. If GIT_FAST_STAT is not set then the standard functions
> + * included in the cygwin library are used. If it is set then our fast and
> + * dirty implementation is invoked, which should be 2-3 times faster than
> + * cygwin functions.
> + */
> +static int cygwin_stat_choice(const char *file_name, struct stat *buf)
> +{
> +	cygwin_stat_fn = getenv("GIT_FAST_STAT") ?
> +		cygwin_stat : stat;
> +	return (*cygwin_stat_fn)(file_name, buf);
> +}
> +
> +static int cygwin_lstat_choice(const char *file_name, struct stat *buf)
> +{
> +	cygwin_lstat_fn = getenv("GIT_FAST_STAT") ?
> +		cygwin_lstat : lstat;
> +	return (*cygwin_lstat_fn)(file_name, buf);
> +}

I wonder, should this be controlled by an environment variable?

Given your description of the feature it seems to be more a property
of the specific repository, as it is based upon where the repository
lives within the Cygwin namespace.  Should this be controlled instead
by say a "core.cygwinnativestat = true" configuration property?

-- 
Shawn.
