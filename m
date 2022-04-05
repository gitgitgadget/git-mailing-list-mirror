Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC494C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384462AbiDEVrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452334AbiDEPyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:47 -0400
X-Greylist: delayed 2220 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 07:53:01 PDT
Received: from lucy.dinwoodie.org (b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:de15:20ad:bda2:90f2:b98:8b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A247131979
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 07:53:01 -0700 (PDT)
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1nbjyK-000GBG-A5; Tue, 05 Apr 2022 15:15:52 +0100
Date:   Tue, 5 Apr 2022 15:15:52 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/8] Makefile: move ".SUFFIXES" rule to shared.mak
Message-ID: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
 <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
 <patch-v5-5.8-18e0a6985f1-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-5.8-18e0a6985f1-20220303T160155Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 05:04:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This was added in 30248886ce8 (Makefile: disable default implicit
> rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
> apply to all our Makefiles.
> 
> This doesn't benefit the main Makefile at all, since it already had
> the rule, but since we're including shared.mak in other Makefiles
> starts to benefit them. E.g. running the 'man" target is now faster:
> 
>     $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation man' 'make -C Documentation -j1 man'
>     Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
>       Time (mean ± σ):     121.7 ms ±   8.8 ms    [User: 105.8 ms, System: 18.6 ms]
>       Range (min … max):   112.8 ms … 148.4 ms    26 runs
> 
>     Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
>       Time (mean ± σ):      97.5 ms ±   8.0 ms    [User: 80.1 ms, System: 20.1 ms]
>       Range (min … max):    89.8 ms … 111.8 ms    32 runs
> 
>     Summary
>       'make -C Documentation -j1 man' in 'HEAD~0' ran
>         1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'
> 
> The reason for that can be seen when comparing that run with
> "--debug=a". Without this change making a target like "git-status.1"
> will cause "make" to consider not only "git-status.txt", but
> "git-status.txt.o", as well as numerous other implicit suffixes such
> as ".c", ".cc", ".cpp" etc. See [1] for a more detailed before/after
> example.
> 
> So this is causing us to omit a bunch of work we didn't need to
> do. For making "git-status.1" the "--debug=a" output is reduced from
> ~140k lines to ~6k.
> 
> 1. https://lore.kernel.org/git/220222.86bkyz875k.gmgdl@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile   | 2 --
>  shared.mak | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1ac924bd844..ce362720947 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2580,8 +2580,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
>  ASM_OBJ := $(ASM_SRC:S=o)
>  C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
>  
> -.SUFFIXES:
> -
>  $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
>  	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>  $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
> diff --git a/shared.mak b/shared.mak
> index 29f0e69ecb9..1dda948df09 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -9,6 +9,11 @@
>  %:: s.%
>  %:: SCCS/s.%
>  
> +## Likewise delete default $(SUFFIXES). See:
> +##
> +##     info make --index-search=.SUFFIXES
> +.SUFFIXES:
> +
>  ### Flags affecting all rules
>  
>  # A GNU make extension since gmake 3.72 (released in late 1994) to

I confess I really don't understand why, but as part of testing
v2.36.0-rc0 on Cygwin, I've started getting errors building the info
pages, and bisect points to this commit as the culprit.

Specifically, I've been running

    git clean -dffx && make configure && ./configure && make -j4 info

Without this commit, that gets me a successful build; there's a bunch of
noisy warnings that have been hanging around for a long time, and I think
are fundamentally due to the slightly mismatched documentation libraries
that Cygwin has.  With this commit, I get the same noisy warnings, but I
also get the error "could not open .texi: No such file or directory".

I have to confess, I don't really understand this aspect of GNU Make, so
I'm not sure if this is a problem with Cygwin having a bad toolset or
there being something about my environment that means this doesn't work,
but regardless, it's currently causing the Cygwin Git builds to fail.
