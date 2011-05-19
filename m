From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] notes remove: allow removing more than one
Date: Thu, 19 May 2011 10:44:33 -0700
Message-ID: <7vpqne7fge.fsf@alter.siamese.dyndns.org>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-2-git-send-email-gitster@pobox.com>
 <4DD4BC0D.2000805@drmicha.warpmail.net>
 <7v1uzv9oab.fsf@alter.siamese.dyndns.org>
 <4DD4C73C.7020600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 19 19:45:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7HU-0005rC-5v
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933778Ab1ESRou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:44:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755Ab1ESRol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:44:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0828D57CB;
	Thu, 19 May 2011 13:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XMeYqdCvc/RH+dJI0BJCUkZ6HOs=; b=lKkPzk
	hR9FUHrc7wL7K4RQS9j8kYAAjKh10VT29CStBLRBQCQL2fLHGqRgvWtyYsuCCp7n
	uY1B2FMADZ4xP78aY30USQugXKq/Tx+oc5vYbBeYdWCKq9Mj7ld+nctkOFODAVnj
	Ceb1vyVsNnJoqHUYE55z0ea+6rQZfrqBpiPxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGig/4KFSweJPgelxm1eQjT0FDxeQOai
	oYOIlls2ACN3ak8BQREtjqn8torOfu5pjxYMFD4XkgytpS8LFGUNR8u10vzG9wlH
	B969L18B346Ye1kNTpaphHZGtBKkikfnjIkDzjc5Tlw3gmBqJUvO0Bm/bCw7MxkZ
	9sKF3k/RdV8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8C2857CA;
	Thu, 19 May 2011 13:46:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE5A457C7; Thu, 19 May 2011
 13:46:41 -0400 (EDT)
In-Reply-To: <4DD4C73C.7020600@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 19 May 2011 09:31:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F64E1A3E-823F-11E0-9162-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173980>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The test has two notes because it was created when remove would remove
> one note at a time only, and the test made sure it did not remove the
> other one (!).

Fair enough.  Here is an incremental update to be squashed in.

I notice that "notes list <commit>" and "notes list | grep <commit>" give
quite different results, and "notes list <commit1> <commit2>..." does not
even work at all. Probably the "notes" interface was done with interactive
use in mind without realizing the need for batch operations.

 t/t3301-notes.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 6a6daa9..6278fe8 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -438,12 +438,13 @@ test_expect_success 'removing non-existing note should not create new commit' '
 test_expect_success 'removing more than one' '
 	before=$(git rev-parse --verify refs/notes/commits) &&
 	test_when_finished "git update-ref refs/notes/commits $before" &&
+
+	# We have only two -- add another and make sure it stays
+	git notes add -m "extra" &&
+	git notes list HEAD >after-removal-expect &&
 	git notes remove HEAD^^ HEAD^^^ &&
-	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
-	test 2 = $(wc -l <actual) &&
-	git ls-tree -r --name-only refs/notes/commits >actual &&
-	>empty &&
-	test_cmp empty actual
+	git notes list | sed -e "s/ .*//" >actual &&
+	test_cmp after-removal-expect actual
 '
 
 test_expect_success 'removing is atomic' '
