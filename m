Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F336C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15132076F
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXShO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Mar 2020 14:37:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30246 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCXShO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:37:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02OIb9LU014900
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Mar 2020 14:37:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: 
In-Reply-To: 
Subject: RE: [ANNOUNCE] Git v2.26.0 - Test Results NonStop Platform
Date:   Tue, 24 Mar 2020 14:37:01 -0400
Message-ID: <031c01d6020b$38f58a80$aae09f80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYBU46R3Md9Ux8iTMi9uY7qLldrgwAt3ZuA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 23, 2020 5:25 PM, I wrote:
> To: 'Junio C Hamano' <gitster@pobox.com>; 'git@vger.kernel.org'
> <git@vger.kernel.org>
> Cc: 'git-packagers@googlegroups.com' <git-packagers@googlegroups.com>
> Subject: RE: [ANNOUNCE] Git v2.26.0 - Test Results NonStop Platform
> 
> On March 22, 2020 9:10 PM, Junio C Hamano wrote:
> > The latest feature release Git v2.26.0 is now available at the usual
> > places.  It is comprised of 504 non-merge commits since v2.25.0,
> > contributed by 64 people, 12 of which are new faces.
> 
> We had t0301 fail again. This is run entirely within bash as we gave up on ksh.
> I need some advice on what to do here. It does look like this is actually in git
> rather than the tests, based on below.
> 
> What is really strange is that the subtests are transiently failing and not the
> same test each time. I cannot get any consistency during test runs. I also do
> not see anything in the differences that might account for this, unless
> somehow the unicode length. I did revert and retried the test, which also
> resulted in transient failures. It all works fine when I use -x, so I can't shed
> light on it from there. An example of the failure is:
> 
> --- expect-stdout       2020-03-23 20:40:57 +0000
> +++ stdout      2020-03-23 20:40:58 +0000
> @@ -1,4 +1,4 @@
>  protocol=https
>  host=example.com
> -username=askpass-username
> -password=askpass-password
> +username=store-user
> +password=store-pass
> not ok 21 - helper (cache) can forget host
> 
> We also had a hang in subtest 23 at
> 
> expecting success of 0301.23 'helper (cache) can forget user':
>                 check reject $HELPER <<-\EOF &&
>                 protocol=https
>                 host=example.com
>                 username=user1
>                 EOF
>                 check fill $HELPER <<-\EOF
>                 protocol=https
>                 host=example.com
>                 username=user1
>                 --
>                 protocol=https
>                 host=example.com
>                 username=user1
>                 password=askpass-password
>                 --
>                 askpass: Password for 'https://user1@example.com':
>                 EOF
> 
> ++ check reject cache
> ++ credential_opts=
> ++ credential_cmd=reject
> ++ shift
> ++ for arg in "$@"
> ++ credential_opts=' -c credential.helper='\''cache'\'''
> ++ read_chunk
> ++ read line
> ++ case "$line" in
> ++ echo protocol=https
> ++ read line
> ++ case "$line" in
> ++ echo host=example.com
> ++ read line
> ++ case "$line" in
> ++ echo username=user1
> ++ read line
> ++ read_chunk
> ++ read line
> ++ read_chunk
> ++ read line
> ++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout
> 2>stderr'
> +++ git -c credential.helper=cache credential reject

I should have mentioned that we are currently on OpenSSL 1.0.2t. The 1.1.x series is not yet available.

