From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Mon, 5 Oct 2009 20:58:02 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20091005165802.GA24402@tugrik.mns.mnsspb.ru>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muquz-0006Vn-8G
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 19:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbZJEQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZJEQ7W
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 12:59:22 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:58024 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbZJEQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 12:59:21 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1MuqtY-00065Q-4T; Mon, 05 Oct 2009 20:58:44 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1Muqss-0006wU-O3; Mon, 05 Oct 2009 20:58:02 +0400
Content-Disposition: inline
In-Reply-To: <20091005152504.GE9261@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129573>

On Mon, Oct 05, 2009 at 08:25:04AM -0700, Shawn O. Pearce wrote:
> Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > I've tracked down that the most time is spent warming up merge_strategy,
> > all_command & porcelain_command caches.
> 
> Nak.
> 
> The problem is, during completion when we modify the value the
> change doesn't persist beyond the current completion invocation.
> Thus there is no value in the cache, so every completion attempt
> which needs the list has to rerun the command to compute it.

Yes, my mistake.

To avoid spawning subshell on $(__git_porcelain_commands) I could come up
with "caching" at the upper level, as e.g.

@@ -2107,7 +2111,10 @@ _git ()
                        --help
                        "
                        ;;
-               *)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
+               *)     __gitcomp "
+                       ${__git_porcelain_commandlist:=$(__git_porcelain_commands)}
+                       $(__git_aliases)
+                       " ;;


but that's ugly and not maintainable since e.g. __git_all_commands() is used in
several places.


The other possibility is to pregenerate all these lists at git build time, but
are we going to do it for things under contrib/ ?


This could have easy solution if bash provided analog of $() to call a function
and obtain either its stdout or return value without spawning subshell, but up
to now I could not find such a construct in bash's man.

I have to go, but I'll try to come up with something practical in several days.


Thanks for spotting it,
Kirill
