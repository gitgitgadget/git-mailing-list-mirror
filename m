Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82421F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933205AbeFMDKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:10:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64931 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754394AbeFMDKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:10:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5203FFD39C;
        Tue, 12 Jun 2018 23:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=3OdF
        cz37HYv7GUGorowld0DuP04=; b=itjyLg5K3KaIaxcc0XbUGjRu4w06R0VJCeQp
        u+uQeq4Ib+vCkJvdcxEzZNWmp213uwZk4mGdgX2A11kvLP37rY6RuhtkD4oIY7A1
        pHkUqvHMFN8beRVO+SiTbXoTz3Wfw6AJoTw5s6Uq3nv8FyYwxU3e+V48y0uzjEz6
        WXJCYRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        pn41FqY4n8WaToO9kzZ2uV0w/ecyw0zZMTfoLZatzAH23NF9+AwJu6J+3gAAj93v
        fHgoNyYB3+1dI7hNHpkvjpMY5v08brvlEMiMJLU/MsuX9cktvKtohjLdTIxQh9Df
        gs0kko+7Ne1WEEeZ00DlPgCGFtFM2zHdYFxYnwzsAgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 411E2FD39B;
        Tue, 12 Jun 2018 23:10:49 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A2A5FD398;
        Tue, 12 Jun 2018 23:10:47 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 4/4] git-credential-netrc: fix exit status when tests fail
Date:   Tue, 12 Jun 2018 23:10:39 -0400
Message-Id: <20180613031040.3109-5-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 5F0D6C44-6EB7-11E8-86CB-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luis Marsano <luis.marsano@gmail.com>

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
---
 contrib/credential/netrc/test.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 2b5280ad6a..c0fb3718b2 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -11,7 +11,6 @@ BEGIN
 	# t-git-credential-netrc.sh kicks off our testing, so we have to go
 	# from there.
 	Test::More->builder->current_test(1);
-	Test::More->builder->no_ending(1);
 }
 
 my @global_credential_args = @ARGV;
@@ -103,6 +102,9 @@ BEGIN
 
 ok(scalar keys %$cred == 2, 'Got keys decrypted by command option');
 
+my $is_passing = eval { Test::More->is_passing };
+exit($is_passing ? 0 : 1) unless $@ =~ /Can't locate object method/;
+
 sub run_credential
 {
 	my $args = shift @_;
