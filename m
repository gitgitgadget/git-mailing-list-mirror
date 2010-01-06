From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Wed, 06 Jan 2010 13:59:10 -0800
Message-ID: <7vzl4qopxt.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <1262122958-9378-10-git-send-email-gitster@pobox.com>
 <4B43AE38.9070800@kdbg.org> <7v4on0oxcs.fsf@alter.siamese.dyndns.org>
 <4B444FF9.1000004@kdbg.org> <7vr5q31871.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSduV-00040j-VH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 22:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907Ab0AFV7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 16:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902Ab0AFV7T
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 16:59:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579Ab0AFV7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 16:59:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA2A8E7AC;
	Wed,  6 Jan 2010 16:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uVBqL63GO1Wwzxl0bBqusEuavWk=; b=ba2Qpi
	XjQz0KMvh717bNaA3vqKcNCk+HOyDjB3dcN3Li3t8BkKZXOEV4RSh9v0CK1/Sp+F
	2wxlT8/XdRBRDjptn2+qGcLebyBc0kpMEvvCbbhqYbD3OFzT3mxwG3fyMAWcd9dn
	ehVxslbpzMyrO6+k1lQy8PzfCsRPmPtG/Dwuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybZxSTUhofK7cA+rWq9WzKCc6a94joK2
	NsIcgYwd/wYQvqisOl52bArj2h1IpHSqPDaLeomv7abw0Voo4OymGb4YA013BMvn
	+FW5K7MWgIYl8OPophZ+GH+vmibS26HmrV0TfHc1si1RdY/ALsqm9oAcVjCuiOsY
	FEK3yrcrS+E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 133A88E7AB;
	Wed,  6 Jan 2010 16:59:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38B0F8E7AA; Wed,  6 Jan
 2010 16:59:12 -0500 (EST)
In-Reply-To: <7vr5q31871.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 06 Jan 2010 08\:58\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAD6C262-FB0E-11DE-AE1C-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136302>

Junio C Hamano <gitster@pobox.com> writes:

> However, I think you need this fix for "checkout -m" to work as intended,

Here is a cleaner reroll with tests, meant to be applied on v1.6.1-rc1 or
later.

-- >8 --
Subject: [PATCH] checkout -m path: fix recreating conflicts

We should tell ll_merge() that the 3-way merge between stages #2 and #3 is
an outermost merge, not a virtual-ancestor creation.

Back when this code was originally written, users couldn't write custom
merge drivers easily, so the bug didn't matter, but these days it does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    2 +-
 t/t7201-co.sh      |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 7f3bd7b..e41e73b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -179,7 +179,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	fill_mm(active_cache[pos+2]->sha1, &theirs);
 
 	status = ll_merge(&result_buf, path, &ancestor,
-			  &ours, "ours", &theirs, "theirs", 1);
+			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0e21632..3214ad2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -534,4 +534,61 @@ test_expect_success 'failing checkout -b should not break working tree' '
 
 '
 
+(
+ echo "#!$SHELL_PATH"
+ cat <<\EOF
+O=$1 A=$2 B=$3
+cat "$A" >.tmp
+exec >"$A"
+echo '<<<<<<< filfre-theirs'
+cat "$B"
+echo '||||||| filfre-common'
+cat "$O"
+echo '======='
+cat ".tmp"
+echo '>>>>>>> filfre-ours'
+rm -f .tmp
+exit 1
+EOF
+) >filfre.sh
+chmod +x filfre.sh
+
+test_expect_success 'custom merge driver with checkout -m' '
+	git reset --hard &&
+
+	git config merge.filfre.driver "./filfre.sh %O %A %B" &&
+	git config merge.filfre.name "Feel-free merge driver" &&
+	git config merge.filfre.recursive binary &&
+	echo "arm merge=filfre" >.gitattributes &&
+
+	git checkout -b left &&
+	echo neutral >arm &&
+	git add arm .gitattributes &&
+	test_tick &&
+	git commit -m neutral &&
+	git branch right &&
+
+	echo left >arm &&
+	test_tick &&
+	git commit -a -m left &&
+	git checkout right &&
+
+	echo right >arm &&
+	test_tick &&
+	git commit -a -m right &&
+
+	test_must_fail git merge left &&
+	(
+		for t in filfre-common left right
+		do
+			grep $t arm || exit 1
+		done
+		exit 0
+	) &&
+
+	mv arm expect &&
+	git checkout -m arm &&
+	test_cmp expect arm
+'
+
 test_done
-- 
1.6.6.184.ge163d
