Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC88220958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935926AbdCWVJn (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:43 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34123 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755618AbdCWVJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id p189so87759986pfp.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+ewuS5SU5qnLskumVm71Ir2C25V+K0/kqVpAKjQ43c=;
        b=HG+aqAL467X/iQUdAuV1MbPKC4s6MKMXmKWF8wpst0mpmOTKAq8w2TAk9C/SQc/OjU
         b4hztkikBbcQ0aE99qCldwrRSjTISixp+xDCAce2ngP7RC8s57Gj3IGHKQfUgscbEywI
         Vup9s0xwXYTW62+SjK1S8ceh0d0VaUctgZBkkZz+7ui8428DmNXM60c2/N4BSZ/sD6yp
         va1BxqeCzPgNpSW/oe3LgKV5m6oYcAu2JCUrQhaA1GyOEJ9WUh3fiH+IQqsjmdxFkbKp
         bPrrR96bNTBo/b3o38tEagIsjuTd0Qtbip7ozhQmV+ALVdwcJ5aqyNSKm+MnXvWX/MCK
         RiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+ewuS5SU5qnLskumVm71Ir2C25V+K0/kqVpAKjQ43c=;
        b=WL/Dyj1GaR8+Sv87q0WDmJkW786rYazuiQPBHhuRXuy4KM82CMRbKObnKu5dD6zHo3
         BcE96w4VX8rOpuSHIQIifD00bzIOrk4Hr/QUv11OfmbElgm0kKd0HGMHLQMDBd30Tls/
         0jVCrn7wIAUs6/B2IMX//8HMtVtu67QKj3jaK0atNrxyexu7BW7gdYrEAvqGhIu8aVCB
         NHdKiIdgBj5zhl+Hzz5nYXBedi10W674pBepS7Te+QBXUOl+xIbmEtEWp1vlhESC04qt
         ik22cjkNKFsATOviY5x45jteCo1hNGqEaKyNkbide3sYRhst447Sr1ReOrUaQIE+vUm3
         OvnA==
X-Gm-Message-State: AFeK/H0mBf6KPIKvVMBvdiW+JSkxD062Uh5UKERBeRerXn+NBS29ErDl5wW5bsiagzSOC8PX
X-Received: by 10.98.49.1 with SMTP id x1mr5238785pfx.26.1490303371561;
        Thu, 23 Mar 2017 14:09:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id y5sm182540pgh.36.2017.03.23.14.09.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Thu, 23 Mar 2017 14:09:20 -0700
Message-Id: <20170323210924.26818-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status. This conversion attempts to convert faithfully, i.e.
the behavior ought to be exactly the same.

As the output in the parsing only distinguishes between untracked files
and the rest, this is easy to port to the new format, as we only
need to identify untracked files and the rest is handled in the "else"
case.

untracked files are indicated by only a single question mark instead of
two question marks, so the conversion is easy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index f01e84faff..da1db90dda 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1068,10 +1068,11 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
 	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
-		if ((buf.buf[0] == '?') && (buf.buf[1] == '?')) {
+		/* regular untracked files */
+		if (buf.buf[0] == '?') {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
 				break;
@@ -1085,7 +1086,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.1.438.gb674c4c09c

