Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771BA1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfBIUWq (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 15:22:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45909 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBIUWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 15:22:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19KMigm064474
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 9 Feb 2019 15:22:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <002301d4bfa9$158716e0$409544a0$@nexbridge.com>
In-Reply-To: <002301d4bfa9$158716e0$409544a0$@nexbridge.com>
Subject: RE: [Hang] t5562 subtest 8 on NonStop
Date:   Sat, 9 Feb 2019 15:22:36 -0500
Message-ID: <000b01d4c0b5$358b6b50$a0a241f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF7XyAaK7kcDLbbZ5zDbowZcN58zqaKqc7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 7:23, I wrote:
> We have suddenly encountered a hung git-http-backend in t5562 in the
> NonStop port. This is a new problem not seen before on the platform,
> surprisingly. I am wondering whether this is a result of not actually
having an
> apache2 server on-board. Is that a possibility and can that sub-test be
> bypassed if no apache2 is detected?
> 
> We also had subtest 15 and I am investigating, but it may depend on 8's
data
> (I had to kill the git-http-backend process, so maybe that's why).

I'm back to investigating subtest 8 hanging after dealing with the /dev/zero
thing. What we end up with two git processes, a git-http-backend, a perl,
and a few shell processes. The act.err file had:

fatal: request ended in the middle of the gzip stream

Which went through die() and should have unwound the whole thing, but
didn't. The git-http-backend is waiting to clean up children and each git is
polling for input. It seems like SIGCHLD did not get back through the
process that started it, or its parent - but I don't quite follow the flow
in this test. I have seen the perl port not like SIGCHLD sometimes, so that
might be what is going on. Is it possible to skip the hanging subtest during
a whole test run? We don't really have anyone using the http backend on
platform (SSH is the generally preferred method to get to git on box), so I
am tempted to ignore the ones that hang as conditional known breakages, if
that is possible, so that we can get our CI builds back in operation.
Thoughts? Advice?

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



