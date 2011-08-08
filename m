From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Tolerate zlib deflation with window size < 32Kb
Date: Mon, 08 Aug 2011 12:23:00 -0700
Message-ID: <7v62m7yagb.fsf@alter.siamese.dyndns.org>
References: <7vhb5x5cgo.fsf@alter.siamese.dyndns.org>
 <1312742773-26373-1-git-send-email-roberto.tyley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Roberto Tyley <roberto.tyley@guardian.co.uk>
To: roberto.tyley@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 08 21:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVPr-0004mK-GK
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab1HHTXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:23:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab1HHTXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:23:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDF43A9B;
	Mon,  8 Aug 2011 15:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AqH3HaKtr3yj9YhCuEjiS86XR6o=; b=BBMJc00aeLcC5ytQkbv+
	i4sLxWFruOPiF8RPvxWK0DRbti5834MXpnsHxQdqwZU0JTwUaflX/sYETfKypvli
	yfDIN28LqGfgfP9JwLbYEfphFFutHTqmwM2zXAJgBThxUr7gN+lxOdkd9KDEDRZa
	y2fUjxw5F2QeIvy/bhslvik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oSVxxL3CsHJe7FdEQLv+j7uWD2+Xxy1uK5SKtn1dGq2mO/
	BY60Tj/nr3souk0dL0d45Z2hQ4y5hX67VkPIeN17WE+140R/8eJajP9ovlWB+nnR
	Vtbf/pMOzFzyVeWJRQWay3xPUMqYeEddTKM4U1b4KaUh/8z8eeU55mq726jjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 541543A9A;
	Mon,  8 Aug 2011 15:23:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC1CC3A99; Mon,  8 Aug 2011
 15:23:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D527A3B8-C1F3-11E0-906C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178974>

roberto.tyley@gmail.com writes:

> +. ./test-lib.sh
> +
> +assert_blob_equals() {
> +	echo -n $2 > expected &&
> +	git cat-file -p $1 > actual &&

Needs proper quoting with dq.

> +	test_cmp expected actual
> +}
> +
> +test_expect_success setup '
> +	cp -R ../t1013/objects .git/
> +	git --version
> +'
> +
> +test_expect_success 'read standard-format loose objects' '
> +	git cat-file tag 8d4e360d6c70fbd72411991c02a09c442cf7a9fa &&
> +	git cat-file commit 6baee0540ea990d9761a3eb9ab183003a71c3696 &&
> +	git ls-tree 7a37b887a73791d12d26c0d3e39568a8fb0fa6e8 &&
> +	assert_blob_equals "257cc5642cb1a054f08cc83f2d943e56fd3ebe99" "foo\n"

Isn't it unportable to expect "\n" to be kept or expanded by "echo"?

Will squash the following in (and I have another patch on top to
consolidate the definition of $LF in this and other test scripts).

Thanks.

-- >8 --
Subject: [PATCH] fixup! Tolerate zlib deflation with window

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1013-loose-object-format.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1013-loose-object-format.sh b/t/t1013-loose-object-format.sh
index b5ac46d..36b4027 100755
--- a/t/t1013-loose-object-format.sh
+++ b/t/t1013-loose-object-format.sh
@@ -26,10 +26,12 @@ standard format, deflated with 4KB window size: Agit/JGit on Android
 '
 
 . ./test-lib.sh
+LF='
+'
 
 assert_blob_equals() {
-	echo -n $2 > expected &&
-	git cat-file -p $1 > actual &&
+	printf "%s" "$2" >expected &&
+	git cat-file -p "$1" >actual &&
 	test_cmp expected actual
 }
 
@@ -42,7 +44,7 @@ test_expect_success 'read standard-format loose objects' '
 	git cat-file tag 8d4e360d6c70fbd72411991c02a09c442cf7a9fa &&
 	git cat-file commit 6baee0540ea990d9761a3eb9ab183003a71c3696 &&
 	git ls-tree 7a37b887a73791d12d26c0d3e39568a8fb0fa6e8 &&
-	assert_blob_equals "257cc5642cb1a054f08cc83f2d943e56fd3ebe99" "foo\n"
+	assert_blob_equals "257cc5642cb1a054f08cc83f2d943e56fd3ebe99" "foo$LF"
 '
 
 test_expect_success 'read experimental-format loose objects' '
-- 
1.7.6.409.ge7a85
