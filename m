From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Sat, 05 Dec 2009 10:24:46 -0800
Message-ID: <7vfx7pwa6p.fsf@alter.siamese.dyndns.org>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
 <7vljhislbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Maarten Lankhorst <m.b.lankhorst@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 19:25:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGzJf-0002yk-UH
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 19:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbZLESY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 13:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbZLESY4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 13:24:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743AbZLESYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 13:24:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5424585F29;
	Sat,  5 Dec 2009 13:24:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PI0mhNzrFpXxDvmMHhbBVe0ZSVE=; b=kMNGqw
	OFU4NXmRTbwr6wcmTXXmsfE/nio/W1UIlhaJAxzgPboj2wYU7B/ORZHbYZhKEAYr
	EGL5QyQysRVEK5Cx25NN2biKNcKUoTx8HYYvH+rUIsxlr147OL21M+AkAm59mv1E
	sr7Eq5guLlapxfep/QnEeIk8bxgax+aTOrJys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=auCFDLpLKShIhvZC7k9Nz2jpvhYu5Dck
	4G+H4AgWxzz/Ff70VEoV4+5z30ufWou3vjmKS62jNCRHy3FXl/6riWQ/QUkSRoKA
	dmIluSQ8/7bv12trAdkLCsSgo4UQOIC+VwkQwktBp7G7dURVw4HORyMdjQ0QiG2I
	vbd7n5/ExJU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CBB185F27;
	Sat,  5 Dec 2009 13:24:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 997AE85F24; Sat,  5 Dec
 2009 13:24:47 -0500 (EST)
In-Reply-To: <7vljhislbj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 04 Dec 2009 09\:25\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0377E0-E1CB-11DE-A252-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134611>

Junio C Hamano <gitster@pobox.com> writes:

> ...  The test already checks that the change won't break soft reset,
> which is good, but it does not seem to check/specify what should happen in
> the mixed reset in this case (I think it should be allowed).

Heh, I was not thinking straight. A bare repository does not have the
index, so allowing (cd .git && git reset) is Ok but mixed in a bare
repository (cd bare.git && git reset) is not.

Let's cover a few more missing cases.

 t/t7103-reset-bare.sh |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 3ddf0ac..68041df 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -21,20 +21,32 @@ test_expect_success 'merge reset requires a worktree' '
 	 test_must_fail git reset --merge)
 '
 
+test_expect_success 'mixed reset is ok' '
+	(cd .git && git reset)
+'
+
+test_expect_success 'soft reset is ok' '
+	(cd .git && git reset --soft)
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
 '
 
-test_expect_success 'hard reset is not allowed' '
-	test_must_fail  git reset --hard HEAD^
+test_expect_success 'hard reset is not allowed in bare' '
+	test_must_fail git reset --hard HEAD^
 '
 
-test_expect_success 'merge reset is not allowed' '
+test_expect_success 'merge reset is not allowed in bare' '
 	test_must_fail git reset --merge HEAD^
 '
 
-test_expect_success 'soft reset is allowed' '
+test_expect_success 'mixed reset is not allowed in bare' '
+	test_must_fail git reset --mixed HEAD^
+'
+
+test_expect_success 'soft reset is allowed in bare' '
 	git reset --soft HEAD^ &&
 	test "`git show --pretty=format:%s | head -n 1`" = "one"
 '
