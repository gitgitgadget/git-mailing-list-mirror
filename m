Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24281F404
	for <e@80x24.org>; Mon, 16 Apr 2018 20:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeDPUqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 16:46:48 -0400
Received: from ao2.it ([92.243.12.208]:40386 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDPUqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 16:46:48 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f8B0L-0006qI-LE; Mon, 16 Apr 2018 22:45:37 +0200
Date:   Mon, 16 Apr 2018 22:46:45 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 02/10] submodule: fix getting custom gitmodule file in
 fetch command
Message-Id: <20180416224645.f5d2f49702ad647cabd8c98d@ao2.it>
In-Reply-To: <CAGZ79kZMXjEAHewkwBR4R91c46+jEL5s9rX2D+2gXo2X6dcozA@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180412222047.5716-3-ao2@ao2.it>
        <CAGZ79kbnc17PZ9_=8QLkZgUZ0DHJKfWnxrekmgkLGFBU_0ieug@mail.gmail.com>
        <20180416181841.b486524b8b9b0e68e3a31bfa@ao2.it>
        <CAGZ79kZMXjEAHewkwBR4R91c46+jEL5s9rX2D+2gXo2X6dcozA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 16 Apr 2018 12:23:59 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, Apr 16, 2018 at 9:18 AM, Antonio Ospite <ao2@ao2.it> wrote:
> 
> >
> > Is there an API to just load one config setting?
> 
> Do you mean to
> 
>   git -c key=value foo-command --options ...

I meant, instead of:

  git_config(git_fetch_config, NULL);

which updates a series of config settings, something which loads
_in_the_code_ just the one value for 'core.submodulesFile' previously
set either via "git -c" or "git config".

It turns out what I was looking for is git_config_get_string_const().

The new patch will be simply this:

diff --git a/config.c b/config.c
index 6ffb1d501..1ef9801d3 100644
--- a/config.c
+++ b/config.c
@@ -2087,6 +2087,7 @@ int git_config_get_pathname(const char *key, const char **dest)
  */
 void config_from_gitmodules(config_fn_t fn, void *data)
 {
+       git_config_get_string_const("core.submodulesFile", &submodules_file);
        if (the_repository->worktree) {
                char *file = repo_worktree_path(the_repository, submodules_file);
                git_config_from_file(fn, file, data);


Which covers my use case without changing the fetch behavior for previous
users, as "core.submodulesFile" is a new option.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
