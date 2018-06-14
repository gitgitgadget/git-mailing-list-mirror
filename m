Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0021F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbeFNWrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:47:51 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:45671 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:47:50 -0400
Received: by mail-ot0-f176.google.com with SMTP id a5-v6so8968215otf.12
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Nful+b7Y42opicci7QL7eozlbju6T5xNNO7GOcTkwio=;
        b=faf8NWP+ZNXcacU/T2vP94loXbAdHh/5NEItxJY6ajOvUA8xuUdqxyMryqDrOmMJ27
         aW18ora8TaEoT68IOeUIoIZK+6Zs8UivkHAJ63VAdB08jcdQ3cBEzCnxdeasFwo44Mbk
         ckwMvU2RL+XpMpuZLwNoV6Nhqh+v00dBnWkDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Nful+b7Y42opicci7QL7eozlbju6T5xNNO7GOcTkwio=;
        b=CZj+Q/L9KUK2oCsPRNqlbjt1pDQVRiCkJsKYETjNY440cIaZrmd1J/U0w3/PuNAJ11
         uf1hvaQMMVdfvCeIW35fuLX0DftzKVoTFrqWEuoUWCO2qY8m7RSf7HMr3F6KJ6Nh2Q6Z
         65bMCuLXRHwFI7/hSMQoAuWnkvRri9FCCirjo8cJlksJ6c2vDpLL1SWRoa1oQNwdyMv9
         89cefn+RpFIX375uF/x5ZhZzFNQHhJ4U/EA+5MillS2kH7TWqVz+ttSqPsA11hs5Tavi
         ixA2IRA3iqg/N4ZWVx679c8rmImdy9ztX/vYLYRqo9sw9XScEKZ1lnYoZ1SVHD3snOnS
         IooQ==
X-Gm-Message-State: APt69E1yV59jU7FrTmJ/NIUxcX12Mqcyy2pLOStLHtjKMbddCk8YRIDq
        6zcXfVrmRXni97It3U3BP3L2WMvzFEwvTN/nK/gwmBJl
X-Google-Smtp-Source: ADUXVKIeFEax+5vgusckVIp5erVH43vW5sOQd2k69NCwQYSVoDXEUF+Xz16qGxC7zZ5beT6j3yIIYKkwFGTIFgD0gO0=
X-Received: by 2002:a9d:3898:: with SMTP id p24-v6mr2732466otc.267.1529016469496;
 Thu, 14 Jun 2018 15:47:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:e8f:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 15:47:28 -0700 (PDT)
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Thu, 14 Jun 2018 17:47:28 -0500
Message-ID: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
Subject: Is NO_ICONV misnamed or is it broken?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

With regards to the Makefile define/variable `NO_ICONV` - the Makefile
comments imply that it should be used if "your libc doesn't properly support
iconv," which could mean anything from "a patch will be applied" to "iconv
won't be used."

Based off the name of the varibale, the assumption is that iconv is an
optional dependency that can be omitted if compiled with NO_ICONV. However, in
practice attempting to compile git with `make ... NO_ICONV=1` and libiconv not
installed results in linker errors as follows:

```
~> make clean
# omitted
~> make NO_ICONV=1
# ommitted
    LINK git-credential-store
/usr/bin/ld: cannot find -liconv
cc: error: linker command failed with exit code 1 (use -v to see invocation)
gmake: *** [Makefile:2327: git-credential-store] Error 1
```

Am I misunderstanding the intended behavior when NO_ICONV is defined (i.e. it
does not remove the dependency on libiconv) or is this a bug and iconv should
not, in fact, be required?

Many thanks,

Mahmoud Al-Qudsi
NeoSmart Technologies
