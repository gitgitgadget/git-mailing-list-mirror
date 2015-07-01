From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed, 01 Jul 2015 13:36:40 -0700
Message-ID: <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:36:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAOkS-0006AG-C7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 22:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbbGAUgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 16:36:45 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:32914 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbGAUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 16:36:42 -0400
Received: by ieqy10 with SMTP id y10so43177443ieq.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bhkEe2AE/UOxhnQ9xt+A9oa+Xy9AGmomcAbXL2YxAKg=;
        b=H6Y7/L80SMjg4Plb/SECu/5H+mslQLhWhh5Rs5bCD/qqG5zZKUOjv22xSCFT46Kp8v
         Jc7q7DSLGOkD/mySXr+qZlpud5OENlvnaEM552maYw8V5kLqQWQYEjNMtTQMmlyHP4+q
         9Ky81UVJXZ5XN9cF7ACf8j5jTydzfOUJJ0hep/d51pKXxKWGrgsJ+Ug8sHkPeS+lrkX8
         xm23ymXVpMEN2hjDg7Kd5nmxS4tvnqV0vFTV86J7W5MeHcP9WzmohnH7XCh/f/vNN9/Q
         dYcZghEda/FBDud3EMkGLy2KnDR5wDtaZl14NtgLGBfXxmSDr3z47oJmhG6f32axgITN
         jwSQ==
X-Received: by 10.50.59.211 with SMTP id b19mr35052456igr.42.1435783002042;
        Wed, 01 Jul 2015 13:36:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id 140sm2202945ion.16.2015.07.01.13.36.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 13:36:41 -0700 (PDT)
In-Reply-To: <xmqqfv578x87.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 13:00:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273196>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Borowitz <dborowitz@google.com> writes:
>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>>  Documentation/technical/pack-protocol.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/technical/pack-protocol.txt
>> b/Documentation/technical/pack-protocol.txt
>> index 1386840..2d8b1a1 100644
>> --- a/Documentation/technical/pack-protocol.txt
>> +++ b/Documentation/technical/pack-protocol.txt
>> @@ -534,6 +534,9 @@ A push certificate begins with a set of header
>> lines.  After the
>>  header and an empty line, the protocol commands follow, one per
>>  line.
>>  
>> +Note that (unlike other portions of the protocol), all LFs in the
>> +`push-cert` specification above MUST be present.
>> +
>>  Currently, the following header fields are defined:
>>  
>>  `pusher` ident::
>
> I am moderately negative about this; wouldn't it make the end result
> cleaner to fix the implementation?

I think that something like this should be sufficient.  As the
receiving end, we must not complain if there is no terminator.

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d0571..303a1dd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1415,9 +1415,12 @@ static struct command *read_head_info(struct sha1_array *shallow)
 					true_flush = 1;
 					break;
 				}
-				if (!strcmp(certbuf, "push-cert-end\n"))
+				if (!strcmp(certbuf, "push-cert-end") ||
+				    !strcmp(certbuf, "push-cert-end\n"))
 					break; /* end of cert */
 				strbuf_addstr(&push_cert, certbuf);
+				if (certbuf[len - 1] != '\n')
+					strbuf_addch(&push_cert, '\n');
 			}
 
 			if (true_flush)
