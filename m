Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8C81F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeHHWLr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:11:47 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:39932 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeHHWLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:11:47 -0400
Received: by mail-qk0-f202.google.com with SMTP id x204-v6so3351260qka.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6a0psMzC5PwyE1pCUAKzBimt29rZXwoJzfvCcwjbTDM=;
        b=EqLc6h+0+sp8j1ergFyvs4KsiVOnn95p9OgXLOcMYfDvhrHpT+uODbrH/Eb7OM3Wml
         nfqhqBAJpAmHBdyNFMrQTxbY54GmNLkycltukARkY3ES8NbMDs3Z4QNNZLtYmRDrwp+r
         Wge0wFDkMPW4NGzzyVREwR7M0hEKsacgTcMRHM1A9iTRKcIIVW20lMqKoCprHxyroi5P
         aWByn+WSn8r83FZHaUGZO0TQi8Q7wakKW+lQEBftvucW75K5EXz26JvOMPCmYWoxo0UT
         5/cE4TSNYuayWCYvOua12pR6flsa5PWvfqN9szGwADbOf7p4qrLDrc2V44QkGo1Sl4Ky
         ElQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6a0psMzC5PwyE1pCUAKzBimt29rZXwoJzfvCcwjbTDM=;
        b=hqPzl5F+79lUuyifs5uGbtYgU/VcrNlgrB9mR0cupI7wOJYpQ76CSgGfhV+H/CeiPZ
         nn+r0tZeANpMWtK/W/PF7qpeo7LPITCMVGQW5h0CTjvEW+Feu2MCcVmgtJTGk1IolLq1
         OvQKhQzoqbez5VYNdG3LEIdGnQgq8VxL/dUSf/BwMXMW0O+3KzIdV+2RQ5zkhpURQe3v
         3R3IkSbf4xgKzQEConuxQxHACQqY4CRJTreGaLUjTKtultI5XRIMKO51w4diD7gQqMmc
         s5adf5gOZ1w9Q+Mr2fDZsjDP67iUqrT19Z2fnSwsn5EvzKV8haBxkGqGasNGmrc1iy1q
         wX/w==
X-Gm-Message-State: AOUpUlGaOXdmGDElOTzXcbi6Vtg1i7pLGpIOQ6euKDaAtSmKQNjFLPil
        lYULwdEXwClAhOAeDT7J+1ScGByvAxGD
X-Google-Smtp-Source: AA+uWPxLjhfDAcHG6wMTX3wXgutkqfE7Z6Kd9jMBxeVGuv8/LKFpM7+MP8Qk9B4JRbEI8rreBchBwpOU+08Z
X-Received: by 2002:a37:8704:: with SMTP id j4-v6mr2350396qkd.9.1533757835391;
 Wed, 08 Aug 2018 12:50:35 -0700 (PDT)
Date:   Wed,  8 Aug 2018 12:50:19 -0700
In-Reply-To: <20180808195020.37374-1-sbeller@google.com>
Message-Id: <20180808195020.37374-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180808195020.37374-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/3] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user reported a submodule issue regarding a section mix-up,
but it could be boiled down to the following test case:

  $ git init test  && cd test
  $ git config foo."Bar".key test
  $ git config foo."bar".key test
  $ tail -n 3 .git/config
  [foo "Bar"]
        key = test
        key = test

Sub sections are case sensitive and we have a test for correctly reading
them. However we do not have a test for writing out config correctly with
case sensitive subsection names, which is why this went unnoticed in
6ae996f2acf (git_config_set: make use of the config parser's event
stream, 2018-04-09)

Unfortunately we have to make a distinction between old style configuration
that looks like

  [foo.Bar]
        key = test

and the new quoted style as seen above. The old style is documented as
case-agnostic, hence we need to keep 'strncasecmp'; although the
resulting setting for the old style config differs from the configuration.
That will be fixed in a follow up patch.

Reported-by: JP Sugarbroad <jpsugar@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c          | 12 +++++++++++-
 t/t1300-config.sh |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 02050529788..27e800c7ce8 100644
--- a/config.c
+++ b/config.c
@@ -35,6 +35,7 @@ struct config_source {
 	int eof;
 	struct strbuf value;
 	struct strbuf var;
+	unsigned subsection_case_sensitive : 1;
 
 	int (*do_fgetc)(struct config_source *c);
 	int (*do_ungetc)(int c, struct config_source *conf);
@@ -603,6 +604,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 
 static int get_extended_base_var(struct strbuf *name, int c)
 {
+	cf->subsection_case_sensitive = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
@@ -639,6 +641,7 @@ static int get_extended_base_var(struct strbuf *name, int c)
 
 static int get_base_var(struct strbuf *name)
 {
+	cf->subsection_case_sensitive = 1;
 	for (;;) {
 		int c = get_next_char();
 		if (cf->eof)
@@ -2328,14 +2331,21 @@ static int store_aux_event(enum config_event_t type,
 	store->parsed[store->parsed_nr].type = type;
 
 	if (type == CONFIG_EVENT_SECTION) {
+		int (*cmpfn)(const char *, const char *, size_t);
+
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
 			return error("invalid section name '%s'", cf->var.buf);
 
+		if (cf->subsection_case_sensitive)
+			cmpfn = strncasecmp;
+		else
+			cmpfn = strncmp;
+
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncasecmp(cf->var.buf, store->key, store->baselen);
+			!cmpfn(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index c15c19bf78d..77c5899d000 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1260,6 +1260,7 @@ test_expect_success 'setting different case sensitive subsections ' '
 		Qc = v2
 		[d "e"]
 		f = v1
+		[d "E"]
 		Qf = v2
 	EOF
 	# exact match
-- 
2.18.0.597.ga71716f1ad-goog

