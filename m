From: Eric Wong <normalperson@yhbt.net>
Subject: Re: simple git repository browser with vim
Date: Sat, 26 Nov 2005 14:05:17 -0800
Message-ID: <20051126220517.GC3899@mail.yhbt.net>
References: <20051124093322.GA3899@mail.yhbt.net> <7v8xveuyq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 23:06:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg8Ae-0003fI-1N
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 23:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKZWFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKZWFS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 17:05:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9611 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750759AbVKZWFR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 17:05:17 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 2F4B22DC033; Sat, 26 Nov 2005 14:05:17 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xveuyq0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12788>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > It relies on a simple shell script I wrote called 'git-show' that picks
> > a reasonable way to display each of the blob, tree, or commit object
> > types.  I'm fairly sure somebody else has written something like
> > git-show before, I just couldn't find it.  I'd imagine it's pretty
> > useful standalone without vim, too.
> 
> Aha.
> 
> It strikes me that the blob case could be enhanced to do
> git-unpack-file, run "file -i" on it to figure out the file's
> mimetype, and then give it to an appropriate MIME type viewer
> ;-).

Maybe somebody else will find this useful, overkill for me.

> For a tag object, you might want to deref it, and also if it is
> a signed kind, you may want to do git-verify-tag it.

This is pretty useful, I've added it to my version, and also added
extra vim foldmarkers for the dereferenced tag.

> The following should not taken too seriously, but you might find
> it instructive to learn how to unwrap tag objects, verify them
> for signature, and pretty-print a single commit without running
> whatchanged.  I suspect the script as posted by you shows the
> commit message twice, BTW.

That was semi-intentional, I wanted the short diff format with the
sha1sums of the blobs so I could further expand those inside vim.
Fortunately, I've figured out that diff-tree is better for this.

Here's what I'm currently using:
--- 

#!/bin/sh

extract_tag_info='
        s/^object /sha1=/p
        /^type /{
                s//type=/
                p
                q
        }
'
sha1sums=
while : ; do
	case "$1" in
	-f|--fold-marker)
		fold_marker=1
		;;
	*)
		sha1sums="$sha1sums $1"
		break
		;;
	esac
	shift
done

for sha1 in $sha1sums
do
	type=`git-cat-file -t $sha1` || continue
	
	test -n "$fold_marker" && echo "$type($1) {{{"
	
	while case "$type" in tag) ;; *) break ;; esac
	do
		git-cat-file tag "$sha1"
		git-verify-tag "$sha1"
		test -n "$fold_marker" && echo '}}}'
 		
		eval `git-cat-file tag "$sha1" | sed -n -e "$extract_tag_info"`
		
		test -n "$fold_marker" && echo "$type($1) {{{"
	done
	
	case "$type" in
	tree)
		git-ls-tree -r "$sha1"
		;;
	blob)
		git-cat-file blob "$sha1"
		;;
	commit)
         	git-diff-tree --pretty=raw -r -m -C --find-copies-harder "$sha1"
		
		test -n "$fold_marker" && echo "commit_diff($1) {{{"

        	git-diff-tree -m -C --find-copies-harder -p "$sha1"
		
		test -n "$fold_marker" && echo '}}}'
		;;
	esac

	test -n "$fold_marker" && echo '}}}'
done
