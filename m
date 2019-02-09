Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E9A1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBIT5F (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 14:57:05 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20571 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfBIT5E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 14:57:04 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x19Jv3Do063499
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 9 Feb 2019 14:57:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>
In-Reply-To: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>
Subject: [Proposed Fix] daemon.c: not initializing revents
Date:   Sat, 9 Feb 2019 14:56:55 -0500
Message-ID: <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHuZCOJOJA2t83onwaMLThpXvGUraWkmm4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I found this while trying to track down a hang in t5562 - this isn't the
fix, but here it is something that could be considered a code-inspection. If
there have been random unexplained hangs when git runs as a daemon, this
might be the cause.

According to many systems (other than Linux), the revents field is supposed
to be 0 on return to poll(). This was the cause of some heart-ache a while
back in compat/poll/poll.c. I am not certain whether that copy of poll() is
used in daemon, but I wanted to point out that the value is being returned
to poll, outside of compat/poll/poll.c and may present a potential for poll
returning an error on that FD due to random values that might be in revents.

Please see 61b2a1acaae for a related change/justification.

diff --git a/daemon.c b/daemon.c
index 9d2e0d20ef..1e275fc8b3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1194,6 +1194,7 @@ static int service_loop(struct socketlist *socklist)
                                }
                                handle(incoming, &ss.sa, sslen);
                        }
+                       pfd[i].revents = 0;
                }
        }
 }

Regards,
Randall

