From: David Woodhouse <dwmw2@infradead.org>
Subject: git-feed-mail-list.sh
Date: Wed, 03 May 2006 18:48:33 +0100
Message-ID: <1146678513.20773.45.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wjLeBdp/bnI4SNQ3IXqQ"
X-From: git-owner@vger.kernel.org Wed May 03 19:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLSs-00083S-UU
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWECRsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWECRsj
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:48:39 -0400
Received: from canuck.infradead.org ([205.233.218.70]:63914 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030272AbWECRsi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 13:48:38 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FbLSm-0002ox-4O
	for git@vger.kernel.org; Wed, 03 May 2006 13:48:37 -0400
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19508>


--=-wjLeBdp/bnI4SNQ3IXqQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've just updated the script which feeds the
git-commits-{head,24}@vger.kernel.org lists -- it now looks like this...

- Git-only; no longer uses cg-*
- No longer uses its own clone repo -- works directly from the original
- Handles MIME encoding of Subject: headers when necessary
  (although this is a bit icky in shell; especially _my_ shell).

Should I be using git-format-patch for this?

-- 
dwmw2

--=-wjLeBdp/bnI4SNQ3IXqQ
Content-Description: 
Content-Type: application/x-shellscript
Content-Disposition: inline; filename=git-feed-mail-list.sh
Content-Transfer-Encoding: 7bit

#!/usr/bin/env bash
#
# Generate a mail feed for a commits list.
#
# Based on 'gitlog.sh' originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
#
# Takes an id resolving to a commit to start from (HEAD by default).

# regex for parent declarations
PARENTS="^parent [A-Za-z0-9]{40}$"

TMPCL=$(mktemp -t gitmail.XXXXXX)
TMPCM=$(mktemp -t gitmail.XXXXXX)
TMPML=$(mktemp -t gitmail.XXXXXX)
TMPMD=$(mktemp -td gitmail.XXXXXX)

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
# EXCLUDEHEAD is given as additional arguments to the git-rev-list
# invocation, and is intended to allow other branches to be excluded.
# For example, subsystem trees might avoid mailing changes which were
# merged in from Linus' tree by setting EXCLUDEHEAD=^linus
#
# GIT_DIR has the obvious effect.
#
# MAILTAG specifies the file in which the 'last commit mailed' information
# is stored. By default, this will be $GIT_DIR/refs/tags/MailDone, or
# just the relative path '.git/refs/tags/MailDone if $GIT_DIR is not specified


# Unless configured otherwise, just cat it instead of mailing.
if [ -z "$FROM" ]; then
    if [ -z "$GIT_COMMITTER_EMAIL" ]; then 
	FROM="$GIT_COMMITTER_EMAIL"
    else
	FROM=`whoami`@`hostname`
    fi
fi

if [ -z "SENDMAIL" -o -z "$MLIST" ]; then 
    SENDMAIL="tee --append"
    MLIST=git-commits-mail.out
fi

if [ -z "$MAILTAG" ]; then
    if [ "$GIT_DIR" = "" ]; then
	MAILTAG=.git/refs/tags/MailDone
    else
	MAILTAG=$GIT_DIR/refs/tags/MailDone
    fi
fi


# takes an object and generates the object's parent(s)
createmail () {
    local commit

    commit=$1

    git-cat-file commit $commit > $TMPCM

    while read key rest; do
	case "$key" in
	    "")
		read SUBJECT
		echo ""
		echo "$SUBJECT"
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
		cat
		break;
		;;
	    
	    "parent")
		parent=$rest
		echo "$key $rest"
		;;

	    "author"|"committer")
		date=(${rest#*> })
		sec=${date[0]}; tz=${date[1]}
		dtz=${tz/+/+ }; dtz=${dtz/-/- }
		pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
		if [ "$pdate" ]; then
		    echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
		else
		    echo "$key $rest"
		fi
		;;
	    
	    *)
		echo "$key $rest"
		;;
	esac
    done > $TMPML < $TMPCM
    
    (
	cat <<EOF 
From: $FROM
To: $MLIST
Subject: $SUBJECT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Git-Commit: $commit
X-Git-Parent: $parent

commit $commit
EOF
	cat $TMPML
	echo
	git-diff -B $parent $commit > $TMPCM
	diffstat -p1 $TMPCM 2>/dev/null
	echo 
	cat $TMPCM
    ) > $TMPMD/$commit
    echo Mail: $SUBJECT
}

base=$(git-rev-parse $1)

if [ -z $2 ]; then
    lastmail=`cat $MAILTAG`
else
    lastmail=$(git-rev-parse $2)
fi

#if [ -z $3 ]; then
#    tagname=`ls -rt .git/refs/tags | grep -v MailDone | tail -1`
#    release=`cat .git/refs/tags/$tagname`
#else
#    release=$(gitXnormid.sh -c $3)
#fi    

if [ -z $1 ]; then
    base=$(git-rev-parse HEAD) || exit 1
else
    base=$(git-rev-parse $1) || exit 1
fi


if [ "$base" != "$lastmail" ]; then
    git-rev-list --topo-order --no-merges $lastmail..$base $EXCLUDEHEAD > $TMPCL

    cat $TMPCL | while read commit ; do createmail $commit ; done

    # No 'cg-tag -F' -- cheat.
    echo $base > $MAILTAG
    tac $TMPCL | while read commit; do
	if [ -r "$TMPMD/$commit" ]; then
	    $SENDMAIL $MLIST < $TMPMD/$commit
	fi
    done
fi
rm $TMPCL $TMPCM $TMPML
rm -rf $TMPMD

--=-wjLeBdp/bnI4SNQ3IXqQ--
