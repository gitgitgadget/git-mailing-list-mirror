Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3EF20285
	for <e@80x24.org>; Wed, 28 Jun 2017 20:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdF1Uiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 16:38:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34736 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdF1Uiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 16:38:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so9382300pge.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=IeVA3+Zg9+i6gIcY+1rU4v7V5RTJEAfnkqx0h1xZA5M=;
        b=CKeEHpdIHDIf4w6PjOb/lH7bUQAzYU6iSzwTrQIOpJiqyNYAZtrak1tgqMdZ4f1MtI
         pQxVsTKdB4PE6na3GF4xjRvI2zrAL7pz2YFCmVtr/OvPoEvey9QR5l4NCPa5FanYMO3U
         NMgK67bFdVcZO3+gcgK8L6731wLUOmyXiv604Brng2inQ42AQc2Shybhicjb2uj8XshP
         bMsDZbF+MmLHWrC1PAHRS9Blh6A+Zc0n6XS2bqUl2WTuYq4nldlURzYu4dDwe8d/thDW
         ygFZgudlJH+ELtA18jrX+mXiHL3s7cpIcPh8/Ie5s1HoK2P8wU6s5TzEkn2Y2ZakUOkH
         VDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=IeVA3+Zg9+i6gIcY+1rU4v7V5RTJEAfnkqx0h1xZA5M=;
        b=IcG76ZV9KmhID3WtDGMespFYYA3fmoU3driTg+xyu8gHitDD2sm6+bQj38iZ/3WZIM
         UaRwJCdhH1vWGDFgDAcwSMqHGKfeqWraQAkuirGWihzeS6FMKYt5jpZKsidOoxC3g1iF
         PyEMV++ohd3flUjpsg++kzLUE4uvqrq/wL7VC2OAyI4tXLqLwbOt14nnbI0weXA+cvH8
         VBK34Dwjx+IgJstneqasEOJdwEE+aEXDijpv5aesSX2WO6SnqciTa8ZgpfNlTJqkQQRU
         Xw0gzLjWu6WaySDQ5Pcmz/OtmjhEqWl2Tzhw+jUZxE5HRLGCjos8BKwqK9cNwNws6j/v
         syQw==
X-Gm-Message-State: AKS2vOxzVVckHlYyanZO43whsZj6oUItBuYS2GTsBMnp2VM/hIyRgz8C
        /WvxzQ9P3R5INal9aeY=
X-Received: by 10.99.0.212 with SMTP id 203mr12057718pga.259.1498682330566;
        Wed, 28 Jun 2017 13:38:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id l85sm5966140pfi.134.2017.06.28.13.38.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 13:38:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] submodule--helper: do not call utf8_fprintf() unnecessarily
Date:   Wed, 28 Jun 2017 13:38:48 -0700
Message-ID: <xmqq1sq3x2xz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function utf8_fprintf(fp, ...) has exactly the same
effect to the output stream fp as fprintf(fp, ...) does, and the
only difference is that its return value counts in display columns
consumed (assuming that the payload is encoded in UTF-8), as opposed
to number of bytes.

There is no reason to call it unless the caller cares about its
return value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The helper was introduced at c0821965 ("Add utf8_fprintf helper
   that returns correct number of columns", 2013-02-09), which also
   taught the help text output from the parse_options API to use it
   to align columns.  These original callers naturally do use the
   returned value and left alone by this fix, which corrects all the
   later callers that misuses it.

 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8517032b3e..50c6af1de7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -326,7 +326,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 			printf("%06o %s %d\t", ce->ce_mode,
 			       oid_to_hex(&ce->oid), ce_stage(ce));
 
-		utf8_fprintf(stdout, "%s\n", ce->name);
+		fprintf(stdout, "%s\n", ce->name);
 	}
 	return 0;
 }
@@ -1038,7 +1038,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	for_each_string_list_item(item, &suc.projectlines)
-		utf8_fprintf(stdout, "%s", item->string);
+		fprintf(stdout, "%s", item->string);
 
 	return 0;
 }
