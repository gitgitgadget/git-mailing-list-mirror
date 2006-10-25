X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthew Wilcox <matthew@wil.cx>
Subject: git-merge-subordinate
Date: Wed, 25 Oct 2006 09:50:10 -0600
Message-ID: <20061025155009.GD5591@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 15:50:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30068>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcl1F-0001cz-B2 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 17:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161364AbWJYPuN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWJYPuM
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 11:50:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:46223 "EHLO
 mail.parisc-linux.org") by vger.kernel.org with ESMTP id S1751707AbWJYPuK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 11:50:10 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919) id
 56BFE494006; Wed, 25 Oct 2006 09:50:10 -0600 (MDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Linus doesn't like seeing unnecessary merges in his tree.  I'm not a huge
fan of them either.  Wouldn't it be nice if we had a merge method that
did a merge without creating a merge?  I call it git-merge-subordinate
(since my tree is subordinate to the tree I'm pulling from).  I suppose
you could call it 'slave' if you want to be more pithy.  Anyway, this
is a first attempt, and it's totally cargo-cult programming; I make no
claim that I understand what I'm doing.  But it does seem to work.

While working on it, I found a small bug in git-merge.  When
no_trivial_merge_strategies has more than one component, setting
index_merge to f doesn't work.  So first, here's the patch to git-merge
adding support for 'subordinate':

--- /usr/bin/git-merge	2006-07-29 15:47:09.000000000 -0600
+++ /home/willy/bin/git-merge	2006-10-25 09:21:00.000000000 -0600
@@ -9,15 +9,15 @@
 LF='
 '
 
-all_strategies='recursive octopus resolve stupid ours'
+all_strategies='recursive octopus resolve stupid subordinate ours'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
-no_trivial_merge_strategies='ours'
+no_trivial_merge_strategies='subordinate ours'
 use_strategies=
 
 index_merge=t
 if test ""; then
-	all_strategies='resolve octopus stupid ours'
+	all_strategies='resolve octopus stupid subordinate ours'
 	default_twohead_strategies='resolve'
 fi
 
@@ -154,12 +154,15 @@
 
 for s in $use_strategies
 do
-	case " $s " in
-	*" $no_trivial_merge_strategies "*)
-		index_merge=f
-		break
-		;;
-	esac
+	for t in $no_trivial_merge_strategies
+	do
+		case "$s" in
+		"$t")
+			index_merge=f
+			break
+			;;
+		esac
+	done
 done
 
 case "$#" in


And now, here's the extremely lame git-merge-subordinate script.

#!/bin/sh
#
# Copyright (c) 2005 Linus Torvalds
# Copyright (c) 2005 Junio C Hamano
#
# Resolve two trees, using enhancd multi-base read-tree.

# The first parameters up to -- are merge bases; the rest are heads.
bases= head= remotes= sep_seen=
for arg
do
	case ",$sep_seen,$head,$arg," in
	*,--,)
		sep_seen=yes
		;;
	,yes,,*)
		head=$arg
		;;
	,yes,*)
		remotes="$remotes$arg "
		;;
	*)
		bases="$bases$arg "
		;;
	esac
done

# Give up if we are given more than two remotes -- not handling octopus.
case "$remotes" in
?*' '?*)
	exit 2 ;;
esac

# Give up if this is a baseless merge.
if test '' = "$bases"
then
	exit 2
fi

git-rebase $remotes || exit 2
if result_tree=$(git-write-tree  2>/dev/null)
then
	exit 0
else
	echo "Simple merge failed, trying Automatic merge."
	if git-merge-index -o git-merge-one-file -a
	then
		exit 0
	else
		exit 1
	fi
fi
