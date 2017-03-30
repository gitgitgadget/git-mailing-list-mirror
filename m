Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BFF20966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbdC3SDz (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:03:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933474AbdC3SDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:03:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65D416C256;
        Thu, 30 Mar 2017 14:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qzzb2YyivU2dq0b0BtwbLo/fQRU=; b=K8uJtI
        SILW4LDCr97CbqAdGI3t7pOJssIQYniXOk4N/fnpkUTw7XxnX/M37UGvrzUDviRZ
        GfNbHShsJBa1bmyKkf6Pqltxkyb8XeXfQ5LD3c+3XrryM38wIP+dG9qAKT9y8sNQ
        on3ONbaj/7MguyKSgrCuRS/OpR1cYPdqGGRjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p6cKe0FWJ3Yohv+fVjK+hBxh+OpQ1hcu
        t2X8yTobogkjcTI1kPEzsN9f+s1YV01SKTx5cApSzOihx4NFIawImnp2PJxKK0Pa
        jiRV5ZbyXGcldTqQxJbCbI2B3AjDPU5aBT/eqqdlZWnUthMTxs3ZK1+7SYDdGFlb
        8oDMjw43gtk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D0776C255;
        Thu, 30 Mar 2017 14:03:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE6C26C253;
        Thu, 30 Mar 2017 14:03:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Rast <tr@thomasrast.ch>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] log: if --decorate is not given, default to --decorate=auto
References: <20170324054631.21622-1-alexhenrie24@gmail.com>
        <20170324183825.GD31294@aiede.mtv.corp.google.com>
Date:   Thu, 30 Mar 2017 11:03:51 -0700
In-Reply-To: <20170324183825.GD31294@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 24 Mar 2017 11:38:25 -0700")
Message-ID: <xmqqa88263qw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BD49F8E-1573-11E7-8BAB-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the "--decorate=auto" option becoming the default for "git
log", "git tbdiff" will be broken.

The configuration variable has been already there, so in that sense
this is not a new breakage (tbdiff wouldn't have worked well for
those with configured default).  A fix is trivial (attached).

I suspect that Alex's change may uncover similar breakages in
people's scripts.  Perhaps the topic should be cooked a bit longer
than other topics on 'next'?


 git-tbdiff.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-tbdiff.py b/git-tbdiff.py
index ccf7a0b..ae7cbb5 100755
--- a/git-tbdiff.py
+++ b/git-tbdiff.py
@@ -75,7 +75,7 @@ def read_patches(rev_list_args):
     series = []
     diffs = {}
     p = subprocess.Popen(['git', 'log', '--no-color', '-p', '--no-merges',
-                          '--reverse', '--date-order']
+                          '--no-decorate', '--reverse', '--date-order']
                          + rev_list_args,
                          stdout=subprocess.PIPE)
     sha1 = None
