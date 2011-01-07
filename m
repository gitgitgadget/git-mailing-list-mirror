From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Fri, 07 Jan 2011 15:17:22 -0800
Message-ID: <7vipy0483h.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLYz-0003aP-RM
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab1AGXRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:17:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1AGXRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:17:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6912931B7;
	Fri,  7 Jan 2011 18:18:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEM/yD8GJ2W71v6cmx0/HdetH04=; b=MTsvCD
	gItsqjcR03Ey3ZwPewJwH5Cb4BEqwZDbBfpXUchcpXfDW4vxF4GNTfcU/wddOvVd
	+iV3cxI+RNsk12FCwb2ygGSqNrsiaBqAgwjHhWPgBSyArEPUHTsJGKUwV4cVKiOV
	yeJ0ZJi0Nj+jPVAphvkdoVIBgwHumZ5uGW+jA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtS2xZ8ewbHkF6RDa2aHq+gy2sWQTdlW
	LBChiaw5M1jkSqJ2FBypVKBXFmzac+ftVMoGjukm6Lqwx8Jm6ry9HHu6JsL3jq/S
	RA/Kx7JyTepCUChDyOSKBod1t6Xz9BTJaoKxgP4O7z3mabQ+CnVxlKd96MdPYFCE
	ClTVuBPpsrQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 349FB31B6;
	Fri,  7 Jan 2011 18:18:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BB3D131B4; Fri,  7 Jan 2011
 18:18:02 -0500 (EST)
In-Reply-To: <7vsjx449bv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 07 Jan 2011 14\:50\:44 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6331C266-1AB4-11E0-8D8A-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164785>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Here is the test script I worked out which shows the issue (and checks
>> that the right messages are shown to the user):
>
> This is a band-aid that is not quite right (even though it passes the
> tests).  Attempting to check out a branch "frotz" in a repository with a
> tag "frotz" that point at a non-commit would still fail, which is not a
> new problem.
>
>
>  builtin/checkout.c               |    7 +++++++
>  t/t2019-checkout-amiguous-ref.sh |   23 ++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletions(-)

... And this comes on top (should probably be squashed into one) to really
favor a branch over a tag.

 builtin/checkout.c               |   26 ++++++++++----------------
 t/t2019-checkout-amiguous-ref.sh |    2 +-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f6fea2f..48e547b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -832,25 +832,19 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argc--;
 
 		new.name = arg;
-		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
-			setup_branch_path(&new);
+		setup_branch_path(&new);
 
-			if ((check_ref_format(new.path) == CHECK_REF_FORMAT_OK) &&
-			    resolve_ref(new.path, rev, 1, NULL))
-				;
-			else
-				new.path = NULL;
-			if (hashcmp(new.commit->object.sha1, rev))
-				/*
-				 * Yikes, arg is an ambiguous and higher
-				 * precedence SHA-1 expression than the
-				 * branch name
-				 */
-				new.commit = lookup_commit_reference_gently(rev, 1);
+		if ((check_ref_format(new.path) != CHECK_REF_FORMAT_OK) ||
+		    !resolve_ref(new.path, rev, 1, NULL))
+			new.path = NULL; /* not an existing branch */
+
+		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {
+			/* not a commit */
+			source_tree = parse_tree_indirect(rev);
+		} else {
 			parse_commit(new.commit);
 			source_tree = new.commit->tree;
-		} else
-			source_tree = parse_tree_indirect(rev);
+		}
 
 		if (!source_tree)                   /* case (1): want a tree */
 			die("reference is not a tree: %s", arg);
diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
index fa1d4e6..e2b330b 100755
--- a/t/t2019-checkout-amiguous-ref.sh
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -31,7 +31,7 @@ test_expect_success 'checkout reports switch to detached HEAD' '
 	! grep "^HEAD is now at" stderr
 '
 
-test_expect_failure 'checkout vague ref succeeds' '
+test_expect_success 'checkout vague ref succeeds' '
 	git checkout vagueness >stdout 2>stderr &&
 	test_set_prereq VAGUENESS_SUCCESS
 '
