From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sat, 28 Jul 2007 01:21:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280115370.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEa5L-0003Ws-8g
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765012AbXG1AXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764329AbXG1AXD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:23:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:47139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758752AbXG1AXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:23:00 -0400
Received: (qmail invoked by alias); 28 Jul 2007 00:22:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 28 Jul 2007 02:22:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8E0onz4X8T0XLMzG99tu4QvqZ4Mgv437U5x+yim
	QYx1VzJnHyCWJE
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53977>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Not only because of ohloh am I proud that in spite of removing
> > 	more lines than I added, there were more comments added than
> > 	removed...
> 
> > diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
> > index 497903a..3f787a8 100644
> > --- a/builtin-rev-parse.c
> > +++ b/builtin-rev-parse.c
> > @@ -320,15 +320,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  				continue;
> >  			}
> >  			if (!strcmp(arg, "--show-cdup")) {
> > -				const char *pfx = prefix;
> > -				while (pfx) {
> > -					pfx = strchr(pfx, '/');
> > -					if (pfx) {
> > -						pfx++;
> > -						printf("../");
> > -					}
> > -				}
> > -				putchar('\n');
> > +				const char *work_tree = get_git_work_tree();
> > +				if (work_tree)
> > +					printf("%s\n", work_tree);
> >  				continue;
> 
> This changes semantics, I think.
> 
> It used to be relative "up" path when no funny work-tree stuff
> is used, but get_git_work_tree() now seems to return absolute,
> hence this option as well.  If it introduces regression to
> existing callers is up to what the caller does to the resulting
> path, though.  If it only is used to prefix other things
> (i.e. path="$(git rev-parse --show-cdup)$1"), the caller would
> be safe, but if the caller counted number of ../ in the return
> value to see how deep it is, or if the caller expected to see
> empty string in order to see if the process is at the toplevel,
> this change would become a regression.

I am somewhat negative on keeping _that_ much backwards compatibility.  
Scripts which depend on show-cdup being a relative path _will_ be broken 
by work-tree.  Is it worth it to detect those errors late?

> > @@ -62,15 +66,8 @@ static void setup_git_env(void)
> >  
> >  int is_bare_repository(void)
> >  {
> > +	/* if core.bare is not 'false', let's see if there is a work tree */
> > +	return is_bare_repository_cfg && !get_git_work_tree();
> >  }
> 
> I thought about making core.bare a tertiary, true/false/depends,
> but I think this makes more sense.

Actually, you made me think again, and I am more along those lines now:

	return is_bare_repository_cfg >= 0 ?
		is_bare_repository_cfg : !get_git_work_tree();

and according patch to get_git_work_tree to return NULL if 
is_bare_repository_cfg == 1.

Ciao,
Dscho
