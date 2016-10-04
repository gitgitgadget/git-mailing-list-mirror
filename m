Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E59C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbcJDWy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:54:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51288 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbcJDWy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:54:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E64E544BF1;
        Tue,  4 Oct 2016 18:54:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=bAOf
        heXAo1ayq6jJF5q1AAr/qME=; b=H9IQnOxgwHiKVs3GsFJILW98hijnBkzjQTOV
        Tef9dPu0yBu/oLu/eVS0K6zxlLUEysDhg/d7QxwGpcBt3L95z+PWiD0JL4Fwuolm
        i50on2oW2gl1Cgc1J4GzB48K3uPoJQqxa7V60XDOPw/taL3/A3fxhVRZcYZS1dur
        FyqZiZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        cYhZQxt4cRniOVIjJjrLhmvWlpzBLQoUv8LhIulM7y4Vb8vuilrnSjng8rAQ3TN5
        Td1ivnbpCL6jLONdkt/HFfHqDZvHi/m1Zi28J5O3YfbOvKGGPID7VCDEO6Z2lHEk
        JX0W81Fqvo/d08Z5nw9hXO3fmRwmFJVn2DCyAIYk5T4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE06F44BF0;
        Tue,  4 Oct 2016 18:54:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C5F144BEE;
        Tue,  4 Oct 2016 18:54:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, strk@kbt.io
Subject: [PATCH 2/4] diff.c: refactor parse_ws_error_highlight()
Date:   Tue,  4 Oct 2016 15:54:47 -0700
Message-Id: <20161004225449.6759-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-510-g1ef781f2c1
In-Reply-To: <20161004225449.6759-1-gitster@pobox.com>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
 <20161004225449.6759-1-gitster@pobox.com>
X-Pobox-Relay-ID: 91DDDCE8-8A85-11E6-81DD-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the function to parse_ws_error_highlight_opt(), because it is
meant to parse a command line option, and then refactor the meat of
the function into a helper function that reports the parsed result
which is typically a small unsigned int (these are OR'ed bitmask
after all), or a negative offset that indicates where in the input
string a parse error happened.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 46260ed7a1..d346378600 100644
--- a/diff.c
+++ b/diff.c
@@ -3666,10 +3666,11 @@ static int parse_one_token(const char **arg, const char *token)
 	return 0;
 }
 
-static int parse_ws_error_highlight(struct diff_options *opt, const char *arg)
+static int parse_ws_error_highlight(const char *arg)
 {
 	const char *orig_arg = arg;
 	unsigned val = 0;
+
 	while (*arg) {
 		if (parse_one_token(&arg, "none"))
 			val = 0;
@@ -3684,13 +3685,23 @@ static int parse_ws_error_highlight(struct diff_options *opt, const char *arg)
 		else if (parse_one_token(&arg, "context"))
 			val |= WSEH_CONTEXT;
 		else {
-			error("unknown value after ws-error-highlight=%.*s",
-			      (int)(arg - orig_arg), orig_arg);
-			return 0;
+			return -1 - (int)(arg - orig_arg);
 		}
 		if (*arg)
 			arg++;
 	}
+	return val;
+}
+
+static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
+{
+	int val = parse_ws_error_highlight(arg);
+
+	if (val < 0) {
+		error("unknown value after ws-error-highlight=%.*s",
+		      -1 - val, arg);
+		return 0;
+	}
 	opt->ws_error_highlight = val;
 	return 1;
 }
@@ -3894,7 +3905,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-		return parse_ws_error_highlight(options, arg);
+		return parse_ws_error_highlight_opt(options, arg);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
-- 
2.10.1-510-g1ef781f2c1

