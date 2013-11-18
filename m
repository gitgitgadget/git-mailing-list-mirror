From: =?UTF-8?B?IkFuZHLDqXMgRy4gQXJhZ29uZXNlcyI=?= <knocte@gmail.com>
Subject: [PATCHv2] transport: Catch non positive --depth option value
Date: Mon, 18 Nov 2013 23:45:11 +0100
Message-ID: <528A9877.4060802@gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 18 23:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViXZN-0001gY-AG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 23:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab3KRWpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 17:45:21 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:64424 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab3KRWpU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 17:45:20 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so2847719eek.12
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rQpyHPi/+51PB03YjIfcYyoUOZ1C38UbvJeNF7Ex3yw=;
        b=i0cblZMEaTWRQ0jR2L4eA32FUjOouJ5AsUCLNlN0l7WQAAgpe8qIsmz8ykkMtpKkbA
         OB7uYgRGkaZgPWdAmkCfVvetmjwQbRdzlnc16FAaiDF0vcSI8eQgmW94zmPnb/ZlrdGE
         Ss3NgwO9ZziO+m559jorcv5esofOQXmQTu8aTbO8yyUbkdJfPiOz8QMv0qiesblqdsBJ
         XijvU6AAC/S26BFl426vuE+5fgqcx0hg4x9lkqsTliZO2zj3IsqLweTwTiQuIdCGmgZT
         kRApiwYnwo2O9o2pD4L7Mc1oEsMy6eP/JuBg3meWdygdVVAoiumaeyyaWYLXtcwsykzt
         cQMA==
X-Received: by 10.14.102.66 with SMTP id c42mr6439579eeg.47.1384814718725;
        Mon, 18 Nov 2013 14:45:18 -0800 (PST)
Received: from ?IPv6:2001:a60:14a5:4a01:85ae:74c0:1f1c:fa3f? ([2001:a60:14a5:4a01:85ae:74c0:1f1c:fa3f])
        by mx.google.com with ESMTPSA id a51sm42244012eeh.8.2013.11.18.14.45.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Nov 2013 14:45:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238020>

Instead of simply ignoring the value passed to --depth
option when it is zero or negative, now it is caught
and reported.

This will let people know that they were using the
option incorrectly (as depth<0 should be simply invalid,
and under the hood depth==0 didn't have any effect).

Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
  transport.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/transport.c b/transport.c
index 7202b77..edd63eb 100644
--- a/transport.c
+++ b/transport.c
@@ -483,6 +483,8 @@ static int set_git_option(struct 
git_transport_options *opts,
              opts->depth = strtol(value, &end, 0);
              if (*end)
                  die("transport: invalid depth option '%s'", value);
+            if (opts->depth < 1)
+                die("transport: invalid depth option '%s' (non 
positive)", value);
          }
          return 0;
      }
-- 
1.8.1.2
