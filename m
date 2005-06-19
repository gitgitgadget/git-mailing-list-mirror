From: Jeff Garzik <jgarzik@pobox.com>
Subject: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 12:27:35 -0400
Message-ID: <42B59CF7.3080509@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030001010500000207060104"
X-From: git-owner@vger.kernel.org Sun Jun 19 18:22:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk2Yg-0005yL-Sm
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 18:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVFSQ1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 12:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVFSQ1s
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 12:27:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22166 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262263AbVFSQ1j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 12:27:39 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dk2e2-00007i-9F
	for git@vger.kernel.org; Sun, 19 Jun 2005 16:27:38 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001010500000207060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I just checked in a change with 'git commit' (no arguments).  Two 
strange things occurred:

1) git-whatchanged does not list the change at all.  However,
	a) I verified that my change is indeed top-of-tree
	b) git-changes-script (attached) does show the change

2) git-changes-script shows the parents in a readable fashion, and it 
shows two duplicate parent entries.  In contrast, other changes do not 
have two parents:

my change:
> commit 4864989199fa62c7044be2258550ddc561411ab6
		^^^ top of tree aka .git/HEAD
> tree b40996c7a0a5446875aa3664045af7e377451bf6
> parent 7df551254add79a445d2e47e8f849cef8fee6e38
> parent 7df551254add79a445d2e47e8f849cef8fee6e38
> author Jeff Garzik <jgarzik@pretzel.yyz.us> Sun, 19 Jun 2005 20:06:28 -0400
> committer Jeff Garzik <jgarzik@pobox.com> Sun, 19 Jun 2005 20:06:28 -0400
> 
> fc4/fc:  fix warnings/errors caused by recent changes

a random change not committed by 'git commit':
> commit 7df551254add79a445d2e47e8f849cef8fee6e38
> tree 468a43ac3f94b9bf8618b102a7d609e29d3900f5
> parent f7d7fc0322c1770fe7ee836ca2732c2f88e2e1a4
> author David S. Miller <davem@davemloft.net> Sun, 19 Jun 2005 13:01:10 -0700
> committer David S. Miller <davem@davemloft.net> Sun, 19 Jun 2005 13:01:10 -0700
> 
> [TCP]: Fix sysctl_tcp_low_latency
> 
> When enabled, this should disable UCOPY prequeue'ing altogether,
> but it does not due to a missing test.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>



--------------030001010500000207060104
Content-Type: text/plain;
 name="git-changes-script"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-changes-script"

#!/bin/bash
#
# Make a log of changes in a GIT branch.
#
# This script was originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
# Rendered trivial by Linus Torvalds.
# Added -L|-R option by James Bottomley
#
# options:
# script [-L <dir> | -R <dir> |-r <from_sha1> [ -r <to_sha1] ] [<sha1>]
#
# With no options shows all the revisions from HEAD to the root
# -L shows all the changes in the local tree compared to the tree at <dir>
# -R shows all the changes in the remote tree at <dir> compared to the local
# -r shows all the changes in one commit or between two

tmpfile=/tmp/git_changes.$$
r1=
r2=

showcommit() {
	commit="$1"
	echo commit ${commit%:*};
	git-cat-file commit $commit | \
		while read key rest; do
			case "$key" in
			"author"|"committer")
				date=(${rest#*> })
				sec=${date[0]}; tz=${date[1]}
				dtz=${tz/+/+ }; dtz=${dtz/-/- }
				pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
				if [ "$pdate" ]; then
					echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
				else
					echo $key $rest
				fi
				;;
			"")
				echo; cat
				;;
			*)
				echo $key $rest
				;;
			esac

		done
}

while true; do
	case "$1" in
		-R)	shift;
			diffsearch=+
			remote="$1"
			shift;;
		-L)	shift;
			diffsearch=-
			remote="$1"
			shift;;
		-r)	shift;
			if [ -z "$r1" ]; then
				r1="$1"
			else
				r2="$1"
			fi
			shift;;
		*)	base="$1"
			break;;
	esac
done

if [ -n "$r1" ]; then
	if [ -z "$r2" ]; then
		showcommit $r1
		exit 0
	fi
	diffsearch=+
	remote=`pwd`;
	tobase="$r2";
	base="$r1"
fi
	
if [ -z "$base" ]; then
	base=$(cat .git/HEAD) || exit 1
fi

git-rev-tree $base | sort -rn  > ${tmpfile}.base
if [ -n "$remote" ]; then
	[ -d $remote/.git ] || exit 1
	if [ -z "$tobase" ]; then
		tobase=$(cat $remote/.git/HEAD) || exit 1
	fi
	pushd $remote > /dev/null
	git-rev-tree $tobase | sort -rn > ${tmpfile}.remote
	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
	rm -f ${tmpfile}.base ${tmpfile}.remote
	mv ${tmpfile}.diff ${tmpfile}.base
	if [ $diffsearch = "-" ]; then
		popd > /dev/null
	fi
fi

[ -s "${tmpfile}.base" ] || exit 0

cat ${tmpfile}.base | while read time commit parents; do
	showcommit $commit
	echo -e "\n--------------------------"

done
rm -f ${tmpfile}.base

--------------030001010500000207060104--
