From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Tue, 02 Oct 2012 15:21:27 -0700
Message-ID: <7vy5jo5xco.fsf@alter.siamese.dyndns.org>
References: <5001644F.10901@web.de>
 <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de>
 <7va9wlhnl3.fsf@alter.siamese.dyndns.org> <506B110B.2050802@web.de>
 <7v4nmc7fmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 00:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJAqW-0001Km-B1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 00:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab2JBWVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 18:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab2JBWVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 18:21:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FD479A17;
	Tue,  2 Oct 2012 18:21:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xm+yar6qchgYlZ2iMFmOEYpQNXA=; b=iOBTuK
	E9LE9mswiYMMOpoeMoqZkUOO5p2RT4dyu1N0r7KITSkm4RiIKemzAipRoT8XGliv
	0xNSI7P0EL096S5pS7f7JS5ixCZHi+sr1nhk45iL5+yq1adh33hFIgxInaLAIMA7
	X+ajwngbb+l5nWyW4IiSrR3HK87epSnrOLIqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h61Hh9J0v27k4dk1H1W+r4xcKRYZ7GpW
	XDUzl7bptHsPfoe7j1D4lRnL+6Ui5Wiz88b9D1OOPhoOPp0zAVur5sH03RO95k9K
	InDg743eIYOXJZn7njHDYpzyMl+ueDw95YzTBP3/RPmDGI3uXtsVg0BxsO5uNn88
	0iHvDirHzpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D9749A16;
	Tue,  2 Oct 2012 18:21:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C414E9A15; Tue,  2 Oct 2012
 18:21:28 -0400 (EDT)
In-Reply-To: <7v4nmc7fmz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Oct 2012 14:01:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82E962E8-0CDF-11E2-9673-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206849>

Junio C Hamano <gitster@pobox.com> writes:

> The last piece to expect "error in tag.*broken links" in the output
> is wrong.  Probably we should remove the misguided check and end
> it with "test_must_fail git fsck --tags".

I think this should suffice.

When we check tag T first, we make a mental note on X that is
referred by T that X must be of a certain type, but we do not bother
recording _why_ we decided X must be of the type (e.g. "because tag
T asks it to be").  So when we check T and later check X, the only
thing we know is that we expected X to be commit but it actually is
blob.  Exactly the same type of issue can arise for a blob that is
pointed by a tree or a tree that is pointed by a commit.  If a tree
records a reference to a commit but with 100644 mode bits, we may
either say tree is broken (when we have already seen the referent
and know it is a commit), or the referent is broken (when we saw the
tree first and expect the referent to be a blob).

-- >8 --
Subject: [PATCH] t1450: the order the objects are checked is undefined

When a tag T points at an object X that is of a type that is
different from what the tag records as, fsck should report it as an
error.

However, depending on the order X and T are checked individually,
the actual error message can be different.  If X is checked first,
fsck remembers X's type and then when it checks T, it notices that T
records X as a wrong type (i.e. the complaint is about a broken tag
T).  If T is checked first, on the other hand, fsck remembers that we
need to verify X is of the type tag records, and when it later
checks X, it notices that X is of a wrong type (i.e. the complaint
is about a broken object X).

The important thing is that fsck notices such an error and diagnoses
the issue on object X, but the test was expecting that we happen to
check objects in the order to make us detect issues with tag T, not
with object X.  Remove this unwarranted assumption.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1450-fsck.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5b79c51..9c64eef 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -177,9 +177,7 @@ test_expect_success 'tag pointing to something else than its type' '
 	test_when_finished "remove_object $tag" &&
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
-	test_must_fail git fsck --tags 2>out &&
-	cat out &&
-	grep "error in tag.*broken links" out
+	test_must_fail git fsck --tags
 '
 
 test_expect_success 'cleaned up' '
-- 
1.8.0.rc0.54.g771a61b
