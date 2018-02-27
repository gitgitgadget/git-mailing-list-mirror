Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4946A1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeB0Xuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:50:35 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18591 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeB0Xuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:50:35 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1RNoVnE056138
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Feb 2018 18:50:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Cc:     "'Joachim Schmitz'" <jojo@schmitz-digital.de>
Subject: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Tue, 27 Feb 2018 18:50:25 -0500
Message-ID: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdOwI9jQuWDAxkQHSzuLX0Z3NLLBaw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

After months of arguing with some platform developers on this subject, the
perl spec was held over my head repeatedly about a few lines that are
causing issues. The basic problem is this line (test-lib-functions.sh, line
633, still in ffa952497)

>        elif test $exit_code -gt 129 && test $exit_code -le 192
>       then
>               echo >&2 "test_must_fail: died by signal $(($exit_code -
128)):

According to the perl spec http://perldoc.perl.org/functions/die.html, die
basically takes whatever errno is, mods it with 256 and there you go. EBADF
is what is used when perl reads from stdin and calls die - that's standard
perl. In most systems, you end up with something useful, when EBADF is 9.
But when it is 4009, you get a garbage answer (4009 mod 256 a.k.a. 169).
However, only 128-165 are technically reserved for signals, rather than all
the way up to 192, which may be true in some places but not everywhere.

The advice (I'm putting that nicely) I received was to use exit so that the
result is predictable - unlikely to be useful in the 15K test suites in git.
However, dropping this to 165 conditionally might help.

I'm looking for what approach to take here, because I don't think I'm going
to get perl fixed any time soon, or the error number range on the platform
fixed ... ever.

This is causing only two breaks that I have lived with and probably still
could. Consider me begging for a suggestion.

Sincerest,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.





