From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] merge-recursive triggered "BUG"
Date: Thu, 17 Mar 2011 14:45:03 -0700
Message-ID: <7vpqpp1kww.fsf@alter.siamese.dyndns.org>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0L0U-0004Kw-32
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 22:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab1CQVpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 17:45:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab1CQVpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 17:45:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE3264A59;
	Thu, 17 Mar 2011 17:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0rDc+qCfd50H5i674F7KIeeHZvQ=; b=smccaI
	nqDaovawa7g36d18MfahiIWhEARDe2onynuyu2zyINwomcRXOMx462kBjJofz9T8
	Qf+JstrCenpIQxGDScCcUpKoXvLX7L9i6V9zsJIP1WmX7yBABqdEr143pUtshfnO
	0GXOvB0QK4UI0mqWcR/oapFfELmsBSOk9Qhbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dOraIDnj2cKam+Lb3Mazd5ht2hovX1uL
	u3sQ+QdPibpjyIGIUHmf5m0GkQVC27uMKcpmjpHMkZ7cSaeB6qGMjdq0nx7p+jQ/
	HlfgaFahNykmi0lZzjTFzlMR40jK6qTzLgGjKpnJWzml3DuwwHXHMCRdSFZdRn2x
	Bt6jFAqUudE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCCE34A54;
	Thu, 17 Mar 2011 17:46:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA0B94A50; Thu, 17 Mar 2011
 17:46:39 -0400 (EDT)
In-Reply-To: <7v4o7260no.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Mar 2011 17:39:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C170038-50E0-11E0-A588-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169281>

To illustrate the issue a bit better, with this patch applied on top of
the en/merge-recursive topic, we get the same errors:

    Merging:
    31734dd Renamed and modified
    virtual merge-branch-1
    found 1 common ancestor(s):
    13277ae Common commmit
    Skipped rename (merged same as existing)
    error: addinfo_cache failed for path 'rename'
    rename: unmerged (f00c965d8307308469e537302baa73048488f162)
    rename: unmerged (3bb459b831ea471b9cd1cbb7c6d54a74251a711b)
    rename: unmerged (f00c965d8307308469e537302baa73048488f162)
    fatal: git write-tree failed to write a tree

In the test case, the merge machinery should notice that the result of the
merge structurally place the merge result in the path "rename", and the
content of the resulting blob matches what our side already have, so we
should end up with a clean merge in the index (the index has the same blob
as the HEAD at path "rename"), keeping the updated contents in the working
tree.

 t/t6022-merge-rename.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 7d955c1..94b9c00 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -730,6 +730,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 
 test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
+	echo modified >>rename &&
 	test-chmtime =1000000000 rename &&
 	test-chmtime -v +0 rename >expect &&
 	git merge merge-branch-1 &&
