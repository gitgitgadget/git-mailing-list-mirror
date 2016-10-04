Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6170720986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbcJDQkn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:40:43 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36193 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbcJDQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:40:42 -0400
Received: by mail-pf0-f171.google.com with SMTP id i85so26155866pfa.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b82h0wajNfu1eOGfSq7CCosbg2e4gb28EBEkmm5qtwM=;
        b=QrvR/+vmXSSzGczlk3w6/2ctNvy8gbXYHH3/Fi5GU/7X1Nl5eeY/psYVK/SV2iCDDw
         LrjiuXVaJNlvbsCwAvkH9HZcfihOOh0/g1SRZ0/dIPfgvzTfFE1PQp+tQy581DIRyT3b
         kn7GdFpjQnbZCLdKWTqgI4l9Q+7Pwsdj6uP90OOPGFD8jQcDd0IXAR7GvXevaI1LSqc4
         NSkM2u+JQrANRQkreFYtlSdeKE58zqzbjk0+5AMyL/6pMaTuI1/z6f3XFOXGxNwXHdkM
         nFYxDUPGn/w/+US9fGbFF9tiWd2M+s+mdcR8HiGANOuR//CBQv7Msu9UE1F3/heStesX
         Qktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b82h0wajNfu1eOGfSq7CCosbg2e4gb28EBEkmm5qtwM=;
        b=XclooMHuAv7ygepCzV9srCp5Z6v5ht3Mtx4dBHYqq8oHmOqcrsKQ5Mlts9qhQTuTcm
         AEXN2uct/yF8rrecoq2bDSQOypiqJNBTb0sWMwvMPnLPAnpMcyVeb3gTvyAZG6bckuRP
         WauXOn3pKlclKV+LT8mmrnooQ4LiABMoEXY1lLNbyrTifvCaPiyGhYVbBKozh8p81JWC
         leMwN9gZKUfhnhBfnNNwIe+1I31hiddckMo8q41x/v7KwRv4CZBBm4jqo2DiKFS70+mB
         tLvc1EkAzhoSV//Fu+g9Z0/2/sR0rrUvOR98j0tTi7gPacSpqJbO8p36IJ5v99XDGP5d
         9vFQ==
X-Gm-Message-State: AA6/9Rmry0ZM/ZdGvQysTCUJqdf/rYDocC9FsQQM7rk1oT8U0DqQolSaKrakpsC6T0E+QCEQ
X-Received: by 10.98.96.193 with SMTP id u184mr7517806pfb.109.1475599241171;
        Tue, 04 Oct 2016 09:40:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d1d:42df:48d7:33a4])
        by smtp.gmail.com with ESMTPSA id t18sm19462253pfk.29.2016.10.04.09.40.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 09:40:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] push: change submodule default to check
Date:   Tue,  4 Oct 2016 09:40:36 -0700
Message-Id: <20161004164036.6584-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
In-Reply-To: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
The setting 'check', which checks if any existing submodule is present on
at least one remote of the submodule remotes, is designed to prevent this
mistake.

Flipping the default to check for submodules is safer than the current
default of ignoring submodules while pushing.

However checking for submodules requires additional work[1], which annoys
users that do not use submodules, so we turn on the check for submodules
based on a cheap heuristic, the existence of the .gitmodules file.

[1] https://public-inbox.org/git/CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Tue, Oct 4, 2016 at 9:21 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 09:19:01AM -0700, Junio C Hamano wrote:
>>
>> Why should we even have a default different from today's?  If most
>> repositories don't have submodules enabled at all, we can just let
>> those working with submodules enabled to toggle their configuration
>> and that is an very easy to understand solution, no?
>
> You will not see any complaint from me on that. I was taking for granted
> that the current default is inconvenient to submodule users, but I don't
> have any experience myself.
>

And there I was trying to help submodule users not shoot in their foot.

I think it is one of the problems that causes serious problems, that is easy
to fix from the side of Git. This patch replaces sb/push-make-submodule-check-the-default
and should be cheap enough for non-submodule users to accept, but still helping
submodule users as it seems to be an ok-ish heuristic. (It is possible to use
submodules and currently have no .gitmodules file present, because you're in
a weird state; then the heuristic fails. By weird state I mean e.g. a bare
repository, or you just checked out an ancient version that has no submodules
yet, or you deleted it locally for whatever reason.)

So how about this patch?

Thanks,
Stefan

 builtin/push.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..d7d664a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -22,7 +22,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules;
 static enum transport_family family;
 
 static struct push_cas_option cas;
@@ -31,6 +31,14 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static void preset_submodule_default(void)
+{
+	if (file_exists(".gitmodules"))
+		recurse_submodules = RECURSE_SUBMODULES_CHECK;
+	else
+		recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+}
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -552,6 +560,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
+	preset_submodule_default();
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
-- 
2.10.0.129.g35f6318

