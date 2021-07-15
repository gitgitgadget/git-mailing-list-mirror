Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6675C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C660A613CC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGOVpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:45:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:51356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhGOVpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:45:15 -0400
Received: (qmail 12908 invoked by uid 109); 15 Jul 2021 21:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jul 2021 21:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5103 invoked by uid 111); 15 Jul 2021 21:42:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jul 2021 17:42:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jul 2021 17:42:20 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Message-ID: <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 08:57:37PM +0200, Andrzej Hunt wrote:

> > @@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >   	if (!strcmp(var, "core.attributesfile"))
> >   		return git_config_pathname(&git_attributes_file, var, value);
> > -	if (!strcmp(var, "core.hookspath"))
> > +	if (!strcmp(var, "core.hookspath")) {
> > +		UNLEAK(git_hooks_path);
> >   		return git_config_pathname(&git_hooks_path, var, value);
> > +	}
> 
> Why is the UNLEAK necessary here? We generally want to limit use of UNLEAK
> to cmd_* functions or direct helpers. git_default_core_config() seems
> generic enough that it could be called from anywhere, and using UNLEAK here
> means we're potentially masking a real leak?
> 
> IIUC the leak here happens because:
> - git_hooks_path is a global variable - hence it's unlikely we'd ever
>   bother cleaning it up.
> - git_default_core_config() gets called a first time with
>   core.hookspath, and we end up allocating new memory into
>   git_hooks_path.
> - git_default_core_config() gets called again with core.hookspath,
>   and we overwrite git_hooks_path with a new string which leaks
>   the string that git_hooks_path used to point to.
> 
> So I think the real fix is to free(git_hooks_path) instead of an UNLEAK?
> (Looking at the surrounding code, it looks like the same pattern of leak
> might be repeated for other similar globals - is it worth auditing those
> while we're here?)

This is a common leak pattern in Git. We do something like:

  static const char *foo = "default";
  ...
  int config_cb(const char *var, const char *value, void *)
  {
          if (!strcmp(var, "core.foo"))
	          foo = xstrdup(value);
  }

So we leak if the variable appears twice. But we can't just call
"free(foo)" here. In the first call, it's pointing to a string literal!

In the case of git_hooks_path, it defaults to NULL, so this works out
OK. But it's setting up a trap for somebody later on, who assigns it a
default value (and the compiler won't help; it's a "const char *", so
the assignment is fine, and the free() would already be casting away the
constness).

I see a few possible solutions:

  - instead of strdup'ing long-lived config values, strintern() them.
    This is really leaking them, but in a way that we hold on to the old
    values. This is actually more or less what UNLEAK() is doing under
    the hood (saving a reference to the old buffer, even the variable is
    overwritten).

  - find a way to tell when a string comes from the heap versus a
    literal. I don't think you can do this portably without keeping your
    own separate flag. We could abstract away some of the pain with a
    struct like:

       struct def_string {
               /* might point to heap memory; const because you must
                * check flag before modifying */
               const char *value;
               int from_heap;
       }

       /* regular static initialization is OK if you don't want a default */
       #define DEF_STRING_INIT(str) { .value = str }

       static void def_string_set(struct def_string *ds, const char *value)
       {
               if (ds->from_heap)
                       free(ds->value);
               ds->value = xstrdup(value);
               ds->from_heap = 1;
       }

    The annoying thing is all of the users need to refer to
    git_hook_path.value instead of just git_hook_path. If you don't mind
    a little macro hackery, we could get around that by declaring pairs
    of variables. Like:

      #define DEF_STRING_DECLARE(name, value) \
      const char *name = value; \
      int name##_from_heap

      #define DEF_STRING_SET(name, value) do { \
              if (name##_from_heap) \
                      free(name); \
              name = xstrdup(value); \
              name##_from_heap = 1; \
      } while(0)

I can't say I _love_ any of that, but I think it would work (and
probably we'd adapt our helpers like git_config_pathname() to take a
def_string. Or I guess just have a def_string_free() which can be called
before writing into them).

But maybe there's a better solution I'm missing.

-Peff
