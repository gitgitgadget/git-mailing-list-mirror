From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] runstatus: do not recurse into subdirectories if not
 needed
Date: Thu, 28 Sep 2006 02:26:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609280216350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609271315470.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac4k97if.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 02:27:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjju-0004ck-4Z
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031285AbWI1A0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031288AbWI1A0z
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:26:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:25733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031285AbWI1A0y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 20:26:54 -0400
Received: (qmail invoked by alias); 28 Sep 2006 00:26:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 28 Sep 2006 02:26:53 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac4k97if.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27957>

Hi,

On Wed, 27 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This speeds up the case when you run git-status, having an untracked
> > subdirectory containing huge amounts of files.
> >
> > It also clarifies the handling of hide_empty_directories; the old version
> > worked, but was hard to understand.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> >  dir.c |   24 +++++++++++++++---------
> >  1 files changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index e2f472b..e69663c 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -274,6 +274,15 @@ static int dir_exists(const char *dirnam
> >  	return !strncmp(active_cache[pos]->name, dirname, len);
> >  }
> >  
> > +static int dir_is_empty(const char *dirname)
> > +{
> > +	DIR *fdir = opendir(dirname);
> > +	int result = (readdir(fdir) == NULL);
> > +
> > +	closedir(fdir);
> > +	return result;
> > +}
> > +
> 
> Does this really check if the directory is empty (I think you
> would read "." and ".." out of it at least)?
>
> When the original code recurses into subdirectory, it seems to
> behave identically for a truly empty directory and a directory
> that has only ".git" (or excluded files in it under !show_ignored).

Of course I missed that. Probably, because there is no test for that.

But given my experience of a very, _very_ slow git-status when I do not 
_care_ about that particular directory (even if it does contain .git and 
excluded files), is it really sensible to have _no_ way to disable 
hide_empty_directories when show_other_directories is enabled?

Or would it make sense to disable hide_empty_directories altogether?

Now, I could enhance dir_is_empty() to recursively test if the dir is 
empty, and return 0 on first sight of a not-excluded dir entry, but is it 
really worth the hassle?

Ciao,
Dscho
