From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach read-tree the -n|--dry-run option
Date: Wed, 25 May 2011 15:30:02 -0700
Message-ID: <7vaaea1kid.fsf@alter.siamese.dyndns.org>
References: <4DDC1DF9.9030109@web.de>
 <7v39k37kmo.fsf@alter.siamese.dyndns.org> <4DDD615E.7020809@web.de>
 <4DDD6241.8070908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 26 00:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPMao-0008BI-VS
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 00:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab1EYWaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 18:30:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab1EYWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 18:30:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 115F1509E;
	Wed, 25 May 2011 18:32:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4H1qzprbyn5z+m0V91UVHW9xGGo=; b=kiudsjyh8zzfI1Qqkquk
	ky5F3G0apN/bn301LGwpIv2uI+dvC2SOX/JGwXVTLylaWGnpRlHwG7gCR/xXKCKv
	gzSBSvuZj37X1xl8wEx7YaeHaaoVRwNG9l3SCoXBqoHH5wRB4UiFjJ0Wyizxdk3O
	lrdQLFTXQdMHcibVGB8kqWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LBrSAiwukgXhx58/BHrLI1U/otIEIHCspH8XdMe4JTlMzn
	bRWJz2PKZnqIstn7eKMa7fU6vScg8FlG2MhUbLhbeqbIRWgpCDt6+DvikOSQKAo6
	J/Tf3oBi0YGR9gKod5RUkLRP01Mgnsl+kcjySSZ+B1Epn+S9tWernYh+vekC4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE749509D;
	Wed, 25 May 2011 18:32:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD3565097; Wed, 25 May 2011
 18:32:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D708C53C-871E-11E0-A91D-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174469>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Using this option tells read-tree to not update the index. That makes it
> possible to check if updating the index would be successful without
> changing anything. Using this option will silently ignore -u but still
> test if updating the work tree would succeed.

I'll reword the above to de-stress "the index" when I queue this patch, as
this is not about the index anymore.  Also I do not think you "silently
ignore" the "-u" option.  Don't you check what would happen when "-u" is
given and checking out the merge result would overwrite the file in the
working tree?  In that scenario, "-u" actively participates in the dry-run
check you implemented.

> diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
> new file mode 100644
> index 0000000..435d19c
> --- /dev/null
> +++ b/t/lib-read-tree.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +#
> +# Helper functions to check if read-tree would succeed/fail as expected with
> +# and without the dry-run option. They also test that the dry-run does not
> +# write the index and that together with -u it doesn't touch the work tree.
> +#
> ...
> +read_tree_u_must_succeed () {
> +    git ls-files -s >pre-dry-run &&
> +    git diff-files >pre-dry-run-wt &&
> +    git read-tree -n "$@" &&
> +    git ls-files -s >post-dry-run &&
> +    git diff-files >post-dry-run-wt &&
> +    test_cmp pre-dry-run post-dry-run &&
> +    test_cmp pre-dry-run-wt post-dry-run-wt &&

As the RHS of diff-files output that represent the working tree status
indicates "contents indeterminate" with 0{40}, this comparison is the same
as comparing what is in the index before and after the dry-run.

> ...
> +read_tree_u_must_fail () {
> +    git ls-files -s >pre-dry-run &&
> +    git diff-files >pre-dry-run-wt &&
> +    test_must_fail git read-tree -n "$@" &&
> +    git ls-files -s >post-dry-run &&
> +    git diff-files >post-dry-run-wt &&
> +    test_cmp pre-dry-run post-dry-run &&
> +    test_cmp pre-dry-run-wt post-dry-run-wt &&
> +    test_must_fail git read-tree "$@"
> +}

Same here.  A few additions of -p will trivially fix them, though.

diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
index 435d19c..abc2c6f 100644
--- a/t/lib-read-tree.sh
+++ b/t/lib-read-tree.sh
@@ -22,10 +22,10 @@ read_tree_must_fail () {
 
 read_tree_u_must_succeed () {
     git ls-files -s >pre-dry-run &&
-    git diff-files >pre-dry-run-wt &&
+    git diff-files -p >pre-dry-run-wt &&
     git read-tree -n "$@" &&
     git ls-files -s >post-dry-run &&
-    git diff-files >post-dry-run-wt &&
+    git diff-files -p >post-dry-run-wt &&
     test_cmp pre-dry-run post-dry-run &&
     test_cmp pre-dry-run-wt post-dry-run-wt &&
     git read-tree "$@"
@@ -33,10 +33,10 @@ read_tree_u_must_succeed () {
 
 read_tree_u_must_fail () {
     git ls-files -s >pre-dry-run &&
-    git diff-files >pre-dry-run-wt &&
+    git diff-files -p >pre-dry-run-wt &&
     test_must_fail git read-tree -n "$@" &&
     git ls-files -s >post-dry-run &&
-    git diff-files >post-dry-run-wt &&
+    git diff-files -p >post-dry-run-wt &&
     test_cmp pre-dry-run post-dry-run &&
     test_cmp pre-dry-run-wt post-dry-run-wt &&
     test_must_fail git read-tree "$@"
