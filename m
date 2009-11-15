From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Document and refuse rebase -s ours
Date: Sun, 15 Nov 2009 13:04:42 -0800
Message-ID: <7veinzfqj9.fsf@alter.siamese.dyndns.org>
References: <7vvdhggote.fsf@alter.siamese.dyndns.org>
 <cover.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mHU-00044F-E2
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbZKOVE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZKOVE5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:04:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZKOVE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:04:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EA969E13A;
	Sun, 15 Nov 2009 16:05:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dn44StVzbZxZVvUnbH/QWWLCBdc=; b=honBB9xDUE62x2J7/ZPTBjA
	hSKPK0bCv5wNQVr3Pa8JzuslmMhbkeLHmU+ySbAo8eXiUEqUvQBY+tuqJcI5CEEM
	B4/883E0vyzLuG9Nn3oxyUNK5AhMh9fiZ/TdYaiOKl0xp8K/dLiJ4WDRI9+NHrhp
	QxcWFjyfbfbwmkW6PSjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=s+wKNoJr7dJ6dDnXeAi5L7sShgu+B3ujVvBk7S0eepX4Ha/Lx
	iksXr4pbj/BTDNVVfMw1MjqKLTmt6ylx6qRdxE7h9J1a5RKmjKVbDVPL5CNtUI2a
	HrB1cF64IOfmvepmLsJ++tPm7m0K2WVPXv2TWUvh+FFOb9JBsEjWsGwZ98=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4FE29E139;
	Sun, 15 Nov 2009 16:04:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D9749E138; Sun, 15 Nov 2009
 16:04:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 861E80BC-D22A-11DE-A942-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132964>

Thomas Rast <trast@student.ethz.ch> writes:

> I also implemented Nicolas's suggestion to reject -s ours outright;
> I'm not really happy with starting a blacklist there, but maybe it
> helps the next unwary user.

I am inclined to agree with you and Nicolas on this, but I'll let the list
decide if [3/3] is a good idea.

I'd rewrite [3/3] in the following way to keep it easier to maintain the
blacklist, like this.

            case "$1" in
    -       ours)
    +       ours | theirs | octopus | subtree)
                    die "Refusing to rebase with $1; see git help rebase."
            esac

It would also make it easier to turn this into a whitelist if we choose
to,

 git-rebase--interactive.sh |    5 +----
 git-rebase.sh              |    5 +----
 git-sh-setup.sh            |    7 +++++++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 53d35f3..de7448b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -571,10 +571,7 @@ first and then run 'git rebase --continue' again."
 			STRATEGY="-s $2"
 			shift ;;
 		esac
-		if test "$STRATEGY" = "-s ours"
-		then
-			die "Refusing to rebase with 'ours' strategy; see git help rebase."
-		fi
+		git_check_merge_strategy_used_in_rebase "${STRATEGY#-s }"
 		;;
 	-m)
 		# we use merge anyway
diff --git a/git-rebase.sh b/git-rebase.sh
index 2d7d566..dd9ec63 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -306,10 +306,7 @@ do
 			strategy="$2"
 			shift ;;
 		esac
-		if test $strategy = ours
-		then
-			die "Refusing to rebase with 'ours' strategy; see git help rebase."
-		fi
+		git_check_merge_strategy_used_in_rebase "$strategy"
 		do_merge=t
 		;;
 	-n|--no-stat)
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c41c2f7..724955f 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -199,3 +199,10 @@ case $(uname -s) in
 	}
 	;;
 esac
+
+git_check_merge_strategy_used_in_rebase () {
+	case "$1" in
+	ours)
+		die "Refusing to rebase with $1; see git help rebase."
+	esac
+}
