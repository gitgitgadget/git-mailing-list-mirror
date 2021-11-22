Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EDC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 15:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbhKVPea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 10:34:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbhKVPe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 10:34:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3F571FD49;
        Mon, 22 Nov 2021 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637595081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lImdsuDU6xtoVE2/94WDaFrA1VCFeYydgnJYdQ9j7is=;
        b=cDxl5x4n3fy2TI/fzEQoLqGNF7+Nd83E9Jlqq3ul/d3d6uIRZJyvkOjN25Z8AWRPVLhcia
        s2LLu9sm9xB1dMzNmK3i5TYYllXNFJ2J8Nwjn12eLTxS/TEnazVMIIN3gITbk/BDidBUb0
        zAuEgc4Wn2f8nlk47om6VN0M9UdJALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637595081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lImdsuDU6xtoVE2/94WDaFrA1VCFeYydgnJYdQ9j7is=;
        b=2g7jzI/W1/nHU+5UsKnmKJoSH1nnvTzY8L5zbJMjstfeAO0QLzylJvk2Z8s1cKKPCgRPv5
        eCp6QD9UMPqaiOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50ADE13CB0;
        Mon, 22 Nov 2021 15:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e6WsBsm3m2FIFQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 22 Nov 2021 15:31:21 +0000
Date:   Mon, 22 Nov 2021 12:31:19 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqfsrplz3z.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Junio C Hamano wrote:
>It is rather common for us to reuse "struct child_process" in a code
>path, e.g. builtin/worktree.c::add_worktree() prepares a single
>instance of such a struct, sets cp.git_cmd to true, and runs either
>"update-ref" or "symbolic-ref" to update "HEAD".  After successful
>invocation of such a git subcommand, it then runs "git reset --hard",
>with this piece of code:

Do you agree that at least NULLing .argv and .env could be part of
child_process_clear()?

diff --git a/run-command.c b/run-command.c
index a7bf81025afb..3839a26eff11 100644
--- a/run-command.c
+++ b/run-command.c
@@ -18,8 +18,9 @@ void child_process_init(struct child_process *child)
  void child_process_clear(struct child_process *child)
  {
         strvec_clear(&child->args);
+       child->argv = NULL;
         strvec_clear(&child->env_array);
+       child->env = NULL;
  }

With this change on main, all tests are successful.


Cheers,

Enzo
