From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 02:12:50 +0100
Message-ID: <1147137170.2694.58.camel@shinybook.infradead.org>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	 <1147134522.2694.45.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org>
	 <1147136467.2694.53.camel@shinybook.infradead.org>
	 <7v64kgc8ik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eaFnnmEF3675ya6YUVp3"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:13:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGmh-0001Up-R1
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWEIBNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEIBNE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:13:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13535 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751332AbWEIBND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 21:13:03 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FdGmb-00081a-V1; Tue, 09 May 2006 02:13:02 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64kgc8ik.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19803>


--=-eaFnnmEF3675ya6YUVp3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-05-08 at 18:05 -0700, Junio C Hamano wrote:
> That's the replacement of "git format-patch".  If you have a
> chance, please try out what's in "next".  Johannes did quite a
> nice enhancements. 

I think I'd best wait for it to turn up in the release; preferably
already capable of MIME quoting. I don't like touching the scripts which
feed the mailing lists :)

This is what I currently have... since it changes the format I think
I'll won't deploy it yet -- I'll wait until the "replacement of
git-format-patch" is done, in case that would change the format _again_.
I'd rather not change the format I send to the list twice within a few
weeks.

-- 
dwmw2

--=-eaFnnmEF3675ya6YUVp3
Content-Disposition: inline; filename=git-feed-mail-list.sh
Content-Type: application/x-shellscript; name=git-feed-mail-list.sh
Content-Transfer-Encoding: 7bit

#!/usr/bin/env bash
#
# Generate a mail feed for a commits list.
#
# Author: David Woodhouse <dwmw2@infradead.org>

# Environment variables used by this script...
#
# $SENDMAIL and $MLIST must be set appropriately if you intend to
# actually send mail to a mailing list (or other recipient). Otherwise,
# an mbox file named 'git-commits-mail.out' will be created in the 
# current directory.
#
# $FROM specifies the From: header used in the mails. It'll default
# to GIT_COMMITTER_EMAIL if that exists, or to `whoami`@`hostname`
#
# $EXCLUDEHEAD is given as additional arguments to the git-rev-list
# invocation, and is intended to allow other branches to be excluded.
# For example, subsystem trees might avoid mailing changes which were
# merged in from Linus' tree by setting EXCLUDEHEAD=^linus
#
# $GIT_DIR has the obvious effect.
#
# $MAILTAG specifies the file in which the 'last commit mailed' information
# is stored. By default, this will be $GIT_DIR/refs/tags/MailDone, or
# just the relative path '.git/refs/tags/MailDone' if $GIT_DIR is not specified

if [ -z "SENDMAIL" -o -z "$MLIST" ]; then 
    SENDMAIL="tee --append"
    MLIST=git-commits-mail.out
fi

if [ -z "$FROM" ]; then
    if [ -n "$GIT_COMMITTER_EMAIL" ]; then 
	FROM="$GIT_COMMITTER_EMAIL"
    else
	FROM=`whoami`@`hostname`
    fi
fi

if [ -z "$MAILTAG" ]; then
    if [ "$GIT_DIR" = "" ]; then
	MAILTAG=.git/refs/tags/MailDone
    else
	MAILTAG=$GIT_DIR/refs/tags/MailDone
    fi
fi

# Command line arguments. The first specifies the commit or branch to treat
# as HEAD, and the second is the starting commit. Defaults to HEAD and 
# whatever's in $MAILTAG, resp.

if [ -z $2 ]; then
    lastmail=$(git-rev-parse `cat $MAILTAG`)
    if [ -z "$lastmail" ]; then
	echo "No last tag"
	exit 1
    fi
else
    lastmail=$(git-rev-parse $2)
fi

if [ -z $1 ]; then
    base=$(git-rev-parse HEAD) || exit 1
else
    base=$(git-rev-parse $1) || exit 1
fi


if [ "$base" != "$lastmail" ]; then
    git-rev-list --topo-order --no-merges $lastmail..$base $EXCLUDEHEAD | tac |
    while read COMMIT ; do (
	PARENT=`git-rev-parse $COMMIT^1`
	SUBJECT="`git-show --pretty=oneline $COMMIT | head -2 | tail -1`"
	echo Mail: $SUBJECT >&2

	SUBHEX="`echo -n "$SUBJECT" | od -t x1 -A none | tr a-f A-F`"
	if echo $SUBHEX | egrep -q ' [8-9A-F]' ; then
	    # Subject contains non-ASCII.
	    NEWSUB="=?UTF-8?Q?"
	    for CHR in $SUBHEX ; do
		case $CHR in
		    20|3D|3F|8*|9*|A*|B*|C*|D*|E*|F*)
			NEWSUB="$NEWSUB=$CHR"
			;;
		    *)
			NEWSUB="$NEWSUB`echo -en \\\\x$CHR`"
		esac
	    done
	    SUBJECT="$NEWSUB?="
	fi
	cat <<EOF 
From: $FROM
To: $MLIST
Subject: $SUBJECT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Git-Commit: $COMMIT
X-Git-Parent: $PARENT

Commit:     $COMMIT
Parent:     $PARENT
EOF
	git-show -B --patch-with-stat --pretty=fuller $COMMIT | 
	    egrep -v '^diff-tree [A-Fa-f0-9]{40} \(from [A-Fa-z0-9]{40}\)$' 
	) | $SENDMAIL $MLIST
    done

    echo $base > $MAILTAG
fi

--=-eaFnnmEF3675ya6YUVp3--
