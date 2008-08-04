From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sun, 3 Aug 2008 19:09:31 -0700
Message-ID: <20080804020931.GA4109@untitled>
References: <1217684549.8296.10.camel@heerbeest> <20080802172742.GT32184@machine.or.cz> <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org> <1217701021.8296.35.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Aug 04 04:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPpWt-0006Rd-US
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYHDCJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbYHDCJd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:09:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50241 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbYHDCJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:09:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2D4512DC01B;
	Sun,  3 Aug 2008 19:09:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1217701021.8296.35.camel@heerbeest>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91303>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> On za, 2008-08-02 at 10:36 -0700, Junio C Hamano wrote:
> 
> > >   You forgot to document your option. (And possibly write a testcase.)
> > 
> > I am not sure if this is generic enough to be in git-svn.perl itself, or
> > perhaps there should be a hook make_log_entry() would call in the form of
> > some Perl scriptlet given by the user to munge $log_entry{log}, which
> > would be very specific to each project.
> 
> If you're not sure, please make up your mind.  I agree it's quite a hack
> but now it's in the archives for others to find.  Doing this in a single
> regexp is a bit tricky and asking a user to write a perl snippet is even
> worse, imho.  Especially if would turn out that stripping changelog bits
> is the only thing that the hook is getting used for, in the end.  I have
> gotten more careful to provide generic solutions to specific problems in
> anticipation of possible future desires.
> 
> I could imagine that leaving git-svn alone and adding a hook to git-log
> would be more useful, though.

NACK on modifying git-svn to support more changelog formats.

A better idea would be to write a generic script that takes "git log",
"git svn log" or even plain "svn log" output and filters it
independently.

This way existing projects don't have to be re-imported (a bad idea to
modify things SVN feeds us anyways), and plain svn users can benefit,
too.

This filter should be reusable for both plain svn and git-svn:

    svn log | changelog-filter --input=svn --style=gnu
    git svn log | changelog-filter --input=svn --style=gnu
    git log --pretty=raw | changelog-filter --input=git-raw --style=gnu


However, I would support a generic --log-filter parameter in git-svn
that would have git-svn filter its output through any given command
before piping it to less.

    git config svn.logFilter "changelog-filter --input=svn --style=gnu"
    git svn log
      or...
    git svn log --log-filter="changelog-filter --input=svn --style=yak"
    git svn log --log-filter="svn-log-to-LaTeX"
    git svn log --log-filter="svn-log-to-HTML"
    git svn log --log-filter="svn-log-to-XML"
    git svn log --log-filter="svn-log-to-JSON"
    git svn log --log-filter="svn-log-to-PNG" > log.png
    git svn log --log-filter="svn-log-to-theora" > log.ogg

    The possibilities are endless :)

-- 
Eric Wong
