Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0241F406
	for <e@80x24.org>; Thu, 10 May 2018 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEJT7V (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:59:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40463 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEJT7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:59:20 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w4AJxHIX037501
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 May 2018 15:59:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Bryan Turner'" <bturner@atlassian.com>
Cc:     "'Git Users'" <git@vger.kernel.org>
References: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com> <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
In-Reply-To: <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
Subject: RE: [Best Practices Request] clean/smudge configuration
Date:   Thu, 10 May 2018 15:59:12 -0400
Message-ID: <001401d3e899$60cf3930$226dab90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFnnQJFkppPCcoZJFTxZlMkMoJajAGXzmEUpPU2t9A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On May 9, 2018 6:39 PM, Bryan Turner wrote:
> On Wed, May 9, 2018 at 3:09 PM Randall S. Becker
> <rsbecker@nexbridge.com>
> wrote:
> 
> > The question: what is the best practice for versioning the parts of
> > clean/smudge filters that are in .git/config given that only some
> > users in my environment will be cloning the repository in question and
> > that I
> really
> > can't put the entries in /etc/gitconfig or ~/.gitconfig because of
> potential
> > conflicts with other repositories that might also have clean/smudge
> > definitions.
> 
> Depending on level of trust, one approach might be to use an [include] in
> .git/config to include a file that's in the repository. Something like:
> 
> [include]
>      path = ../path/to/config
> 

What if we create a ../.gitconfig like ../.gitattributes, that is loaded
before .git/config? With loads of warnings in the documentation about what
*NOT* to put in here, any platform specifics and your own risk. The code in
config.c would look like the following, with obvious updates to
documentation and the test suite, so it's not fully baked yet. So far, I
don't have a solution to the chicken-and-egg problem, other than this.
However, if I'm barking up the wrong ballpark...

diff --git a/config.c b/config.c
index b0c20e6cb..75d5288ff 100644
--- a/config.c
+++ b/config.c
@@ -1555,11 +1555,15 @@ static int do_git_config_sequence(const struct
config_options *opts,
        char *xdg_config = xdg_config_home("config");
        char *user_config = expand_user_path("~/.gitconfig", 0);
        char *repo_config;
+       char *repo_config_versioned;

-       if (opts->commondir)
+       if (opts->commondir) {
                repo_config = mkpathdup("%s/config", opts->commondir);
-       else
+               repo_config_versioned = mkpathdup("%s/../.gitconfig",
opts->commondir);
+       } else {
                repo_config = NULL;
+               repo_config_versioned = NULL;
+       }

        current_parsing_scope = CONFIG_SCOPE_SYSTEM;
        if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
0))
@@ -1574,6 +1578,8 @@ static int do_git_config_sequence(const struct
config_options *opts,
                ret += git_config_from_file(fn, user_config, data);

        current_parsing_scope = CONFIG_SCOPE_REPO;
+       if (repo_config_versioned && !access_or_die(repo_config_versioned,
R_OK, 0))
+               ret += git_config_from_file(fn, repo_config_versioned,
data);
        if (repo_config && !access_or_die(repo_config, R_OK, 0))
                ret += git_config_from_file(fn, repo_config, data);

@@ -1585,6 +1591,7 @@ static int do_git_config_sequence(const struct
config_options *opts,
        free(xdg_config);
        free(user_config);
        free(repo_config);
+       free(repo_config_versioned);
        return ret;
 }


