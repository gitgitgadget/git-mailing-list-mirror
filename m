From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Tue, 22 Jan 2013 09:25:15 +0100
Message-ID: <50FE4CEB.5040200@viscovery.net>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org> <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZAx-0003Gx-T3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab3AVIZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:25:26 -0500
Received: from so.liwest.at ([212.33.55.24]:13368 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab3AVIZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:25:25 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TxZAS-00078B-Av; Tue, 22 Jan 2013 09:25:16 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D9B9F1660F;
	Tue, 22 Jan 2013 09:25:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
X-Enigmail-Version: 1.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214216>

Am 1/22/2013 8:49, schrieb Robin Rosenberg:
> Specifically the fields uid, gid, ctime, ino and dev are set to zero
> by JGit. Other implementations, eg. Git in cygwin are allegedly also
> somewhat incompatible with Git For Windows and on *nix platforms
> the resolution of the timestamps may differ.
> 
> Any stat checking by git will then need to check content, which may
> be very slow, particularly on Windows. Since mtime and size
> is typically enough we should allow the user to tell git to avoid
> checking these fields if they are set to zero in the index.

Isn't this paragraph about slowness in the commit message misleading, as
what the patch does has no influence on the speed of stat checking? Am I
missing something?

> This change introduces a core.checkstat config option where the
> the user can select to check all fields (default), or just size
> and the whole second part of mtime (minimal).

> +core.checkstat::
> +	Determines which stat fields to match between the index
> +	and work tree. The user can set this to 'default' or
> +	'minimal'. Default (or explicitly 'default'), is to check
> +	all fields, including the sub-second part of mtime and ctime.

I think this needs some more clarification, less 1337 speak, as well as a
hint when to set the option.

	Determines which file attributes are checked to detect whether
	a file has been modified. Set this option to 'minimal', when...,
	which checks only the file size and whole-seconds of the last
	modification time. Otherwise, leave unset or set to the value
	'default'.

By starting with the hint when to set to 'minimal' in this way allows us
to omit a specification what the 'default' is.

> diff --git a/read-cache.c b/read-cache.c
> index fda78bc..23db681 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -197,21 +197,25 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  	}
>  	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
>  		changed |= MTIME_CHANGED;
> -	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> -		changed |= CTIME_CHANGED;
> +	if (trust_ctime ? check_stat : trust_ctime/*false*/)
> +		if (ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> +			changed |= CTIME_CHANGED;

It took me a while to understand why you write /*false*/ there. Isn't the
the condition merely this:

	if (trust_ctime && check_stat &&
	    ce->ce_ctime.sec != (unsigned int)st->st_ctime)
		changed |= CTIME_CHANGED;

>  
>  #ifdef USE_NSEC
> -	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
> +	if (check_stat && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
>  		changed |= MTIME_CHANGED;
> -	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
> -		changed |= CTIME_CHANGED;
> +	if (trust_ctime ? check_stat : trust_ctime/*false*/)
> +		if (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
> +			changed |= CTIME_CHANGED;

Same here.

>  #endif

-- Hannes
