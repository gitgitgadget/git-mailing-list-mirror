From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Tue, 27 Mar 2012 12:16:36 -0700
Message-ID: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbsr-0000CX-6u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab2C0TQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:16:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942Ab2C0TQi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:16:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1D076AD;
	Tue, 27 Mar 2012 15:16:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgikqFAc8jYQfIijG4sE1NmawKE=; b=PJdJrK
	0Kfftp4H6DsPF4+u2eU8c3Ezz9hguVeGOGU9c/1DJIWZRWOOzG7e+1Mf/Icr7fKV
	g3V2S+J97yjq0s7IqK3z4slfCYCUd2EuVZYIspQZZekekkpY8LCXFhny588eMYQg
	2bNtSdXULxFhz29aPpC4xD2VCSmdLMfTxvI4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RNLdTkWrBPAi7HWaQKTUvLb/p9dinV0H
	/tUOxK6dJqKSEsSI+xUFoQbZjXElxqclvHEM1ws55AHDZv5ME/yfK16xWJ4TcXwk
	QmAYf2JA6kT/VrAu0bmWjC7pl6YXk5KDu9Utzt6pEwrHD7JvR0GW0tWJOnuo3yi2
	7nhu/nugAL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D873C76A2;
	Tue, 27 Mar 2012 15:16:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55EC476A1; Tue, 27 Mar 2012
 15:16:37 -0400 (EDT)
In-Reply-To: <20120327180503.GB4659@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Mar 2012 14:05:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FD20A22-7841-11E1-B05A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194077>

Jeff King <peff@peff.net> writes:

> If git receives an EACCES error while trying to execute an
> external command, we currently give up and report the error.
> However, the EACCES may be caused by an inaccessible
> directory in the user's PATH.

Regardless of EACCES/ENOENT change we discussed, the observable behaviour
should be testable.  Something like this?

 t/t0061-run-command.sh |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 8d4938f..dbb1d9e 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,7 +26,7 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
-test_expect_success POSIXPERM 'run_command reports EACCES' '
+test_expect_failure POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
 	test_must_fail test-run-command run-command ./hello.sh 2>err &&
@@ -34,4 +34,17 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
+test_expect_success POSIXPERM 'unreadable directory in PATH' '
+	mkdir local-command &&
+	test_when_finished "chmod u+rwx local-command && rm -fr local-command" &&
+	git config alias.nitfol "!echo frotz" &&
+	chmod a-rx local-command &&
+	(
+		PATH=./local-command:$PATH &&
+		git nitfol >actual
+	) &&
+	echo frotz >expect &&
+	test_cmp expect actual
+'
+
 test_done
