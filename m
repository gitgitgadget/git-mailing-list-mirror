From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Tue, 09 Feb 2010 10:06:33 -0800
Message-ID: <7vhbpqe11y.fsf@alter.siamese.dyndns.org>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
 <4B71122F.3040809@viscovery.net>
 <76718491002090955g66eca03ar7438e57811616267@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuU6-00045R-Tv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab0BISGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 13:06:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab0BISGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 13:06:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3C169842E;
	Tue,  9 Feb 2010 13:06:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2KR1p+qnlnyUx8Hv7kRT0Rqp76U=; b=C4BRh8
	LqNo+55mZEEh3Su/+zYY9RbzN3yZi7Yu1/rsfQOzCYjY1o+/jI7pPqNnGacF3Fu3
	yg7BebQaPQB63boQhLkfa7b28Pzqxw6pQz29AAFbk49ek2uFzQcU+Dw1KsBK80cc
	hgP9rc0P1OC9eC/cEP4x3e34y/tvGP0LpTOFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghAsFlMGM7uQPtWKqaBKkXV7t95E1guG
	7gpC21uUDmiMXw8DF7EDiL9daQPt970PQe1WlCBqXRbPxywU4mJwOATQbLw5Yc5j
	LgoEhOIARI0hVdIuf7tU4tygEqtazHUoD0MHHTXknNhadx57zVyeARqq0htgHV6P
	SGv3CCbtED0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BAFF9842D;
	Tue,  9 Feb 2010 13:06:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 993BC98428; Tue,  9 Feb
 2010 13:06:35 -0500 (EST)
In-Reply-To: <76718491002090955g66eca03ar7438e57811616267@mail.gmail.com>
 (Jay Soffian's message of "Tue\, 9 Feb 2010 12\:55\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEB70CC6-15A5-11DF-8B0D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139428>

Sorry for knowing but forgetting about the issue while applying.
I'll queue this fix-up.

-- >8 --
t8003: check exit code of command and error message separately

Shell reports exit status only from the most downstream command
in a pipeline.  In these tests, we want to make sure that the
command fails in a controlled way, and produces a correct error
message.

This issue was known by Jay who submitted the patch, and also was
pointed out by Hannes during the review process, but I forgot to
fix it up before applying.  Sorry about that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t8003-blame.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 4a8db74..3bbddd0 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -158,11 +158,13 @@ EOF
 '
 
 test_expect_success 'blame -L with invalid start' '
-	test_must_fail git blame -L5 tres 2>&1 | grep "has only 2 lines"
+	test_must_fail git blame -L5 tres 2>errors &&
+	grep "has only 2 lines" errors
 '
 
 test_expect_success 'blame -L with invalid end' '
-	git blame -L1,5 tres 2>&1 | grep "has only 2 lines"
+	test_must_fail git blame -L1,5 tres 2>errors &&
+	grep "has only 2 lines" errors
 '
 
 test_done
