From: Mike Edgar <adgar@google.com>
Subject: [PATCH v2] fetch-pack: check for shallow if depth given
Date: Wed, 17 Jun 2015 07:48:14 -0400
Message-ID: <1434541694-12748-1-git-send-email-adgar@google.com>
References: <xmqqzj46dlfw.fsf@gitster.dls.corp.google.com>
Cc: peff@peff.net, pclouds@gmail.com, Mike Edgar <adgar@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 13:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5BpZ-0000Ob-SO
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 13:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbbFQLs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 07:48:29 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36447 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbbFQLs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 07:48:27 -0400
Received: by yhan67 with SMTP id n67so31551719yha.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fD4YPIsKC2L3MC3zdV2ITXR0l3kI6PM0ezn+Co2UgaU=;
        b=TWs2W/rgU7RArsKVcYTGybTyUTasave4UqD/6aLrPYW08gkQAZMBLKxdFohNmRfP6W
         qBlYQgbSUOv0sBzqTiFLrBqOfat1rRapMXRO6A38l8xkYq2mZmyl0oK9z/ACuUp8YDNX
         IWpclLY04+GGzZ5qyfACmHDmKAMI4fzfYeU7idD3KmXaECS2grXMei8E1YAgZRg/xWY3
         ARlxd2vHX94j7WFe7Fnux0vM6sU7Y+3nMV5ceEVBmknAGR6cjxp8QU72V27LIDHrJNtt
         j/kxPranLb5ERuiU6htnwA8ot80QVVok6Vc2LHOq8bS65ilU8Rlrsv6dC1i8/3lPE8RE
         fKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fD4YPIsKC2L3MC3zdV2ITXR0l3kI6PM0ezn+Co2UgaU=;
        b=Wj075LtRwyAY2kHwjAmJ90bdMs5Nz6ChhUpzdA/TCz9lQCS3gE2EJAU+ta+yKEpNTk
         hGoJBEunbR5knxpZ1OhksaF813UX1gL19MWT7QUkTYs4SgCKz32IuDYeUFPk5raSLE/m
         fWrAOqaqfnK3rrz6zX+i3bJccc5fraUXtAtTIZmDD1PTTC8XeRvWjPS322epqbIhWRYI
         UDNcwE8ywfW5M56Bs+6WvOSI9Wl6e1zPP4esRo7idUXH3tF77WpRAdBdUFuG0dQ0Gg4a
         uIFAMKwYKJ274PFf7enz4ZVTlztJcHdXONpVm7rBaPcpHU81yiD78Flx8st1NI3XjhDZ
         jjlg==
X-Gm-Message-State: ALoCoQni5qFFO3EoWsRzwkCW5EamSHEP8ZGyDBbXXku144To6Cqn+/+hnU5Nv4RIV1ehLeX5UVQm
X-Received: by 10.129.133.2 with SMTP id v2mr6346631ywf.119.1434541706720;
        Wed, 17 Jun 2015 04:48:26 -0700 (PDT)
Received: from smtp.gmail.com ([172.26.9.125])
        by mx.google.com with ESMTPSA id 74sm3281837ywe.43.2015.06.17.04.48.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jun 2015 04:48:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.493.g7974889.dirty
In-Reply-To: <xmqqzj46dlfw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271833>

When a repository is first fetched as a shallow clone, either by
git-clone or by fetching into an empty repo, the server's capabilities
are not currently consulted. The client will send shallow requests even
if the server does not understand them, and the resulting error may be
unhelpful to the user. This change pre-emptively checks so we can exit
with a helpful error if necessary.

Signed-off-by: Mike Edgar <adgar@google.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a912935..a136772 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -809,7 +809,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
 
-	if (is_repository_shallow() && !server_supports("shallow"))
+	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
 		if (args->verbose)
-- 
2.2.0.rc0.207.ga3a616c
