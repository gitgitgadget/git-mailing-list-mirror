Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB6ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 05:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVEzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVEzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 00:55:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B009E0C5
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 21:55:49 -0700 (PDT)
Received: (qmail 4652 invoked by uid 109); 22 Sep 2022 04:55:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 04:55:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30142 invoked by uid 111); 22 Sep 2022 04:55:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 00:55:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 00:55:47 -0400
From:   Jeff King <peff@peff.net>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: fatal: options '--bare' and '--origin foo' cannot be used
 together
Message-ID: <Yyvq01W/r73xfgqf@coredump.intra.peff.net>
References: <20220921192333.yasrvnisccuk3ivg@Lima-X2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921192333.yasrvnisccuk3ivg@Lima-X2>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 03:23:33PM -0400, John A. Leuenhagen wrote:

> Usually, I only remember after I clone, and wind up doing `git remote
> rename origin foo`. I'd like to get in the habit of instead doing
> `git clone -o foo https://link.to/foo.git`. However, when I tried doing
> this with --bare, I got the error that I've made the subject of this
> email. Why can't I do this?

I don't think there's a fundamental reason they cannot be mixed. In
fact, you can do what you want with:

  git -c clone.defaultRemoteName=foo clone ...

(which, btw, might give a better solution than remembering to use "-o"
each time, since you can put that in your global git config).

So we are just complaining about the actual "-o" option. The conditional
which catches that comes from 8434c2f1af (Build in clone, 2008-04-27),
which is not much help. Before that, the same logic was in the shell
version, which was added in Junio's e6489a1bdf (clone: do not accept
more than one -o option., 2006-01-22), but there's no explanation given.

I do think the remote name is less important in a bare clone, because we
don't create refs/remotes/foo/* there. But you might still care about
the name of the remote for doing "git fetch foo", etc. So I imagine we
could simply loosen the check like:

diff --git a/builtin/clone.c b/builtin/clone.c
index d269d6fec6..ed8d44bb6a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -929,9 +929,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_bare = 1;
 
 	if (option_bare) {
-		if (option_origin)
-			die(_("options '%s' and '%s %s' cannot be used together"),
-			    "--bare", "--origin", option_origin);
 		if (real_git_dir)
 			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
 		option_no_checkout = 1;
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index f6bb02ab94..cf221e92c4 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -42,11 +42,12 @@ test_expect_success 'rejects invalid -o/--origin' '
 
 '
 
-test_expect_success 'disallows --bare with --origin' '
+test_expect_success 'clone --bare -o' '
 
-	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
-	test_debug "cat err" &&
-	test_i18ngrep -e "options .--bare. and .--origin foo. cannot be used together" err
+	git clone -o foo --bare parent clone-bare-o &&
+	(cd parent && pwd) >expect &&
+	git -C clone-bare-o config remote.foo.url >actual &&
+	test_cmp expect actual
 
 '
 

> When I try to do `git remote rename origin foo` in the bare repository
> (cloned without -o foo), I get a different error:
> 
> >fatal: could not unset 'remote.foo.fetch'
> 
> However, `git config remote.foo.fetch` indicates that this value is not
> set.
> 
> Why does this behavior differ from the equivalent commands on a non-bare
> repository?

This second case is IMHO a minor bug in the git-remote code. As
documented in git-clone(1):

  --bare::
     [...]
        Also the branch heads at the remote are copied directly
        to corresponding local branch heads, without mapping
        them to `refs/remotes/origin/`. When this option is
        used, neither remote-tracking branches nor the related
        configuration variables are created.

So it is expected that there is no configured refspec in a bare
repository. But it looks like the remote-renaming code is not prepared
to handle this case. The backtrace for the error is:

  #0  die (err=0x5555558c349a "could not unset '%s'") at usage.c:175
  #1  0x00005555556bce85 in git_config_set_multivar_in_file (config_filename=0x5555559bc700 "config",
      key=0x5555559b5850 "remote.foo.fetch", value=0x0, value_pattern=0x0, flags=1) at config.c:3459
  #2  0x00005555556bcf77 in git_config_set_multivar (key=0x5555559b5850 "remote.foo.fetch", value=0x0,
      value_pattern=0x0, flags=1) at config.c:3485
  #3  0x000055555562bb59 in mv (argc=2, argv=0x7fffffffe550, prefix=0x0) at builtin/remote.c:738
  #4  0x000055555562f7b9 in cmd_remote (argc=3, argv=0x7fffffffe550, prefix=0x0) at builtin/remote.c:1772
  #5  0x0000555555574c53 in run_builtin (p=0x5555559760b0 <commands+2352>, argc=4, argv=0x7fffffffe550) at git.c:466
  #6  0x000055555557506f in handle_builtin (argc=4, argv=0x7fffffffe550) at git.c:721
  #7  0x00005555555752dd in run_argv (argcp=0x7fffffffe3bc, argv=0x7fffffffe3b0) at git.c:788
  #8  0x0000555555575848 in cmd_main (argc=4, argv=0x7fffffffe550) at git.c:921
  #9  0x00005555556694c1 in main (argc=5, argv=0x7fffffffe548) at common-main.c:56

So probably it needs to use the "gently" version of git_config_set_multivar(),
which avoids calling die(), and then check for a return code which
indicates no value was found.

-Peff
