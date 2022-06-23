Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7BCC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiFWPv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiFWPv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:51:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F243483
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:51:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i10so24801272wrc.0
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4Vk/iCsfzSXjJtrxqiaiWnaQRwDaMWzEgwyiy0z8wE=;
        b=OWn2oeaVjl0D1FqwUvJKfOlkUh5NphPiu4NzqtEsQyv2RCv1AuN1ZxrshTWCxhg72b
         WLOikKvPB3GDC3O2/x+VccnoelaJYNFma+KpmobvSFU3tPxYo+NouQfyYO/mpXvI6RSL
         slQEMfr8ECTTkS0gn4WvtN+iRSnQf1LVHN8vbnLHQggS0bs1HEX310y+12D0Hd1dNLP+
         S3m0eN7dYAd3SsLgRluzGJBzuHtNRRtfdaMAiedpUHAVl7vq6CeG3Jh9wAKQvMQm/ReT
         xzLLw1y+5LhHh+h/3kUaybj+K1ECooIFs+/x7kaq3EbOFzyXqzOaXBnahyRfKzLuDaKw
         x18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4Vk/iCsfzSXjJtrxqiaiWnaQRwDaMWzEgwyiy0z8wE=;
        b=1pwg78UrT0yU1aeArfuJbnYZ/Zjps5bePTs7WzWmlI0r/zJubKl1xPAMgmmyMxm2GP
         cGFfBosLa8Q/CEokJe8fn916eHYRkhirgMZSCy7LWFrlQH4uZoR8d+AaJ46iln2FsRvq
         q+0DtBL9DsyUmJ4xPnwHxS4uxYxCq8wQON2BFTlSjtkeR4H55IjFWsp2aPdZTQwEN5H8
         7DPs/iJ8PsMOLhJqif5SLR5lw62cRNPClMRYCaGUBm9vlOtFQ3e+5/RZEnZub2nCQZYw
         UwSvcySY8algqcx1QzQhOnzzixQXvccXOad1lxGUSYvToyKuExcENQ4tzMvq0u8l0dIn
         +eJQ==
X-Gm-Message-State: AJIora/t955E3fh/q3YDBKXVMKwc3GpbvGMCxKikKIM7zVWVacEs3S2Q
        9yM/hCGDkRtR/EJZk8kzcS9tyFjzUCd60Q==
X-Google-Smtp-Source: AGRyM1uBwkeWX85hptjKgNg8aARtrzZRC49rR9iYfRKBxy0ndpX8Qs76noLgJ6j/fMta/xuJfiPQXg==
X-Received: by 2002:a5d:6484:0:b0:219:eb95:3502 with SMTP id o4-20020a5d6484000000b00219eb953502mr8861644wri.692.1655999515184;
        Thu, 23 Jun 2022 08:51:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b0039c975aa553sm3596125wmj.25.2022.06.23.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:51:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] trace2: don't include "fsync" events in all trace2 logs
Date:   Thu, 23 Jun 2022 17:51:46 +0200
Message-Id: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.rc2.867.gbe8216e3e5c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the overly verbose trace2 logging added in 9a4987677d3 (trace2:
add stats for fsync operations, 2022-03-30) (first released with
v2.36.0).

Since that change every single "git" command invocation has included
these "data" events, even though we'll only make use of these with
core.fsyncMethod=batch, and even then only have non-zero values if
we're writing object data to disk. See c0f4752ed2f (core.fsyncmethod:
batched disk flushes for loose-objects, 2022-04-04) for that feature.

The result was that e.g. "git version" would previously emit a total
of 6 trace2 events with the GIT_TRACE2_EVENT target (version, start,
cmd_ancestry, cmd_name, exit, atexit), but afterwards would emit
8. We'd emit 2 "data" events before the "exit" event.

The reason we didn't catch this was that the trace2 unit tests added
in a15860dca3f (trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
t0212.sh, 2019-02-22) would omit any "data" events that weren't the
ones it cared about. Before this change to the C code 6/7 of our
"t/t0212-trace2-event.sh" tests would fail if this change was applied
to "t/t0212/parse_events.perl".

Let's make the trace2 testing more strict, and further append any new
events types we don't know about in "t/t0212/parse_events.perl". Since
we only invoke the "test-tool trace2" there's no guarantee that we'll
catch other overly verbose events in the future, but we'll at least
notice if we start emitting new events that are issues every time we
log anything with trace2's JSON target.

We exclude the "data_json" event type, we'd otherwise would fail on
both "win test" and "win+VS test" CI due to the logging added in
353d3d77f4f (trace2: collect Windows-specific process information,
2019-02-22). It looks like that logging should really be using
trace2_cmd_ancestry() instead, which was introduced later in
2f732bf15e6 (tr2: log parent process name, 2021-07-21), but let's
leave it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This is a fix for a v2.36.0 regression/change, so perhaps it's
categorically out for v2.37.0, but given how isolated the fix is & how
verbose the new trace2 data is perhaps it's worth including anyway.

Passing CI at: https://github.com/avar/git/actions/runs/2548732003

 t/t0212/parse_events.perl | 17 +++++++++++------
 wrapper.c                 |  3 +++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index b6408560c0c..389cf6f61c4 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -216,12 +216,17 @@
 
     elsif ($event eq 'data') {
 	my $cat = $line->{'category'};
-	if ($cat eq 'test_category') {
-	    
-	    my $key = $line->{'key'};
-	    my $value = $line->{'value'};
-	    $processes->{$sid}->{'data'}->{$cat}->{$key} = $value;
-	}
+	my $key = $line->{'key'};
+	my $value = $line->{'value'};
+	$processes->{$sid}->{'data'}->{$cat}->{$key} = $value;
+    }
+
+    elsif ($event eq 'data_json') {
+	# Ignore due to compat/win32/trace2_win32_process_info.c
+    }
+
+    else {
+	push @{$processes->{$sid}->{$event}} => $line->{value};
     }
 
     # This trace2 target does not emit 'printf' events.
diff --git a/wrapper.c b/wrapper.c
index 1c3c970080b..eebd764131f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -618,6 +618,9 @@ int git_fsync(int fd, enum fsync_action action)
 
 void trace_git_fsync_stats(void)
 {
+	if (!count_fsync_writeout_only && !count_fsync_hardware_flush)
+		return;
+
 	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
 	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
 }
-- 
2.37.0.rc2.867.gbe8216e3e5c

