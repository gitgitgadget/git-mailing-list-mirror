Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0AAC05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 11:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjAZL0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAZL0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 06:26:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C862278
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 03:25:58 -0800 (PST)
Received: (qmail 20797 invoked by uid 109); 26 Jan 2023 11:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 11:25:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22630 invoked by uid 111); 26 Jan 2023 11:25:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 06:25:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 06:25:57 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 12/12] credential: add WWW-Authenticate header to cred
 requests
Message-ID: <Y9JjRfhl1H4Julv3@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <09164f77d56e8efd1450091cf1b12af2bc6cf2f5.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09164f77d56e8efd1450091cf1b12af2bc6cf2f5.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:50PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Add the value of the WWW-Authenticate response header to credential
> requests. Credential helpers that understand and support HTTP
> authentication and authorization can use this standard header (RFC 2616
> Section 14.47 [1]) to generate valid credentials.
> 
> WWW-Authenticate headers can contain information pertaining to the
> authority, authentication mechanism, or extra parameters/scopes that are
> required.

I'm definitely on board with sending these to the helpers. It does feel
a bit weird that we don't parse them at all, and just foist that on the
helpers.

If I understand the RFC correctly, you can have multiple challenges per
header, but also multiple headers. So:

  WWW-Authenticate: Basic realm="foo", OtherAuth realm="bar"
  WWW-Authenticate: YetAnotherScheme some-token

could be normalized as:

  www-auth-challenge=Basic realm="foo"
  www-auth-challenge=OtherAuth realm="bar"
  www-auth-challenge=YetAnotherScheme some-token

which saves each helper from having to do the same work. Likewise, we
can do a _little_ more parsing to get:

  www-auth-basic=realm="foo"
  www-auth-otherauth=realm="bar"
  www-auth-yetanotherscheme=some-token

I don't think we can go beyond there, though, without understanding the
syntax of individual schemes. Which is a shame, as one of the goals of
the credential format was to let the helpers do as little as possible
(so they can't get it wrong!). But helpers are stuck doing things like
handling backslashed double-quotes, soaking up extra whitespace, etc.

I'm not really sure what we expect to see in the real world. I guess for
your purposes, you are working on an already-big helper that is happy to
just get the raw values and process them according to the rfc. I'm just
wondering if there are use cases where somebody might want to do
something with this header, but in a quick shell script kind of way. For
example, my credential config is still:

  [credential "https://github.com"]
  username = peff
  helper = "!f() { test $1 = get && echo password=$(pass ...); }; f"

That's an extreme example, but I'm wondering if there's _anything_
useful somebody would want to do in a similar quick-and-dirty kind of
way. For example, deciding which cred to use based on basic realm, like:

  realm=foo
  while read line; do
    case "$line" in
    www-auth-basic=)
        value=${line#*=}
	# oops, we're just assuming it's realm= here, and we're
	# not handling quotes at all. I think it could technically be
	# realm=foo or realm="foo"
	realm=${value#realm=}
	;;
    esac
  done
  echo password=$(pass "pats-by-realm/$realm")

which could be made a lot easier if we did more parsing (e.g.,
www-auth-basic-realm or something). I dunno. Maybe that is just opening
up a can of worms, as we're stuffing structured data into a linearized
key-value list. The nice thing about your proposal is that Git does not
even have to know anything about these schemes; it's all the problem of
the helper. My biggest fear is just that we'll want to shift that later,
and we'll be stuck with this microformat forever.

> The current I/O format for credential helpers only allows for unique
> names for properties/attributes, so in order to transmit multiple header
> values (with a specific order) we introduce a new convention whereby a
> C-style array syntax is used in the property name to denote multiple
> ordered values for the same property.

I don't know if this is strictly necessary. The semantics of duplicate
keys are not really defined anywhere, and just because the
implementations of current readers happen to replace duplicates for the
current set of keys doesn't mean everything has to. So you could just
define "wwwauth" to behave differently. But I don't mind having a
syntactic marker to indicate this new type.

If you're at all convinced by what I said above, then we also might be
able to get away with having unique keys anyway.

>  Documentation/git-credential.txt |  19 ++-
>  credential.c                     |  11 ++
>  t/lib-credential-helper.sh       |  27 ++++
>  t/t5556-http-auth.sh             | 242 +++++++++++++++++++++++++++++++
>  4 files changed, 298 insertions(+), 1 deletion(-)
>  create mode 100644 t/lib-credential-helper.sh

The patch itself looks pretty reasonable to me.

One small thing I noticed:

> +	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&

As you undoubtedly figured out, the helper path is fed to the shell, so
spaces in the trash directory are a problem. You've solved it here by
adding a layer of double quotes, which handles spaces. But you'd run
into problems if the absolute path that somebody is using for the test
suite has a backslash or a double quote in it.

I don't know how careful we want to be here (or how careful we already
are[1]), but one simple-ish solution is:

  export CREDENTIAL_HELPER
  git -c "credential.helper=!\"\$CREDENTIAL_HELPER\"" ...

I.e., letting the inner shell expand the variable itself. Another option
is to put the helper into $TRASH_DIRECTORY/bin and add that to the
$PATH.

I also wondered if it was worth having setup_credential_helper() just
stick it in $TRASH_DIRECTORY/.gitconfig so that individual tests don't
have to keep doing that ugly "-c" invocation. Or if you really want to
have each test enable it, perhaps have set_credential_reply() turn it on
via test_config (which will auto-remove it at the end of the test).

-Peff

[1] Curious, I tried cloning git into this directory:

      mkdir '/tmp/foo/"horrible \"path\"'

    and we do indeed already fail. The first breakage I saw was recent,
    but going further back, it looks like bin-wrappers don't correctly
    handle this case anyway. So maybe that's evidence that nobody would
    do something so ridiculous in practice.
