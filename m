From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 6/7] Support signing pushes iff the server supports it
Date: Wed, 19 Aug 2015 11:18:02 -0400
Message-ID: <CAD0k6qRPmJAF4-LT1jZTCjTiGMpfS4+gt2C36izt5qe3P1pJig@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <1439492451-11233-7-git-send-email-dborowitz@google.com> <xmqqio8hfobk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:18:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS58L-0005wD-35
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbbHSPSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:18:23 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35218 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbbHSPSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:18:22 -0400
Received: by iodt126 with SMTP id t126so12670399iod.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LkCUOC42HASLmon+DdgYPUuKnV0Hqn453sV4gqK4Vtc=;
        b=brFz0MU/SPyDpsqF0D7XdNdzHiBdRZDFo0K7CfzdKf3twOG4weUVrml33wyRHqCXxW
         SRqQ7HwNEBNrUmmjJn0w5i+/MhNK+VQ9mogsO3L6Dbora6FDt1xoSynz0W3iQN8yhe2V
         ora8arlOJFgQ2fgSX5YfAP8xmvmmx8kGkcCMsta1KPe2Sm27ZkTMP7RnPDO3P/UdNUJ6
         1BlicxJ1AbWETloS8ffRvlwfnCpqENglFBLn474N3OsaVCB4h9AUuq4sOpl/70YGkyxl
         n9KyLQVq3BuZql6jzE8/iU4rZrybleGduZJULUVT4B4QBX8W5Ah1QTvcUVxc7zPCbr11
         p83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=LkCUOC42HASLmon+DdgYPUuKnV0Hqn453sV4gqK4Vtc=;
        b=BFJYvIwMu63O+EKBsjinRNmtkRVTb70zE+wBwhCB2X2gPrffDewipmpAuCWiP25eHe
         /fJJUO1ItXPU2JA7N9Dewz5Rgem/dySD3LhoJDGh2wfUzAhLQBqIIiB1DrBpDPg529yK
         Y7H7eYBBbCc88+GGaGPwc/r1xGQek71yzXs+nhJpwlSidHrzD8BjsAn6lMP9+QH5DKjy
         cyQRLbmQzohMppLzHrM0Y+p46b1+6zVTK1xdwR6LmPn5YBDpGEhRch3zSwXoVpE1+6Il
         PxLPI7XD/yBUJHTvMOrnSNegyYHCjiR5PnBHUZ9qS5X1RfnRRHAQnvuuvOt2fOCSjHbv
         28cQ==
X-Gm-Message-State: ALoCoQmPHSk1M/KwwUS2pF7rNOo2rqs8ijlCJcZRH20mqguqWClNofK5J6cSzexM4oYZYeX+Qvji
X-Received: by 10.107.6.66 with SMTP id 63mr12991872iog.9.1439997501520; Wed,
 19 Aug 2015 08:18:21 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Wed, 19 Aug 2015 08:18:02 -0700 (PDT)
In-Reply-To: <xmqqio8hfobk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276182>

On Fri, Aug 14, 2015 at 7:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> diff --git a/send-pack.c b/send-pack.c
>> index 2a64fec..6ae9f45 100644
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -370,7 +370,7 @@ int send_pack(struct send_pack_args *args,
>>               args->use_thin_pack = 0;
>>       if (server_supports("atomic"))
>>               atomic_supported = 1;
>> -     if (args->push_cert) {
>> +     if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
>>               int len;
>>
>>               push_cert_nonce = server_feature_value("push-cert", &len);
>> @@ -379,6 +379,18 @@ int send_pack(struct send_pack_args *args,
>>               reject_invalid_nonce(push_cert_nonce, len);
>>               push_cert_nonce = xmemdupz(push_cert_nonce, len);
>>       }
>> +     if (args->push_cert == SEND_PACK_PUSH_CERT_IF_POSSIBLE) {
>> +             int len;
>> +
>> +             push_cert_nonce = server_feature_value("push-cert", &len);
>> +             if (push_cert_nonce) {
>> +                     reject_invalid_nonce(push_cert_nonce, len);
>> +                     push_cert_nonce = xmemdupz(push_cert_nonce, len);
>> +             } else
>> +                     warning(_("not sending a push certificate since the"
>> +                               " receiving end does not support --signed"
>> +                               " push"));
>> +     }
>
> I wonder if the bodies of these two if statements can be a bit
> better organized to avoid duplication (I suspect you have tried
> and you may already know that the above is the most readable
> version, but I haven't tried to do so myself, so...).

Found a slightly less repetitious way.
