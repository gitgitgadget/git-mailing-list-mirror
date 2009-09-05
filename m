From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sat, 05 Sep 2009 10:46:42 -0700
Message-ID: <7vab191dz1.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Haas <haas@debian.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjzLp-0005db-4H
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 19:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbZIERqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 13:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZIERqw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 13:46:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZIERqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 13:46:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 909EC45542;
	Sat,  5 Sep 2009 13:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w1M2aHdDx1cUY/fcrYDUYcPM57k=; b=jQYWKW
	QPjFGbeqQzOGFq2xx0RnIEW+hBSEX31WWLJSan0qph1cFUm1jIVlU93GQGwthyKd
	UR5l7x1b8ex8lkEoe4mMR2diQ3qZzDM8fx94FjvaBjXltBIbF2fIDcKke8K4X0vq
	l14D+N4TV4scqzUPKH8SA9YMWWXpTGh2Z6JwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+Ju6rK6Glms2cjq2cYGPkEvKyJHSUOw
	3xBf3gnVePULzkRIBM//A6elFItEtKN8kFXGq1Vod2ZtQ0xaZ/qmLq4Fiv7AAWaq
	YCa2zfXeFyR8kWPlvxOdhPLOcGflUcbuuVo0MTd2CcLKRKErusxjTgS469sHMwXi
	Jr8U3xkYzRw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 66A5C45541;
	Sat,  5 Sep 2009 13:46:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB88345540; Sat,  5 Sep 2009
 13:46:43 -0400 (EDT)
In-Reply-To: <20090904234552.GA43797@gmail.com> (David Aguilar's message of
 "Fri\, 4 Sep 2009 16\:45\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17198676-9A44-11DE-85B4-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127823>

David Aguilar <davvid@gmail.com> writes:

> Does anyone else on the list have any insights?

Yes; the problem does not have anything to do with renames but
unfortunately is much deeper.  See $gmane/127783.

Here is a reproduction recipe for the lowest-level ingredient of the
breakage in "git read-tree -m"that needs to be fixed, before we can start
looking at what "git merge-recursive" does incorrectly (if any) and what
"git merge" does incorrectly (again, if any).

 t/t1004-read-tree-m-u-wf.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index f19b4a2..055bb00 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -238,4 +238,27 @@ test_expect_success 'D/F recursive' '
 
 '
 
+################################################################
+
+test_expect_failure 'D/F D-F' '
+	git reset --hard &&
+	git rm -f -r . &&
+
+	mkdir t && echo 1 >t/f && git add t &&
+	git tag ONE $(git write-tree) &&
+
+	echo 3 >t-f && echo 3 >t/f && git add t-f t &&
+	git tag THREE $(git write-tree) &&
+
+	git rm -f -r t &&
+	echo 2 >t && echo 2 >t-f && git add t t-f &&
+	git tag TWO $(git write-tree) &&
+	git commit -a -m TWO &&
+
+	test_must_fail git read-tree -m -u ONE TWO THREE &&
+	git ls-files -u >actual &&
+	grep t/f actual &&
+	grep t-f actual
+'
+
 test_done
