From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] request-pull: use the branch description
Date: Thu, 22 Sep 2011 15:09:22 -0700
Message-ID: <1316729362-7714-7-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSn-0007M2-RD
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1IVWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab1IVWJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1AEF6EE4
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uMq5
	6uVb4rBAYsKLRdPY/K0q8aE=; b=MpDH4MLzTDUyjUjkNTr6egpA8glbXOPVo3Dp
	ZDmFdmBUTB52SAgc+BDHrLLm4x7UHrwmiQFvYkR9eGcQrQTnKm1s3rAjVx7z2C6h
	0v8pBy4HVG925EmWnJtAK3P7cnOqqSvvWqelLaHDt7rkgSjs0Fj2lQkVkOy7SsNG
	Hubns4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kztNI8
	FRIDfh1NOcy7uYkVftenqQA6OEOnxqlSK4V0249pfQjQOEfFLZwUZ1poO6yxX++K
	E6Lzx5PldKi1X+qaCNrImeatpDTBDWIQUo99lUxtDrO2UcVelamNQbXH1tYu2Hz8
	NGCjmrx7iGMZS5Fwo+dByaP7RR2vLBeXRMYOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAEAF6EE3
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 487B66EE0 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8E4F45DA-E567-11E0-955C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181924>

Now we have branch descriptions stored in the repository, we can
use it when preparing the request-pull message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 438e7eb..626cf25 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -35,7 +35,18 @@ do
 	shift
 done
 
-base=$1 url=$2 head=${3-HEAD} status=0
+base=$1 url=$2 head=${3-HEAD} status=0 branch_name=
+
+headref=$(git symbolic-ref -q "$head")
+if git show-ref -q --verify "$headref"
+then
+	branch_name=${headref#refs/heads/}
+	if test "z$branch_name" = "z$headref" ||
+		! git config "branch.$branch_name.description" >/dev/null
+	then
+		branch_name=
+	fi
+fi
 
 test -n "$base" && test -n "$url" || usage
 baserev=$(git rev-parse --verify "$base"^0) &&
@@ -66,6 +77,13 @@ for you to fetch changes up to %H:
 
 ----------------------------------------------------------------' $headrev &&
 
+if test -n "$branch_name"
+then
+	echo "(from the branch description for $branch local branch)"
+	echo
+	git config "branch.$branch_name.description"
+	echo "----------------------------------------------------------------"
+fi &&
 git shortlog ^$baserev $headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
-- 
1.7.7.rc2.4.g5ec82
