From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test the commit.gpgsign config option
Date: Tue, 17 Dec 2013 15:27:12 -0800
Message-ID: <xmqqr49bkqi7.fsf@gitster.dls.corp.google.com>
References: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
	<1387202104-17580-1-git-send-email-boklm@mars-attacks.org>
	<xmqq38lsrakh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Wed Dec 18 00:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt42q-0004oE-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 00:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab3LQX1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 18:27:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab3LQX1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 18:27:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52DFF5C54D;
	Tue, 17 Dec 2013 18:27:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3r19PFt3i5FLjHEw3qCro3u+2E=; b=QBP0RQ
	M7nUOKwmG2XD8b2mZfjgDbYbAwdqdRhy+Jy6taL/lJjEMIzzW9+TiszJoqwWDOh7
	4eA7G7KJ6CKa+3dtFiHs+8KAlOhEDhBX44GO8K7iNwvkHKFGz8YJhReAkVdnmy2o
	cal+GH1pyadnA/rfjFUk7+l3agnFI7EuQJPMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuZQA1WoFqH7yCFP0/eauVyjoQ2SWYWo
	3nwrxZJV3Re5qivYrxtpArdaG3Gcq3QwTmYdB+psZLe8RimaLM1hBiVDd6hzemle
	/oZsDRs+lrJSw25we7dMsiZTT3iwixFRSEX6Lg77MKF0Jjs3t2iBvKSq+9HxbT/Z
	n7AgWqdKWGs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECD65C54C;
	Tue, 17 Dec 2013 18:27:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AC975C549;
	Tue, 17 Dec 2013 18:27:14 -0500 (EST)
In-Reply-To: <xmqq38lsrakh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 16 Dec 2013 09:05:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C2E77314-6772-11E3-A0EF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239411>

Junio C Hamano <gitster@pobox.com> writes:

> If any of the above fail, the next test will run with an unknown
> random value in commit.gpgsign depending on where the sequence
> failed.  Use one test_when_finished with test_unconfig at the very
> beginning, perhaps.

In other words, I'll squash this in.

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 537bfba..5ddac1a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -5,6 +5,8 @@ test_description='signed commit tests'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success GPG 'create signed commits' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+
 	echo 1 >file && git add file &&
 	test_tick && git commit -S -m initial &&
 	git tag initial &&
@@ -40,9 +42,7 @@ test_expect_success GPG 'create signed commits' '
 	git tag seventh-unsigned &&
 
 	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
-	git tag seventh-signed &&
-
-	git config --unset commit.gpgsign
+	git tag seventh-signed
 '
 
 test_expect_success GPG 'show signatures' '
