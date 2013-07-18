From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] diff: allow lowercase letter to specify what change class to exclude
Date: Wed, 17 Jul 2013 17:30:05 -0700
Message-ID: <1374107406-14357-6-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc7I-0006io-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934457Ab3GRAah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934244Ab3GRAaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9E420ABD;
	Thu, 18 Jul 2013 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zTa1
	hzgo6O8QvRtangAFTN4YZqY=; b=ta9JYvTVlIs5KlAaUiUudrrijN6vCc+AOukw
	q66lCKDPYhBWl4t3jO6UsR0nEkaA0UPaTe7rQd8Vx8qBqLdSFXAPNrQcVOcmgWOj
	4oRDUWxdCXxebcOmbO6kZRoFecSwBMiOPmjAvIxA1/aU7MEyGpVUfrwQBskyd5iV
	dVpADRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	m1Y/ij2PvryWNPZRkOhTqFZk//FEk/Zgp95kU5HX4kd1bk4ipgJ6Ib0b8RSRKIuO
	PdEPfNJGfsB5vSD8XWwN7Q2wZO4xQu+ByaK425RrtET8Q1FeVPBO62UuC/GLQOyS
	NwbFWvYY1Hfm7en23G1HZ4y7iAJHMohVKGeWIx1YUeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9419C20ABC;
	Thu, 18 Jul 2013 00:30:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D43AF20AB9;
	Thu, 18 Jul 2013 00:30:19 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 39F45BCA-EF41-11E2-85FB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230671>

In order to express "we do not care about deletions", we had to say
"--diff-filter=ACMRTXUB", giving all the possible change class
except for the one we do not want, "D".

This is cumbersome.  As all the change classes are in uppercase,
allow their lowercase counterpart to selectively exclude the class
from the output.  When such a negated change class is in the input,
start the filter option with the full bits set.

This would allow us to express the old "show-diff -q" with
"git diff-files --diff-filter=d".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 3d37b56..2d0b5e3 100644
--- a/diff.c
+++ b/diff.c
@@ -3532,13 +3532,40 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 	int i, optch;
 
 	prepare_filter_bits();
+
+	/*
+	 * If there is a negation e.g. 'd' in the input, and we haven't
+	 * initialized the filter field with another --diff-filter, start
+	 * from full set of bits, except for AON.
+	 */
+	if (!opt->filter) {
+		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
+			if (optch < 'a' || 'z' < optch)
+				continue;
+			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
+			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
+			break;
+		}
+	}
+
 	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
 		unsigned int bit;
+		int negate;
+
+		if ('a' <= optch && optch <= 'z') {
+			negate = 1;
+			optch = toupper(optch);
+		} else {
+			negate = 0;
+		}
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
 			return optarg[i];
-		opt->filter |= bit;
+		if (negate)
+			opt->filter &= ~bit;
+		else
+			opt->filter |= bit;
 	}
 	return 0;
 }
-- 
1.8.3.3-962-gf04df43
