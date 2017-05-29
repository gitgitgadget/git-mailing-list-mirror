Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA8120D0A
	for <e@80x24.org>; Mon, 29 May 2017 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdE2Pc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 11:32:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59417 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbdE2Pcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 11:32:55 -0400
Received: (qmail 7765 invoked by uid 109); 29 May 2017 15:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 15:32:52 +0000
Received: (qmail 17534 invoked by uid 111); 29 May 2017 15:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 11:33:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 May 2017 11:32:50 -0400
Date:   Mon, 29 May 2017 11:32:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Bug] setup_git_env called without repository
Message-ID: <20170529153250.zq4qz3s5fmztc6ih@sigill.intra.peff.net>
References: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
 <CACBZZX4kfNhEOtgpFkWtuTZshJX+tX_Dogd6tk6qEuGX07JqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4kfNhEOtgpFkWtuTZshJX+tX_Dogd6tk6qEuGX07JqiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 03:01:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, May 29, 2017 at 1:45 PM, Zero King <l2dy@macports.org> wrote:
> > After upgrading to Git 2.13.0, I'm seeing the following error message
> > when running `git am -h`.
> >
> >    $ git am -h
> >    fatal: BUG: setup_git_env called without repository
> >
> > And with Git built from the next branch:
> >
> >    $ git am -h
> >    BUG: environment.c:172: setup_git_env called without repository
> >    Abort trap: 6
> 
> Jeff, bisects to your b1ef400eec ("setup_git_env: avoid blind
> fall-back to ".git"", 2016-10-20).

Well, yes. But that commit is just making it easier to notice existing
violations of the setup_git_env() rules. The interesting thing is where
the violation comes from. :)

In this case, the "am" builtin uses git_pathdup() and git_config() to
set up some defaults before calling parse_options(), which is where we
handle "-h". Normally that's fine, because it uses the RUN_SETUP flag to
tell the git wrapper to barf if we're not in a repository.

But when the wrapper sees that there is a single command-line argument
and that it's "-h", it skips all of the setup and runs the builtin's
cmd_am() function anyway, under the assumption that the builtin won't do
anything meaningful before noticing the "-h" and dying. This goes back
to Jonathan's 99caeed05 (Let 'git <command> -h' show usage without a git
dir, 2009-11-09).

I have mixed feelings on that commit. It's unquestionably more friendly
to make "git foo -h" work outside of a repository, rather than printing
"Not a git repository". But it does break the assumptions of the cmd_*
functions.

In this case it's fairly harmless. We'd fill in bogus values for the
am_state (a bogus git-dir, but also we'd quietly ignore any repo-level
config when we _are_ in a repo), but those aren't actually used before
we hit the "-h" handling. Conceivably a cmd_* function could show
defaults as part of "-h" output, but I don't know of any cases where
that is true.

I'd be much more worried about cases where the cmd function doesn't
handle "-h" at all, and just proceeds with a broken setup. That said,
it's been this way for almost 8 years. And I see that several commands
already have workarounds for dying early in this case (try grepping for
'"-h"'). So probably we should just follow suit, like:

diff --git a/builtin/am.c b/builtin/am.c
index 0f63dcab1..5ee146bfb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2311,6 +2311,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(usage, options);
+
 	git_config(git_am_config, NULL);
 
 	am_state_init(&state);

I've used the same incantation there as in other commands; possibly
this should be abstracted to a simple:

  check_help_option(argc, argv, usage, options);

that each builtin could call.

What would be _really_ nice is if the usage/options pointers for each
builtin were made available to git.c, and then it could just call
usage_with_options() itself when it sees "-h". I think that would end up
with more boilerplate than it saves, though, as we'd have to add the
pointer to the definition of each builtin struct in git.c. Possibly it
could be helped with some macro trickery and naming conventions, but I
don't know if it's worth it.

The other thing to add is a test to make sure this doesn't pop up again
in another builtin.  We should be able to do:

  for i in $builtins
  do
	test_expect_success "$i -h works" "
		test_expect_code 129 $i -h
	"
  done

We'd need a list of builtins; probably a "git help --list-builtins"
would be helpful there. I ran something similar by hand and "git am" is
the only command that has this problem (for now, anyway). Interestingly,
"git credential" doesn't parse the "-h" at all, and so it just hangs
waiting for input (and would misbehave by ignoring repo config in this
case!). It should be fixed, too.

I'll try to put together patches in the next day or so. Comments welcome
in the meantime.

-Peff
