From: Junio C Hamano <junkio@cox.net>
Subject: Re: simple git repository browser with vim
Date: Thu, 24 Nov 2005 02:28:07 -0800
Message-ID: <7v8xveuyq0.fsf@assigned-by-dhcp.cox.net>
References: <20051124093322.GA3899@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:30:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfELB-0004bq-2l
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 11:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKXK2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 05:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVKXK2J
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 05:28:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57992 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750800AbVKXK2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 05:28:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124102725.HDJT20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 05:27:25 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051124093322.GA3899@mail.yhbt.net> (Eric Wong's message of
	"Thu, 24 Nov 2005 01:33:22 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12701>

Eric Wong <normalperson@yhbt.net> writes:

> It relies on a simple shell script I wrote called 'git-show' that picks
> a reasonable way to display each of the blob, tree, or commit object
> types.  I'm fairly sure somebody else has written something like
> git-show before, I just couldn't find it.  I'd imagine it's pretty
> useful standalone without vim, too.

Aha.

It strikes me that the blob case could be enhanced to do
git-unpack-file, run "file -i" on it to figure out the file's
mimetype, and then give it to an appropriate MIME type viewer
;-).

For a tag object, you might want to deref it, and also if it is
a signed kind, you may want to do git-verify-tag it.

The following should not taken too seriously, but you might find
it instructive to learn how to unwrap tag objects, verify them
for signature, and pretty-print a single commit without running
whatchanged.  I suspect the script as posted by you shows the
commit message twice, BTW.

-- >8 --
#!/bin/sh

extract_tag_info='
	s/^object /sha1=/p
        /^type /{
        	s//type=/
                p
                q
	}
'
for sha1
do
    type=`git-cat-file -t "$sha1"` || continue
    while case "$type" in tag) ;; *) break ;; esac
    do
	echo "*** tag $sha1 ***"
        git-cat-file tag "$sha1"
	git-verify-tag "$sha1"
	echo
	eval `git-cat-file tag "$sha1" | sed -n -e "$extract_tag_info"`
    done
    case "$type" in
    tree)
        echo "*** $type $sha1 ***"
        git-ls-tree -r "$sha1"
        ;;
    blob)
        temp=`git-unpack-file "$sha1"`
	mimetype=`file -i "$temp" | sed -e 's/^[^:]*: *//'`
        echo "*** $type ($mimetype) $sha1 ***"
	case "$mimetype" in
        image/*)
        	display "$temp" ;;
	audio/*)
        	cat "$temp" >/dev/audio ;; # sorry I do not do audio
        text/html)
        	links -dump "$temp" ;; # hello, Pasky
	*)
		cat "$temp" ;;
	esac
        rm -f $temp
        ;;
    commit)
        echo "*** $type $sha1 ***"
        git-diff-tree --pretty -m -C --find-copies-harder -p "$sha1"
        ;;
    esac
    echo
done
