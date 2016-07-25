Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A33203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbcGYKpM (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 06:45:12 -0400
Received: from fr-hpida-esg-02.alcatel-lucent.com ([135.245.210.21]:52766 "EHLO
	smtp-fr.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123AbcGYKpK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 06:45:10 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jul 2016 06:45:10 EDT
Received: from fr712umx3.dmz.alcatel-lucent.com (unknown [135.245.210.42])
	by Websense Email Security Gateway with ESMTPS id 7E347757BF903;
	Mon, 25 Jul 2016 10:34:12 +0000 (GMT)
Received: from fr711usmtp1.zeu.alcatel-lucent.com (fr711usmtp1.zeu.alcatel-lucent.com [135.239.2.122])
	by fr712umx3.dmz.alcatel-lucent.com (GMO-o) with ESMTP id u6PAYE0C006524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 25 Jul 2016 10:34:14 GMT
Received: from FR712WXCHHUB03.zeu.alcatel-lucent.com (fr712wxchhub03.zeu.alcatel-lucent.com [135.239.2.74])
	by fr711usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id u6PAY8KN010289
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 25 Jul 2016 12:34:13 +0200
Received: from [138.203.139.41] (135.239.27.39) by
 FR712WXCHHUB03.zeu.alcatel-lucent.com (135.239.2.74) with Microsoft SMTP
 Server (TLS) id 14.3.195.1; Mon, 25 Jul 2016 12:34:01 +0200
From:	Jan Smets <jan.smets@nokia.com>
Subject: Client exit whilst running pre-receive hook : commit accepted but no
 post-receive hook ran
To:	<git@vger.kernel.org>
CC:	Stephen Morton <stephen.morton@nokia.com>, <peff@peff.net>
Message-ID: <5795EB1C.1080102@nokia.com>
Date:	Mon, 25 Jul 2016 12:34:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [135.239.27.39]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi

I have always assumed the post-receive hook to be executed whenever a 
commit is "accepted" by the (gitolite) server. That does not seem to be 
true any more.

Since 9658846 is appears that, when a client bails out, the pre-receive 
hook continues to run and the commit is written to the repository, but 
no post-receive hook is executed. No signal of any kind is received in 
the hook, not even a sig pipe when the post- hook is writing to stdout 
whilst the client has disconnected.


commit 9658846ce3d379b9ff8010a2ed326fcafc10eb82
Author: Jeff King <peff@peff.net>
Date:   Wed Feb 24 02:40:16 2016 -0500

     write_or_die: handle EPIPE in async threads

diff --git a/write_or_die.c b/write_or_die.c
...
  static void check_pipe(int err)
  {
         if (err == EPIPE) {
+               if (in_async())
+                       async_exit(141);



Please keep me in CC as I am not subscribed to the list.

Thanks
Jan



The pre-receive hook from my quick testing => press Ctrl-C on the client 
when it is busy processing the 'sleep 5'
In my testing I was committing/pushing 32MB+ binary files that take some 
time to process.

#!/bin/bash
trap 'echo TRAP >> /tmp/gittest/log' 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
IN=$(cat /dev/stdin)

echo -n $(date) >> /tmp/gittest/log
echo " : PRE START"  >> /tmp/gittest/log

for i in $(seq 1 10); do
   echo This is the pre-receive hook $i; sleep 0.1
done

# give time for client to ctrl-c out
sleep 5

echo -n $(date) >> /tmp/gittest/log
echo " : PRE END"  >> /tmp/gittest/log

# This should result in a sigpipe? but it isn't.
echo "Done !"
echo "Done !"

# no exit code -> accept commit



