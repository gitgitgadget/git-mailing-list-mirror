From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Wed, 16 Jan 2008 11:52:43 -0800
Message-ID: <7vodblpmyc.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEKR-0002zE-QZ
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYAPTxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYAPTxK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:53:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYAPTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:53:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3FC41E5;
	Wed, 16 Jan 2008 14:53:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D93FF41E4;
	Wed, 16 Jan 2008 14:53:00 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 16:02:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70733>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 15 Jan 2008, Linus Torvalds wrote:
>> 
>> This makes write_ref_sha1() more careful: it actually checks the SHA1 of 
>> the ref it is updating, and refuses to update a ref with an object that it 
>> cannot find.
>
> Side note: this breaks some tests, because those tests do things like
>
> 	git update-ref refs/heads/master 1111111111111111111111111111111111111111 &&
> 		test 1111111111111111111111111111111111111111 = $(cat .git/refs/heads/master)
>
> ...
> (Pet peeve on mine: people fixing assert()'s by changing the source-code, 
> without ever asking themselves whether maybe the assert itself was the 
> bug).

The rules for the plumbing used to be that refs can point at
anything that get_sha1() accepts.  We did not even require it to
be parse_object() happy let alone it being parse_commit() kosher.

You changed the world order.  I agree that the world order was
changed in a good way, but saying that the original test did not
check the right thing or it was a bug is not quite fair.  At
worst, we can say that it was very sloppily written by assuming
that the commands involved in the particular test would not care
about corrupted repositories whose refs point at nonexistant
bogus objects.

I'll squash the following to your patch.

---
 t/t1400-update-ref.sh |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a90824b..71ab2dd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -7,12 +7,19 @@ test_description='Test git update-ref and basic ref logging'
 . ./test-lib.sh
 
 Z=0000000000000000000000000000000000000000
-A=1111111111111111111111111111111111111111
-B=2222222222222222222222222222222222222222
-C=3333333333333333333333333333333333333333
-D=4444444444444444444444444444444444444444
-E=5555555555555555555555555555555555555555
-F=6666666666666666666666666666666666666666
+
+test_expect_success setup '
+
+	for name in A B C D E F
+	do
+		test_tick &&
+		T=$(git write-tree) &&
+		sha1=$(echo $name | git commit-tree $T) &&
+		eval $name=$sha1
+	done
+
+'
+
 m=refs/heads/master
 n_dir=refs/heads/gu
 n=$n_dir/fixes
