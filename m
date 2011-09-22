From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] request-pull: state what commit to expect
Date: Thu, 22 Sep 2011 15:09:21 -0700
Message-ID: <1316729362-7714-6-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSo-0007M2-EM
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab1IVWJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab1IVWJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 016C76EDE
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=P47Y
	X4ERTiTrnkuZvj8XDqpuDbE=; b=VIw6wHJRPS6t4Gu1MpLcSGKXFYBe5HvaX8uc
	JTCq5MFNqXB7uRaJUzooLnBH2cJt0H944w4THM90xar8eseVqTNQMjuUAN8+3vRx
	pJ8cBV2fRxEeS77221XolxQtyogvXroGjCKx6S3Qkyy3gpvI8aBEVwUBQ4Cl54Mv
	5h1EG7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Pomt8X
	aqN46Ml9VcRpvuszIe8ABIMzttEKeH+yeXe9/QDOTtj9ElVdgZsarICTGCqAKHeo
	Kr5hyUa7bft2vdvPsg8RQaIYHewn4dBTLSgwwP4eDPvYc5ZPa30z/tdxny6ovHX+
	+f7YhLircfCjvfqgD74ZOEqqEzq3NcyASA6Ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE4D06EDD
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65FDF6ED9 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8D308B8C-E567-11E0-A77F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181928>

The message gives a detailed explanation of the commit the requester based
the changes on, but lacks information that is necessary for the person who
performs a fetch & merge in order to verify that the correct branch was
fetched when responding to the pull request.

Add a few more lines to describe the commit at the tip expected to be
fetched to the same level of detail as the base commit.

Also update the warning message slightly when the script notices that the
commit may not have been pushed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh     |   34 +++++++++++++++++++---------------
 t/t5150-request-pull.sh |    6 ++++++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index afb75e8..438e7eb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -35,7 +35,7 @@ do
 	shift
 done
 
-base=$1 url=$2 head=${3-HEAD}
+base=$1 url=$2 head=${3-HEAD} status=0
 
 test -n "$base" && test -n "$url" || usage
 baserev=$(git rev-parse --verify "$base"^0) &&
@@ -51,25 +51,29 @@ find_matching_branch="/^$headrev	"'refs\/heads\//{
 }'
 branch=$(git ls-remote "$url" | sed -n -e "$find_matching_branch")
 url=$(git ls-remote --get-url "$url")
-if test -z "$branch"
-then
-	echo "warn: No branch of $url is at:" >&2
-	git log --max-count=1 --pretty='tformat:warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed $head there?" >&2
-	echo >&2
-	echo >&2
-	branch=..BRANCH.NOT.VERIFIED..
-	status=1
-fi
 
 git show -s --format='The following changes since commit %H:
 
   %s (%ci)
 
-are available in the git repository at:' $baserev &&
-echo "  $url $branch" &&
-echo &&
+are available in the git repository at:
+' $baserev &&
+echo "  $url${branch+ $branch}" &&
+git show -s --format='
+for you to fetch changes up to %H:
+
+  %s (%ci)
+
+----------------------------------------------------------------' $headrev &&
 
 git shortlog ^$baserev $headrev &&
-git diff -M --stat --summary $patch $merge_base..$headrev || exit
+git diff -M --stat --summary $patch $merge_base..$headrev || status=1
+
+if test -z "$branch"
+then
+	echo "warn: No branch of $url is at:" >&2
+	git show -s --format='warn:   %h: %s' $headrev >&2
+	echo "warn: Are you sure you pushed '$head' there?" >&2
+	status=1
+fi
 exit $status
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 9cc0a42..5bd1682 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -193,8 +193,14 @@ test_expect_success 'pull request format' '
 	  SUBJECT (DATE)
 
 	are available in the git repository at:
+
 	  URL BRANCH
 
+	for you to fetch changes up to OBJECT_NAME:
+
+	  SUBJECT (DATE)
+
+	----------------------------------------------------------------
 	SHORTLOG
 
 	DIFFSTAT
-- 
1.7.7.rc2.4.g5ec82
