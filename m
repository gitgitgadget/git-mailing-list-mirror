Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C3720A04
	for <e@80x24.org>; Sun, 16 Apr 2017 08:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdDPI2l (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 04:28:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51339 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752092AbdDPI2j (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 04:28:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id C5074202DD
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 04:28:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 16 Apr 2017 04:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=8NWSPOchlFL7QdOayeGd3DlnFSg4Xxh7MFew1rSmy
        1U=; b=Q6RZfszuN1I5ryHbdPK2a8TzDf9p6z7CmEf1miGTCO1frDT3TIb/dLRB5
        XVkuiReRTIdaYGiasTRQyWp5CDm6JQ05VnIPAyYb5FTp8dpPGLibeItMK+pHfHMm
        noi6HBD/XTsNVun75qDhiIWE6R5w58McTXDHoOwORW3A6paTHG7JW6mpv7F4ziNy
        7ojERNKIzT8Tgp0VTbgsVe6Ms8b2t6ZqXY+5PgPShY48mJ9+2CMSP/8hP7D8p6Iy
        I7fEOxBIehYu5NG+dWUk/EJKVTrqXTGBAPen7ek+u3XJgMjTTUI6G9CqocDYr4nO
        RCWvimsBMOvwaiowjD5lzYZ3pY/iQ==
X-ME-Sender: <xms:NivzWOSuJRu9Z5nXONUJr2oZ5GGzNmTAtK3nxOpcX_v2cLNR62A3-A>
X-Sasl-enc: RAuvY+C/rIrsqLBqLQRIXCANYnipkmSC2V79uA12Rn/F 1492331318
Received: from [192.168.1.247] (node-15n6.pool-118-173.dynamic.totbb.net [118.173.210.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id F02227E1D7
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 04:28:37 -0400 (EDT)
To:     git <git@vger.kernel.org>
From:   "Tom \"Ravi\" Hale" <tom@hale.ee>
Subject: [PATCH] __git_ps1: Don't kill shell if user types `set -e`
Message-ID: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee>
Date:   Sun, 16 Apr 2017 15:28:33 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CD5FAC836FED56B3EAC9D5CE"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------CD5FAC836FED56B3EAC9D5CE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

If a user types `set -e` in an interactive shell, and is using __git_ps1
to set
their prompt, the shell will die if the current directory isn't inside a git
repository.

This is because `set -e` instructs the shell to exit upon a command
returning a non-zero exit status, and the following command exits with
status 128:

	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"

I couldn't write a test to illustrate this - the test harness seems to
be preventing
`set -e` from having an effect.
	
<attachment>

Signed-off-by: Tom "Ravi" Hale <tom@hale.ee>

--------------CD5FAC836FED56B3EAC9D5CE
Content-Type: text/x-patch;
 name="0001-__git_ps1-Don-t-kill-shell-if-user-types-set-e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-__git_ps1-Don-t-kill-shell-if-user-types-set-e.patch"

From 7867768f4516559c129ed9eb07ae29c36a6c9367 Mon Sep 17 00:00:00 2001
From: "Tom \"Ravi\" Hale" <tom@hale.ee>
Date: Sun, 16 Apr 2017 14:10:10 +0700
Subject: [PATCH] __git_ps1: Don't kill shell if user types `set -e`

Ensure that `set +e` is in effect inside __git_ps1 to prevent any commands
exiting non-zero from killing an interactive shell in which the user has run
`set -e`.
---
 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 97eacd7..15a0b74 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -304,6 +304,10 @@ __git_ps1 ()
 	local ps1pc_start='\u@\h:\w '
 	local ps1pc_end='\$ '
 	local printf_format=' (%s)'
+	# Prevent any non-zero exit statuses from killing an interactive shell in the
+	# case that a user types `set -e`
+	local -- - # Shadow shell options in $- (restored upon return)
+	set +e
 
 	case "$#" in
 		2|3)	pcmode=yes
-- 
2.11.1


--------------CD5FAC836FED56B3EAC9D5CE--
