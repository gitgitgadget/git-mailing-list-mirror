From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-base: fix duplicates and not best ancestors in output
Date: Mon, 30 Dec 2013 12:06:28 -0800
Message-ID: <xmqqy532qf23.fsf@gitster.dls.corp.google.com>
References: <CABEtfDFu=Fc0SXbyFctEyiMCJwqxP25K9mdVhAB0X_vKHxvW_A@mail.gmail.com>
	<xmqqppoerwnm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: =?iso-2022-jp?B?GyRCJyMnUSdjJ1onXSdaJ1sbKEIgGyRCJy4nUSdcJ1EnYidgGyhC?=
	 =?iso-2022-jp?B?GyRCJ1MbKEI=?= <einmalfel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxj6i-0007Kc-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab3L3UGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:06:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146Ab3L3UGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:06:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B4275FD52;
	Mon, 30 Dec 2013 15:06:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=foKf/juFpE2IRd+5td5cRwESedQ=; b=OCL/87
	zNi88bMUJdmfjiFrUZyjBCMv8UwX29qeUmUVy7iEoLt6KbhEyfCVUBgbvelC9A7L
	DrwwLRqjNiOrYkvFZAYOvHIsPI0ApTALATABgTZRdpZHnipqrXRHRczK0iXEo6mr
	I1MydFKPNGeQWK+JYtHKjkWGdTrHvKcMsnbH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nb8nhb9+WM9yQweWj2d13REoNbsHkCCV
	uW3zhXqVSm9ckN36khKEszJeFDoCWLT4BjlRbNRIVRip+rAKIj3XfosTYIAMywA5
	LaAgMUTj2oaAS5cH3L72oDt5w3kYWNZ+H3Lb8l9n8OpsOMrdo0dnkpF6VURQJtrw
	QBQnH/Rfcxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2164C5FD51;
	Mon, 30 Dec 2013 15:06:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2585FD4F;
	Mon, 30 Dec 2013 15:06:30 -0500 (EST)
In-Reply-To: <xmqqppoerwnm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 Dec 2013 11:01:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF6AB3D2-718D-11E3-A1D4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239820>

Junio C Hamano <gitster@pobox.com> writes:

> I do not offhand remember if it was deliberate that we do not dedup
> the result from the underlying get_octopus_merge_bases() (the most
> likely reason for not deduping is because the caller is expected to
> do that if it wants to).
>
> Whether it is an improvement to force deduping here or it is an
> regression to do so, I think we should split that helper function
> handle_octopus().  It does two totally unrelated things (one is only
> to list independent heads without showing merge bases, the other is
> to show one or more merge bases across all the heads given).
> Perhaps if we split the "independent" codepath introduced by
> a1e0ad78 (merge-base --independent to print reduced parent list in a
> merge, 2010-08-17) into its own helper function, like this, it would
> make it clear what is going on.

And assuming that deduping is the right thing to do here, here is a
follow-up on top of the spliting patch.

-- >8 --
Subject: [PATCH] merge-base --octopus: reduce the result from get_octopus_merge_bases()

Scripts that use "merge-base --octopus" could do the reducing
themselves, but most of them are expected to want to get the reduced
results without having to do any work themselves.

Tests are taken from a message by Василий Макаров
<einmalfel@gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 We might want to vet the existing callers of the underlying
 get_octopus_merge_bases() and find out if _all_ of them are doing
 anything extra (like deduping) because the machinery can return
 duplicate results. And if that is the case, then we may want to
 move the dedupling down the callchain instead of having it here.

 builtin/merge-base.c  |  2 +-
 t/t6010-merge-base.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index daa96c7..87f4dbc 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -73,7 +73,7 @@ static int handle_octopus(int count, const char **args, int show_all)
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = get_octopus_merge_bases(revs);
+	result = reduce_heads(get_octopus_merge_bases(revs));
 
 	if (!result)
 		return 1;
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f80bba8..abb5728 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -230,4 +230,43 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
 	test_cmp expected.sorted actual.sorted
 '
 
+test_expect_success 'merge-base --octopus --all for complex tree' '
+	# Best common ancestor for JE, JAA and JDD is JC
+	#             JE
+	#            / |
+	#           /  |
+	#          /   |
+	#  JAA    /    |
+	#   |\   /     |
+	#   | \  | JDD |
+	#   |  \ |/ |  |
+	#   |   JC JD  |
+	#   |    | /|  |
+	#   |    |/ |  |
+	#  JA    |  |  |
+	#   |\  /|  |  |
+	#   X JB |  X  X
+	#   \  \ | /   /
+	#    \__\|/___/
+	#        J
+	test_commit J &&
+	test_commit JB &&
+	git reset --hard J &&
+	test_commit JC &&
+	git reset --hard J &&
+	test_commit JTEMP1 &&
+	test_merge JA JB &&
+	test_merge JAA JC &&
+	git reset --hard J &&
+	test_commit JTEMP2 &&
+	test_merge JD JB &&
+	test_merge JDD JC &&
+	git reset --hard J &&
+	test_commit JTEMP3 &&
+	test_merge JE JC &&
+	git rev-parse JC >expected &&
+	git merge-base --all --octopus JAA JDD JE >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.5.2-311-g6427a96
