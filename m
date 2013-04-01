From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] send-email: use "return;" not "return undef;" on error
 codepaths
Date: Sun, 31 Mar 2013 18:40:40 -0700
Message-ID: <1364780442-6015-1-git-send-email-gitster@pobox.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 03:41:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMTkH-0000ki-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab3DABkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:40:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab3DABkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE73ED5E;
	Mon,  1 Apr 2013 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FHeX
	Dhzffm7kqRwebxtF0StJRd0=; b=mbZmAAyK2oWKmzddYiXAo2dHRzLVjPlViMwJ
	2ncuNVnvCXtuxgd+/bkod6iLSR82BfvIcMYt73wp8dCyQ/xfTxzHuBCHVJgkcSST
	UJku7gb4N9W2oylzu87HWNrgSxqBFxbXTTBkdL0kGb4ogFkCLzEyDqlL64ZKBnlJ
	BVLf6iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZbLi0RPqXs2hBEdAF1tUy9+PoV+RJ8D/Hg1kjnO0HtVXTdrPCAUlilvWSlvix8Fp
	cjc4DvNTrOIbMfi51gBc3GnDsYwdXKVfwkjbKpYgsK8X48oFcDMUVnZlWNXG14TZ
	Nf4Z5nxXIiQaevurQgwpEg5nBgqVp33VarZh8siE2x8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF934ED5D;
	Mon,  1 Apr 2013 01:40:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 548FCED5C; Mon,  1 Apr 2013
 01:40:44 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-441-g6e6f07b
In-Reply-To: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 2B53A770-9A6D-11E2-B365-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219652>

From: Ramkumar Ramachandra <artagnon@gmail.com>

All the callers of "ask", "extract_valid_address", and "validate_patch"
subroutines assign the return values from them to a single scaler:

	$var = subr(...);

and "return undef;" in these subroutine can safely be turned into a
simpler "return;".  Doing so will also future-proof a new caller that
mistakenly does this:

    @foo = ask(...);
    if (@foo) { ... we got an answer ... } else { ... we did not ... }

Note that we leave "return undef;" in validate_address on purpose,
even though Perlcritic may complain.  The primary "return" site of
the function returns whatever is in the scaler variable $address, so
it is pointless to change only the other "return undef;" to "return".
The caller must be prepared to see an array with a single undef as
the return value from this subroutine anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..79cc5be 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -711,7 +711,7 @@ sub ask {
 			}
 		}
 	}
-	return undef;
+	return;
 }
 
 my %broken_encoding;
@@ -833,7 +833,7 @@ sub extract_valid_address {
 	# less robust/correct than the monster regexp in Email::Valid,
 	# but still does a 99% job, and one less dependency
 	return $1 if $address =~ /($local_part_regexp\@$domain_regexp)/;
-	return undef;
+	return;
 }
 
 sub extract_valid_address_or_die {
@@ -1484,7 +1484,7 @@ sub validate_patch {
 			return "$.: patch contains a line longer than 998 characters";
 		}
 	}
-	return undef;
+	return;
 }
 
 sub file_has_nonascii {
-- 
1.8.2-441-g6e6f07b
