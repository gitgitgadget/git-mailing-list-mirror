From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Thu, 24 Feb 2011 16:13:28 +0100
Message-ID: <20110224151328.GB14720@neumann>
References: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:13:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pscsr-0001Ro-Ga
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab1BXPNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 10:13:31 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:14064 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab1BXPNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 10:13:31 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 24 Feb
 2011 16:13:27 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 24 Feb
 2011 16:13:28 +0100
Content-Disposition: inline
In-Reply-To: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167823>

Hi,


On Wed, Feb 23, 2011 at 01:43:08PM -0800, Junio C Hamano wrote:
> While doing a final sanity check before merging a topic Bsomething, it is
> a good idea to review what damage Bsomething branch would make, by running:
> 
>     $ git diff ...Bsomething
> 
> I however find myself often typing "git diff ...B<TAB>", seeing nothing
> happening and then repeatedly hitting <TAB>, saying "huh? <TAAAAAAAAB>!".
> 
> This change would hopefully help me, and others like me.

I agree that this would be a good change ...

> Even though there is no point in supporting "git diff A..B" (you can say
> "git diff A B" just fine), but reusing complete-revlist was the easiest
> and that form is supported as a benign but not so useful side effect.

... and this side effect is nothing to worry about, ...

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I sent this out a while ago and have been using it ever since, but
>    totally forgot about it.  Likes, dislikes, alternatives?
> 
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 64341d5..cf56514 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1137,7 +1137,7 @@ _git_diff ()
>  		return
>  		;;
>  	esac
> -	__git_complete_file
> +	__git_complete_revlist

... but I don't think this is the right solution, because it
introduces a regression.

There is this 'ref:file' notation (as in 'git show master:README', but
I don't know the proper term for it), which is understood by
__git_complete_file(), and can be useful for 'git diff', e.g. to
compare a file in two branches when the file was renamed in between:

  git diff branchA:old branchB:new

However, __git_complete_revlist() doesn't understand this notation,
and does plain filename completion after the ':', i.e. it lists all
files and dirs in the current worktree including untracked files, not
just the files that are actually present in the given ref, breaking
the completion for 'git diff branchA:o<TAB>'.

How about teaching __git_complete_file() to offer refs after '...'
instead?  It wouldn't make sense for any other commands for which we
use __git_complete_file() in the completion script, but the users
wouldn't write '...' for those commands anyway, so this is in the same
"benign but not so useful side effect" category.  But for 'git diff'
it would allow the completion of both 'git diff ...B<TAB>' and 'git
diff branch:o<TAB>'.

I mean something like this, but didn't test it that much.  The first
hunk is just a sanity check to prevent invoking 'git ls-tree' in case
the user does 'git diff ...branch:o<TAB>', because it would trigger
some error messages by 'git ls-tree', and would later cause an error
in 'git diff' anyway.


diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..2b02505 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -667,6 +667,9 @@ __git_complete_file ()
 	local pfx ls ref cur
 	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
+	*...?*:*)
+		return
+		;;
 	?*:*)
 		ref="${cur%%:*}"
 		cur="${cur#*:}"
@@ -705,6 +708,11 @@ __git_complete_file ()
 				       s/^.*	//')" \
 			-- "$cur"))
 		;;
+	*...*)
+		pfx="${cur%...*}..."
+		cur="${cur#*...}"
+		__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		;;
 	*)
 		__gitcomp "$(__git_refs)"
 		;;
