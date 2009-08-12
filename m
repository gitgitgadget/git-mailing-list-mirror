From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 15:49:56 -0700
Message-ID: <7vab24ve97.fsf@alter.siamese.dyndns.org>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
 <20090812075833.GF15152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbMeB-00019g-7e
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 00:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZHLWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 18:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbZHLWuG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 18:50:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZHLWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 18:50:05 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EF128F4F;
	Wed, 12 Aug 2009 18:50:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F4DB8F49; Wed, 12 Aug
 2009 18:49:58 -0400 (EDT)
In-Reply-To: <20090812075833.GF15152@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 12 Aug 2009 03\:58\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 790646A4-8792-11DE-8B89-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125755>

Jeff King <peff@peff.net> writes:

> Yeah, I think that is a better idea. Do you want to tweak the patch, or
> should I re-submit?

I'll do this then.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 11 Aug 2009 23:27:40 -0400
Subject: [PATCH] Subject: [PATCH] allow pull --rebase on branch yet to be born

When doing a "pull --rebase", we check to make sure that the index and
working tree are clean. The index-clean check compares the index against
HEAD. The test erroneously reports dirtiness if we don't have a HEAD yet.

In such an "unborn branch" case, by definition, a non-empty index won't
be based on whatever we are pulling down from the remote, and will lose
the local change.  Just check if $GIT_DIR/index exists and error out.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-pull.sh     |   18 +++++++++++++-----
 t/t5520-pull.sh |   11 +++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0f24182..0bbd5bf 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -119,11 +119,19 @@ error_on_no_merge_candidates () {
 }
 
 test true = "$rebase" && {
-	git update-index --ignore-submodules --refresh &&
-	git diff-files --ignore-submodules --quiet &&
-	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
-	die "refusing to pull with rebase: your working tree is not up-to-date"
-
+	if ! git rev-parse -q --verify HEAD >/dev/null
+	then
+		# On an unborn branch
+		if test -f "$GIT_DIR/index"
+		then
+			die "updating an unborn branch with changes added to the index"
+		fi
+	else
+		git update-index --ignore-submodules --refresh &&
+		git diff-files --ignore-submodules --quiet &&
+		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
+		die "refusing to pull with rebase: your working tree is not up-to-date"
+	fi
 	oldremoteref= &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e78d402..dd2ee84 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -149,4 +149,15 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 '
 
+test_expect_success 'pull --rebase works on branch yet to be born' '
+	git rev-parse master >expect &&
+	mkdir empty_repo &&
+	(cd empty_repo &&
+	 git init &&
+	 git pull --rebase .. master &&
+	 git rev-parse HEAD >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.4.196.gd1fd8
