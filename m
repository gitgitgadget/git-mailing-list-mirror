From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Wed, 27 Jan 2010 12:18:22 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001271149050.14365@iabervon.org>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org> <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-587346271-1264612702=:14365"
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 18:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaBXC-0000U9-VT
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab0A0RSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 12:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782Ab0A0RSY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:18:24 -0500
Received: from iabervon.org ([66.92.72.58]:40981 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755760Ab0A0RSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 12:18:23 -0500
Received: (qmail 10710 invoked by uid 1000); 27 Jan 2010 17:18:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jan 2010 17:18:22 -0000
In-Reply-To: <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138173>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-587346271-1264612702=:14365
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 27 Jan 2010, Tor Arvid Lund wrote:

> On Mon, Jan 25, 2010 at 10:35 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > This is probably not particularly appropriate for mainline
> > application, and is somewhat buggy, not extensively tested, and
> > incomplete. The push support is also currently based on a transport helper
> > export design that isn't upstream and I don't like any more; a better
> > design is probably to have the core send an "export" command and then a
> > gfi stream, but I haven't worked on this.
> >
> > It has two implementations of the interaction with the Perforce
> > server: one that uses the command-line client (and therefore makes a
> > ton of separate connections to the server) and one that uses the
> > (closed source, vaguely licensed) C++ API. The former does not support
> > everything used in push/submit correctly at this point.
> >
> > It also adds support to the Makefile for building C++ object files and
> > linking with a C++ linker. It should be easy to omit entirely for
> > builds that don't use p4, and it's at least somewhat out of the way.
> >
> > The biggest flaw currently is that it doesn't save its analysis of the
> > structure of the history, and doesn't have a way to push it out of memory,
> > so a long or complex history will run you out of memory or will take a
> > long time to do an incremental fetch.
> >
> > Fetch features:
> >
> >  - following integrations (with some guessing)
> >  - finding other branches of a codeline
> >
> > Push features (only with the C++ API):
> >
> >  - works if you don't do anything at all complicated
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> <snip>
> 
> Hi, and thank you for posting this.
> 
> I tried applying it to current master, and got it to compile using the
> p4 c++ api.
> 
> However, I'm having trouble getting it to run. This is most certainly
> my own fault, and I'm guessing it has to do with my .git/config file
> setup.
> 
> I tried doing 'git init', and making a .git/config file like so:
> ------------
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> 
> [vcs-p4]
>         port = perforce.mycompany.com:1666
>         client = toral
> 
> [remote "origin"]
>         vcs = p4
>         codeline = //depot/path/to/my/existing/test/project
> ------------
> Then, I did 'git fetch', and got a seg fault. I got around it by
> commenting out a line:
> 
> diff --git a/transport.c b/transport.c
> index 7714fdb..5b404f7 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -924,7 +924,7 @@ struct transport *transport_get(struct remote
> *remote, const char *url)
>         ret->url = url;
> 
>         /* In case previous URL had helper forced, reset it. */
> -       remote->foreign_vcs = NULL;
> +/*     remote->foreign_vcs = NULL;*/
> 
>         /* maybe it is a foreign URL? */
>         if (url) {
> 
> -------------
> So - now I get this:
> 
> $ GIT_TRANSPORT_HELPER_DEBUG=1 git fetch
> Debug: Remote helper: -> capabilities
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- import
> Debug: Got cap import
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- export
> Debug: Got cap export
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <-
> Debug: Capabilities complete.
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- ? refs/p4/depot/path/to/my/existing/test/project
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- ? refs/p4/depot/path/to/my/existing/test/project
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <-
> Debug: Read ref listing.
> fatal: Couldn't find remote ref HEAD
> -------------
> 
> I also tried setting vcs-p4.findbranches to 'true'. The only
> difference in the output, is that the "<- ? refs/p4/..." line is just
> output once.
> 
> So if anyone has a clue for me, I shall, well, cease to be clueless.

The p4 remote helper doesn't present the remote as having a ref "HEAD". It 
probably ought to when you've configured exactly one codeline, which is 
obviously the default you mean. (And that should be an easy addition.)

The way I use it is to have a line like:

	fetch = refs/p4/depot/path/to/my/existing/test/project:refs/remotes/origin/master

Or, actually, I'm making a mirror of the p4 (since I want multiple 
working directories without redoing the import), so I'm fetching a pattern 
into refs/heads/*.

The findBranches thing can identify more branches by looking at outgoing 
integrations, but these (if any) come out with the same long branches 
name, and need to be fetched into something sensible.

	-Daniel
*This .sig left intentionally blank*
--1547844168-587346271-1264612702=:14365--
