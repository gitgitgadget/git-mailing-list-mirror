From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] am: let command-line options override saved options
Date: Tue, 04 Aug 2015 14:12:33 -0700
Message-ID: <xmqqbnem69mm.fsf@gitster.dls.corp.google.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697116-27799-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMjVp-00043u-2A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 23:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbbHDVMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 17:12:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33486 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbbHDVMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 17:12:35 -0400
Received: by padck2 with SMTP id ck2so17520896pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Wrj1hFLrEcbUdiIeyRKcVmt+yOs51cntWSTR3YXlqaU=;
        b=V8M6ao/7Ctklxz0+2a3aVD7dz53RRV26gCHnRsAFubgXjzdlUTfsdpNT3S3zVfFr1t
         UCStmM40oGiYvXiUkAbJoh1gcoGLKFn8Slfg9Taxk9FRrNFwWFJq2qQ1rqTaO72AqZ6m
         YrT0BR9E98irT0Jw/3U8u/PqzrZxU0b6Eeo5snTh3FgV6u9i+BAqVmUiRUqsWh8jcMSr
         WLdD6MM8WHRrNMmpjKyT+5YuFw+Px3upnlSVhBsFoHcP7uVJtTYSn4NA+IqtK+gixQ5+
         Ep63PzxSpr9dqfEz5GYJceEGEwc6pqFaDvUKRTrw5bV10SFMOz89St0FvppsrkUJ3xC9
         sxdA==
X-Received: by 10.66.62.163 with SMTP id z3mr11905866par.12.1438722754988;
        Tue, 04 Aug 2015 14:12:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8df6:f08:8b8d:96a6])
        by smtp.gmail.com with ESMTPSA id lm8sm344960pbc.22.2015.08.04.14.12.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 14:12:34 -0700 (PDT)
In-Reply-To: <1438697116-27799-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 4 Aug 2015 22:05:13 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275335>

Paul Tan <pyokagan@gmail.com> writes:

> Let command-line options override saved options in git-am when resuming
>
> This is a re-roll of [v1]. Previous versions:
>
> [v1] http://thread.gmane.org/gmane.comp.version-control.git/274789
>
> When resuming, git-am mistakenly ignores command-line options.
>
> For instance, when a patch fails to apply with "git am patch", subsequently
> running "git am --3way" would not cause git-am to fall back on attempting a
> threeway merge.  This occurs because by default the --3way option is saved as
> "false", and the saved am options are loaded after the command-line options are
> parsed, thus overwriting the command-line options when resuming.
>
> [PATCH 1/3] tweaks test-terminal.perl to redirect the stdin of the child
> process to a pty. This is to support the tests in [PATCH 2/3].
>
> [PATCH 2/3] fixes builtin/am.c, enabling command-line options to override saved
> options. However, even with this patch, the following command-line options have
> no effect when resuming:
>
> * --signoff overriding --no-signoff
>
> * --no-keep overriding --keep
>
> * --message-id overriding --no-message-id
>
> * --scissors overriding --no-scissors
>
> This is because they are only taken into account during the mail-parsing stage,
> which is skipped over when resuming.

It is more like "which has already happened", so I would tend to
think that these are the right things to ignore.  Otherwise, a
pretty common sequence would not work well ...

    $ git am mbox
    ... conflicted ...
    $ edit .git/rebase-apply/patch
    $ git am

... if the "resuming" invocation re-split the message by running
mailinfo again, the edit by the user will be lost.
