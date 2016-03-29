From: Jeff King <peff@peff.net>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 15:41:56 -0400
Message-ID: <20160329194156.GA9527@sigill.intra.peff.net>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
 <20160329123306.GD1578@serenity.lan>
 <xmqqshz9z5hu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Elliott Cable <me@ell.io>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:42:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzWg-0000Nk-Io
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbcC2TmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:42:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:40109 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753994AbcC2TmA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:42:00 -0400
Received: (qmail 4922 invoked by uid 102); 29 Mar 2016 19:41:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 15:41:59 -0400
Received: (qmail 25742 invoked by uid 107); 29 Mar 2016 19:41:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 15:41:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 15:41:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshz9z5hu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290173>

On Tue, Mar 29, 2016 at 08:08:29AM -0700, Junio C Hamano wrote:

> So it is a misconfiguration if you only set GIT_WORK_TREE without
> setting GIT_DIR.

Hmm. I have frequently done this when my cwd is a git repository (e.g.,
a bare one), and it works as you'd expect (find the git-dir in the
current path, then the working tree via $GIT_WORK_TREE).

I always assumed that was the intended behavior, as it is the only one
that makes sense. I suspect I am not alone in having relied on this.

> Also, if you set both and run Git from outside $GIT_WORK_TREE, even
> though Git may try to do its best to give you a reasonable behaviour
> [*1*], it is working by accident not by design (see the statement
> you are making by setting GIT_WORK_TREE in the third bullet above).
> 
> IOW, running from outside GIT_WORK_TREE is a misconfiguration.
> 
> [Footnote]
> 
> *1* Think what should happen when you are outside GIT_WORK_TREE and
>     say this:
> 
> 	$ git grep foo
> 
>     As you are not even inside the working tree, the command would
>     not know in which subdirectory you want to find the string foo;
>     the "reasonable behaviour" is to work on the whole working tree
>     in this case.

Likewise, I always assumed this "reasonable behavior" was intended. When
we setup_git_directory(), we end up in the root of the working tree as
usual. The "prefix" must be empty, as we were not in the work tree at
all, and we do a whole-tree operation.

Those behaviors may not have been fully designed, but as they do the
only reasonable thing (besides dying with an error), and people may have
baked that assumption into their scripts, I think we should avoid
changing them unless there is a compelling reason.

-Peff
