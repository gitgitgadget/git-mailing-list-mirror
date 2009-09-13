From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 13:38:48 -0700
Message-ID: <7v1vmar353.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmvqi-0005zw-3g
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbZIMUi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbZIMUi4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:38:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbZIMUiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:38:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A4831956;
	Sun, 13 Sep 2009 16:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yu/XwrdSrNURcl0JaiZo1YWQmFs=; b=AV5QzG
	GOs86+3c+YCMAbpFcVwRDHz0Yn5c8baNma6p+uhvTH/qUw3dEZ1tYGtwkQSTi5oO
	wOTtrzfaIPseF8dOSV1W9HyZTi7P1D6Kh9AHyn1Lyhsm81PW+dIvCapHIsjVtXFJ
	8G1u+JKHFd3McOPh7gXdtZ2q4ClibFI/exnBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KHOu1ikTeOE9MtnrMy2vVHsfXJLdmDQM
	aKPkUadj1m82JTsg2k5vPiBaY82bU969WVO49bOioZHIVFkXAa234c9IKpYWxxX6
	Ctmkt5hlr8RsVUIdzdE0wR1EnzPWCN7wPUGBR966AU6/++XMna1k/gh/LK4klO5F
	EGROCGppTrI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ADCE31955;
	Sun, 13 Sep 2009 16:38:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65D8131954; Sun, 13 Sep
 2009 16:38:50 -0400 (EDT)
In-Reply-To: <20090912211119.GA30966@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Sep 2009 17\:11\:19 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73D14EE6-A0A5-11DE-A09C-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128408>

Jeff King <peff@peff.net> writes:

> I think it is enough for git-pull to just check whether the config
> exists, and if so, guess that the ref was simply not fetched. IOW,
> this:

Thanks.

I saw some discussion on improving the wording.  Here is what I plan to
commit.

diff --git a/git-pull.sh b/git-pull.sh
index 0bbd5bf..2c2fa79 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -89,6 +89,8 @@ error_on_no_merge_candidates () {
 	done
 
 	curr_branch=${curr_branch#refs/heads/}
+	upstream=$(git config "branch.$curr_branch.merge" ||
+			git config "branch.$curr_branch.rebase")
 
 	if [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
@@ -96,7 +98,7 @@ error_on_no_merge_candidates () {
 		echo "Please specify which branch you want to merge on the command"
 		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
-	else
+	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
 		echo "your configuration file does not tell me either.	Please"
@@ -114,6 +116,10 @@ error_on_no_merge_candidates () {
 		echo "    remote.<nickname>.fetch = <refspec>"
 		echo
 		echo "See git-config(1) for details."
+	else
+		echo "Your configuration specifies to merge the ref"
+		echo "'${upstream#refs/heads/}' from the remote, but no such ref"
+		echo "was fetched."
 	fi
 	exit 1
 }
