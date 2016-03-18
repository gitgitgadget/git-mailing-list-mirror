From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5500: do not depend on the way an earlier pull fails
Date: Fri, 18 Mar 2016 12:31:58 -0700
Message-ID: <xmqqzitvpopd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 20:32:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah08B-0007xw-TN
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 20:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbcCRTcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 15:32:03 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbcCRTcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 15:32:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E03074DAF1;
	Fri, 18 Mar 2016 15:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	fOGfmbbEx5MGOVooz6Ik02rm+U=; b=AV+nSrDSZsFNCTThqOCIYHh+DA1+JhR4t
	bk2SR38UST3e/W+QyEfC2iQXWm4jSulvasRxZmfBeUEp54JEzio/OldFQAF5GgbG
	ANHhQPZ+5GigBscz/kzlVCjMTaQQ34eZdcxaFwHAxGAPudD4pwn/JEz4SvfjLDaD
	iJqxWPhAvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=gMx
	YdX1Zvyutx9mD5Z0yvmuPiRupzs3Gf4ZBHajPpJnPfgVNeb7cqCM6d/AI4SsRex/
	jVaiHY5++IUdEYMvDS3kZaDmbudUYMx7R6pp/mZ83MQV+6IBQ3dUYqM6UzoPxymR
	Bc1etF2rcsqedAMl/vjvKGuncKNY7M4GB6LNeaNw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5E9B4DAF0;
	Fri, 18 Mar 2016 15:31:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4F4564DAED;
	Fri, 18 Mar 2016 15:31:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1528EA36-ED40-11E5-8D1A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289246>

Three tests before the test updated here is a test that is called
'pull in shallow repo with missing merge base' and does this:

    test_must_fail git pull --depth 4 .. A

While attempting to create a merge after fetching necessary objects,
the current implementation happens to create a throw-away object to
represent a conflicted merge result before failing.  This object is
not connected to any of the refs in the result (i.e. prunable).

The test touched by this patch counts the number of loose objects
and depends on the presence of this prunable garbage.  Once we
improve the implementation of "merge" not to leave such a throw-away
object in the object database, this will start failing.

Remove the throw-away object, if any, before counting in order to
future-proof this test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5500-fetch-pack.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..f4e479a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -279,9 +279,10 @@ test_expect_success 'clone shallow depth count' '
 test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
+		git prune &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 55" count.shallow
+	grep "^count: 54" count.shallow
 '
 
 test_expect_success 'fetch --no-shallow on full repo' '
