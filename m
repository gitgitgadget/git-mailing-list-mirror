From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #05; Sat, 16)
Date: Sun, 17 Jan 2010 22:30:49 -0800
Message-ID: <7vd417udpi.fsf@alter.siamese.dyndns.org>
References: <7vljfxa1o6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 07:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWl8m-00066e-V7
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 07:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab0ARGa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 01:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943Ab0ARGa7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 01:30:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0ARGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 01:30:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF21E92443;
	Mon, 18 Jan 2010 01:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6sjKh3Y7xq6uDDLRPwQ9SzpCa4U=; b=p6BQNpheOLDICTPTO6QO1/Y
	GGn8vTZ1y8zONTSQaaf5CS2i7G+4UeBEwnxmiwrL3stsSe5qaS0Ujk8w5TY3CgX3
	WKdxB7cWQqeUWw85AfD9WiNzJVmA/L+kQbVYp49LUiuzutYN3xPOQmkaoDJ0Mk7b
	Lfmh+RBmOWE2ZdzjA1QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=auobJb/C5DH3eKoLkwSN3QSAF6c4LCnGKvLbgexjGeh/vGiIc
	6ZaZvvdn6TBdXgS4Fy5NzXNSsk0aPe8Gco6zKehqMCRlh/RYJHZfcrk8VHhX1dw3
	c1S0c9k3k/FOvwS3rdLfT0kmu8RC1boI8yJ/N5pggFehdLkLHyA87M5PSI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4CA29243F;
	Mon, 18 Jan 2010 01:30:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08F0592438; Mon, 18 Jan
 2010 01:30:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07405826-03FB-11DF-92EB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137370>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * ap/merge-backend-opts (2008-07-18) 6 commits
>  - Document that merge strategies can now take their own options
>  - Extend merge-subtree tests to test -Xsubtree=dir.
>  - Make "subtree" part more orthogonal to the rest of merge-recursive.
>  - Teach git-pull to pass -X<option> to git-merge
>  - git merge -X<option>
>  - git-merge-file --ours, --theirs
>
> "git pull" patch needs sq-then-eval fix to protect it from $IFS
> but otherwise seemed good.

Generally I hate to step in to fix up other's series, especially when I
know that the party responsible for issues is capable enough.  As the
pre-release feature freeze gets closer, however, I sometimes find myself
doing so, and (I repeat) I hate it.

In any case, a squashable update to the "Teach git-pull to pass -X" would
look like this.  Please give it extra set of eyeballs.

diff --git a/git-pull.sh b/git-pull.sh
index 6d961b6..fc3536b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -68,10 +68,10 @@ do
 		1,-X)
 			usage ;;
 		*,-X)
-			xx="-X $2"
+			xx="-X $(git rev-parse --sq-quote "$2")"
 			shift ;;
 		*,*)
-			xx="$1" ;;
+			xx=$(git rev-parse --sq-quote "$1") ;;
 		esac
 		merge_args="$merge_args$xx "
 		;;
@@ -228,8 +228,15 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-test true = "$rebase" &&
-	exec git-rebase $diffstat $strategy_args $merge_args --onto $merge_head \
-	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args $merge_args \
-	"$merge_name" HEAD $merge_head $verbosity
+case "$rebase" in
+true)
+	eval="git-rebase $diffstat $strategy_args $merge_args"
+	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
+	;;
+*)
+	eval="git-merge $diffstat $no_commit $squash $no_ff $ff_only"
+	eval="$eval  $log_arg $strategy_args $merge_args"
+	eval="$eval \"$merge_name\" HEAD $merge_head $verbosity"
+	;;
+esac
+eval "exec $eval"
