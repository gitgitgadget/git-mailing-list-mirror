Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F231F453
	for <e@80x24.org>; Fri, 19 Oct 2018 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeJTHCL (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 03:02:11 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39155 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeJTHCL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 03:02:11 -0400
Received: by mail-qk1-f202.google.com with SMTP id c132-v6so227807qkb.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C7xFkrVDHd/fwh64+tIsVn+zlKt2liG9E05iTbjDikI=;
        b=HCUd3VwyZDbHoDcygBixs08dxZnC8tyuQOx/HUcYi0xrFrR+OvikpdberPKoFVcJ9O
         VTi4mVRsDDvZiezyLaiETXqei0gLweJDBfN0+noAb+NQgoFvdfh+SYD13A78XknRtZrG
         QEgULHjwET/J2mBqVd7fwmBjQqaO3XVJdcztEP3VZH6HCNRE9dhSwSFXnZA+9LD7QShz
         XQnXkfR+GrhkCDMjBe1IkvXnMVBimcyjf1Y+8/FKrPjirlJxEieiEu/qRiQ4kaHkNL4D
         Aap6IB2PMSHLZeqOroWLjF3npLuCo5Y2TKodzu/Dh4BAA7Zoyk32bqe/rlgP2NndE/8z
         76bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C7xFkrVDHd/fwh64+tIsVn+zlKt2liG9E05iTbjDikI=;
        b=fFxE5h5RsepmkwAQ5Y/tenEwOIAU0ldhFWfaDrOMUEm4d0OXTpWll/0ik7cN7pmn8z
         UNrVbC0sfzF2w3w/3JJtmlnvzmymAGQWbDIU4glbsKXPM9OJpF9mGFXfjve084cvOr9d
         cqHBNI6Bu/kfFjmC5mvIiGqLophQeku2RTjgXvY3SGA+8dLMiAeCwU+ANr/N72qP7Tw6
         CscNdNUXCZ3+srvQOu1B0y/JBR05DMTr5bkn+yN0E9WTKK8YMaIaabap0l3dsIaMfvz8
         KJekSEkXFnbuwCau2HcV+uj1Ucdvtc6pwEM5Ik1u+VXa3koywz3Op2FYos6Jf5cqSrI4
         O79A==
X-Gm-Message-State: ABuFfoi11rWrQvVCJ1X5rcVrs/PE5Nnbeh4WILjqoB3z8OAy2K1k4X2z
        IUoFO0/6EodlAOKCCt+t/sa408nJpm4khUw85dx7TsZzME4czIUMoF3ZmKyCthZdVTuKkazt+Rf
        jLzJ0yvO2C84tE1lzB39zoWQJHmgn7JD04tjEt0DDym9nsSl/0ECmrQTPWxFSzcl1OSbBXKIGre
        vF
X-Google-Smtp-Source: ACcGV62AQFuiZZzFDCtVFrmewR6jxn6PqZBGea+TtWmHWOJxRP1EuGiRbcz6jdeKcLkPcIpNfDsxq3ngwb74HOoiPNRj
X-Received: by 2002:aed:2541:: with SMTP id w1-v6mr28158886qtc.27.1539989647707;
 Fri, 19 Oct 2018 15:54:07 -0700 (PDT)
Date:   Fri, 19 Oct 2018 15:54:04 -0700
Message-Id: <20181019225404.34496-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] fetch-pack: be more precise in parsing v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each section in a protocol v2 response is followed by either a DELIM
packet (indicating more sections to follow) or a FLUSH packet
(indicating none to follow). But when parsing the "acknowledgments"
section, do_fetch_pack_v2() is liberal in accepting both, but determines
whether to continue reading or not based solely on the contents of the
"acknowledgments" section, not on whether DELIM or FLUSH was read.

There is no issue with a protocol-compliant server, but can result in
confusing error messages when communicating with a server that
serves unexpected additional sections. Consider a server that sends
"new-section" after "acknowledgments":

 - client writes request
 - client reads the "acknowledgments" section which contains no "ready",
   then DELIM
 - since there was no "ready", client needs to continue negotiation, and
   writes request
 - client reads "new-section", and reports to the end user "expected
   'acknowledgments', received 'new-section'"

For the person debugging the involved Git implementation(s), the error
message is confusing in that "new-section" was not received in response
to the latest request, but to the first one.

One solution is to always continue reading after DELIM, but in this
case, we can do better. We know from the protocol that "ready" means at
least the packfile section is coming (hence, DELIM) and that no "ready"
means that no sections are to follow (hence, FLUSH). So teach
process_acks() to enforce this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c           | 12 ++++++++++
 t/t5702-protocol-v2.sh | 50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b3ed7121bc..9691046e64 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1248,6 +1248,18 @@ static int process_acks(struct fetch_negotiator *negotiator,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing acks: %d"), reader->status);
 
+	/*
+	 * If an "acknowledgments" section is sent, a packfile is sent if and
+	 * only if "ready" was sent in this section. The other sections
+	 * ("shallow-info" and "wanted-refs") are sent only if a packfile is
+	 * sent. Therefore, a DELIM is expected if "ready" is sent, and a FLUSH
+	 * otherwise.
+	 */
+	if (received_ready && reader->status != PACKET_READ_DELIM)
+		die(_("expected packfile to be sent after 'ready'"));
+	if (!received_ready && reader->status != PACKET_READ_FLUSH)
+		die(_("expected no other sections to be sent after no 'ready'"));
+
 	/* return 0 if no common, 1 if there are common, or 2 if ready */
 	return received_ready ? 2 : (received_ack ? 1 : 0);
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 8360188c01..51009ca391 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -512,6 +512,56 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	! grep "git< version 2" log
 '
 
+test_expect_success 'when server sends "ready", expect DELIM' '
+	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
+
+	git clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
+
+	# After "ready" in the acknowledgments section, pretend that a FLUSH
+	# (0000) was sent instead of a DELIM (0001).
+	printf "/ready/,$ s/0001/0000/" \
+		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+
+	test_must_fail git -C http_child -c protocol.version=2 \
+		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
+	test_i18ngrep "expected packfile to be sent after .ready." err
+'
+
+test_expect_success 'when server does not send "ready", expect FLUSH' '
+	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
+
+	git clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
+
+	# Create many commits to extend the negotiation phase across multiple
+	# requests, so that the server does not send "ready" in the first
+	# request.
+	for i in $(test_seq 1 32)
+	do
+		test_commit -C http_child c$i
+	done &&
+
+	# After the acknowledgments section, pretend that a DELIM
+	# (0001) was sent instead of a FLUSH (0000).
+	printf "/acknowledgments/,$ s/0000/0001/" \
+		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
+		-c protocol.version=2 \
+		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
+	grep "fetch< acknowledgments" log &&
+	! grep "fetch< ready" log &&
+	test_i18ngrep "expected no other sections to be sent after no .ready." err
+'
 
 stop_httpd
 
-- 
2.19.0.271.gfe8321ec05.dirty

