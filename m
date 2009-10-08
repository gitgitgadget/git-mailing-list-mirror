From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Thu, 8 Oct 2009 08:02:06 -0700
Message-ID: <20091008150206.GD9261@spearce.org>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Oct 08 17:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvuZp-0004Pe-C4
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 17:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbZJHPCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbZJHPCn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 11:02:43 -0400
Received: from george.spearce.org ([209.20.77.23]:52493 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbZJHPCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 11:02:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B0FF1381FE; Thu,  8 Oct 2009 15:02:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091008132718.GA12161@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129694>

Kirill Smelkov <kirr@mns.spb.ru> wrote:
> diff --git a/contrib/completion/Makefile b/contrib/completion/Makefile
> new file mode 100644
> index 0000000..a0fbb66
> --- /dev/null
> +++ b/contrib/completion/Makefile
> @@ -0,0 +1,11 @@
> +all	: git-completion.bash
> +
> +
> +git-completion.bash: git-completion.bash.in git-completion.bash.generate
> +	# Generate completions for binaries we have just built
> +	PATH="$(shell pwd)/..:$$PATH" ./git-completion.bash.generate

Is only one .. enough?  Isn't that putting us into the contrib
directory, and therefore not finding the 'git' we just compiled?

I'm also concerned that git-completion.bash.generate requires
bash to compile the completion for bash.  IMHO, if we are building
this code at compile time we shouldn't assume bash is available.
What if this is a sandboxed build environment using another shell
and /bin/bash isn't installed?

I think the git-completion.bash.generate code needs to be a bit
more sh agnostic than the completion routines themselves are.

> +# pregenerated stuff (to save load time)
> +__git_merge_strategylist=__GIT_MERGE_STRATEGYLIST
> +__git_all_commandlist=__GIT_ALL_COMMANDLIST
> +__git_porcelain_commandlist=__GIT_PORCELAIN_COMMANDLIST

This also makes testing the completion a bit more difficult, now
we have to build it before we can load it, making the testing cycle
actually be:

  make && . git-completion.bash

We probably should place a quick comment here to remind folks that
they need to build the script in order to test it properly.

-- 
Shawn.
