Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C84CC433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7623B60F4B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJ2SsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:48:03 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56300 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhJ2Srw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:52 -0400
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635533123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvkuA/ug4S0hS2yB0odE/1/5ABERYKJiWMluBy2Z3P0=;
        b=qtdIEajsFLp+IlVlMnAEXmreHpMB5JmX3DjQp02ET4nCK4l1+TLlkDKgd1OHXKjNEC5U6a
        mJZZTPQuZVkqWie6T9O7wf58EvFO8wkvizBKwlV4W90Gg/dO36DhzcRnBgRaWPoGhxYWEu
        EvLianr5legzTZKkxRvFtlx7rKWI2pazRSdMgjYvXNmuMvRTC/RCUd5138Pml+NkhSutI5
        r75nWTZff3jEUS/q1TFgiWLrjhSTN4XYGboqfENy+1eG5RkgFm+zusDz6AAlVvu/POjq/3
        6bKn2omn2zNQ4qclDgbOHKy9zxL4S9jCiFbAhXftutkicHhQQymWVSmkGr8FUHih3E1DMT
        nRBZtnsOca5qkByRgWJJ3YstXbv3z3jKEwwfOnRQhNGLI41X8e0J39mNOluwXkj313aX64
        xYyk1TgSHed8EUXfGjZmUIaaMfDInmuUAenEPgvw9vp6jexyo1KStkUFrMWdWsIvaanlQx
        KNkhOyko1QEA2NSHTgiABFJtWyMW4iIUX7vEG24nqxXnwW1rc9L4qs97+q3oV/LKPPNK/A
        diAQ+pHPDt5U1LQsayyuCSu809ecItxSAZ1DnC4Pb49YIxFNBarv+0tnihLI6VmgfZoxjO
        /nylHI2iCJN6V1RxBQ4iy9RZ5ByMV/VeQZPiz6XhHo+23u2xz0NhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635533123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvkuA/ug4S0hS2yB0odE/1/5ABERYKJiWMluBy2Z3P0=;
        b=Zx0GbzfpEBXoGcGwvCSKET3dStT5DXBjEyVCaYluzKkFhXvzz0jJlNh7LRZ6trSPmVPKHr
        dcmsgJMhlwh8p/Cw==
To:     git@vger.kernel.org
Subject: [PATCH v3 0/3] Add some more options to the pretty-formats
Date:   Fri, 29 Oct 2021 14:45:09 -0400
Message-Id: <20211029184512.1568017-1-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211026013452.1372122-1-eschwartz@archlinux.org>
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This revision only contains style nits in response to review comments.
See below.

Eli Schwartz (3):
  pretty.c: rework describe options parsing for better extensibility
  pretty: add tag option to %(describe)
  pretty: add abbrev option to %(describe)

 Documentation/pretty-formats.txt | 16 +++++++---
 pretty.c                         | 54 ++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh    | 16 ++++++++++
 3 files changed, 71 insertions(+), 15 deletions(-)

Range-diff against v2:
1:  1cf0d82b91 ! 1:  55a20468d3 pretty.c: rework describe options parsing for better extensibility
    @@ pretty.c: int format_set_trailers_options(struct process_trailer_options *opts,
     -							&argval, &arglen)) {
     -				matched = options[i];
     +		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
    -+			switch(option[i].type) {
    ++			switch (option[i].type) {
     +			case OPT_STRING:
     +				if (match_placeholder_arg_value(arg, option[i].name, &arg,
    -+								&argval, &arglen) && arglen) {
    ++								&argval, &arglen)) {
     +					if (!arglen)
     +						return 0;
     +					strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
2:  cb6af9bc14 ! 2:  c34c8a4f7f pretty: add tag option to %(describe)
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
      		int i;
      
      		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
    - 			switch(option[i].type) {
    + 			switch (option[i].type) {
     +			case OPT_BOOL:
    -+				if(match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
    -+					if (optval) {
    ++				if (match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
    ++					if (optval)
     +						strvec_pushf(args, "--%s", option[i].name);
    -+					} else {
    ++					else
     +						strvec_pushf(args, "--no-%s", option[i].name);
    -+					}
     +					found = 1;
     +				}
     +				break;
      			case OPT_STRING:
      				if (match_placeholder_arg_value(arg, option[i].name, &arg,
    - 								&argval, &arglen) && arglen) {
    + 								&argval, &arglen)) {
     
      ## t/t4205-log-pretty-formats.sh ##
     @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(describe:exclude=...) vs git describe --exclude ...' '
3:  08ade18b35 ! 3:  b751aaf3c6 pretty: add abbrev option to %(describe)
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
      				break;
     +			case OPT_INTEGER:
     +				if (match_placeholder_arg_value(arg, option[i].name, &arg,
    -+								&argval, &arglen) && arglen) {
    ++								&argval, &arglen)) {
    ++					char *endptr;
     +					if (!arglen)
     +						return 0;
    -+					char* endptr;
     +					strtol(argval, &endptr, 10);
     +					if (endptr - argval != arglen)
     +						return 0;
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
     +				break;
      			case OPT_STRING:
      				if (match_placeholder_arg_value(arg, option[i].name, &arg,
    - 								&argval, &arglen) && arglen) {
    + 								&argval, &arglen)) {
     
      ## t/t4205-log-pretty-formats.sh ##
     @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(describe:tags) vs git describe --tags' '
-- 
2.33.1

