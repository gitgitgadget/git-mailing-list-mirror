From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 15:58:36 -0700
Message-ID: <7vaa0yzeqr.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
 <7vipfmzfel.fsf@alter.siamese.dyndns.org>
 <7vehqazf9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>, Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu May 24 00:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXKVw-0001wb-KT
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab2EWW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 18:58:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab2EWW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 18:58:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87F9C82D6;
	Wed, 23 May 2012 18:58:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1HNDAVHS8oslihhDdfv6QExFGfo=; b=gve8cJ
	am/fZuas5uvjRsClpcDnsoXUWa5Y3N9IxjPHAiOvda9Gd4iHSNwotJsQ5n1R2IxN
	U1yXiWf3YlI7dZdPWJ44kodpW7Y1CZi183fC4oDheBkvNc6dB+sdlLYToZmqkDHc
	X9C+soTHZTvrgt/aPjdsmegtYNf4LwstZ64P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rqlqOhoKnLf4icDw6CgYEuWuelen+GaY
	UEsXS8EKuAxnihEcCbLl57y0bI1SBVtv1QnyS7WnpSYOKQ/F1XZPa/I21MyGIh8D
	W4MKV3iDnWfQI13dQwCDiM+53RO7Hdn/uXNjB+JZPffur6YC9PTIzajEe+QJ3ll7
	sbOLUflCp7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA6382D4;
	Wed, 23 May 2012 18:58:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0384E82D3; Wed, 23 May 2012
 18:58:37 -0400 (EDT)
In-Reply-To: <7vehqazf9d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 May 2012 15:47:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D519964A-A52A-11E1-915B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198334>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phil Hord <hordp@cisco.com> writes:
>>
>>> In git.git 'master' when I cherry-pick a commit which is eventually
>>> empty, git gives me a friendly description of my supposed error, leaves
>>> my cherry-pick "pending" and exits with an error code.
>>> ...
>>> In 'next' this is broken.

The above was written back when nh/empty-rebase topic was not in 'master'
yet.

The attached will help reproducing it.

 t/t3505-cherry-pick-empty.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 92f00cd..bd06981 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -23,8 +23,19 @@ test_expect_success setup '
 	git checkout master &&
 	git checkout -b empty-branch2 &&
 	test_tick &&
-	git commit --allow-empty -m "empty"
+	git commit --allow-empty -m "empty" &&
+
+	git checkout master &&
+	echo second >>file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "second" &&
 
+	git checkout -b merge-to-empty master^ &&
+	echo second >>file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "will merge to empty"
 '
 
 test_expect_success 'cherry-pick an empty commit' '
@@ -40,7 +51,13 @@ test_expect_success 'index lockfile was removed' '
 
 '
 
+test_expect_failure 'cherry-pick to result in empty' '
+	git checkout master^0 &&
+	test_must_fail git cherry-pick merge-to-empty
+'
+
 test_expect_success 'cherry-pick a commit with an empty message' '
+	git reset --hard &&
 	git checkout master && {
 		git cherry-pick empty-branch
 		test "$?" = 1
