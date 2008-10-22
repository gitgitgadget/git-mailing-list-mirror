From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: git add --patch newfile doesn't add newfile to cache ?
Date: Wed, 22 Oct 2008 15:12:32 +0200
Message-ID: <20081022131232.GL3988@gmx.de>
References: <20081020143636.GB3988@gmx.de> <20081020235049.GA23120@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 15:14:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsdX9-0004RF-UJ
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 15:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYJVNMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 09:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYJVNMk
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 09:12:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:48997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbYJVNMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 09:12:39 -0400
Received: (qmail invoked by alias); 22 Oct 2008 13:12:34 -0000
Received: from pD9E09255.dip.t-dialin.net (EHLO nixos) [217.224.146.85]
  by mail.gmx.net (mp001) with SMTP; 22 Oct 2008 15:12:34 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+bXOJnCQebkBJ7gwhl7TpYiSwKkyGsaolS1iyb2z
	3UoM9pnB5OX57p
Received: by nixos (sSMTP sendmail emulation); Wed, 22 Oct 2008 15:12:33 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081020235049.GA23120@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98863>

On Mon, Oct 20, 2008 at 07:50:50PM -0400, Jeff King wrote:
> On Mon, Oct 20, 2008 at 04:36:36PM +0200, Marc Weber wrote:
> 
> > Is this desired behaviour?
> > [...]
> >         git init
> >         echo test > test
> >         git add --patch test
> >         echo "running status, nothing has been added"
> >         git status
> 
> I think your example makes sense, but nobody ever really tried it
> before. [..]
I came across this use case because I'm lazy. eg
        git add --patch file-to-be-committed-partly  newfile

is shorter than
        git add --patch file-to-be-committed-partly
        git add newfile



> I use "git add -p" all the time, but almost always when I am
> adding a new file, I add the whole contents.
> 
> I think there are two ways to go about fixing it:
> 
>   - in git-add--interactive.perl, the function patch_update_cmd
>     explicitly looks at the list of modified files. It would have to
>     also check for untracked files, which is easy. But we also need to
>     keep track of which files are modified and which are untracked
>     through the whole patching procedure, which is a bit more invasive.
> 
>   - the recently-added "git add -N" adds an empty file into the index,
>     at which point we could add content in the normal way. So:
> 
>       git add -N test
>       git add -p test
> 
>     should just work (but obviously requires two steps from the user).
>     You could do something more automatic like the patch below, but I
>     think the semantics aren't quite right. If you stage nothing for a
>     newly added file, then you still end up with an empty version of the
>     staged file in the index. I would expect the semantics to be:
> 
>       1. if you stage any content, then the file is added to the index
>          with that content
> 
>       2. if you stage no content, then the file remains untracked

> ---
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> [...]
>  sub patch_update_cmd {
> +	my @new = list_untracked();
> +	if (@new) {
> +		system(qw(git add -N), @new)
> +			and die "git add reported failure";
> +	}
> +
 

I've tried the patch. However I'm not fully satisified.
I often use --patch to have another second look at each change to be
committed. Your patch adds new files to the cache silently without
giving the user the change to omit or edit the patch. But exatly that's
the reason I'm using --patch. So maybe I can work on this in some days..
Maybe I've also injected those lines into the wrong git version 
(1.6.0.2.GIT)

May I try rewriting your semantics proposal to this ?

      1) when using git add --patch untracked-file the user should be
         given the default patch view (only containing + lines)
         so that he can use edit to only commit parts of the file in the
         usual way. (I guess this is similar to having used git add -N
         before, I haven't tried yet)

      2) if he wants to skip the entire patch / file nothing should be
         added to the index.

Thanks for your reply.

Sincerly
Marc Weber
