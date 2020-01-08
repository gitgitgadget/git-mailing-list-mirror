Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB6C33C9E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 11:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27998206ED
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 11:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAHL5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:57:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:60182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726098AbgAHL5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 06:57:24 -0500
Received: (qmail 21670 invoked by uid 109); 8 Jan 2020 11:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 11:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9402 invoked by uid 111); 8 Jan 2020 12:03:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 07:03:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 06:57:23 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bogus config file vs. 'git config --edit'
Message-ID: <20200108115723.GA3381405@coredump.intra.peff.net>
References: <20191227110431.GC32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191227110431.GC32750@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 12:04:31PM +0100, SZEDER Gábor wrote:

> I think bith 'git config --edit' and 'git help ...' should just work,
> no matter what nonsense might be in the config file, even if they then
> launch a different editor or pager than what are set in the
> configuration.

Agreed. This has come up before (e.g., [1]) but I think doing it right
would need several changes:

  - the config code is too eager to die on a syntax error; it should
    return an error up the stack

  - the stack looks like this when we first die():

      #0  die (err=0x55555582436f "%s") at usage.c:165
      #1  0x0000555555678ab6 in git_parse_source (fn=0x5555557719c4 <check_repo_format>, data=0x7fffffffe1e0, opts=0x0)
          at config.c:849
      #2  0x000055555567a9c5 in do_config_from (top=0x7fffffffdfc0, fn=0x5555557719c4 <check_repo_format>, 
          data=0x7fffffffe1e0, opts=0x0) at config.c:1546
      #3  0x000055555567aab4 in do_config_from_file (fn=0x5555557719c4 <check_repo_format>, origin_type=CONFIG_ORIGIN_FILE, 
          name=0x555555913220 ".git/config", path=0x555555913220 ".git/config", f=0x5555559117c0, data=0x7fffffffe1e0, 
          opts=0x0) at config.c:1574
      #4  0x000055555567ab80 in git_config_from_file_with_options (fn=0x5555557719c4 <check_repo_format>, 
          filename=0x555555913220 ".git/config", data=0x7fffffffe1e0, opts=0x0) at config.c:1594
      #5  0x000055555567abc5 in git_config_from_file (fn=0x5555557719c4 <check_repo_format>, 
          filename=0x555555913220 ".git/config", data=0x7fffffffe1e0) at config.c:1603
      #6  0x0000555555771e0b in read_repository_format (format=0x7fffffffe1e0, path=0x555555913220 ".git/config")
          at setup.c:523
      #7  0x0000555555771bb5 in check_repository_format_gently (gitdir=0x555555911750 ".git", candidate=0x7fffffffe1e0, 
          nongit_ok=0x7fffffffe2cc) at setup.c:460
      #8  0x000055555577272f in setup_discovered_git_dir (gitdir=0x555555911750 ".git", cwd=0x5555558c90b0 <cwd>, 
          offset=19, repo_fmt=0x7fffffffe1e0, nongit_ok=0x7fffffffe2cc) at setup.c:770
      #9  0x0000555555773490 in setup_git_directory_gently (nongit_ok=0x7fffffffe2cc) at setup.c:1100
      #10 0x00005555555706c8 in run_builtin (p=0x5555558bb980 <commands+576>, argc=2, argv=0x7fffffffe538) at git.c:416
      #11 0x0000555555570baf in handle_builtin (argc=2, argv=0x7fffffffe538) at git.c:674
      #12 0x00005555555711b2 in cmd_main (argc=2, argv=0x7fffffffe538) at git.c:842
      #13 0x000055555563412e in main (argc=2, argv=0x7fffffffe538) at common-main.c:52

     So we'd need to teach read_repository_format() to handle the error
     and just assume we're not in a Git repo. But then how would "git
     config --edit" realize it needs to edit the repo config file?

  - assuming we get around the above problem, I suspect we'd run into
    other things that want to read the config (e.g., loading default
    config like the editor). We could be more lenient everywhere, but I
    suspect that most of the other commands _do_ want to die on bogus
    config (rather than do something unexpected). I wouldn't want to
    change every git_config() call to handle errors, but maybe we could
    have a lenient form and use it in just enough call-sites. Or maybe
    we could detect early in git-config that we are in "--edit" mode,
    and set a global for "be lenient when reading the config". I dunno.

So I think it's definitely do-able and would be much better, but it's
probably not entirely trivial.

-Peff

[1] https://lore.kernel.org/git/A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com/
