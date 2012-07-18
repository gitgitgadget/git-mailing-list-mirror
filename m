From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Tue, 17 Jul 2012 22:08:59 -0700
Message-ID: <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
 <20120717041603.GD20945@sigill.intra.peff.net>
 <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
To: "Jakub Vrana" <jakub@vrana.cz>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:09:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrMVZ-0005jo-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 07:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab2GRFJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 01:09:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab2GRFJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 01:09:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC99B648D;
	Wed, 18 Jul 2012 01:09:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYc+ekDXcv/Qdmf5BUtrmVjikeI=; b=oLU42n
	XPDcSZtv6AIOAfCHe9F86R7Q30eM+QOdisnh+TdA+WMgS+c/zZ61DCYCXcXvmfh0
	BgeBilOt3nuMjTf9SOz4B8Hr538JcxMJSeezVOk0HADIN24QgVSecig+yJopB/d2
	1wcbOlJ2gwCgBukcGkSBPBqfWZesSo538Y4S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TiPsWaGgX4njaV4oPwzcqQGct/0WL7Fd
	Sb/KDpAN/y5FjdTDCtOO+unaVFTn2NBJodF8wFaJryO4yvJbE1367OPEafg3H70Z
	STrw6oFuqJW5oJ4w8uEcm1SKhksKduTZqG0GyNMqEkEU82+baJuvGmvv8Cq56dAR
	aCszQtRTf2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD4F648C;
	Wed, 18 Jul 2012 01:09:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDDF8648B; Wed, 18 Jul 2012
 01:09:00 -0400 (EDT)
In-Reply-To: <000e01cd6481$bbd63970$3382ac50$@vrana.cz> (Jakub Vrana's
 message of "Tue, 17 Jul 2012 18:07:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFA7D5C4-D096-11E1-9B28-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201645>

"Jakub Vrana" <jakub@vrana.cz> writes:

> Yes, I was fixing the invalid (!pgm) condition, sorry for a non-precise description.
>
> Does it mean that my patch is accepted or is there something else I need to do?

The impression I got from Peff's review was that the problem
description in the proposed commit log message did not describe the
reality at all, and the added three lines did not do what the
message implied they do.  So I do not see how it can be acceptable
by anybody.

It also needs a test to protect this fix from being broken by other
people in the future.

I've followed the codepath myself, and here is what I would have
liked the submitted patch to look like.  Note that run_diff_cmd()
no longer needs to reset pgm to NULL based on ALLOW_EXTERNAL, but
it still needs to look at it to decide if per-path external userdiff
needs to be called.

-- >8 --
Subject: diff: correctly disable external_diff with --no-ext-diff

Upon seeing a type-change filepair, "diff --no-ext-diff" does not
show the usual "deletion followed by addition" split patch and does
not run the external diff driver either.

This is because the logic to disable external diff was placed at a
wrong level in the callchain.  run_diff_cmd() decides to show the
split patch only when external diff driver is not configured or
specified via GIT_EXTERNAL_DIFF environment, but this is done before
checking if --no-ext-diff was given.  To make things worse,
run_diff_cmd() checks --no-ext-diff and disables the output for such
a filepair completely, as the callchain below it (e.g. builtin_diff)
does not want to handle typechange filepairs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The use of userdiff_find_by_path() in run_diff_cmd() may be iffy;
   it is probably OK to override diff.external with a more specific
   per-path configuration, but I think an external diff specified by
   the GIT_EXTERNAL_DIFF environment may want to trump the
   configured per-path one, as an environment is a stronger one-shot
   request.

   But this patch is not about changing that semantics, so I left it
   as-is. 

 diff.c                   |  8 +++++---
 t/t4020-diff-external.sh | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 208096f..62cbe14 100644
--- a/diff.c
+++ b/diff.c
@@ -2992,9 +2992,8 @@ static void run_diff_cmd(const char *pgm,
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 	int must_show_header = 0;
 
-	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
-		pgm = NULL;
-	else {
+
+	if (DIFF_OPT_TST(o, ALLOW_EXTERNAL)) {
 		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
 		if (drv && drv->external)
 			pgm = drv->external;
@@ -3074,6 +3073,9 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
+	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
+		pgm = NULL;
+
 	if (DIFF_PAIR_UNMERGED(p)) {
 		run_diff_cmd(pgm, name, NULL, attr_path,
 			     NULL, NULL, NULL, o, p);
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 533afc1..5a5f68c 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -48,7 +48,26 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 
 '
 
+test_expect_success SYMLINKS 'typechange diff' '
+	rm -f file &&
+	ln -s elif file &&
+	GIT_EXTERNAL_DIFF=echo git diff  | {
+		read path oldfile oldhex oldmode newfile newhex newmode &&
+		test "z$path" = zfile &&
+		test "z$oldmode" = z100644 &&
+		test "z$newhex" = "z$_z40" &&
+		test "z$newmode" = z120000 &&
+		oh=$(git rev-parse --verify HEAD:file) &&
+		test "z$oh" = "z$oldhex"
+	} &&
+	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >actual &&
+	git diff >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'diff attribute' '
+	git reset --hard &&
+	echo third >file &&
 
 	git config diff.parrot.command echo &&
 
