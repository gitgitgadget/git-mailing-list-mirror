From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 15:55:53 -0400
Message-ID: <20080612195553.GK13626@fieldses.org>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com> <alpine.DEB.1.00.0806101632570.1783@racer> <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com> <alpine.DEB.1.00.0806112000400.1783@racer> <4850E647.7050602@trolltech.com> <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6suu-0005im-5p
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYFLT4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYFLT4I
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:56:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33828 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbYFLT4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:56:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1K6stl-0005Fe-If; Thu, 12 Jun 2008 15:55:53 -0400
Content-Disposition: inline
In-Reply-To: <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84778>

On Thu, Jun 12, 2008 at 12:33:01PM -0700, Junio C Hamano wrote:
> Marius Storm-Olsen <marius@trolltech.com> writes:
> 
> > Johannes Schindelin said the following on 11.06.2008 21:06:
> >> On Wed, 11 Jun 2008, Marius Storm-Olsen wrote:
> >>> Well, consider this:
> >>>
> >>> Say you are merging two branches, and know that you want to just
> >>> use the parts which conflict from the branch being merged in. Then
> >>> you simply do:
> >>>
> >>> 	git merge side
> >>> 	git show :3:file.txt > file.txt
> >>
> >> This is not really how I would do things.  I would do
> >>
> >> 	git checkout side file.txt here.
> >
> > Uhm, 'git checkout side file.txt' is not the same file content
> > (ignoring EOLs please) as 'git show :3:file.txt'.
> > Ref: user-manual.html#conflict-resolution
> 
> Bruce, I think the comment in this quoted section is wrong.
> 
> True, the combined diff can show only the interesting differences between
> the three, but that is not because we munge stage #2 and #3.  They contain
> verbatim copies from the HEAD and the MERGE_HEAD respectively, and the
> combining logic runs three-way diffs between the three stages to discard
> the hunks that the result comes solely from either stage #2 or stage #3.

Oops, thanks for catching that!  I don't know how I got the idea it
worked that way.

(Is there any advantage, then, to the :n:filename syntax to a user?
Is it useful in any cases when they couldn't use HEAD or MERGE_HEAD
instead?  If not I might be tempted to cut this bit entirely (or
postpone it till later.)

--b.

> 
> So perhaps something like this is in order...
> 
> ---
> 
>  Documentation/user-manual.txt |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index bfde507..64a820b 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1254,16 +1254,15 @@ these three "file stages" represents a different version of the file:
>  
>  -------------------------------------------------
>  $ git show :1:file.txt	# the file in a common ancestor of both branches
> -$ git show :2:file.txt	# the version from HEAD, but including any
> -			# nonconflicting changes from MERGE_HEAD
> -$ git show :3:file.txt	# the version from MERGE_HEAD, but including any
> -			# nonconflicting changes from HEAD.
> +$ git show :2:file.txt	# the version from HEAD.
> +$ git show :3:file.txt	# the version from MERGE_HEAD.
>  -------------------------------------------------
>  
> -Since the stage 2 and stage 3 versions have already been updated with
> -nonconflicting changes, the only remaining differences between them are
> -the important ones; thus linkgit:git-diff[1] can use the information in
> -the index to show only those conflicts.
> +When you ask linkgit:git-diff[1] to show the conflicts, it runs a
> +three-way diff between the conflicted merge results in the work tree with
> +stages 2 and 3 to show only hunks whose contents come from both sides,
> +mixed (in other words, when a hunk's merge results come only from stage 2,
> +that part is not conflicting and is not shown.  Same for stage 3).
>  
>  The diff above shows the differences between the working-tree version of
>  file.txt and the stage 2 and stage 3 versions.  So instead of preceding
