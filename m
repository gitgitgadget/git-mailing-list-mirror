From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Fri, 13 Mar 2015 15:42:06 -0400
Message-ID: <CAPig+cS07W6gtW8L5wbQwZuxSLxb-r0s6KNO4eDO5BYdBDbWjw@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 20:42:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWVTJ-0001cD-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 20:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbbCMTmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 15:42:09 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35999 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbCMTmH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 15:42:07 -0400
Received: by ykp9 with SMTP id 9so11473727ykp.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QKAFEN9t7p5wdXrMfy4k3sjlnpFcjo97OkGxSIJJNZw=;
        b=nthC1+c5xmpkFh9fRwuwhU1JBo2eJz7mC1bkmX5jRNh3+sdDScggJgzQg1CskBrXyJ
         I5MX61aIybZyxf8GIQEn8W0EHyY4tbiygJ7cYrzsU8hUXwEgJTrW69/3+DvWhH+fXGMW
         6AAi7odar2Ri8A1s0IwnZ05gKcy/3JMHIO4ERYtRtV39EkgZQLfCfVWnR2CJcBx5awe0
         rLFOuyV43jQiQysW++J7LR3qx3tAAaWySepiEBJIytkBZkNIPDqVvaEOBZH0G0vAkHBe
         /bI3vz7WBUTr5GgCCCZbX6dTd16LTqQoPi98aOiXlmWzl8BiLKTDbPNtAID1LkY8rduR
         tPkg==
X-Received: by 10.236.70.33 with SMTP id o21mr532376yhd.94.1426275726528; Fri,
 13 Mar 2015 12:42:06 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 13 Mar 2015 12:42:06 -0700 (PDT)
In-Reply-To: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
X-Google-Sender-Auth: UBtCk0h0duM642pfU8aMrLJYUnU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265419>

On Fri, Mar 13, 2015 at 9:04 AM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> This patch is just for discusstion. An option --deepen is added to
> 'git fetch'. When it comes to '--deepen', git should fetch N more
> commits ahead the local shallow commit, where N is indicated by
> '--depth=N'. [1]
> [...]
> Of course, as a patch for discussion, it remains a long way to go
> before being complete.
> [...]
> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 655ee64..6f4adca 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -295,6 +295,7 @@ static int find_common(struct fetch_pack_args *args,
>                         if (no_done)            strbuf_addstr(&c, " no-done");
>                         if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
>                         if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
> +                       if (args->depth_deepen)  strbuf_addstr(&c, " depth_deepen");

For consistency, should this be "depth-deepen" rather than "depth_deepen"?

>                         if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
>                         if (args->no_progress)   strbuf_addstr(&c, " no-progress");
>                         if (args->include_tag)   strbuf_addstr(&c, " include-tag");
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index d78f320..6738006 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -708,4 +708,15 @@ test_expect_success 'fetching a one-level ref works' '
>         )
>  '
>
> +test_expect_success 'fetching deepen' '
> +       git clone . deepen --depth=1 &&
> +       cd deepen &&

When this tests ends, the working directory will still be 'deepen',
which will likely break tests added after this one. If you wrap the
'cd' and following statements in a subshell via '(' and ')', then the
'cd' will affect the subshell but leave the parent shell's working
directory alone, and thus not negatively impact subsequent tests.

> +       git fetch .. foo --depth=1
> +       git show foo
> +       test_must_fail git show foo~
> +       git fetch .. foo --depth=1 --deepen
> +       git show foo~
> +       test_must_fail git show foo~2

Broken &&-chain throughout.

> +'
> +
>  test_done
