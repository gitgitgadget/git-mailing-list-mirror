From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 00:44:36 +0100
Message-ID: <1147131877.2694.37.camel@shinybook.infradead.org>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-PAUELfR5bJaAQu5yN4jK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 01:44:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFPL-0007FE-2O
	for gcvg-git@gmane.org; Tue, 09 May 2006 01:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWEHXow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWEHXow
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 19:44:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750891AbWEHXov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 19:44:51 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FdFPF-00073W-RM; Tue, 09 May 2006 00:44:50 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19784>


--=-PAUELfR5bJaAQu5yN4jK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-05-03 at 21:35 -0700, Junio C Hamano wrote:
> If you were to do bashism local, don't you want to also localize
> other variables like key, SUBHEX, NEWSUB,...?
> 
> It may make sense to enhance format-patch to do the Q encoding,
> so that you do not have to do this part by hand... 

Yes, that would be useful. We should perhaps to the From: and To:
headers too. Here's my current version (thanks for the feedback)...

The remaining problem is that the invocation of 'date' doesn't work with
new versions of coreutils. This...

   date=(${rest#*> })
   sec=${date[0]}; tz=${date[1]}
   dtz=${tz/+/+ }; dtz=${dtz/-/- }
   pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"

... doesn't work any more on FC-5, because:

 $ date -Rud '1970-01-01 UTC + 1147104611 sec + 0100'
date: invalid date `1970-01-01 UTC + 1147104611 sec + 0100'

-- 
dwmw2

--=-PAUELfR5bJaAQu5yN4jK
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
    while read commit ; do 
      ( git-cat-file commit $commit | while read key rest; do

	case "$key" in
	    "parent"|"tree")
		eval $key="$rest"
		;;

	    "author"|"committer")
		date=(${rest#*> })
		sec=${date[0]}; tz=${date[1]}
		dtz=${tz/+/+ }; dtz=${dtz/-/- }
		pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
		if [ "$pdate" ]; then
		    eval $key=\"`echo $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"`\"
		else
		    eval $key=\"$rest\"
		fi
		;;
	    
	    "")
		read SUBJECT
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
		    SUBJHDR="$NEWSUB?="
		else
		    SUBJHDR="$SUBJECT"
		fi
		cat <<EOF 
From: $FROM
To: $MLIST
Subject: $SUBJHDR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Git-Commit: $commit
X-Git-Parent: $parent

commit $commit
parent $parent
tree $tree
author $author
committer $committer

$SUBJECT
EOF
		# Now the rest of the commit comments
		cat
		echo
		# ... and then the patch itself
		git-diff --patch-with-stat $parent $commit
		echo Mail: $SUBJECT >&2

		break;
		;;
	    
            *)
		# Ignore unknown headers.
		;;
	esac
      done # each header
    
      ) | $SENDMAIL $MLIST
    
    done # each commit

    echo $base > $MAILTAG
fi

--=-PAUELfR5bJaAQu5yN4jK--
