From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] am -3: recover the diagnostic messages for corrupt patches
Date: Wed, 14 Apr 2010 13:33:30 -0700
Message-ID: <7vpr21pyed.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29HO-0008Js-4s
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab0DNUdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:33:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0DNUdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:33:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95548AA268;
	Wed, 14 Apr 2010 16:33:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=oEwm
	AItFPeS2qEk+NRn+kIeIEd0=; b=vjCPzlk6qHoW5STQhuEni7H+xxS1FReb3Skt
	xXnkWS4rLHYCxTNgOf16Zznql4Bhj+vB8Ye1CrVpW4R0woP07zmaw0QablbMF5nQ
	BEMsvCTZegxX+Z0DIQMcdW5t/vbnXIPIWHpqgqHntfiMEnqEQjS2sDm550ATB/bG
	9tEmCvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	jcNx/s7DiZysERwaBp3c5jCis9dHBOh9nsSGce8DLRgOck/e6oiXM29MmWKwQ+vG
	U89dyP4jiCZ74mGgFzcnt94Kv5kRem+5eXOAdPkIaklfDgnZOZ1OmTYizkQKcff6
	KxsXsWdek/FtQCO86qZImjNZFR52nXKbBop3QLLd8QY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C10AA263;
	Wed, 14 Apr 2010 16:33:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE11CAA261; Wed, 14 Apr
 2010 16:33:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF491420-4804-11DF-89BD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144906>

"git am -3" first tries to apply the patch without any extra trick, and
applies it to a synthesized tree for 3-way merge after the first attempt
fails.  "git apply" exits with status 1 for a patch that is well-formed
but is not applicable (and it dies on other errors with non-zereo, non-1
status) and has an optimization to fall back to the 3-way merge only in
the case.

An earlier patch 3ddd170 (am: suppress apply errors when using 3-way,
2009-06-16) squelched diagnostic messages from the first attempt, not to
be shown to the end user.  This worked reasonably well if the reason the
first application failed was because the patch was made against a wrong
version.

When the patch is corrupt (e.g. line-wrapped or leading whitespaces got
dropped), however, because the second patch application is not even
attempted, the error message from the first application is never shown
and is forever lost.  This message is necessary to locate where the patch
is corrupt and fix it up.

We could fix this issue by reverting 3dd170, or keeping the error message
to somewhere and showing it, but because this is an error codepath, the
easiest is to disable the optimization.  The second patch application is
attempted even when the input is corrupt, and it will notice, diagnose,
and stop with an error message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e26c54a..4e0e406 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -534,7 +534,7 @@ do
 		;;
 	esac
 
-	if test $apply_status = 1 && test "$threeway" = t
+	if test $apply_status != 0 && test "$threeway" = t
 	then
 		if (fall_back_3way)
 		then
-- 
1.7.1.rc1.252.gce30c
