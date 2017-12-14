Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D321F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbdLNVJe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:09:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55833 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752361AbdLNVJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:09:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADF32C980D;
        Thu, 14 Dec 2017 16:09:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Li4ByWgHjkoOu6HpE9X088SsFDs=; b=AHViJp
        2mH7wYx0sXbUhy5pb2aDhItLTxJ2y89z+1txXqMIJg2by6y4JGLvctKykUM/Npa8
        pin9Eri2EJ8+/ebS7ZhYosXgYgKhTFlaaz61orB8Jd38JRiNChyYrpiWDL3vtuGP
        zmxlzvCA0GQgLY2EALM/G3nrGo2Ne1glEVdtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MFXe94vxtz4lgVu17DWbA1MzRl9TyyGA
        K4CDSV1l6vajZ7S/zHVLol9QPbNj7GYFt+3uBqteZQmAnB0XPF/wiNHYIC2CqAe3
        TtReyk8x2FSWUJCOAAlfMn8nGHEdMROxn4fs2dj0CYArWI6ZtkPldHs5+PBH2Qcy
        ywP7rloFgbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A615BC980C;
        Thu, 14 Dec 2017 16:09:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20219C980B;
        Thu, 14 Dec 2017 16:09:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v4 3/3] rebase: rebasing can also be done when HEAD is detached
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <1513255038.6351.2.camel@gmail.com>
        <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 13:09:32 -0800
In-Reply-To: <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 14 Dec 2017 09:20:38 -0800")
Message-ID: <xmqqshcdrp83.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 150689DC-E113-11E7-8EC0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Mon, 27 Nov 2017 22:51:04 +0530

Attempting to rebase when the HEAD is detached and is already
up to date with upstream (so there's nothing to do), the
following message is shown

        Current branch HEAD is up to date.

which is clearly wrong as HEAD is not a branch.

Handle the special case of HEAD correctly to give a more precise
error message.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e5adb596a0..f3dd864437 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -601,11 +601,23 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		if test "$branch_name" = "HEAD" &&
+			 !(git symbolic-ref -q HEAD)
+		then
+			say "$(eval_gettext "HEAD is up to date.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		fi
 		finish_rebase
 		exit 0
 	else
-		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		if test "$branch_name" = "HEAD" &&
+			 !(git symbolic-ref -q HEAD)
+		then
+			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		fi
 	fi
 fi
 
-- 
2.15.1-554-g7ec1e7e2b9

