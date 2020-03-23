Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052FC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BB2070A
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCWVZh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 23 Mar 2020 17:25:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22245 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:25:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02NLPVeq026619
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Mar 2020 17:25:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
Subject: RE: [ANNOUNCE] Git v2.26.0 - Test Results NonStop Platform
Date:   Mon, 23 Mar 2020 17:25:25 -0400
Message-ID: <02d901d60159$94b3b250$be1b16f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYBU46R3Md9Ux8iTMi9uY7qLldrgw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 22, 2020 9:10 PM, Junio C Hamano wrote:
> The latest feature release Git v2.26.0 is now available at the usual places.  It
> is comprised of 504 non-merge commits since v2.25.0, contributed by 64
> people, 12 of which are new faces.

We had t0301 fail again. This is run entirely within bash as we gave up on ksh. I need some advice on what to do here. It does look like this is actually in git rather than the tests, based on below.

What is really strange is that the subtests are transiently failing and not the same test each time. I cannot get any consistency during test runs. I also do not see anything in the differences that might account for this, unless somehow the unicode length. I did revert and retried the test, which also resulted in transient failures. It all works fine when I use -x, so I can't shed light on it from there. An example of the failure is:

--- expect-stdout       2020-03-23 20:40:57 +0000
+++ stdout      2020-03-23 20:40:58 +0000
@@ -1,4 +1,4 @@
 protocol=https
 host=example.com
-username=askpass-username
-password=askpass-password
+username=store-user
+password=store-pass
not ok 21 - helper (cache) can forget host

We also had a hang in subtest 23 at

expecting success of 0301.23 'helper (cache) can forget user':
                check reject $HELPER <<-\EOF &&
                protocol=https
                host=example.com
                username=user1
                EOF
                check fill $HELPER <<-\EOF
                protocol=https
                host=example.com
                username=user1
                --
                protocol=https
                host=example.com
                username=user1
                password=askpass-password
                --
                askpass: Password for 'https://user1@example.com':
                EOF

++ check reject cache
++ credential_opts=
++ credential_cmd=reject
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential reject


