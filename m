Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6871F404
	for <e@80x24.org>; Wed, 10 Jan 2018 18:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeAJSgM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 Jan 2018 13:36:12 -0500
Received: from elephants.elehost.com ([216.66.27.132]:48337 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeAJSgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 13:36:11 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0AIa99S008986
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 13:36:10 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [BUG] Breakage in t5509 # 2 from read(stdin) EINVAL
Date:   Wed, 10 Jan 2018 13:36:04 -0500
Message-ID: <00e601d38a41$e25a1c60$a70e5520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_00D7_01D38A15.0BFA3690";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE9kcIhK26B6mL9TrgyDP0tCNFtlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Here’s the situation. In the NonStop port, since time immemorial, we’ve had
a breakage in 5509 that I’ve finally had the chance to track down. The error
report at the breakage is:

./trash directory.t5509-fetch-push-namespaces/original: GIT_TRACE=true
GIT_PACKET_TRACE=true GIT_TRANSLOOP_DEBUG=true git push pushee-namespaced
master
11:55:02.512020 trace: built-in: git 'push' 'pushee-namespaced' 'master'
11:55:02.600895 trace: run_command: 'git-remote-ext' 'pushee-namespaced'
'git --namespace=namespace %s ../pushee'
11:55:02.610439 trace: built-in: git 'remote-ext' 'pushee-namespaced' 'git
--namespace=namespace %s ../pushee'
11:55:02.612643 trace: run_command: 'git' '--namespace=namespace'
'receive-pack' '../pushee'
11:55:02.622553 trace: built-in: git 'receive-pack' '../pushee'
Transfer loop debugging: stdin is readable
error: read(stdin) failed: Invalid function argument
Transfer loop debugging: remote input is readable
error: read(remote input) failed: Invalid function argument
error: Git to program copy process failed
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

transport-helper.c uses read instead of wrapper.c’s xread to do its work. It
looks like when the buffer size calculation is done passed into read, we’re
getting a very large value, more than SSIZE_MAX. In udt_do_read:

bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);

generates EINVAL. This may be because unidirectional_transfer.bufuse is
size_t instead of ssize_t. I can try to fix this a number of ways, but it
seems that xread is likely the way to go. udt_do_write already uses xwrite.

I’m looking to fix on or after 2.13.5 (7234152).

Opinions?

Thanks,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



