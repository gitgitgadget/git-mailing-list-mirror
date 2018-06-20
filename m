Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6921F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeFTVco (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:32:44 -0400
Received: from ao2.it ([92.243.12.208]:50849 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933438AbeFTVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:42 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fVki0-00088k-NL; Wed, 20 Jun 2018 23:32:08 +0200
Date:   Wed, 20 Jun 2018 23:32:39 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH 04/10] submodule--helper: add a new 'config'
 subcommand
Message-Id: <20180620233239.dce00f3d9400b674f95adad7@ao2.it>
In-Reply-To: <CAGZ79kbkDO8KEm6ps75xTykU2JCVwHVVpOr+Eq_RQy_bn-jRCw@mail.gmail.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-5-ao2@ao2.it>
        <CAGZ79kbkDO8KEm6ps75xTykU2JCVwHVVpOr+Eq_RQy_bn-jRCw@mail.gmail.com>
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

On Mon, 14 May 2018 18:33:44 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > Add a new 'config' subcommand to 'submodule--helper', this extra level
> > of indirection makes it possible to add some flexibility to how the
> > submodules configuration is handled.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >  builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
> >  t/t7411-submodule-config.sh | 26 +++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 9e8f2acd5..b32110e3b 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1825,6 +1825,44 @@ static int is_active(int argc, const char **argv, const char *prefix)
> >         return !is_submodule_active(the_repository, argv[1]);
> >  }
> >
> > +static int config_print_callback(const char *key_, const char *value_, void *cb_data)
> > +{
> > +       char *key = cb_data;
> > +
> > +       if (!strcmp(key, key_))
> > +               printf("%s\n", value_);
> > +
> > +       return 0;
> > +}
> > +
> > +static int module_config(int argc, const char **argv, const char *prefix)
> > +{
> > +       int ret;
> > +
> > +       if (argc < 2 || argc > 3)
> > +               die("submodule--helper config takes 1 or 2 arguments: name [value]");
> > +
> > +       /* Equivalent to ACTION_GET in builtin/config.c */
> > +       if (argc == 2) {
> > +               char *key;
> > +
> > +               ret = git_config_parse_key(argv[1], &key, NULL);
> > +               if (ret < 0)
> > +                       return CONFIG_INVALID_KEY;
> > +
> > +               config_from_gitmodules(config_print_callback, the_repository, key);
> > +
> > +               free(key);
> > +               return 0;
> > +       }
> > +
> > +       /* Equivalent to ACTION_SET in builtin/config.c */
> > +       if (argc == 3)
> > +               return config_gitmodules_set(argv[1], argv[2]);
> 
> Ah, here we definitely want to set it in the .gitmodules file?
> (Or does that change later in this series?)
> 
> > +
> > +       return 0;
> > +}
> > +
> >  #define SUPPORT_SUPER_PREFIX (1<<0)
> >
> >  struct cmd_struct {
> > @@ -1850,6 +1888,7 @@ static struct cmd_struct commands[] = {
> >         {"push-check", push_check, 0},
> >         {"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> >         {"is-active", is_active, 0},
> > +       {"config", module_config, 0},
> >  };
> >
> >  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> > diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> > index a648de6a9..dfe019f05 100755
> > --- a/t/t7411-submodule-config.sh
> > +++ b/t/t7411-submodule-config.sh
> > @@ -139,4 +139,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> >         )
> >  '
> >
> > +test_expect_success 'reading submodules config with "submodule--helper config"' '
> > +       (cd super &&
> 
> I think the project prefers a style
> of the cd at the same level of the echo and the following commands.
>

There is mixed style about that, so for new tests in existing files I'd
stick to the predominant style in the file.

For new test files I'll use the recommended style of cd on the same
level of the following commands.

> However we might not need the (cd super && ...) via
> 
>   echo "../submodule"  >expected
>   git -C super ubmodule--helper config submodule.submodule.url >../actual
>   test_cmp expected actual
> 
> Our friends developing git on Windows will thank us for saving
> to spawn a shell as spawning processes is expensive on Windows. :)
> Also we have fewer lines of code.
>

I'll see how that looks, thanks for the suggestion.

Again, I'd use a subshell if that's what the other tests in a file do,
and use "git -C" in new files.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
