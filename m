Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039AC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 22:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiLBWuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiLBWuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 17:50:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DF5F5F
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 14:50:19 -0800 (PST)
Received: (qmail 29632 invoked by uid 109); 2 Dec 2022 22:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Dec 2022 22:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8887 invoked by uid 111); 2 Dec 2022 22:50:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Dec 2022 17:50:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Dec 2022 17:50:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y4qBKoIpKLkthQXb@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
 <221202.86wn7af2xl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221202.86wn7af2xl.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2022 at 12:31:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > But with a little work, we can have our cake and eat it, too. If we
> > define the type-checking wrappers with a unique name, and then redirect
> > the system names to them with macros, we still get our type checking,
> > but without redeclaring the system function names.
> 
> This looks good to me. The only thing I'd like to note is that while the
> above explanation might read as though this is something novel, it's
> really just doing exactly what we're already doing for
> e.g. git_vsnprintf:
> 	
> 	$ git -P grep git_snprintf
> 	compat/snprintf.c:int git_snprintf(char *str, size_t maxsize, const char *format, ...)
> 	git-compat-util.h:#define snprintf git_snprintf
> 	git-compat-util.h:int git_snprintf(char *str, size_t maxsize,
> 
> Now, that's not a downside here but an upside, plain old boring and
> using existing precedence is a goood thing. Except that....

Yes, though the motivation here is just a tiny bit different. In the
case of snprintf, say, the reason we intercept it is that we know the
platform version sucks and we want to replace it. With the functions
touched by 15b52a44e0, the idea was that we're replacing them because
the platform doesn't provide them at all, and so macros weren't needed.
But that assumption turns out sometimes not to be true.

> > +#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
> 
> ...this part is where we differ from the existing pattern. I don't think
> it matters except for the redundant verbosity, but as we're not
> re-arranging the parameters here, why not simply:
> 
> 	#define setitimer git_setitimer

The two aren't quite the same. Try this:

-- >8 --
gcc -E - <<-\EOF
#define no_parens replaced
#define with_parens(x) replaced(x)
struct foo {
  no_parens x;
  with_parens x;
};
no_parens(foo);
with_parens(foo);
EOF
-- 8< --

If the macro is defined with parentheses, it's replaced only in
function-call contexts. Whereas without it, any token is replaced. I
doubt it matters much in the real world either way. Replacing only in
function context seems to match the intent a bit more, though note that
if you tried to take a function pointer to a macro-replaced name, you'd
get the original.

As you saw, there are many examples of each style, and I don't think
we've ever expressed a preference for one or the other.

Note that for some, like snprintf, we traditionally _had_ to use the
non-function form because we couldn't count on handling varargs
correctly. In the opposite direction, many macros have to use the
function form because they modify the arguments (e.g., foo(x) pointing
to repo_foo(the_repository, x)).

> I went looking a bit more, and we also have existing examples of these
> sort of macros, but could probably have this on top of "next" if we care
> to make these consistent.

I don't have a strong feeling either way. I think you'd need to argue in
the commit message why one form is better than the other. The function
pointer thing is probably the most compelling to me.

-Peff
