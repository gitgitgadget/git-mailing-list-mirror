From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] archive.c: add support for
 --submodules[=(all|checkedout)]
Date: Sun, 25 Jan 2009 14:55:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251452530.14855@racer>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>  <1232844726-14902-2-git-send-email-hjemli@gmail.com>  <1232844726-14902-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901251247040.14855@racer>
 <8c5c35580901250500s667db3f0j608a30541321ac0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 14:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR5Ti-0007eF-9R
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 14:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbZAYNzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 08:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZAYNzW
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 08:55:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:36007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753124AbZAYNzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 08:55:20 -0500
Received: (qmail invoked by alias); 25 Jan 2009 13:55:17 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp070) with SMTP; 25 Jan 2009 14:55:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19m/gkEqH9m0q2At2EaqYekRvrR4s67DP2TuzKV8A
	hTTle6/cn77aNe
X-X-Sender: gene099@racer
In-Reply-To: <8c5c35580901250500s667db3f0j608a30541321ac0a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107059>

Hi,

On Sun, 25 Jan 2009, Lars Hjemli wrote:

> On Sun, Jan 25, 2009 at 12:57, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > My reasoning for "*" instead of "all" and "" instead for "checkedout" 
> > was that you could allow "<name1>,<name2>" at some stage, where <name> 
> > would first be interpreted as a submodule group, and if that fails, as 
> > submodule name.
> >
> > Thinking about that more, "" seems illogical, that should rather mean 
> > "none", i.e. the same as --no-submodules.  The "checkedout" could be 
> > "." then, perhaps?  As in "what we have checked out in ./, the current 
> > directory"?
> 
> Yes, I think that makes sense, i.e. '--submodules' will include _all_ 
> submodules (making the option behave identically for bare and non-bare 
> repositories), '--submodules=.' will include checked out submodules 
> (making the option a no-op in bare repos, which also makes sense) and 
> '--submodules=<name>[,<name>...]' will include the named submodules, 
> where "named" could mean groupname, submodule name or submodule path, in 
> that order.

Well, I can live with the default of all submodules, even if I think that 
"git-submodule.sh" uses the checked out submodules by default.

> But then we probably also want some (optional) syntax to specify the 
> kind of name, e.g. '--submodules=g:foo,n:bar,p:lib/baz' for group foo, 
> name bar and path lib/baz. Agree?

IMO that is overkill.  Anybody naming a submodule group identically to a 
submodule deserves what she gets, anyway.


> >> @@ -91,6 +92,70 @@ static void setup_archive_check(struct git_attr_check *check)
> >>       check[1].attr = attr_export_subst;
> >>  }
> >>
> >> +static int include_repository(const char *path)
> >> +{
> >> +     struct stat st;
> >> +     const char *tmp;
> >> +
> >> +     /* Return early if the path does not exist since it is OK to not
> >> +      * checkout submodules.
> >> +      */
> >> +     if (stat(path, &st) && errno == ENOENT)
> >> +             return 1;
> >> +
> >> +     tmp = read_gitfile_gently(path);
> >
> > This will leak memory, no?
> 
> I don't think so: read_gitfile_gently() returns a value obtained by
> calling make_absolute_path() which returns a static buffer. Also, the
> path argument to include_repository() is obtained by calling mkpath()
> which returns another static buffer so I don't see any malloc()'s
> which should be free()'d. Is my code-reading flawed?

No, your code reading is good.  And you spared me having to read the code 
myself ;-)  Now, maybe a code comment is in order, to spare others, too?

Ciao,
Dscho
