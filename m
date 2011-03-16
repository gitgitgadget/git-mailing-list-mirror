From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff --quiet: disable optimization when --diff-filter=X is
 used
Date: Wed, 16 Mar 2011 16:09:50 -0700
Message-ID: <7vmxku64sh.fsf_-_@alter.siamese.dyndns.org>
References: <4D80EBC1.7010105@elegosoft.com>
 <7v62ri7oqm.fsf@alter.siamese.dyndns.org>
 <7vwrjy670r.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakob Pfender <jpfender@elegosoft.com>, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 00:10:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzzr0-0002KJ-8a
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 00:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab1CPXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 19:10:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1CPXKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 19:10:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9342842FE;
	Wed, 16 Mar 2011 19:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cWAnZCdBu8YiiKm8Lw3YRQB1qDY=; b=YoB8DV
	Yed9XP+zB7CO4tviYXogGdnwVI7En8+SVyvWyyY6bANcP7PkxuPYCc2yG0ub3Y5W
	hDGUQcbpvgwn9s9jyB9YfbDETJhLpjiwtIgqK7cWdRBapSRRHcaTFXHARE6jdNvB
	HIR293d536zC9GP02u6fggtLplJyhCXY+gytg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3aaIfmm8jgT8MvMw5ovYdFKd8BZwXB3
	G3cO/8fpqEFdfOzhFzJsWCrU1ncVVSQRPUYQIpWUr/bbTC9reJTLmDYrQ4c1ysxr
	bWhC97U9UvNWuSe0q6liiP4slqwJhe82a3y6q8S3H41J75GYSnG8C4oBdbr1k0ub
	wP0OntpTSXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A41B42F8;
	Wed, 16 Mar 2011 19:11:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4E0842F1; Wed, 16 Mar 2011
 19:11:24 -0400 (EDT)
In-Reply-To: <7vwrjy670r.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Mar 2011 15:21:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA15FC5C-5022-11E0-A008-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169208>

The code notices that the caller does not want any detail of the changes
and only wants to know if there is a change or not by specifying --quiet.
And it breaks out of the loop when it knows it already found any change.

When you have a post-process filter (e.g. --diff-filter), however, the
path we found to be different in the previous round and set HAS_CHANGES
bit may end up being uninteresting, and there may be no output at the end.
The optimization needs to be disabled for such case.

Note that the f245194 (diff: change semantics of "ignore whitespace"
options, 2009-05-22) already disables this optimization by refraining
from setting HAS_CHANGES when post-process filters that need to inspect
the contents of the files (e.g. -S, -w) in diff_change() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with tests, on top of 90b1994 (diff: Rename QUIET internal
   option to QUICK, 2009-05-23), which was the last commit in the series
   that introduced the incorrect optimization in the first place.

   Note that the test script was renamed to t/t4040 in today's codebase,
   but it merges cleanly.

 diff-lib.c                   |    3 ++-
 t/t4037-whitespace-status.sh |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b7813af..bfa6503 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -74,7 +74,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		int changed;
 
 		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
-			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
+		    !revs->diffopt.filter &&
+		    DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
 
 		if (!ce_path_match(ce, revs->prune_data))
diff --git a/t/t4037-whitespace-status.sh b/t/t4037-whitespace-status.sh
index a30b03b..abc4934 100755
--- a/t/t4037-whitespace-status.sh
+++ b/t/t4037-whitespace-status.sh
@@ -60,4 +60,11 @@ test_expect_success 'diff-files -b -p --exit-code' '
 	git diff-files -b -p --exit-code
 '
 
+test_expect_success 'diff-files --diff-filter --quiet' '
+	git reset --hard &&
+	rm a/d &&
+	echo x >>b/e &&
+	test_must_fail git diff-files --diff-filter=M --quiet
+'
+
 test_done
-- 
1.7.4.1.430.g5aa4d
