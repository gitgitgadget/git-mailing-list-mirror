From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 8 Feb 2008 20:44:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082042440.11591@racer.site>
References: <20080208174654.2e9e679c@pc09.procura.nl> <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com> <alpine.LNX.1.00.0802081526350.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNa5b-0006KS-AH
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYBHUoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYBHUoU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:44:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:36744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751421AbYBHUoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:44:19 -0500
Received: (qmail invoked by alias); 08 Feb 2008 20:44:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 08 Feb 2008 21:44:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gS/Y0NIagA5D0/BiBOL9FVy06OYKr/6pZ48A2rm
	po7fjN9KsgpHnI
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802081526350.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73143>

Hi,

On Fri, 8 Feb 2008, Daniel Barkalow wrote:

> On Fri, 8 Feb 2008, Mike Ralphson wrote:
> 
> > On Feb 8, 2008 4:46 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> > > HP-UX allows directories to be opened with fopen (path, "r"), which
> > > will cause some translations that expect to read files, read dirs
> > > instead. This patch makes sure the two fopen () calls in remote.c
> > > only open the file if it is a file.
> > >
> > > Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> > 
> > Many thanks, this is also required for AIX. I had got some way to
> > tracking it down, but I thought it was an issue with strbuf. So...
> 
> Does the following help? We really ought to know that ".." must be a path 
> literal (and there obviously should be more limitations on nicknames for 
> remotes, but I haven't figured out what they should be yet).
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> diff --git a/remote.c b/remote.c
> index 0e00680..83a3d9d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -348,7 +348,7 @@ struct remote *remote_get(const char *name)
>         if (!name)
>                 name = default_remote_name;
>         ret = make_remote(name, 0);
> -       if (name[0] != '/') {
> +       if (name[0] != '/' && strcmp(name, "..")) {
>                 if (!ret->url)
>                         read_remotes_file(ret);
>                 if (!ret->url)

You'll need to check for ".", too: "git pull . <branch>" was originally 
the only way to merge a local branch, and it is still valid.

Ciao,
Dscho
