From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sat, 24 Feb 2007 23:16:22 +0100
Message-ID: <20070224221622.GA3897@xp.machine.xx>
References: <20070224172037.GA31963@xp.machine.xx> <7vvehrw9mz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 23:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL58p-0003kB-Dd
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 23:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570AbXBXWNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 17:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbXBXWNQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 17:13:16 -0500
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:47252 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S933570AbXBXWNP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 17:13:15 -0500
Received: (qmail 23683 invoked by uid 0); 24 Feb 2007 22:13:12 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 24 Feb 2007 22:13:12 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvehrw9mz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40524>

On Sat, Feb 24, 2007 at 01:03:48PM -0800, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > The documentation mentions "git-diff --cached" to see what is staged for
> > the next commit. But this failes if you haven't done any commits yet.
> > So lets fix it.
> > ...
> > ...  I am
> > not sure if this is the right fix and/or if git-diff-index
> > should also be fixed. I decided against it and let the core
> > cmd git-diff-index stay as it is now.
> 
> I think you decision here is a correct one.  The plumbing level
> command git-diff-index should error out if you do not give a
> tree to compare against.
> 
> My preference for 'git-diff --cached' issue is to fix the
> explanation.  Clearly document that --cached is to review the
> difference between any commit (we could even be more precise to
> say any tree, but I think we should say commit here, as the
> description is at the end-user level) and what is staged for the
> commit that will be created with your next 'git-commit'.  For
> convenience it defaults to 'HEAD', the latest commit on your
> current branch, because that is what people would do most often.
> 

I tend to agree, but I'd like to also have somethin in the spirit of
"log.showroot = true" which handles the diff of the first commit like
diffing against an empty tree. Why should diff --cached differ from
this? At least it is easier to explain, just mention that diff --cached
shows everything which would become the next commit.

> Until you have a commit at HEAD, there really is nothing to diff
> against.  I think "foo is a new entry, no comparison available."
> is one of the very few things that CVS got right.
> 

Hm. But a diff against nothing should show you what you have added :-)

> The bug in the current code is that we do not check if that HEAD
> is sensible when we add it as the default commit to compare
> with.  The error message coming out of the low-level diff-index
> code might be sensible if that 'HEAD' were what the user
> actually gave us, but clearly not the right error message in
> this case.
> 

Here I agree with you. But I guess you know what I would prefere.

-Peter

> ---
> 
>  builtin-diff.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-diff.c b/builtin-diff.c
> index c387ebb..67f4932 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -261,6 +261,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  				break;
>  			else if (!strcmp(arg, "--cached")) {
>  				add_head(&rev);
> +				if (!rev.pending.nr)
> +					die("No HEAD commit to compare with (yet)");
>  				break;
>  			}
>  		}
>
