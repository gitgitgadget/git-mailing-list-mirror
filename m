Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37341F403
	for <e@80x24.org>; Tue,  5 Jun 2018 09:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeFEJyP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 05:54:15 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33456 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeFEJyN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 05:54:13 -0400
Received: by mail-yw0-f180.google.com with SMTP id u124-v6so527500ywg.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 02:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbXDNeTWw+SjwnJSdlMhjh76l4z4hS+WRtkjRxXUnEY=;
        b=VOuFvLtbf1yTEtk+teaT3nHi0EAvnyCnsE4+rmEc4i47G6mMOyYhDmWsIdU2ErT7ih
         7I2GKRxbMdFKGrhros5kwd9x5O1Kluzcp8qo9OGiUAU2TXky4j6UwWWTnWS1SGT88IZv
         nek+GJzqKvbDdy9BSAhjFFYEP0jLzsC+h9hVRMgl4NgFzOuK10CMwtK1V2xIFTKT9ysx
         mtWbOaWbzf/AVqwiARKicS4rg53UyD16r6tkyauMji66AA8zxUyhGmTE7HVEAD8wERDB
         22RX9wReHcHokUiSO3yA98IRjmtDzW46NCtBhVnleScJJycfInRRDkTKSTLtXo7cFrkw
         C75A==
X-Gm-Message-State: ALKqPwe2/EShovahuUS3Yi1uEkTFHukj2pjMVRSFcGxNvTvMcpZAZuGk
        6QLNFIdv2YfPCFqL/5iWmejmKCtYLn8ejYjpxHs=
X-Google-Smtp-Source: ADUXVKJNwPZ2f/doWJ14IfiiWIW9f4tq5zbc7DNi3lKBZoUIolo3oIXYP/sh/x+0SfqgKZ21J34qQZCVCt2f2ip8n7I=
X-Received: by 2002:a81:738b:: with SMTP id o133-v6mr8168108ywc.120.1528192452671;
 Tue, 05 Jun 2018 02:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-2-luke@diamand.org>
In-Reply-To: <20180605091350.14476-2-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jun 2018 05:54:01 -0400
Message-ID: <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on
 error from p4 server
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        merlorom@yahoo.fr, Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>, lex@lexspoon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 5:14 AM Luke Diamand <luke@diamand.org> wrote:
> This change lays some groundwork for better handling of rowcount errors
> from the server, where it fails to send us results because we requested
> too many.
>
> It adds an option to p4CmdList() to return errors as a Python exception.
>
> The exceptions are derived from P4Exception (something went wrong),
> P4ServerException (the server sent us an error code) and
> P4RequestSizeException (we requested too many rows/results from the
> server database).
>
> This makes makes the code that handles the errors a bit easier.
>
> The default behavior is unchanged; the new code is enabled with a flag.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -566,10 +566,30 @@ def isModeExec(mode):
> +class P4ServerException(Exception):
> +    """ Base class for exceptions where we get some kind of marshalled up result from the server """
> +    def __init__(self, exit_code, p4_result):
> +        super(P4ServerException, self).__init__(exit_code)
> +        self.p4_result = p4_result
> +        self.code = p4_result[0]['code']
> +        self.data = p4_result[0]['data']

The subsequent patches never seem to access any of these fields, so
it's difficult to judge whether it's worthwhile having 'code' and
'data' bits split out like this.

> @@ -616,9 +636,25 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False):
>      if exitCode != 0:
> -        entry = {}
> -        entry["p4ExitCode"] = exitCode
> -        result.append(entry)
> +        if errors_as_exceptions:
> +            if len(result) > 0:
> +                data = result[0].get('data')
> +                if data:
> +                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
> +                    if not m:
> +                        m = re.search('Request too large \(over (\d+)\)', data)

Does 'p4' localize these error messages?

> +                    if m:
> +                        limit = int(m.group(1))
> +                        raise P4RequestSizeException(exitCode, result, limit)
> +
> +                raise P4ServerException(exitCode, result)
> +            else:
> +                raise P4Exception(exitCode)
> +        else:
> +            entry = {}
> +            entry["p4ExitCode"] = exitCode
> +            result.append(entry)
