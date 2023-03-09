Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D3C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCIStE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCIStD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:49:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B89F9EE1
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:49:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso7202146pjb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678387742;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SaD7nnx1UDIRi1O/csDKR1zs5BYKGUyjSIczIugSYg=;
        b=TkoBR3hJvNZW7HmcGBlT1wl8u9eNR4qey3vvrb0FJrQHstQyrphBKbBZmFeGg3glG1
         ESrWsolRqYH5sxPFE6oZ56Tuu6/A5cr6GvvCcXZ5Dh1QPfeDN+8j4FXCeQUxC/J2GDEy
         cspywCNRnXBcrk2AW91G1InMR75i6jMmSTJYAHABo9XKrN5l+Le9cbejnmyEC+aZvSh2
         T52c3bhX2M89cX6Jmr2kYnE1p4KbZaAw4JQjG/KjWVWKqQ6fM0AeNHO9/CSKLgotNbdD
         SfBYQA0706teCbJw/L44eFvmBa1v6HlrKRtHRUugZ8pLxik3oAVK0VkxKFT7qmY4PT21
         Vd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387742;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5SaD7nnx1UDIRi1O/csDKR1zs5BYKGUyjSIczIugSYg=;
        b=XrbDGFXMHZfDTSmRDhNhWxCv/pmkfCSKOk06MEjVF2wwlg1F4hzZhaq1T+RpVjpzI7
         xs3aAFk43/RymVIe2yaTX5kozTDqbLzQHoWuZ/FmMgRqgsJ+0vtpUvXKt+JkgJ4s7Y/p
         CkzHdVTtm2qjAX8eO7mm9f4TwCBECq6wmFLaHZKXr+t46tLRNQnhp7pPqdDobLFzPjdj
         FESuMkOIIT4sdrXohNaN7VTjgd1Rz7Qp7iTI6aXpU+OW79E9Dg8/NsveHwZSS9Qkm2s7
         /dIZIri+YZIrxmtWtLulEQOUAbKqyFUXAf0KFeXHBi4X1d8YrYxPioyRGw5+DqPZ/xP+
         JUrw==
X-Gm-Message-State: AO0yUKVfl5F+2b3AVleWZMGe6lJpF4fu600P7TADw9pTKvGlOfl04jHx
        LzKv2bAPovaKiOCyHrntoZA=
X-Google-Smtp-Source: AK7set+lwfFllJC/dkaz5U/ox8iqnYqpZ1i0I2LTBQnuU0IlU7QQBLCH4QDQrWD11LOQuF87/n80kw==
X-Received: by 2002:a17:903:41d0:b0:19b:c2d:1222 with SMTP id u16-20020a17090341d000b0019b0c2d1222mr1841124ple.52.1678387742217;
        Thu, 09 Mar 2023 10:49:02 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id le6-20020a170902fb0600b0019edd30f828sm4986479plb.209.2023.03.09.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:49:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
        <xmqqsfedahhl.fsf@gitster.g>
Date:   Thu, 09 Mar 2023 10:49:01 -0800
In-Reply-To: <xmqqsfedahhl.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Mar 2023 10:48:22 -0800")
Message-ID: <xmqqo7p1ahgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -2281,6 +2287,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>  		if (status)
>>  			return "index-pack fork failed";
>>  		pack_lockfile = index_pack_lockfile(child.out, NULL);
>> +		atexit(unlink_pack_lockfile);
>
> Hmph, why isn't this a straight application of tempfile API?

Ah, sorry, that has already been raised in the thread.  I should
have checked first.

Sorry for the noise.
