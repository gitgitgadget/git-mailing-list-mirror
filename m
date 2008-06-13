From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bugs
Date: Fri, 13 Jun 2008 16:09:05 -0700
Message-ID: <7vbq25j5ke.fsf@gitster.siamese.dyndns.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
 <20080613101024.GA8221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Lynn <benlynn@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7IPM-0004uD-2H
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 01:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbYFMXJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 19:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbYFMXJR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 19:09:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbYFMXJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 19:09:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 458973DB1;
	Fri, 13 Jun 2008 19:09:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D5853DB0; Fri, 13 Jun 2008 19:09:07 -0400 (EDT)
In-Reply-To: <20080613101024.GA8221@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Jun 2008 06:10:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCE47B0A-399D-11DD-B7ED-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84951>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 10, 2008 at 10:44:43AM -0700, Linus Torvalds wrote:
>
>> You can fix this multiple ways. One would be to pick another size that is 
>> simply less likely (eg ~0 instead), which leaves the theoretical race, and 
>> just makes it practically impossible to hit (not that I think it's very 
>> practical to hit already).
>
> Hmm. I may have just hit it in the test suite.
>
> Try this:
>
>   cd git/t
>   for i in `seq 1 1000`; do
>     ./t4126-apply-empty.sh -v -i || break
>   done
>   echo made it to $i
>
> Most of the time it works, but somewhere in that thousand (generally
> within a few hundred), I end up with a failed test.
> ...
> However, I can still trigger the failure with your patch, so I wonder if
> it is some other race entirely...

This is not a race but the test itself is simply buggy.

When telling apply to affect index and work tree at the same time (that is
what --index means), the caller must make sure that the diff-files won't
report stale stat information.

If "git reset --hard" and ">empty" crossed the second boundary, the reset
might have written out an empty "empty" with timestamp T and then the
independent ">empty" would have given a new timestamp T+1.

I think "reset --hard" without ">empty" is enough as the head commit
records an empty blob there.

---

 t/t4126-apply-empty.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 0cfd47c..ceb6a79 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -26,7 +26,6 @@ test_expect_success setup '
 
 test_expect_success 'apply empty' '
 	git reset --hard &&
-	>empty &&
 	rm -f missing &&
 	git apply patch0 &&
 	test_cmp expect empty
@@ -34,7 +33,6 @@ test_expect_success 'apply empty' '
 
 test_expect_success 'apply --index empty' '
 	git reset --hard &&
-	>empty &&
 	rm -f missing &&
 	git apply --index patch0 &&
 	test_cmp expect empty &&
@@ -43,7 +41,6 @@ test_expect_success 'apply --index empty' '
 
 test_expect_success 'apply create' '
 	git reset --hard &&
-	>empty &&
 	rm -f missing &&
 	git apply patch1 &&
 	test_cmp expect missing
@@ -51,7 +48,6 @@ test_expect_success 'apply create' '
 
 test_expect_success 'apply --index create' '
 	git reset --hard &&
-	>empty &&
 	rm -f missing &&
 	git apply --index patch1 &&
 	test_cmp expect missing &&
