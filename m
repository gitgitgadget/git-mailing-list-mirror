From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 15:14:57 -0800
Message-ID: <7vy6yvbki6.fsf@gitster.siamese.dyndns.org>
References: <49382612.3010207@fs.ei.tum.de>
 <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de>
 <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8NQk-0000QC-WE
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 00:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYLDXPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 18:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYLDXPE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 18:15:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbYLDXPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 18:15:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 702F8181ED;
	Thu,  4 Dec 2008 18:15:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE39B181A7; Thu, 
 4 Dec 2008 18:14:58 -0500 (EST)
In-Reply-To: <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Dec 2008 14:33:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60E4C70C-C259-11DD-8A4F-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102375>

Junio C Hamano <gitster@pobox.com> writes:

> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
>
>> You mean not storing/restoring the flags across an invocation?  No,
>> that's a different thing.  My patch only adds the --directory option,
>> it does not fix the previously existing bug.
>
> The question is if it _introduces_ a bug that the directory given in the
> initial invocation of "git am --directory=foo" is lost if an patch does
> not apply and you need to manually resolve and continue.
>
> If it does not introduce such a bug, you do not have the same issue as the
> old patch.  Otherwise you have the same issue as the old patch.  The
> question was if you have the same issue or you don't.  Yes?  No?

I think this fixes the --whitespace=* one, although I obviously haven't
tried to use it myself extensively.

The third hunk is just a style fix.  "am" is written in a quite old
fashioned way.

-- >8 --
Subject: [PATCH] git-am --whitespace: do not lose the command line option

When you start "git am --whitespace=fix" and the patch application process
is interrupted by an unapplicable patch early in the series, after
fixing the offending patch, the remainder of the patch should be processed
still with --whitespace=fix when restarted with "git am --resolved".

The commit 67dad68 (add -C[NUM] to git-am, 2007-02-08) broke this long
time ago.  This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index aa60261..1bf70d4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
+sign= utf8=t keep= skip= interactive= resolved= rebasing= abort= ws=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -156,7 +156,7 @@ do
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+		ws="--whitespace=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
 	--)
@@ -283,7 +283,7 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-ws=`cat "$dotest/whitespace"`
+ws=$(cat "$dotest/whitespace")
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
@@ -454,7 +454,7 @@ do
 
 	case "$resolved" in
 	'')
-		git apply $git_apply_opt --index "$dotest/patch"
+		git apply $git_apply_opt $ws --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
-- 
1.6.1.rc1.60.g1d1d7
