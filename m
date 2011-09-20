From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] request-pull: use the branch description
Date: Tue, 20 Sep 2011 16:03:04 -0700
Message-ID: <7vpqiu4y1j.fsf_-_@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org>
 <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
 <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 01:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R69LN-0003jD-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab1ITXDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 19:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1ITXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 19:03:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A80F50DD;
	Tue, 20 Sep 2011 19:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uMq56uVb4rBAYsKLRdPY/K0q8aE=; b=tvW+2Y
	Wn7xA/tANXwE1dSkkDBnyCnDncVvA3JczrHImlZxkm+OR0DQ3xpJ+SGKbRXiXdIR
	ySsd84S0Jwjg8lpjZ6IgNYqA79Sgr7H5QhRnlIsif8hT7KC3rZibl/Ot10aSQszT
	8lUqjJLUsBci7xaCQ96vFqnqm74X5+uxQJlCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d3bRpvcJ9zxAHbEbUEMfdX+fpSzGWfg5
	FF6R/vsK1cx4vXEPTuJGcmqHY7NjgyLTqzdY/j5finUT6AYeaOrNAAUChGg3HmFo
	XpoHYEVi/relBY2QQsO/CihDr0RFuI7PQnReN+lzGuNLcs5p0eu/802Ii+Fd9drD
	XBu3fdDgguo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321CB50DC;
	Tue, 20 Sep 2011 19:03:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B403750DA; Tue, 20 Sep 2011
 19:03:05 -0400 (EDT)
In-Reply-To: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 20 Sep 2011 16:01:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B30F0DF6-E3DC-11E0-BE74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181806>

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
