Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9531FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdAFVb2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:31:28 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:32875 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbdAFVb1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 16:31:27 -0500
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 4A8E7258066;
        Fri,  6 Jan 2017 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version; s=novalis.org;
         bh=7t30wnQEX4PTz3FGhCx4S4Uw71g=; b=BDL0rVy9h2vXVtcTTJ/hbemrsqr0
        tuhvW1TAHZnqkHfgDicemLJP20F15H4Apb5ZZAzNrMyTVUiSq64OWMKKLVyPJhvP
        zHhX1LFR7zjJ004VS5ZoOUa+DOEtMWng/Ymm/uKub+b11TyB9JwqlMORfYhNNg2T
        LOoQK3uCtGnfWtI=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id E7AB2258062;
        Fri,  6 Jan 2017 13:31:25 -0800 (PST)
Message-ID: <1483738284.31165.6.camel@frank>
Subject: minor bug: git submodule update --init from a subdir shows wrong
 path
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org, sbeller@google.com
Date:   Fri, 06 Jan 2017 16:31:24 -0500
Content-Type: multipart/mixed; boundary="=-UB5Ppjzr9bwKsmTt06xw"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-UB5Ppjzr9bwKsmTt06xw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I believe (from bisection) that this was introduced in the transition to
C at 3604242f080.

I've attached a repro (against master).  At the time the bug was
introduced, the output in question went to stdout instead of stderr, so
the attached test case will not quite work on the older version.  But if
you run under -v, you'll be able to see the bad ("foo/foo/sub" instead
of "foo/sub" or just "sub") output.



--=-UB5Ppjzr9bwKsmTt06xw
Content-Disposition: attachment; filename="wrong-submodule-path.patch"
Content-Type: text/x-patch; name="wrong-submodule-path.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 64f322c..e1deb17 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -140,6 +140,23 @@ test_expect_success 'submodule update --init --recursive from subdirectory' '
 	test_i18ncmp expect2 actual2
 '
 
+cat <<EOF >expect2
+Submodule 'foo/sub' (/home/novalis/twosigma/git/t/trash directory.t7406-submodule-update/withsubs/../rebasing) registered for path 'foo/sub'
+EOF
+
+test_expect_success 'submodule update --init from and of subdirectory' '
+	git init withsubs &&
+	(cd withsubs &&
+	 mkdir foo &&
+	 git submodule add "$(pwd)/../rebasing" foo/sub &&
+	 (cd foo &&
+	  git submodule deinit -f sub &&
+	  git submodule update --init sub 2>../../actual2
+	 )
+	) &&
+	test_i18ncmp expect2 actual2
+'
+
 apos="'";
 test_expect_success 'submodule update does not fetch already present commits' '
 	(cd submodule &&

--=-UB5Ppjzr9bwKsmTt06xw--

