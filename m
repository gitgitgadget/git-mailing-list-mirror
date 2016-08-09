Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2F72018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcHIEIm (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:42 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34903 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcHIEIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id x72so675362pfd.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hBELIyehuY18V27xYOkVGtP22OqDiMxtaCnundHeIuM=;
        b=bb9zgJwuHYczjA5XWvY7y1aQS0rlr8tUFU4bpMBYl/qZ6fy5vRPi4wETHn7BXxCa1d
         XD47ZDJRbyY2+9T1GhgLwDjdTBE0oSLJIDD2BURLzkpKCqcIBaN8ez1qA8h3BG47ihuc
         lmFAOFHqMUWViSxWzd/+HRu0owt5cCmsg/W1Edzf0SSvIIcPA8nTOg6BhF+7vASNxdYz
         DipCQmGeiTWLfLopdxAe1SkL3CqxF0rj1U41vQepqGguE4O0C+yifPW+PA55d93bPCtA
         KRtl0pSJPCY92zBK9x/Nuww/nmIbkLfdmXZiOleHq+S/YOqbon4JmrkvfUnjLl8jvlgj
         3Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hBELIyehuY18V27xYOkVGtP22OqDiMxtaCnundHeIuM=;
        b=KQWI4BkF8hVk0VajV8u7q/YJPkqVyROGg1S4/MVoE7iHSSoh9TMUO++Rp80hBUAtUa
         clgRZuS5Z0jqfcBuJyrilN5yS1spvWUfJueeFNPCIRYPrpAAldGlKTQhhad8rVQZtmlw
         4tie6xl/puCZYgAMa0wnS0bT8J3dDGyDRysPhf07n6ssOIseQwdh4lyPuxRfNHyAWcWF
         E4127YYe4DBa0+7gwa3ttD8MqNgA2SY4ITr/V0FfIc5adkC8QFhT7Q77Htfkdh2QHZ6G
         sBcloP2T0AS3VCJq++SeLHERnl9SzQVkdAVArpw0EzihuEceZI0tQeaI1iSq74ScM8pV
         N5mw==
X-Gm-Message-State: AEkoouumTgmCtdsm2cOzB8G3ApdDt3zZeQcy1bmUPwbEJoaqNAZVs98LLDc/VTq9KVkrlBu0
X-Received: by 10.98.34.151 with SMTP id p23mr169248728pfj.102.1470715717636;
        Mon, 08 Aug 2016 21:08:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id h125sm51485608pfg.54.2016.08.08.21.08.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:36 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 9/9] submodule--helper: use parallel processor correctly.
Date:	Mon,  8 Aug 2016 21:08:11 -0700
Message-Id: <20160809040811.21408-12-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When developing the prior patches I had a temporary state in which
git-clone would segfault, when prepared the call in
prepare_to_clone_next_submodule. This lead to the call failing, i.e. in
`update_clone_task_finished` the task was scheduled to be tried again.
The second call to prepare_to_clone_next_submodule would return 0, as the
segfaulted clone did create the .git file already, such that was not
considered to need to be cloned again. I was seeing the "BUG: ce was
a submodule before?\n" message, which was the correct behavior at the
time as my local code was buggy. When trying to debug this failure, I
tried to use printing messages into the strbuf that is passed around,
but these messages were never printed as the die(..) doesn't
flush the `err` strbuf.

When implementing the die() in 665b35ecc (2016-06-09, "submodule--helper:
initial clone learns retry logic"), I considered this condition to be
a severe condition, which should lead to an immediate abort as we do not
trust ourselves any more. However the queued messages in `err` are valuable
so let's not toss them out by immediately dieing, but a graceful return.

Another thing to note: The error message itself was missleading. A return
value of 0 doesn't indicate the passed in `ce` is not a submodule any more,
but just that we do not consider cloning it any more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fc14843..3e40f99 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -815,8 +815,12 @@ static int update_clone_get_next_task(struct child_process *child,
 	if (index < suc->failed_clones_nr) {
 		int *p;
 		ce = suc->failed_clones[index];
-		if (!prepare_to_clone_next_submodule(ce, child, suc, err))
-			die("BUG: ce was a submodule before?");
+		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			suc->current ++;
+			strbuf_addf(err, "BUG: submodule considered for cloning,"
+				    "doesn't need cloning any more?\n");
+			return 0;
+		}
 		p = xmalloc(sizeof(*p));
 		*p = suc->current;
 		*idx_task_cb = p;
-- 
2.9.2.583.gd6329be.dirty

