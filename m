From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 15:42:36 -0600
Message-ID: <20110216214236.GC2615@elie>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
 <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:42:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppp9A-0002fL-BP
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab1BPVms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:42:48 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44564 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1BPVmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:42:46 -0500
Received: by wwi17 with SMTP id 17so4793668wwi.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 13:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/qJf/hkgwgoUytmS9bQUlFAzLDlCLPWbI8O2wqxtl/U=;
        b=Op5ziFplJIXDxDcn6fNagV2OVM4p+upsong6GoV14xon6p7lTgJBMmNwWC6T1ByCKy
         8yZXllmw+/kwv0M6xtg1pfVkyxnic5ou3moc7/ckfANrPJIZF8xh42fFJzUX6dKxFxr8
         U1yF2lmC270cEMiGlvfhWyqY+c/sgOfPk9/Us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tpQgtECn2cPxxq2+4eqV6meNXMHNWfQ10GRaEDITjFAJcRSII4Z0KzcVLxaEs6AX5t
         VbeRn9iXNEKXDH3AFb9JcW2ktGjL6tYCWg34pHkBta7a8BtHEBAf6SrtFIjLvEaQTplG
         VUMpCRSVsM4qqyVQcVu9ElyHTjLUjjksJBvBU=
Received: by 10.216.3.3 with SMTP id 3mr945539weg.57.1297892564836;
        Wed, 16 Feb 2011 13:42:44 -0800 (PST)
Received: from elie ([69.209.51.217])
        by mx.google.com with ESMTPS id n11sm92045wej.19.2011.02.16.13.42.41
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 13:42:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167007>

Jay Soffian wrote:

> When a cherry-pick conflicts git advises to use:
>
>  $ git commit -c <original commit id>
>
> to preserve the original commit message and authorship. Instead, let's
> record the original commit id in CHERRY_PICK_HEAD and advise to use:
>
>   $ git commit -c CHERRY_PICK_HEAD
>
> In the next commit, we teach git to handle the '-c CHERRY_PICK_HEAD'
> part. Note that we record CHERRY_PICK_HEAD even in the case where there
> are no conflicts so that we may use it to communicate authorship to
> commit; this will then allow us to remove set_author_ident_env from
> revert.c.

This "In the next commit" phrasing is dangerous, since a person can
build on top of your first commit at any time. :)  I would say:

	A later patch will teach "git commit" without -c to use
	CHERRY_PICK_HEAD to set the authorship automatically. Note
	that[...]

[...]
> +++ b/builtin/revert.c
> @@ -263,6 +279,11 @@ static void print_advice(void)
>  
>  	if (msg) {
>  		fprintf(stderr, "%s\n", msg);
> +		/*
> +		 * rebase interactive takes care of the authorship
> +		 * when the user invokes rebase --continue
> +		 */
> +		unlink(git_path("CHERRY_PICK_HEAD"));

Nit: GIT_CHERRY_PICK_HELP is not just for rebase --interactive but
for arbitrary porcelain that wants to take care of the commit itself
(see v1.5.4-rc0~106^2~1, revert/cherry-pick: Allow overriding the
help text by the calling Porcelain, 2007-11-28).

The conservative thing to do is indeed to remove CHERRY_PICK_HEAD in
this case, I suppose.  But I'd like to have the CHERRY_PICK_HEAD to
get the --amend safety when rebasing.  I can send a separate patch
for it if you'd like.

> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -11,6 +11,12 @@ test_description='test cherry-pick and revert with conflicts
[...]
> +test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '

Some more tests.  Yes, they are repetitive.  A patch on top to factor
out the setup into a function might help, but that feels out of scope
here.

With whatever subset of the below looks good,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
 t/t3507-cherry-pick-conflict.sh |  116 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index fd569c8..ea52720 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -78,6 +78,122 @@ test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	test_cmp_rev picked CHERRY_PICK_HEAD
 '
 
+test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	git cherry-pick base &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'cherry-pick --no-commit sets CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	git cherry-pick --no-commit base &&
+
+	test_cmp_rev base CHERRY_PICK_HEAD
+'
+
+test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	(
+		GIT_CHERRY_PICK_HELP="and then do something else" &&
+		export GIT_CHERRY_PICK_HELP &&
+		test_must_fail git cherry-pick picked
+	) &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+	git reset &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+	test_must_fail git commit &&
+
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
+test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	git update-index --refresh -q &&
+	test_must_fail git diff-index --exit-code HEAD &&
+	(
+		GIT_EDITOR=false &&
+		export GIT_EDITOR &&
+		test_must_fail git commit
+	) &&
+
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
+test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	git commit &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'failed cherry-pick produces dirty index' '
 
 	git checkout -f initial^0 &&
-- 
1.7.4.1
