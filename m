From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 15:05:37 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907081456570.2147@iabervon.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <7viqi386th.fsf@alter.siamese.dyndns.org> <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu> <7vskh76pui.fsf@alter.siamese.dyndns.org> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
 <7vd48b6md8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 21:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOcSg-0004G7-QG
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 21:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZGHTFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 15:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbZGHTFk
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 15:05:40 -0400
Received: from iabervon.org ([66.92.72.58]:34302 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbZGHTFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 15:05:39 -0400
Received: (qmail 26863 invoked by uid 1000); 8 Jul 2009 19:05:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jul 2009 19:05:37 -0000
In-Reply-To: <7vd48b6md8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122912>

On Wed, 8 Jul 2009, Junio C Hamano wrote:

> Fritz Anderson <fritza@uchicago.edu> writes:
> 
> > On Jul 8, 2009, at 12:34 PM, Junio C Hamano wrote:
> >
> >> Which makes the initial "sudo git clone..." find git in _your_ path
> >> before sanitization (and that is why it even starts), but then the path
> >> is nuked for the git process it launches, and we cannot find
> >> git-index-pack on the PATH.
> >>
> >> But this should be fine, as git is expected to find git-index-pack in
> >> its GIT_EXEC_PATH that is compiled in the binary of "git" itself.
> >>
> >> Which makes me suspect that your "git" in /usr/local/bin may be
> >> misconfigured.  You might want to check what these tell you.
> >>
> >> 	$ git --exec-path
> >> 	$ /usr/local/bin/git --exec-path
> >
> > Glad to oblige. These are the four possibilities:
> >
> > $ git --exec-path
> > /usr/local/libexec/git-core
> > $ /usr/local/bin/git --exec-path
> > /usr/local/libexec/git-core
> > $ sudo git --exec-path
> > /usr/local/libexec/git-core
> > $ sudo /usr/local/bin/git --exec-path
> > /usr/local/libexec/git-core
> > $
> >
> > Same path every time, sudo or not, full path to git or not.

Just to verify, /usr/local/libexec/git-core/git-index-pack exists, and is 
executable?

> Hmm, there is something fishy going on, and I am a bit frustrated not
> being able to see what it is.
> 
> The callpath should look like this:
> 
>   git.c::main()
>   -> setup_path()
>   -> cmd_clone()
>      -> transport_fetch_refs()
>         -> fetch_refs_via_pack()
>            -> fetch_pack()
>               -> do_fetch_pack()
>                  -> get_pack()
>                     -> start_command(), running either
>                        "index-pack" or "unpack-objects"
>                        on the incoming stream
> 
> and start_command() forks and eventually does execv_git_cmd() which is a
> thin wrapper around execvp().
> 
> The PATH exported when this execvp() runs should have been adjusted to
> have the exec-path at the beginning by calling setup_path() and this is
> done way before cmd_clone() was called by git.c::main() function.
> 
> What am I not seeing?  There should be something obvious that I am
> missing.  I do not see how your original command can fail with "exec
> failed: No such file or directory".

All I can think of is that this could happen if PATH already had 
git-index-pack, and the exec-path didn't have it.

	-Daniel
*This .sig left intentionally blank*
