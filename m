From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Commands requiring a work tree must not run in GIT_DIR
Date: Wed, 24 Jan 2007 15:14:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241508510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com> <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
 <45B07875.9030506@fs.ei.tum.de> <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
 <45B0C7E6.4020509@op5.se> <1169214414.18684.25.camel@localhost.localdomain>
 <Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzymhma2.fsf@assigned-by-dhcp.cox.net> <878xfuuhco.wl@mail2.atmark-techno.com>
 <Pine.LNX.4.63.0701231312170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodoohcol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 15:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9iuB-00067l-G8
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbXAXOPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbXAXOPI
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:15:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:33059 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751562AbXAXOPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:15:06 -0500
Received: (qmail invoked by alias); 24 Jan 2007 14:15:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 24 Jan 2007 15:15:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodoohcol.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37642>

Hi,

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This patch helps when you accidentally run something like git-clean
> > in the git directory instead of the work tree.
> 
> I think "require_work_tree" reflects what we are trying to do
> much better than NOT_BARE.  So maybe we should rename NOT_BARE
> to REQUIRE_WORK_TREE.

Hm. Might make sense.

But there is a subtle trap here: if a repo is not bare, it does have a 
work tree. But what we want here actually is NOT_INSIDE_GIT_DIR:

It is perfectly sensible to run git-pull from inside the git dir, since it 
has to cd to the top _anyway_. So, git-pull needs a work tree, but does 
not forbid running from within GIT_DIR.

> Existing check function is_bare_repository() is sometimes used
> to see if it is a bare repository regardless of where you are
> (e.g. refs.c::log_ref_write()), so that function can stay as is,
> but the combined check below (you seem to have a few instances
> in your patch) can be made into a function require_work_tree().
> 
> > diff --git a/git.c b/git.c
> > index 5133a07..2027d1c 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -302,8 +302,9 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
> >  			prefix = setup_git_directory();
> >  		if (p->option & USE_PAGER)
> >  			setup_pager();
> > -		if ((p->option & NOT_BARE) && is_bare_repository())
> > -			die("%s cannot be used in a bare git directory", cmd);
> > +		if ((p->option & NOT_BARE) &&
> > +				(is_bare_repository() || is_inside_git_dir()))
> > +			die("%s must be run in a work tree", cmd);
> >  		trace_argv_printf(argv, argc, "trace: built-in: git");
> >  
> >  		exit(p->fn(argc, argv, prefix));
> 
> Similar to the "conditionally require working tree" you did to
> ls-files, "apply --index" and perhaps "apply --cached" (but this
> is "perhaps" --- you _could_ have an index in a bare repository,
> although it is debatable if there is a valid use case for it),
> grep (grep_cache() but perhaps !cached for the same reason),
> "read-tree -u", "rerere", "update-index" (except --index-info
> and friends that feed object names directly without using
> working tree), should require working tree.

As I said, maybe we have to introduce DISALLOW_INSIDE_GIT_DIR (which is 
ugly, since it is so long, but I cannot think of anything saner), and 
likewise "disallow_inside_GIT_DIR" for scripts.

> On the script front, bisect should require working tree, but I do not 
> think anybody is stupid enough to start bisecting in a bare repository 
> ;-)

OTOH it is really easy:

diff --git a/git-bisect.sh b/git-bisect.sh
index 6da31e8..f8a2b64 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -11,6 +11,7 @@ git bisect replay <logfile>	replay bisection log
 git bisect log			show bisect log.'
 
 . git-sh-setup
+require_work_tree
 
 sq() {
 	@@PERL@@ -e '


Ciao,
Dscho
