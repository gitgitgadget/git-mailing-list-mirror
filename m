Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938C81F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936469AbcJTROG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:14:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33235 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933403AbcJTRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:13:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u9KHDjce005783
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 20 Oct 2016 19:13:46 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9KHDlKN029374;
        Thu, 20 Oct 2016 19:13:47 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
        <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610201154070.3264@virtualbox>
        <xmqqmvhzhu6f.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Oct 2016 19:13:47 +0200
In-Reply-To: <xmqqmvhzhu6f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Oct 2016 09:16:56 -0700")
Message-ID: <vpqinsnndtg.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 20 Oct 2016 19:13:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9KHDjce005783
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1477588426.43702@FsH3v/YVRT74rEDFzVZtSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Are you proposing to replace the tests written as shell scripts with
> scripts in another language or framework that run equivalent
> sequences of git commands that is as portable as, if not more,
> Bourne shell?

The language (/bin/sh) is probably not the biggest issue. The way we use
it may be.

I don't have benchmark to tell what slows down the testsuite, but for
example we often write

	cat >expected <<EOF &&
	content
	EOF
	git foo >actual &&
	test_cmp expected actual

We create 2 files, fork one 'cat' and one 'diff'. Now, suppose we can
write instead

	test_check_output git foo <<EOF
	content
	EOF

where test_check_output would be a compiled program running "git foo"
with popen(), reading the expected output on stdin, and comparing both
(and possibly creating files and forking 'diff', but only on the error
path). That would reduce the overhead of test a lot: on fork+exec to
create the "test_check_output" process + plain string comparison.

Obviously, I don't expect this change to drastically reduce the time
(Peff's numbers seem to suggest that there's not so much to gain), but
maybe getting a few C helpers and "optimized" idioms in our testsuite
could lead to measurable improvements.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
