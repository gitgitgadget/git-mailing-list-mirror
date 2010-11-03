From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Wed, 03 Nov 2010 10:30:44 -0700
Message-ID: <7v4obyxqkb.fsf@alter.siamese.dyndns.org>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino> <201011010909.15198.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDhAw-0008Ak-9L
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab0KCRbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:31:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab0KCRa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 168F111E5;
	Wed,  3 Nov 2010 13:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2yEeQ1b3/yx/gR2cDeoTLZf3DAY=; b=XdhX+/
	Yl85c+kn6HAShkG+7mcjjk4QvtYr0l4AegQLEE3G+ABHfoloDyXjDRuYWKPMKHGm
	HSvW5A8U+dnJLQV+Y4FA9HYB5+fd+9Jwi8Egusz00+8s9Z/4MQGAH17HNpXXFFMe
	ArnM2W8aOu2602M1TjoHORUgVrq2HRvY5OzLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CcAI8oja5nZ7H6DGTuRlDx8ehnQW7hfe
	JKFoRvgNb6Mv9msBqIXzRvbAuqJyvICatn3A3Y2pv/9nfaD6tlkISmroMaQptIro
	utg0ONybJmb+ZI1xVlkrO8eJ4eroD4T8k8Wp7RyTuoPFLIQOnRK+ZdY3BYlXLmP/
	yrfKlyspWm8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAC6811E4;
	Wed,  3 Nov 2010 13:30:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB32B11D3; Wed,  3 Nov
 2010 13:30:46 -0400 (EDT)
In-Reply-To: <201011010909.15198.j6t@kdbg.org> (Johannes Sixt's message of
 "Mon\, 1 Nov 2010 09\:09\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B74CF62-E770-11DF-A53F-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160630>

Johannes Sixt <j6t@kdbg.org> writes:

> On Windows, this doesn't test what it should test because we do not look at 
> the inode number (currently). Please use test-chmtime to change stat 
> information.

Like this, perhaps?

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index b210188..a5b963a 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -81,15 +81,12 @@ test_expect_success 'revert after renaming branch' '
 
 '
 
-test_expect_success 'revert on stat-dirty working tree' '
-	git clone . repo &&
-	(
-		cd repo &&
-		git checkout initial
-	) &&
-	cp -R repo copy &&
+test_expect_success 'cherry-pick on stat-dirty working tree' '
+	git clone . copy
 	(
 		cd copy &&
+		git checkout initial &&
+		test-chmtime +40 oops &&
 		git cherry-pick added
 	)
 '
