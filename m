From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Wed, 24 Apr 2013 18:59:42 -0700
Message-ID: <7v61zb8j5d.fsf@alter.siamese.dyndns.org>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
	<1366658602-12254-1-git-send-email-kevin@bracey.fi>
	<7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi>
	<7va9ona77d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Apr 25 03:59:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVBTY-0001XJ-O1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 03:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378Ab3DYB7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 21:59:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356Ab3DYB7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 21:59:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 463C210078;
	Thu, 25 Apr 2013 01:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=s2eaOh4YlaFX8Ch+KCWG6LshIFQ=; b=Gjq9F+Usrt7IF8B2YUpC
	i+0ckVl6FhsSESQYVw2iCkT2DlXqqYg2LsciKmQmDp+zBNw7NcxnuPq1C18V/tTQ
	U5LjhPBaLtn9pL/suPJA79fSyr7xHU2mi0wfs13pQ0oto0hUkYwZyFx7qggtCrQS
	YyfIfOIQpmJKBmSKJjmYsXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uy55GT97RTOeBBpSST2hd5qtAeSs55gtHx9yepgcXdBPvb
	ev9m4Y+3zQr5cyULV/l9ccfESvYW1xFTSILnFDM+dbZvac9RyOVIWgyn54NkXZju
	wDNhX4P0I0JJIkPPL6NFiqP4e02p00rsLcSpXlBsiYIBq1Q+T1ApD0x67ugJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DB6310077;
	Thu, 25 Apr 2013 01:59:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7146E10071;
	Thu, 25 Apr 2013 01:59:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCCDDCA6-AD4B-11E2-BADC-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222339>

Junio C Hamano <gitster@pobox.com> writes:

>> So, given all that, revised patch below:

I tried to squeeze the minimum test I sent $gmane/220919 to the test
suite.  I think the "do not use --parents option for this test"
switch needs to be cleaned up a bit more, but it fails without your
patch and does pass with your patch.

I somehow was hoping that your fix to TREESAME semantics would also
correct the known breakage documented in that test, but it seems
that I was too greedy ;-)

Thanks.

 t/t6012-rev-list-simplify.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index dd6dc84..4e55872 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -14,21 +14,24 @@ unnote () {
 
 test_expect_success setup '
 	echo "Hi there" >file &&
-	git add file &&
-	test_tick && git commit -m "Initial file" &&
+	echo "initial" >lost &&
+	git add file lost &&
+	test_tick && git commit -m "Initial file and lost" &&
 	note A &&
 
 	git branch other-branch &&
 
 	echo "Hello" >file &&
-	git add file &&
-	test_tick && git commit -m "Modified file" &&
+	echo "second" >lost &&
+	git add file lost &&
+	test_tick && git commit -m "Modified file and lost" &&
 	note B &&
 
 	git checkout other-branch &&
 
 	echo "Hello" >file &&
-	git add file &&
+	>lost &&
+	git add file lost &&
 	test_tick && git commit -m "Modified the file identically" &&
 	note C &&
 
@@ -37,7 +40,9 @@ test_expect_success setup '
 	test_tick && git commit -m "Add another file" &&
 	note D &&
 
-	test_tick && git merge -m "merge" master &&
+	test_tick &&
+	test_must_fail git merge -m "merge" master &&
+	>lost && git commit -a -m "merge" &&
 	note E &&
 
 	echo "Yet another" >elif &&
@@ -110,4 +115,16 @@ check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
 check_result 'H' --first-parent -- another-file
 
+check_result 'E C B A' --full-history E -- lost
+test_expect_success 'full history simplification without parent' '
+	printf "%s\n" E C B A >expect &&
+	git log --pretty="$FMT" --full-history E -- lost |
+	unnote >actual &&
+	sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
+	test_cmp expect check || {
+		cat actual
+		false
+	}
+'
+
 test_done
-- 
1.8.2.1-730-gf07461b
