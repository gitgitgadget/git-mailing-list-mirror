Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1543020A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbdI1VVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:21:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21632 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdI1VVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:21:01 -0400
X-Greylist: delayed 1167 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Sep 2017 17:21:01 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v8SL1XB6097670
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 17:01:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Bug/Solution] Git hangs in compat/poll/poll.c on HPE NonStop
Date:   Thu, 28 Sep 2017 17:01:27 -0400
Message-ID: <009c01d3389c$f6c0cb00$e4426100$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdM4m50XJfAODqdWSIKKpNIKVLclZg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

After a whole lot of investigating, we (it is a large "we") have discovered
the reason for the hang we occasionally get in git-upload-pack on HPE
NonStop servers - reported here well over a year ago. This resulted from a
subtle check that the operating system does on file descriptors. When it
sees random values in pfd[i].revents, it sometimes thinks its dealing with a
TTY and well, things end badly after that. There is a non-destructive fix
that I would like to propose for this that I have already tested. Sadly, I
have no email mechanism where our repo resides for a real patch message. The
patch is based on 2.3.7 (16018ae), but should be applicable forward. We have
held off moving to a more recent version until resolving this, so that's
next on our plan.

--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -438,6 +438,10 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
            pfd[i].revents = happened;
            rc++;
          }
+        else
+          {
+            pfd[i].revents = 0;
+          }
       }

   return rc;

Sincerely,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.

