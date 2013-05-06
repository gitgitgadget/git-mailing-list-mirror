From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] t6111: new TREESAME test set
Date: Mon, 06 May 2013 12:37:46 -0700
Message-ID: <7vmws7rjat.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367767977-14513-4-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 06 21:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZRES-0003TA-6g
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab3EFThv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:37:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755865Ab3EFThu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:37:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6331B1CF40;
	Mon,  6 May 2013 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L7o2T32VzMHiQ0z4wJUxY+LkBpM=; b=VFtr/V
	FcK/uFBJHvsV6TLOHLCRPirMTDyWykNfisfR+kcJ1McHle6vz69JssxEiSQGxV7N
	fVYFiZcuF4L6cg4GjJDgDht8FSHFwG8k+sdnbC5F+q7UTWxV80R4PrdflOMQOFf7
	M5bR5UjJG5WWVZjStwyz9aEo3aZ+LLuE+ISU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrXV/GuYvUJrQ6bu/BPxYi5PmJSFCoH2
	jMyrVHUtOX8vxdoxxm/TgPPeHDRYvY8JOvU1F42YDicMiqLjWn6Mtbo5AtkMLpmB
	vHs35d4BhZxMjfpt2zDLPZtDjeEPwlDx84LRN8gVgWnTZkbk1SjHC90ooHHWayMH
	sgzG3vlEooE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 580981CF3F;
	Mon,  6 May 2013 19:37:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 676091CF3B;
	Mon,  6 May 2013 19:37:48 +0000 (UTC)
In-Reply-To: <1367767977-14513-4-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Sun, 5 May 2013 18:32:51 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EBCB6AE-B684-11E2-8183-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223500>

Kevin Bracey <kevin@bracey.fi> writes:

> Some side branching and odd merging to illustrate various flaws in
> revision list scans, particularly when limiting the list.
>
> Many expected failures, which will be gone by the end of the "history
> traversal refinements" series.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  t/t6111-rev-list-treesame.sh | 180 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100755 t/t6111-rev-list-treesame.sh
>
> diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
> new file mode 100755
> index 0000000..602c02d
> --- /dev/null
> +++ b/t/t6111-rev-list-treesame.sh
> @@ -0,0 +1,180 @@
> +#!/bin/sh
> +#
> +#        ,---E--.   *H----------.             * marks !TREESAME parent paths
> +#       /        \ /             \*
> +# *A--*B---D--*F-*G---------K-*L-*M
> +#   \     /*       \       /
> +#    `-C-'          `-*I-*J
> +#
> +# A creates "file", B and F change it.
> +# Odd merge G takes the old version from B.
> +# I changes it, but J reverts it.
> +# H and L both change it, and M merges those changes.

... and because J is a revert of I, K ends up merging the same and
being the same with both G and J.

> +test_description='TREESAME and limiting'
> +
> +. ./test-lib.sh
> +
> +note () {
> +	git tag "$1"
> +}
> +
> +unnote () {
> +	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
> +}
> +
> +test_expect_success setup '
> +	test_commit "Initial file" file "Hi there" A &&
> +	git branch other-branch &&
> +
> +	test_commit "file=Hello" file "Hello" B &&
> +	git branch third-branch &&
> +
> +	git checkout other-branch &&
> +	test_commit "Added other" other "Hello" C &&
> +
> +	git checkout master &&
> +	test_merge D other-branch &&
> +
> +	git checkout third-branch &&
> +	test_commit "Third file" third "Nothing" E &&
> +
> +	git checkout master &&
> +	test_commit "file=Blah" file "Blah" F &&
> +
> +	test_tick && git merge --no-commit third-branch &&
> +	git checkout third-branch file &&
> +	git commit &&
> +	note G &&
> +	git branch fiddler-branch &&
> +
> +	git checkout -b part2-branch &&
> +	test_commit "file=Part 2" file "Part 2" H &&
> +
> +	git checkout fiddler-branch &&
> +	test_commit "Bad commit" file "Silly" I &&
> +
> +	test_tick && git revert I && note J &&
> +
> +	git checkout master &&
> +	test_tick && git merge --no-ff fiddler-branch &&
> +	note K
> +
> +	test_commit "file=Part 1" file "Part 1" L &&
> +
> +	test_tick && test_must_fail git merge part2-branch &&
> +	test_commit M file "Parts 1+2"
> +'
> +
> +FMT='tformat:%P 	%H | %s'
> +
> +# could we soup this up to optionally check parents? So "(BA)C" would check
> +# that C is shown and has parents B A.

Sounds like a good thing to do, especially given that some of the
earlier issues you brought up triggered only when --parents is not
used, so...

Perhaps something like the attached.

> +check_outcome () {
> +	outcome=$1
> +	shift
> +	for c in $1
> +	do
> +		echo "$c"
> +	done >expect &&

Maybe

	printf "%s\n" $1 >expect

is more fashionable these days?

> +# Odd merge G drops a change in F. Important that G is listed in all
> +# except the most basic list. Achieving this means normal merge D will also be
> +# shown in normal full-history, as we can't distinguish unless we do a
> +# simplification pass. After simplification, D is dropped but G remains.
> +check_result 'M L K J I H G F E D C B A'

I'll read the expectation and comment on them in a separate message.

 t/t6111-rev-list-treesame.sh | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 602c02d..f4c9cac 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -20,7 +20,7 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
+	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\))\([ 	]\)|\1\2|g"
 }
 
 test_expect_success setup '
@@ -66,23 +66,34 @@ test_expect_success setup '
 	test_commit M file "Parts 1+2"
 '
 
-FMT='tformat:%P 	%H | %s'
-
 # could we soup this up to optionally check parents? So "(BA)C" would check
 # that C is shown and has parents B A.
 check_outcome () {
 	outcome=$1
 	shift
-	for c in $1
-	do
-		echo "$c"
-	done >expect &&
-	shift &&
+
+	case "$1" in
+	*"("*)
+		FMT="%P	%H | %s"
+		munge_actual="
+			s/^\([^	]*\)	\([^ ]*\) .*/(\1)\2/
+			s/ //g
+			s/()//
+		"
+		;;
+	*)
+		FMT="%H | %s"
+		munge_actual="s/^\([^ ]*\) .*/\1/"
+		;;
+	esac &&
+	printf "%s\n" $1 >expect &&
+	shift
+
 	param="$*" &&
 	test_expect_$outcome "log $param" '
 		git log --format="$FMT" $param |
 		unnote >actual &&
-		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
+		sed -e "$munge_actual" <actual >check &&
 		test_cmp expect check || {
 			cat actual
 			false
@@ -99,6 +110,7 @@ check_result () {
 # shown in normal full-history, as we can't distinguish unless we do a
 # simplification pass. After simplification, D is dropped but G remains.
 check_result 'M L K J I H G F E D C B A'
+check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FE)G (D)F (B)E (BC)D (A)C (A)B A'
 check_result 'M H L K J I G E F D C B A' --topo-order
 check_result 'M L H B A' -- file
 check_result 'M L H B A' --parents -- file
