Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8970C83F14
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbjH3Wcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjH3Wcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 18:32:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC3B0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 15:32:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C95D81BA5BE;
        Wed, 30 Aug 2023 18:32:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ucV9FBO4jNtwqM3nI9R9jdNKe973TCqOTS2cfd
        6qdis=; b=v1MC1beHvTpz+9xCooVo01N++jv2rwn2aNvWKp8OVFEhw5R1tPPGj1
        S2dis+k8mWsmtRrfVpi7CFxMn9liMEC70RHrhgIvUT1y1oizAFo1jk2gMUsPBXy3
        b3LR3sOT63RgSvNkinpPbQmJZrl+ssg9IeKJxFx5b4AukWqIT9/kk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1BF51BA5BD;
        Wed, 30 Aug 2023 18:32:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3489E1BA5BC;
        Wed, 30 Aug 2023 18:32:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley <wesleys@opperschaap.net>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: [PATCH] git-svn: drop FakeTerm hack
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
        <xmqqcyzupf3b.fsf@gitster.g>
        <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
        <xmqqwmy2no2e.fsf@gitster.g>
        <20230811145121.GB2303200@coredump.intra.peff.net>
        <xmqqjzu1o97n.fsf@gitster.g>
Date:   Wed, 30 Aug 2023 15:32:08 -0700
In-Reply-To: <xmqqjzu1o97n.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        11 Aug 2023 09:05:48 -0700")
Message-ID: <xmqqa5u888lz.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EF61D26-4785-11EE-9B3A-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> It could still benefit from cleaning up FakeTerm, since we lazily init
>> the object since 30d45f798d (git-svn: delay term initialization,
>> 2014-09-14). But I don't think there's a visible bug here with the new
>> version of Term::ReadLine::Gnu.
>
> True.  Let me drop the patch from the 'next down to master
> fast-track' candidate status.

We did the above but then everybody seems to have forgotten about
it.  Let's resurrect the topic.  Here is my attempt.

---- >8 ----
From: Wesley Schwengle <wesleys@opperschaap.net>
Subject: [PATCH] git-svn: drop FakeTerm hack

Drop the FakeTerm hack, just like dfd46bae (send-email: drop
FakeTerm hack, 2023-08-08) did, for exactly the same reason.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-svn.perl | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git c/git-svn.perl w/git-svn.perl
index be987e316f..4e8878f035 100755
--- c/git-svn.perl
+++ w/git-svn.perl
@@ -297,28 +297,12 @@ sub _req_svn {
 		{} ],
 );
 
-package FakeTerm;
-sub new {
-	my ($class, $reason) = @_;
-	return bless \$reason, shift;
-}
-sub readline {
-	my $self = shift;
-	die "Cannot use readline on FakeTerm: $$self";
-}
-package main;
-
 my $term;
 sub term_init {
-	$term = eval {
-		require Term::ReadLine;
-		$ENV{"GIT_SVN_NOTTY"}
+	require Term::ReadLine;
+	$term = $ENV{"GIT_SVN_NOTTY"}
 			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
 			: new Term::ReadLine 'git-svn';
-	};
-	if ($@) {
-		$term = new FakeTerm "$@: going non-interactive";
-	}
 }
 
 my $cmd;
