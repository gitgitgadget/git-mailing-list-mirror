From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Enable "git rerere" by the config variable rerere.enabled
Date: Sat, 7 Jul 2007 13:41:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071333520.4093@racer.site>
References: <Pine.LNX.4.64.0707061303450.4093@racer.site>
 <7vejjkdaqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 14:48:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I79iI-0006kg-AK
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 14:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXGGMs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXGGMs0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 08:48:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:59190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753339AbXGGMsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 08:48:25 -0400
Received: (qmail invoked by alias); 07 Jul 2007 12:48:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 07 Jul 2007 14:48:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189lmNzV3o9Hvuxktr8vDzK2Pa0kcae6556g/BTc2
	VCfUYGQe3rAr+A
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejjkdaqe.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51814>

Hi,

On Fri, 6 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	And yeah, the git-gui part should be factored out, I guess. Shawn?
> 
> I'll exclude git-gui part and commit with a minor tweaks;

Thank you. I planned to redo the patch when consensus is reached that this 
is actually a good patch. But as usual, you're faster.

> > -int cmd_rerere(int argc, const char **argv, const char *prefix)
> > +int is_rerere_enabled(void)
> >  {
> 
> This will be "static".

But of course!

> > +	const char *rr_cache = git_path("rr-cache");
> > +	int rr_cache_exists;
> >  
> > -	if (stat(git_path("rr-cache"), &st) || !S_ISDIR(st.st_mode))
> > +	if (!rerere_enabled)
> >  		return 0;
> 
> As git_path() is not zero-cost, assignment to rr_cache will be
> moved here.

Yes, fully agree. It probably does not matter much right now, as 
git-rerere is mostly called from scripts, and thus does a fork() && exec() 
anyway, but I am smilingly awaiting the first full-fledged builtin 
implementation of "git commit", in which case this very function should 
move somewhere else, and there it does matter a bit more.

> > +	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
> > +	if (rerere_enabled < 0)
> > +		return rr_cache_exists;
> > +
> > +	if (!rr_cache_exists && (mkdir(rr_cache, 0777) ||
> > +			adjust_shared_perm(rr_cache)))
> > +		die("Could not create directory %s", rr_cache);
> > +	return 1;
> > +}
> 
> If rr-cache is a regular file, we will hit "Could not create
> directory" which is exactly what we want anyway.  Even if it is
> a dangling symlink, it would fail with "File exists", so that
> should be Ok.

That was the intended error path, yes. It does not safeguard against old 
behaviour, where you could ": > .git/rr-cache", and be wondering why it is 
not activating rr-cache ;-)

Ciao,
Dscho
