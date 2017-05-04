Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5A0207B3
	for <e@80x24.org>; Thu,  4 May 2017 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdEDI1H (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 04:27:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52339 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbdEDI1E (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 May 2017 04:27:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D41B207AA;
        Thu,  4 May 2017 04:27:03 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 04 May 2017 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=eG2GwFkjMnVGOjZaqz
        YjIkRISIFXfqbuZ6XUbG6QZc4=; b=jwsNYkkNc33ffw4roT98eKZk1be42nTa7F
        lfjBC2KBZgn6OGyzyBDZ+/wPhprI1zfFSWcT7Dh6Y3iEfK54DlJ4XE9S5gcipnM9
        LX4gvkSb5Nvm5EEWEtGAaer0SvaBpw1aOixZW3TzbOQ7lloy+/5ONs6JAp1dvqBz
        zHqc2937GP7XJveiQPKoVWUTDbzjJHvZFH6+KYWuvW40nsOZIaxvk58L934MwLQW
        4Z9HjX1O+0KuphIvqkXRRaNFrYowWGz+YswYZp9z9quJesOtkUMWavBWWEBh6gac
        qP02rR40u+6WhmS3nmoff/eWmaD4zoFu4z3GsF1SLbckrm1+sYaw==
X-ME-Sender: <xms:1-UKWQ_sJa2LPE_uu7VUY8J53VNGdbn2V9hNHlTtpFjPCeYjxxzn4Q>
X-Sasl-enc: zGtSbzVbKCXbP2T5Or8mciyR2ciu+b6wi/uxZKiZJzMD 1493886422
Received: from [192.168.1.83] (unknown [223.207.25.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id F09917E266;
        Thu,  4 May 2017 04:27:01 -0400 (EDT)
From:   Tom Hale <tom@hale.ee>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] __git_ps1: Don't kill shell if user types `set -e`
References: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee>
 <xmqq60i3k6ed.fsf@gitster.mtv.corp.google.com>
Message-ID: <c8879806-4e43-d033-bd69-918e730e2d05@hale.ee>
Date:   Thu, 4 May 2017 15:26:58 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <xmqq60i3k6ed.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------7857F5CC9658BE999605F9CA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------7857F5CC9658BE999605F9CA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 17/04/17 11:24, Junio C Hamano wrote:
> "Tom \"Ravi\" Hale" <tom@hale.ee> writes:
>
> > If a user types `set -e` in an interactive shell, and is using __git_ps1
> > to set
> > their prompt, the shell will die if the current directory isn't inside a git
> > repository.
> >
> Hmph.  So the fix would be something like this?
>
>      repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
>          --is-bare-repository --is-inside-work-tree \
> -         --short HEAD 2>/dev/null)"
> +         --short HEAD 2>/dev/null || :)"

Nope, that would cause the next line
    rev_parse_exit_code="$?"
to always be assigned 0.

I believe the patch we're after is attached.

-- 
Cheers,

Tom

--------------7857F5CC9658BE999605F9CA
Content-Type: text/x-patch;
 name="0001-Prevent-non-zero-exit-if-outside-a-repository.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Prevent-non-zero-exit-if-outside-a-repository.patch"

From 74fa2e2fa058f89605cf0b2774ad8e9df981cf86 Mon Sep 17 00:00:00 2001
From: "Tom \"Ravi\" Hale" <tom@hale.ee>
Date: Sun, 16 Apr 2017 14:15:14 +0700
Subject: [PATCH] Prevent non-zero exit if outside a repository

---
 contrib/completion/git-prompt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 97eacd7..d0d890c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -361,8 +361,8 @@ __git_ps1 ()
 	local repo_info rev_parse_exit_code
 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
 		--is-bare-repository --is-inside-work-tree \
-		--short HEAD 2>/dev/null)"
-	rev_parse_exit_code="$?"
+		--short HEAD 2>/dev/null)" && 
+		rev_parse_exit_code="$?" || : # Don't die if "set -e"
 
 	if [ -z "$repo_info" ]; then
 		return $exit
-- 
2.12.2


--------------7857F5CC9658BE999605F9CA--
