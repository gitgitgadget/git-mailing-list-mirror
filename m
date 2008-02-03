From: Jeff King <peff@peff.net>
Subject: Re: handle_alias() inside .git dir
Date: Sat, 2 Feb 2008 23:57:38 -0500
Message-ID: <20080203045738.GA10660@coredump.intra.peff.net>
References: <837649D4-465F-4C85-BBE8-B004637EDEF7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 05:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLWvk-0002sN-Ev
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 05:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbYBCE5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 23:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbYBCE5l
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 23:57:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2500 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbYBCE5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 23:57:40 -0500
Received: (qmail 17306 invoked by uid 111); 3 Feb 2008 04:57:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 02 Feb 2008 23:57:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Feb 2008 23:57:38 -0500
Content-Disposition: inline
In-Reply-To: <837649D4-465F-4C85-BBE8-B004637EDEF7@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72327>

On Sat, Feb 02, 2008 at 04:02:20AM -0500, Kevin Ballard wrote:

> This happens because setup_git_directory_gently() ends up setting  
> GIT_DIR_ENVIRONMENT to "." if it detects that we are in the .git  
> directory, and then a subsequent call to setup_git_directory() calls  
> setup_git_directory_gently() again, which sees the GIT_DIR_ENVIRONMENT  
> and ends up calling set_work_tree(). The comment to set_work_tree() says 
> it's only called if GIT_DIR is set and calls what it does "old behavior". 
> I assume it exists for some sort of backwards compatibility, but in quick 
> testing simply commenting out line 266 of setup.c (the call to 
> set_work_tree) makes `git st` work as expected. I'm not sure if this will 
> have any adverse effect on anything else. Does anybody know if this will 
> cause problems?

No, I don't think that's right. That call is there for people who have
explicitly set GIT_DIR to use their cwd as the working tree, wherever it
may be.

The problem is that setup_git_directory_gently actually _sets_ GIT_DIR.
So the next time through when we call setup_git_directory_gently again,
it thinks you have set it in the environment, which has the special
meaning.

Unfortunately, it doesn't look like there's a simple fix. Because the
semantics of the two are related, I think we need to set GIT_WORK_TREE
whenever we set GIT_DIR, and we need some way of setting GIT_WORK_TREE
to a value that means "I don't have a work tree."

-Peff
