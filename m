Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAD51F437
	for <e@80x24.org>; Tue, 31 Jan 2017 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdAaNSk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 31 Jan 2017 08:18:40 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:42697 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbdAaNQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 08:16:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 03D5C1E306D;
        Tue, 31 Jan 2017 14:16:26 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Xx_5tK66jN70; Tue, 31 Jan 2017 14:16:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9BB2B1E306E;
        Tue, 31 Jan 2017 14:16:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S6lgVJG1nwwH; Tue, 31 Jan 2017 14:16:25 +0100 (CET)
Received: from [192.168.178.72] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 562EB1E306D;
        Tue, 31 Jan 2017 14:16:25 +0100 (CET)
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
 <20170127100948.29408-2-cornelius.weig@tngtech.com>
 <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
 <xmqq8tpstaus.fsf@gitster.mtv.corp.google.com>
Cc:     peff@peff.net, git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <68b6ac92-459d-849d-9589-e1fa500e2572@tngtech.com>
Date:   Tue, 31 Jan 2017 14:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tpstaus.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> The extra free(refname) is to plug the leak I pointed out, and the
> type of refname is no longer const, because "const char *" cannot be
> free()d without casting, and in this codepath I do not see a reason
> to mark it as const.

Ooops.. thanks for not yelling at me for that :-/

> When queued on top of 4e59582ff7 ("Seventh batch for 2.12",
> 2017-01-23), however, this fails t2017#9 (orphan with -l makes
> reflog when core.logAllRefUpdates = false).

And again, thanks for not yelling. I overlooked that the
"should_autocreate_reflog" return value should have been negated as
shown below. Should I resend this patch, or is it easier for you
to do the change yourself?


Interdiff v2..v3:
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 81ea2ed..1e8631a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -612,8 +612,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
        const char *old_desc, *reflog_msg;
        if (opts->new_branch) {
                if (opts->new_orphan_branch) {
-                       const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
-                       if (opts->new_branch_log && should_autocreate_reflog(refname)) {
+                       char *refname;
+
+                       refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
+                       if (opts->new_branch_log && !should_autocreate_reflog(refname)) {
                                int ret;
                                struct strbuf err = STRBUF_INIT;
 
@@ -622,6 +624,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
                                        fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
                                                opts->new_orphan_branch, err.buf);
                                        strbuf_release(&err);
+                                       free(refname);
                                        return;
                                }
                                strbuf_release(&err);
