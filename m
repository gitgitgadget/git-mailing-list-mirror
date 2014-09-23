From: Jeff King <peff@peff.net>
Subject: Re: Bug in git 2.1.0 when cloning to directory with same name as
 repository
Date: Tue, 23 Sep 2014 04:39:03 -0400
Message-ID: <20140923083903.GA7644@peff.net>
References: <CAMoD=Bi41mB3QRn3JdZL-FGHs4w3C2jGpnJB-CqSndO7FMtfzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Barabanov <michael.barabanov@windriver.com>,
	git@vger.kernel.org
To: Chris Salzberg <csalzberg@degica.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWLcw-00078G-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaIWIjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:39:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:50851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751559AbaIWIjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:39:07 -0400
Received: (qmail 7745 invoked by uid 102); 23 Sep 2014 08:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 03:39:06 -0500
Received: (qmail 25514 invoked by uid 107); 23 Sep 2014 08:39:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 04:39:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 04:39:03 -0400
Content-Disposition: inline
In-Reply-To: <CAMoD=Bi41mB3QRn3JdZL-FGHs4w3C2jGpnJB-CqSndO7FMtfzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257405>

On Tue, Sep 23, 2014 at 04:49:55PM +0900, Chris Salzberg wrote:

> I've found what looks like a bug wherein if you are using an ssh alias
> for a git remote, and that remote has a dash in its name, and you
> specify the target path as the name of the url itself, git complains
> about refs not being valid packed references.
> 
> To reproduce, in git 2.1.0 and with a repository using ssh config and
> which has a dash in the name, e.g.:

Thanks for a reproduction recipe. I think we can make it simpler,
though. The problem seems to come when your destination directory is
identical to the remote URL. I saw similar failures with:

  git clone git@github.com:git/git git@github.com:git/git

and even:

  git clone https://github.com/git/git https://github.com/git/git

It bisects to f38aa83 (use local cloning if insteadOf makes a local URL,
2014-07-17) by Michael Barabanov (cc'd). That commit moved a call to
get_repo_path() much further down cmd_clone, after we have already
created the repo directory. As a result, we try to fetch objects from
the newly created directory, which of course has none (and because it's
local, we try to use "cp" instead of the git protocol. We don't notice
the error at transfer time, but rather later when trying to write out
the references).

I'm not sure of the simplest solution. I guess along the lines of one
of:

  1. Move the code back before the directory is created. Rather than
     using `remote_get` to apply insteadOf substitution as a side
     effect, make it possible to call into the insteadOf code directly.

  2. It might work to chdir() into the repo after creating it, though
     that probably creates its own problems with other relative paths
     (and I am not sure it would save us if you had a remote URL that
     looked like an absolute path).

-Peff
