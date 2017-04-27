Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8401FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbdD0FxZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:53:25 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36573 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbdD0FxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:53:24 -0400
Received: by mail-pf0-f173.google.com with SMTP id 194so16032312pfv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=skdZhNRAkUHdKynBtX1XzxpmXzd7dzoABH1HtaPjoIc=;
        b=DiHv1O8VSkXVGJOMtS+J+CJZyzGZ4oyt0qJfRMiEt7QCt9K+D2zljflxuyl+XTDgUU
         QXLe+0pwmqzfsOYLCupvJP9E/DWr5ci6xI2PpXvjObZcpL6YjKGnPPTDeifgQ0qL78dn
         7zcHzRG6Dtf6xPGEeVmQv/olCW44kCh5gxfqIg7U+qV9YWX3yknCwbbmXxuBBI/D145U
         3GpTO5fh2MVIlgWTPk+eOjMsCSiAyr1PasCP1SjtphEeDAYzYzyTRowLjTX7FXWRLhJU
         lF9FQpV/qaMICqgnDeF4yWEpPQF1GJhVGxGmBgNBpr/WNm8HGnNHlPqmRxkHpCh0nosl
         1P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=skdZhNRAkUHdKynBtX1XzxpmXzd7dzoABH1HtaPjoIc=;
        b=VuUHjVV5ZW7L71sh6AIyOmFDlgD7YyQJGIHzFgBc5pM3N52GQBBpx+hrvLB3Eqt1TQ
         lczbnQ2gmDrpCdN5FX4S95C2RMIxc91p20lYYLcL6S3JlCjijzeVNkhEr9ucX5uZMRkI
         ityBXYQuzz2TNOrtLlT3XATYF/SDUO3o0609qEczjZ/PQmWTYl5nDRIq0N9rMM5Y7088
         s9Kfj/4STBhSvbZshUpeblMatq6SOI+ThWjVv9b92oogQQf+eK35+Jt54Fg/7IZ4wL0x
         vIY9dCfWP2X2a4lj2sEnwNDMBqszMxBmem+ixAiE9gVtAyWYKgfTmzuwxyWQ0yKCJHSt
         xAGQ==
X-Gm-Message-State: AN3rC/6IGnrgDNFZtIgcZM+i/BE5BoDJP+E8M+m3K13vkXGQo1QDbj0N
        MOqHEqHFfbo14MKFuXDVoQ==
X-Received: by 10.98.4.199 with SMTP id 190mr1138080pfe.54.1493272403389;
        Wed, 26 Apr 2017 22:53:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id p11sm2037637pfl.4.2017.04.26.22.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 22:53:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
        <CAGZ79kbQTbFEtg7N8kpnWDhPmuVyhc-=gey7ca0XobgOwE8Q3w@mail.gmail.com>
Date:   Wed, 26 Apr 2017 22:53:21 -0700
In-Reply-To: <CAGZ79kbQTbFEtg7N8kpnWDhPmuVyhc-=gey7ca0XobgOwE8Q3w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Apr 2017 14:06:09 -0700")
Message-ID: <xmqq8tmmo0q6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> -       if (get_oid_hex(x, commit_id) < 0)
>> -               return -1;
>> +       if (!ret && get_oid_hex(x, commit_id) < 0)
>> +               ret = -1;
>>
>
> In similar cases of fixing mem leaks, we'd put a label here
> and make excessive use of goto, instead of setting ret to -1.
> As "ret" and the commands are short, this is visually just as appealing.

I wouldn't call that visually appealing.  Fixing resource leaks is
good, and only because this function is short enough and the funny
way to skip over various operation need to last for just a few
instructions, it is tolerable.  If the function were shorter, then
we may have used

	if (!strbuf_getline_lf() &&
	    skip_prefix() &&
	    !get_oid_hex())
		ret = 0; /* happy */
	else
		ret = -1;
	release resources here;
        return ret;

and that would have been OK.  If longer, as you said, jumping to a
label at the end of function to release the acquired resource would
be a lot more maintainable way than either of the above alternatives
that are only usable for short functions.

The patch as posted makes the function fail to return -1 when it
finds problems, by the way.  It needs to return "ret" not the
hardcoded "0" at the end.


        
