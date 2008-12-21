From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add support for changing packed_git_window_size at
	process start time
Date: Sun, 21 Dec 2008 14:28:48 -0800
Message-ID: <20081221222848.GE17355@spearce.org>
References: <1229895454-19498-1-git-send-email-tyler@slide.com> <1229895454-19498-2-git-send-email-tyler@slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWoV-0001cJ-Jd
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYLUW2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbYLUW2t
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:28:49 -0500
Received: from george.spearce.org ([209.20.77.23]:54509 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYLUW2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:28:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9BE0E38200; Sun, 21 Dec 2008 22:28:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229895454-19498-2-git-send-email-tyler@slide.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103725>

"R. Tyler Ballance" <tyler@slide.com> wrote:
> "Works" insofar that it will alter the packed_git_window_size variable in environment.c
> when the environment is set up. It /doesn't/ work when commands like git-diff(1) and git-log(1)
> call get_revision() which seems to disregard the setting if the packed_window_size is set to something
> low (i.e. ulimit -v 32768)

I think you are tweaking the wrong variable here.  Its more than
just the window size that matters to how much of the ulimit we use.
Its also packed_git_limit, which on a 64 bit system is 8 GB.

That's probably why get_revision doesn't seem to honor this as
a setting.  Yea, its down to 0.85% of your ulimit per window,
but we'll still try to open a new window because we have space
left before the 8 GB limit.

I think this is a good idea, trying to fit within the ulimit
rather than assuming we can take whatever we please.  But you
also need to drop the packed_git_limit down.

My suggestion is this:

	packed_git_limit = as->rlim_cur * 0.85;
	packed_git_window_size = packed_git_limit / 4;

or maybe / 2.  You really want at least 2 windows available within
your limit.
 
> @@ -75,6 +78,13 @@ static void setup_git_env(void)
>  	git_graft_file = getenv(GRAFT_ENVIRONMENT);
>  	if (!git_graft_file)
>  		git_graft_file = git_pathdup("info/grafts");
> +	
> +	if (DYNAMIC_WINDOW_SIZE) {
> +		struct rlimit *as = malloc(sizeof(struct rlimit));
> +		if ( (getrlimit(RLIMIT_AS, as) == 0) && ((int)(as->rlim_cur) > 0) ) 
> +			packed_git_window_size = (unsigned int)(as->rlim_cur * DYNAMIC_WINDOW_SIZE_PERCENTAGE);
> +		free(as);
> +	}
>  }

-- 
Shawn.
