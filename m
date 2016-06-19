Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750B320189
	for <e@80x24.org>; Sun, 19 Jun 2016 02:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbcFSCqG (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 22:46:06 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33497 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbcFSCqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 22:46:05 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so8409330pac.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 19:46:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lNJiA4UYyLUNjnmsGuk4lMdFbORyTy1diLkGctCHFDA=;
        b=SwkbeZhowricQrxmjdN2EBY+57I/YdYzqxBdFnwWf+J9Ym3UPV3+jUp8jF9uCsmY1r
         NlY2/jO007mykJ4f1o1g4HGVNVLpT5QkcAEuMyGR2KQAPSyXx1d7LxzC5JGDCls0ME0I
         1CfyiY3pHXoZcpgtUcPjvI+r5JonyPPF9L2nvfKNf0t8xDQ8M8PskMHLGy+2qtCIzkcy
         aQwyNqivFD9/BxM3a4K4LO2r3mK9GSyn6jYGPqUB0+a1KEA82p5tyaVDuTPvzn6m6kkf
         03AP9PjL6e1N+g7QcAPoIWwOv5gOaUtK6Vi17dYXwtJ/2UxlwGMu6ZOfX7aIzXHs0NUo
         ryXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lNJiA4UYyLUNjnmsGuk4lMdFbORyTy1diLkGctCHFDA=;
        b=TW2iKW3DXatMiA96+8QqRoypsXGic6zXYROIFOf7AVTfg4MkDPq5Ouj4mfzuLaACRK
         J932/Sym6oT3hO/bwHO068dOSsr8SW/iJ8Ai80W5yQE87M9xvT+fBEHTj8L3eBo4tH1i
         RmNT/kddVjXSkzv39K9mje1z0mMI1EhQlWuWSTNKxxGEZ8I3pPcZN8aOyhO4XoR48/hX
         F7118fYX1xZdIViHRbQoZWxVTkqFk6exL/7jcn/AFsPmMPMclogMvuhrpZ8+6EOiEzOH
         i+qp8OEg9ockyBSqLlGjO6IEZRlfpHkxxnCFLappl+QtN3rvm97nKR5FfTRhYaqZw+sn
         ggwA==
X-Gm-Message-State: ALyK8tKgLOZdZG5rZuelAFMs9ZYFvHw+0lvCy+mroxUjEeci83DYvw092+ynFHJxKYr4UQ==
X-Received: by 10.66.170.168 with SMTP id an8mr12448569pac.47.1466304364095;
        Sat, 18 Jun 2016 19:46:04 -0700 (PDT)
Received: from localhost.localdomain ([118.71.221.47])
        by smtp.gmail.com with ESMTPSA id o6sm1914451pax.9.2016.06.18.19.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 19:46:03 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, LE Manh Cuong <cuong.manhle.vn@gmail.com>
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
Date:	Sun, 19 Jun 2016 09:45:54 +0700
Message-Id: <20160619024554.2983-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <xmqqshwax8ah.fsf@gitster.mtv.corp.google.com>
References: <xmqqshwax8ah.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> Given that LESS, LV and GIT_OBJECT_DIRECTORY are expected to be free
> of any "expensive to expand" strings, I am not sure if this actually
> matters, though.  And more importantly, these are what the end users
> are expected to set to whatever sensible values for them.

The problem is the end users want a "string". In shell, it means you want
scalar context instead of list context, which is where the vulnerability
occured.

Using `$var` is actually `glob(split($var))`. While using
`"$var"` means the shell interpreted $var content as string. That's also
what you do with `test`, `[...]`, redirection `>"$file"` (which is mentioned
in Git conding contention).

That's a mistake usage to introduce that "bug" to the end user.
(I invite you to read the excelent question/answer about this problem
at http://unix.stackexchange.com/q/171346/38906)

> You would not be lying if you said that Git lets people who want to
> do strange things shoot their feet off; I do not think that hardly
> deserves to be called "vulnerability", though.
>
> Having said all that, I do not mind preventing people from shooting
> their foot off, and the change in this patch certainly would not
> hurt.

It's not only people shooting their foot, but also from malicious user.
Given that `curl url | sudo sh/bash` is often found in many instructions,
an end user may not be noticed about the environment variable injection
from their side.

IMHO, it's better if  git can protect the end users in this situation.
