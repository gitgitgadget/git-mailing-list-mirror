From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Allow git-instaweb to be run from bare repositories
Date: Thu, 8 Nov 2007 16:46:10 +0100
Message-ID: <20071108154610.GB18727@diku.dk>
References: <20071102090922.GA10141@diku.dk> <7vodec31k0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9bI-0002sT-Hq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761296AbXKHPqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761285AbXKHPqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:46:16 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:33424 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761269AbXKHPqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:46:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 815B752C366;
	Thu,  8 Nov 2007 16:46:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fI+OznX7l4me; Thu,  8 Nov 2007 16:46:10 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id AA1CB52C370;
	Thu,  8 Nov 2007 16:46:10 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E5BDB6DFE12; Thu,  8 Nov 2007 16:45:49 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 92C1F5B8001; Thu,  8 Nov 2007 16:46:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vodec31k0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64045>

Junio C Hamano <gitster@pobox.com> wrote Fri, Nov 02, 2007:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> >  git-instaweb.sh |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >  On IRC yesterday, two were asking for this and it seems simply enough.
> >  Apparently, git-instaweb is a great way to see if you've set up a
> >  remote repository correctly.
> >
> > diff --git a/git-instaweb.sh b/git-instaweb.sh
> > index 95c3e5a..14917ac 100755
> > --- a/git-instaweb.sh
> > +++ b/git-instaweb.sh
> > @@ -6,6 +6,7 @@ USAGE='[--start] [--stop] [--restart]
> >    [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
> >    [--module-path=<path> (for Apache2 only)]'
> >  
> > +SUBDIRECTORY_OK=Yes
> >  . git-sh-setup
> >  
> >  fqgitdir="$GIT_DIR"
> 
> I'd agree with the goal of the patch, and I would not doubt the
> patch worked for you, but it somewhat feels wrong that you can
> say "It is Ok to run this script from a subdirectory" and that
> is the magic to allow something to work in a bare repository.
> 
> Care to share your insights on what is going on?

After disecting the source code in more depth as well as the trace of
running git-instaweb inside a bare repository, the command relies on
git-sh-setup (which is assumed to be safe in bare repos) to initialize a
sane value of GIT_DIR. It uses GIT_DIR to initialize: 

	+ fqgitdir=/tmp/git.git

which is never touched later (and could possibly be changed to just use
the GIT_DIR variable instead, since either is used interchangably
throughout the script. In fact, it later does:

	GIT_DIR="$fqgitdir"

which could be removed. Anyway, this fqgitdir variable is used for
creating a place for gitweb and HTTP server configuration files under
"$fqgitdir/gitweb".

	+ mkdir -p /tmp/git.git/gitweb/tmp

The remaining things in the script is option handling and setting up the
HTTP server configuration. The only place where I see it possibly
"spilling out" into the parent directory is this sequence:

	+ dirname /tmp/git.git
	+ script=
	s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "/tmp";#
	s#\(my\|our\) $gitbin =.*#\1 $gitbin = "/home/fonseca/bin";#
	s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#
	s#\(my\|our\) $git_temp =.*#\1 $git_temp = "/tmp/git.git/gitweb/tmp";#

Where it creates gitweb.cgi. This might make gitweb try to look for .git
directories in subdirectories. Maybe it should create a projects_list
file to explicitly list that only "$barerepo.git" is exported?

-- 
Jonas Fonseca
