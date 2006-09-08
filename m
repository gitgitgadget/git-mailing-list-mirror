From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git-commit.sh: convert run_status to a C builtin
Date: Fri, 8 Sep 2006 01:42:26 -0400
Message-ID: <20060908054226.GA19537@coredump.intra.peff.net>
References: <64c62cc942e872b29d7225999e74a07be586674a.1157610743.git.peff@peff.net> <20060907063621.GC17083@coredump.intra.peff.net> <7vzmdbqke3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 07:42:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLZ8V-0006tE-Lq
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 07:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbWIHFm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 01:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbWIHFm3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 01:42:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:16063 "HELO
	peff.net") by vger.kernel.org with SMTP id S1752200AbWIHFm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 01:42:28 -0400
Received: (qmail 29423 invoked from network); 8 Sep 2006 01:41:52 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Sep 2006 01:41:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  8 Sep 2006 01:42:26 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmdbqke3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26677>

On Thu, Sep 07, 2006 at 05:20:20PM -0700, Junio C Hamano wrote:

> "status.h" and "struct status" somehow sounds too broad.
> Granted, "object.h" is also broad, but in git context "object"
> has a specific meaning.

I agree it is quite broad (as is git-runstatus). Conceptually it's
another type of diff format, but making it a diff argument doesn't
really makes much sense. We're at least not introducing any broadness,
since there is already git-status; are we interested in fixing that
name?

Names for similar concepts from other systems: tree-lint (arch),
inventory (arch), whatsnew (darcs, perhaps a little too close to
whatchanged), status (svn, hg), update -n (cvs, ugh!).

> Having said that I cannot come up with a good alternative name.
> It is not "project status" nor "repository status".  It is
> "working tree status", but that sounds very loooooooooooooooong.

wt_status? ucu_status (updated, changed, untracked)?

> Very nicely done.  Especially I liked that you are careful not
> to paint leading '#\t' (which is noticeable when you use reverse
> as an attribute).

Yes. I seem to recall some issues raised about color attributes
persisting over a newline, but I can't find any reference to it now.
Using color_printf makes sure every color is 'closed' but it sometimes
includes the newline in the colorized portion. Does anybody object to
that?


> Very nice code reuse.  I do not mean sarcasm -- the part copied
> and pasted from ls-files is almost trivial to bother factoring

Yes, I don't like cutting and pasting, but it seemed more confusing to
try factoring it out. It's not a lot of *code*, it's just that
remembering to pick out unmerged entries (and the weird -pos bit) is
confusing.

> out.  What's nice is read_directory() does all what is needed to
> deal with .gitignore files, which I forgot almost all about.

I just had to write a file_exists to check for .git/gitignore, which was
a little clumsy.

> > +int status_foreach_cached(status_cb cb);
> > +int status_foreach_updated(status_cb cb);
> > +int status_foreach_changed(status_cb cb);
> > +int status_foreach_untracked(status_cb cb);
> I do not see them defined nor used...

My fault, they were left in from a previous iteration.

> I'll take only [1/3] for now but I am interested in 2 and 3.

OK. Besides the things you mentioned, what improvements would you like
to see?

-Peff
