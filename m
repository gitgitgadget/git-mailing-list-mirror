From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] git-commit: Disallow unchanged tree in non-merge mode
Date: Wed, 5 Sep 2007 22:25:39 -0400
Message-ID: <20070906022539.GG18160@spearce.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT741-00083m-3P
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbXIFCZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbXIFCZo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:25:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35700 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbXIFCZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:25:43 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT73h-0005oJ-5Y; Wed, 05 Sep 2007 22:25:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 37DC420FBAE; Wed,  5 Sep 2007 22:25:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070905234941.GA643@nomad.office.altlinux.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57801>

"Dmitry V. Levin" <ldv@altlinux.org> wrote:
> Do not commit an unchanged tree in non-merge mode.

A laudable goal.  git-gui also does this.  Turns out the other
checks within git-gui prevent the user from ever getting that far.
I probably should remove the empty tree check as it costs CPU time
to get the old tree.  But I'd rather have the safety check.
 
> The idea is that amend should not commit an unchanged tree,
> one should just remove the top commit using git-reset instead.

NO.  `git commit --amend` is *often* used for fixing the commit
message.  Or adding additional detail.  Forcing the user to do
a `git reset --soft HEAD^ && git commit --amend` just because
you don't want git-commit to make an "empty commit" (which it
doesn't usually like to do now anyway!) is a major step back
in functionality.

NACK.
 
> diff --git a/git-commit.sh b/git-commit.sh
> index 1d04f1f..800f96c 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -629,6 +629,16 @@ then
>  		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git write-tree) &&
>  		rm -f "$TMP_INDEX"
>  	fi &&
> +	if test -n "$current" -a ! -f "$GIT_DIR/MERGE_HEAD"
> +	then
> +		current_tree="$(git cat-file commit "$current${amend:+^}" 2>/dev/null |
> +				sed -e '/^tree \+/!d' -e 's///' -e q)"

The better way to get the old tree would be this:

		current_tree="$(git rev-parse "$current${amend:+^}^{tree}" 2>/dev/null

as it avoids the tool from needing to know about the internal
representation of a commit object.  It also avoids an entire
fork+exec of a sed process.

> +		if test "$tree" = "$current_tree"
> +		then
> +			echo >&2 "nothing to commit${amend:+ (use \"git reset HEAD^\" to remove the top commit)}"

That message is a bad idea.  Doing a mixed mode reset will also
reset the index, causing the user to lose any changes that had
already been staged.  This may actually be difficult for him/her to
recover from if they have used `git add -i` or git-gui to stage only
certain hunks of files, or if their working tree has been further
modified after the commit but they want to go back and amend the
message only of the prior commit.

-- 
Shawn.
