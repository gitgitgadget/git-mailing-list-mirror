From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 20/23] git notes merge: Add testcases for merging notes
 trees at different fanouts
Date: Fri, 29 Oct 2010 08:01:10 -0700
Message-ID: <7vwrp16o21.fsf@alter.siamese.dyndns.org>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <1287965333-5099-21-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, srabbelier@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 17:01:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBqSb-0001KW-JV
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 17:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933942Ab0J2PBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 11:01:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917Ab0J2PB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 11:01:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 705D02A1B;
	Fri, 29 Oct 2010 11:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hFHioMzxfKoRXrjijzKWWZ1fnu4=; b=eITFvN
	Ab2118XW9pRO1JfYs2V8ns/G3LSWR0amJvrMa8SWQ2g+WO7XIUWb+iB3urTEEAkG
	lzX93sMWNqE20w4+1NFHjyXKuDsm1FObg08iyAqWHtdPTlXaI0MPt1RlUX8rrSCg
	vhpilmB4YX7d1FdKBTUvqWrBMQIFFcFXA8+KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFUMOoluhVLfchk/AHtKaxcH9Bf2smWM
	7EQpIBYiiH/IaXgW6vFtIiSnys13XbkgQOejwdAkb29dUnEkBU2KFRsJ1VuV94DS
	FadCGVlexGwu2RXNTtpKz621ksqLm2XjLDv6ZauxVO+l6GX5ozoCGZSGaULm4VfW
	LDeCkhCuXvQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF19C2A1A;
	Fri, 29 Oct 2010 11:01:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1C802A19; Fri, 29 Oct
 2010 11:01:12 -0400 (EDT)
In-Reply-To: <1287965333-5099-21-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon\, 25 Oct 2010 02\:08\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 632A2A70-E36D-11DF-A6AD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160332>

Subject: [PATCH] portability fix for [20/23]

    test "$(line generator | wc -l)" = $expected_number_of_lines (bad)

is not portable, as "wc -l" can prefix the number with whitespaces.

Either write the $(... | wc -l) without enclosing in a dq pair, i.e.

    test $(line generator | wc -l) = $expected_number_of_lines (good)

or compare them numerically with 

    test "$(... | wc -l)" -eq $num (ok)

The former is preferred for readability.

---
 t/t3311-notes-merge-fanout.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index d1c7b69..93516ef 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -123,8 +123,8 @@ test_expect_success 'Add a few hundred commits w/notes to trigger fanout (x -> y
 	done &&
 	test "$(git rev-parse refs/notes/y)" != "$(git rev-parse refs/notes/x)" &&
 	# Expected number of commits and notes
-	test "$(git rev-list HEAD | wc -l)" = "$num" &&
-	test "$(git notes list | wc -l)" = "$num" &&
+	test $(git rev-list HEAD | wc -l) = $num &&
+	test $(git notes list | wc -l) = $num &&
 	# 5 first notes unchanged
 	verify_notes y commit5
 '
-- 
1.7.3.2.193.g78bbb
