From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Fri, 07 Jan 2011 14:50:44 -0800
Message-ID: <7vsjx449bv.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbL9D-0007RA-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab1AGWu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:50:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1AGWu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:50:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 690522E67;
	Fri,  7 Jan 2011 17:51:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8AqBsIo/ie7IXbPuNkhCrBT9kX4=; b=CTymeY
	a6Z4jP+tiJZWC0uZhIqNOnp6xBTnWx6lPBqlkPdotJFyG691CbJPEkSYdN2X1R+m
	2eSvgwOMIPo9CrP9RZ90iNs1SRAP5aq7Kr/Z1We/9UhqETDo+G3jCrAPj0NXCcwv
	0jiNdzy/Aubb7bNzqwHTN9dpYo2AmQKuE3bPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D2tWib5uIGo8xFgs8VmOGSjRI/pHv1t3
	TADpvyqoYF+zNQrqJhgcByeRSoUKt3trpZ7HFXt2k8Rn76Xxg4Rb/UFpRLuSXlKl
	O7ZWWj4i8HPdHhWCvoe/vjKWBEB2I3SVJwfk8Uau9wqbOSJSqaivUj52PhvfCAmu
	KLvJlwnYoEU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C7982E66;
	Fri,  7 Jan 2011 17:51:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77E6A2E54; Fri,  7 Jan 2011
 17:51:25 -0500 (EST)
In-Reply-To: <20110107195417.GC6175@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 7 Jan 2011 14\:54\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB3F9F46-1AB0-11E0-A7D0-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164779>

Jeff King <peff@peff.net> writes:

> Here is the test script I worked out which shows the issue (and checks
> that the right messages are shown to the user):

This is a band-aid that is not quite right (even though it passes the
tests).  Attempting to check out a branch "frotz" in a repository with a
tag "frotz" that point at a non-commit would still fail, which is not a
new problem.


 builtin/checkout.c               |    7 +++++++
 t/t2019-checkout-amiguous-ref.sh |   23 ++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a54583b..f6fea2f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -840,6 +840,13 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				;
 			else
 				new.path = NULL;
+			if (hashcmp(new.commit->object.sha1, rev))
+				/*
+				 * Yikes, arg is an ambiguous and higher
+				 * precedence SHA-1 expression than the
+				 * branch name
+				 */
+				new.commit = lookup_commit_reference_gently(rev, 1);
 			parse_commit(new.commit);
 			source_tree = new.commit->tree;
 		} else
diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
index 0981f11..fa1d4e6 100755
--- a/t/t2019-checkout-amiguous-ref.sh
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -6,8 +6,10 @@ test_description='checkout handling of ambiguous (branch/tag) refs'
 test_expect_success 'setup ambiguous refs' '
 	test_commit branch file &&
 	git branch ambiguity &&
+	git branch vagueness &&
 	test_commit tag file &&
 	git tag ambiguity &&
+	git tag vagueness HEAD:file &&
 	test_commit other file
 '
 
@@ -19,7 +21,7 @@ test_expect_success 'checkout produces ambiguity warning' '
 	grep "warning.*ambiguous" stderr
 '
 
-test_expect_failure 'checkout chooses branch over tag' '
+test_expect_success 'checkout chooses branch over tag' '
 	echo branch >expect &&
 	test_cmp expect file
 '
@@ -29,4 +31,23 @@ test_expect_success 'checkout reports switch to detached HEAD' '
 	! grep "^HEAD is now at" stderr
 '
 
+test_expect_failure 'checkout vague ref succeeds' '
+	git checkout vagueness >stdout 2>stderr &&
+	test_set_prereq VAGUENESS_SUCCESS
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout produces ambiguity warning' '
+	grep "warning.*ambiguous" stderr
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
+	echo branch >expect &&
+	test_cmp expect file
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to detached HEAD' '
+	grep "Switched to branch" stderr &&
+	! grep "^HEAD is now at" stderr
+'
+
 test_done
