Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572E820966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbdDGTj7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:39:59 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35662 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdDGTj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:39:58 -0400
Received: by mail-pg0-f43.google.com with SMTP id 81so75250845pgh.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rp0UXBQwKrxlrs4lACE7tW6mtmEPK4dijirmjyBuoJE=;
        b=NGT+UfJD3zz281BWbBcqGVpCyve0FnVxHwdWpsuampyUs6JQCllquxkyAI5yBix/ky
         1auQOFLB40Dv2f9IDSK54b8UfJ+LWmbKy6LTvcjEgzmfrRZ2nmLF50tcfHSm7TtVxaE6
         DOiM2xoG43WM3ZsdCRqVCDwVRIWFiLcnws3ZfKeTM8VFSTuwnKBk47dex/VzyIeUH0Ou
         IuEL4d50Qa9sZwOnouC+5pJCbVMvQzsde/tMKRoRORvxMM+UFRKLwzEfg2oNt1EkmSN3
         7Eqhiy40M0aKNjdqMrSztGPxSbvcQ0jA8918IKwS+xCdV9w9Momj7uLZ+mIQ2jNwPn40
         9+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rp0UXBQwKrxlrs4lACE7tW6mtmEPK4dijirmjyBuoJE=;
        b=mqR6uwRUG5kgZSs+2ye9Ph2UrYgxdgIAfrxTsqdvcj0H97BtF+YeyEKgjI69+6zwfB
         FJ26GOyPg/QQMry+0gCQP5fqHpCl7cnUiZS/vWrNzOF79KQ9YDWaYunJHTqucNNpta4N
         EysDdUUvS0/O7NG62DsHwrjyV85cdc6dqQZ9F1er+oP3abEw2UyUE6sXihmfWviI3XH8
         oW+/TUe1MIHuBMReLEvYlgQ8oTbrnV3RpqeSrW3FWep4i6hqd82kUtivg2wpUDFsjkLB
         7d9xfr9zgZbKnqr0gIb6l1HzPF4Gd/Ug+AmHTXyXbOQq0RmA4DJ8mGj16c/kqbunAmBO
         9pEQ==
X-Gm-Message-State: AFeK/H2J/t2+2fu1jOru9sVw83xfnFWnUQxOiynJjvsAICUFBazS4bcVailRCIKTi58FiNtX7zkTyKCxiOuEd8WN
X-Received: by 10.98.193.69 with SMTP id i66mr42015704pfg.35.1491593997552;
 Fri, 07 Apr 2017 12:39:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 12:39:57 -0700 (PDT)
In-Reply-To: <20170407192919.10209-1-bmwill@google.com>
References: <20170407192919.10209-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 12:39:57 -0700
Message-ID: <CAGZ79kao8R9ANDv94oovwB0QK4V_r2VmdCuuUxoEBt_LWFm70A@mail.gmail.com>
Subject: Re: [PATCH] pathspec: fix segfault in clear_pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 12:29 PM, Brandon Williams <bmwill@google.com> wrote:
> In 'clear_pathspec()' the incorrect index parameter is used to bound an
> inner-loop which is used to free a 'struct attr_match' value field.
> Using the incorrect index parameter (in addition to being incorrect)
> occasionally causes segmentation faults when attempting to free an
> invalid pointer.  Fix this by using the correct index parameter 'i'.

This was introduced via b0db704652 (pathspec: allow querying for
attributes, 2017-03-13), and it seems there was no other topics
in flight since then or at the time.  So the review failed to spot it
and not some other weird root cause.

Thanks,
Stefan
