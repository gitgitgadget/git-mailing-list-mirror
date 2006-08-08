From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Racy git: avoid having to be always too careful
Date: Tue, 08 Aug 2006 10:25:45 -0700
Message-ID: <7vr6zrw352.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
	<7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 19:26:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAVKy-0004QT-0v
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 19:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWHHRZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWHHRZr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 13:25:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49545 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964951AbWHHRZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 13:25:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808172546.GJFM18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 13:25:46 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 8 Aug 2006 17:43:20 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25078>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This makes "make test" dog slow. How about making this overrideable?
> (It is just a guess, but I _think_ that the sleeping is worse than having 
> to check the files with the same time stamp again and again -- a "git 
> status" will help that).
>
>
> -- 8< --
> [PATCH] read-cache: optionally disable being cautious with racy caches
>
> By setting the environment variable GIT_RISK_RACY_CACHE or the config
> variable core.riskRacyCache, the sleeping (to avoid a racy cache) is
> disabled.

"RISK" is a misnomer here -- the original code without patch is
being cautious and taking a runtime hit but not risky.  The
"delay while writing the cache out for the first time" is trying
to avoid the runtime hit by taking a hit at cache generation
time.  In either case you never risk racy cache.

Perhaps throwing away the whole "delay" thing might be simpler
and more worthwhile.

Another possibility is to tweak the heuristics -- currently we
say 20 paths or 1/4 of whole paths is too many and would cause
too much runtime hit but that was done without any measurement.
We could raise the threashold which would solve the case for the
testsuite whose trees are all small.
