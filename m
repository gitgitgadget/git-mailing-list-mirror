From: Jeff King <peff@peff.net>
Subject: Re: Effectively tracing project contributions with git
Date: Sun, 13 Sep 2009 05:24:30 -0400
Message-ID: <20090913092429.GA14438@coredump.intra.peff.net>
References: <4AAB9459.3070809@webdrake.net>
 <20090912185940.GA21277@coredump.intra.peff.net>
 <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com>
 <4AAC3889.6030908@webdrake.net>
 <20090913022843.GB26588@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 13 11:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmlKs-0008EH-EW
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 11:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbZIMJYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 05:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZIMJYb
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 05:24:31 -0400
Received: from peff.net ([208.65.91.99]:49487 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbZIMJYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 05:24:30 -0400
Received: (qmail 16740 invoked by uid 107); 13 Sep 2009 09:24:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 05:24:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 05:24:30 -0400
Content-Disposition: inline
In-Reply-To: <20090913022843.GB26588@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128345>

On Sat, Sep 12, 2009 at 10:28:43PM -0400, Theodore Tso wrote:

> > I don't see any solution that doesn't see me browsing diffs -- there's
> > no metric that will solve the problem -- but if your stats work could
> > help me get an output of the form 'here are all the diffs on file X by
> > contributor Y in order of size, largest first' then I think it would
> > help a LOT.
> 
> This will display all of the diffs on file (pathname) XXX by contributor YYY:
> 
> 	git log -p --author=YYY XXX 
> 
> You might also find the diffstats useful:
> 
> 	git log --stat --author=YYY XXX
> 
> Or if you want *only* the diffstats for the file in question, you might try:
> 
> 	git log --stat --pretty=format: --author=YYY XXX | grep XXX

There is also the "--numstat" format which is a bit easier for parsing.
I think the "all diffs on file $X by contributor $Y, ordered by size"
would look like:

  git log -z --pretty=tformat:%H --numstat --author=$Y $X |
  perl -0ne '
    my ($commit) = /^([0-9a-f]{40})$/m;
    my ($lines_added) = /^(\d+)\s/m;
    print "$lines_added $commit\n";
  ' |
  sort -rn |
  cut -d ' ' -f2 |
  xargs -n 1 git show

-Peff
