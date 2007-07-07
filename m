From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable "git rerere" by the config variable rerere.enabled
Date: Fri, 06 Jul 2007 22:49:29 -0700
Message-ID: <7vejjkdaqe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707061303450.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 07:49:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I73Ak-0007wa-5Y
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 07:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXGGFtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 01:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbXGGFtb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 01:49:31 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45459 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbXGGFtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 01:49:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707054930.DJFU17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 01:49:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LVpV1X00f1kojtg0000000; Sat, 07 Jul 2007 01:49:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51804>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Earlier, "git rerere" was enabled by creating the directory
> .git/rr-cache.  That is definitely not in line with most other
> features, which are enabled by a config variable.
>
> So, check the config variable "rerere.enabled". If it is set
> to "false" explicitely, do not activate rerere, even if
> .git/rr-cache exists. This should help when you want to disable
> rerere temporarily.
>
> If "rerere.enabled" is not set at all, fall back to detection
> of the directory .git/rr-cache.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Touches quite some parts, doesn't it?
>
> 	And yeah, the git-gui part should be factored out, I guess. Shawn?

I'll exclude git-gui part and commit with a minor tweaks; having
extra "does the directory exist" check in git-gui would not hurt
people who are used to how rerere works in the short term, and I
think I read somewhere that I should expect git-gui updates over
the weekend anyway.

> -int cmd_rerere(int argc, const char **argv, const char *prefix)
> +int is_rerere_enabled(void)
>  {

This will be "static".

> -	struct path_list merge_rr = { NULL, 0, 0, 1 };
> -	int i, fd = -1;
>  	struct stat st;
> +	const char *rr_cache = git_path("rr-cache");
> +	int rr_cache_exists;
>  
> -	if (stat(git_path("rr-cache"), &st) || !S_ISDIR(st.st_mode))
> +	if (!rerere_enabled)
>  		return 0;

As git_path() is not zero-cost, assignment to rr_cache will be
moved here.
>  
> +	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
> +	if (rerere_enabled < 0)
> +		return rr_cache_exists;
> +
> +	if (!rr_cache_exists && (mkdir(rr_cache, 0777) ||
> +			adjust_shared_perm(rr_cache)))
> +		die("Could not create directory %s", rr_cache);
> +	return 1;
> +}

If rr-cache is a regular file, we will hit "Could not create
directory" which is exactly what we want anyway.  Even if it is
a dangling symlink, it would fail with "File exists", so that
should be Ok.
