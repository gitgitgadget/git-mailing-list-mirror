Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59E81F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFDDoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:44:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44514 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFDDoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:44:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so41596840wrg.11
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 20:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=raRTLciUZwlxfaAbbim7qWxBMNKyswWjC54grnQ2gHo=;
        b=IC3b6cX407xcNHkrKCHU1GcaAFiYavpHMletnmhGWn3h1yKSthjQJdW5Lha1wve2ow
         4gLPFNPor8q2NHJqklu3IFkLTrES3C9LyckmCUohzlh4hPW/qmEIqUAmcCwlDCAlRF5a
         WSIDcWtYLxVbrj/xzXHBL43dfsilUy7b2QlPFZcbXZvisha9Tbx2IUNyh74grZtOQkm7
         rREV0qtMxeWNkAPNMiWJPNX5DR4jgbgmgZMczniFGOORLayaBqRVUhAHaNUeP7cKSvmt
         a9VC/xT7jcI76Co5k3Niqi04DgC/44pE2VX9sDudGqc+JxKAFTCqjQaELRUgBtUFJVdG
         goGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=raRTLciUZwlxfaAbbim7qWxBMNKyswWjC54grnQ2gHo=;
        b=TGs9ZxKf4SIQRYt8nY/jUltHCM1MRgPlsxVwwdCzvTA5crk5qQhtkltUG6M0viY1o5
         BkZlarR1FlXaTM4aD69iXnztsyY9R35eiCLNNqsmHB6WtSBOC+6KW5eJqKtIY3ut5p6W
         gtTioxHmx95gJRVvZmLdcE77ZqnRkeGVhGMXADGF/TaeSPjtZ34uye5lruyskxVHYC7+
         t+l8qTzk6cobg9jUWk/mPZ16qMDiFAa+HErtK4gJpnPSF5dwjdOXkT+TmwM1i/rwGc/7
         Zch05n0Wd2Eg3KMQsMlZHHdzbuHVMCCSQEiprLun33NMEPhwlSLKVHoxC6EVET0/GjjA
         XHBQ==
X-Gm-Message-State: ALKqPwfCTHkqKU8IOQhLU0PTnxVUY4czKLva930WtRMZsXZv54zH6dT9
        z95ZAtrXMYvxVaU2oX9xGhKiLYDe
X-Google-Smtp-Source: ADUXVKLtl548c4GpXl0bQnxUSPIahBmPubXi4lcXLWOL1UaYGYeG1NWsT66j/j2w8wtJhR6jo/D6Yw==
X-Received: by 2002:adf:e751:: with SMTP id c17-v6mr14657808wrn.143.1528083856859;
        Sun, 03 Jun 2018 20:44:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g129-v6sm2247124wmf.5.2018.06.03.20.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 20:44:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
References: <20180601200146.114919-1-sbeller@google.com>
        <20180601200146.114919-2-sbeller@google.com>
        <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 04 Jun 2018 12:44:15 +0900
In-Reply-To: <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 04 Jun 2018 11:41:02 +0900")
Message-ID: <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  sequencer.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index b98690ecd41..aba03e9429a 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -175,6 +175,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>>  			warning(_("invalid commit message cleanup mode '%s'"),
>>  				  s);
>>  
>> +		free(s);
>>  		return status;
>>  	}
>
> Shouldn't 's' now lose 'const'?  After all, git_config_string()
> gives you an allocated memory so...

Yikes.  Should git_config_string() and git_config_pathname() take
"char **dst" instead of "const char **" as their out-location
parameter?  They both assign a pointer to an allocated piece of
memory for the caller to own or dispose of, but because of
const-ness of the pointee their first parameter has, a caller like
this one must declare "const char *s" yet is forced to call free()
not to leak the value when it is done.

