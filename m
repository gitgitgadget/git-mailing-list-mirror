Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C8C433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BC02053B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGZWSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:18:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35403 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 18:18:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 184so12897448wmb.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 15:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlnVUEsLoaD5lJpvfYJbJAMAGW/c+GaXIz60aA1MBZM=;
        b=BymTrAJ9TkGUHNMDipXcmA/LqGahpJWGLUP5hmGIi458mIKinK7glY+a1DVtncFNxH
         zrmPODCrpIrU2H95rNENpaR/Qlc90nmibhulbFMbBdfiCMLZHLgL9k45NuluCTgJKElK
         8GdCF+LvOITw1Xo1LfxnttxUf3V9deDmeVMCmM7npOBm28FqUg/gPWcNORg1w/nOphXm
         +s1EDegVOExLK1LH0bTOwo1VleU1dvPtjUZyn4CRjCNvZv9URCpERwFLW94Iw4xNYPMg
         9NRNj05OLVjWJZ6osWMHg3t6ABU6zY5OqNv41spxR800YFTxSx3O/7oIr5yt5jKsTg80
         UdRg==
X-Gm-Message-State: AOAM532u7Fh+ORUnf/KFvBKg2RK1HQIB5osu3AOa9V7oYejuQeRO9tsQ
        Tsuc1WiHfdkDjXCKPZCC5rbU+9+nZeFBUuFsdEnE9OuIMas=
X-Google-Smtp-Source: ABdhPJxzjN2+sC6zSCY5WcMF6NP46UI00vPqgFERwGHgKgbWaM+63LYroPz68zDOAqdguSknBPqNMxYXJof2ik8OLdE=
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr1379085wmh.177.1595801914803;
 Sun, 26 Jul 2020 15:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-32-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-32-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 18:18:23 -0400
Message-ID: <CAPig+cR+e9XGNCgtDMHUsaAgbKDi=-bztwtd64fVZj7S05ppKQ@mail.gmail.com>
Subject: Re: [PATCH v4 31/39] bundle: add new version for use with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> Since we cannot extend the v2 format in a backward-compatible way, let's
> add a v3 format, which is identical, except for the addition of
> capabilities, which are prefixed by an at sign.  We add "object-format"
> as the only capability and reject unknown capabilities, since we do not
> have a network connection and therefore cannot negotiate with the other
> side.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/bundle.c b/bundle.c
> @@ -23,15 +32,30 @@ static void add_to_ref_list(const struct object_id *oid, const char *name,
> +static int parse_capability(struct bundle_header *header, const char *capability)
>  {
> +       const char *arg;
> +       if (skip_prefix(capability, "object-format=", &arg)) {
> +               int algo = hash_algo_by_name(arg);
> +               if (algo == GIT_HASH_UNKNOWN)
> +                       return error(_("unable to detect hash algorithm"));

This error message would be more helpful if it provided more context,
such as the name it tried looking up. For instance:

    return error(_("unrecognized bundle header hash algorithm: "
        "@object-format=%s"), arg);

or something.

> @@ -57,21 +83,21 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
> +               if (header->version == 3 && *buf.buf == '@') {
> +                       buf.buf[--buf.len] = '\0';

The reader has to think through this unconditional NUL-termination
more carefully than would be the case if...

> +                       if (parse_capability(header, buf.buf + 1)) {
> +                               status = -1;
> +                               break;
> +                       }
> +                       continue;
> +               }
> +
>                 if (*buf.buf == '-') {
>                         is_prereq = 1;
>                         strbuf_remove(&buf, 0, 1);
>                 }
>                 strbuf_rtrim(&buf);

... you just moved this strbuf_rtrim() call above the capability check
conditional.

> @@ -449,13 +475,14 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
> +       int default_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
> @@ -464,8 +491,22 @@ int create_bundle(struct repository *r, const char *path,
> +       if (version == -1)
> +               version = default_version;
> +
> +       if (version < 2 || version > 3) {
> +               die(_("unsupported bundle version %d"), version);
> +       } else if (version < default_version) {
> +               die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);

This conditional will become fragile when bundle version v4 is
introduced and the git-bundle invocation somehow triggers v4 to be
assigned to 'default_version', in which case:

    git bundle --version=3 ...

will complain:

    cannot write bundle version 3 with algorithm sha256

which is clearly wrong and misleading.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -281,15 +281,20 @@ test_expect_success 'create bundle 1' '
>  test_expect_success 'header of bundle looks right' '
>         head -n 4 "$D"/bundle1 &&
> -       head -n 1 "$D"/bundle1 | grep "^#" &&
> -       head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
> -       head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
> -       head -n 4 "$D"/bundle1 | grep "^$"

Do you still need the "head -n 4 ... &&" check at the very top of this
list? Is that providing something that we don't get from the new code
which uses test_cmp with 'expect' and 'actual' files?

> +       cat >expect <<-EOF &&
> +       # v3 git bundle
> +       @object-format=$(test_oid algo)
> +       -OID message
> +       OID message
> +
> +       EOF
> +       sed -e "s/$OID_REGEX .*/OID message/g" -e "5q" "$D"/bundle1 >actual &&

In my earlier review when I suggested using an "expect" file and
converting the object ID to some literal string such as "OID", the
example I gave did indeed also use literal "message", though my use of
"message" was meant as a placeholder that you would fill in with the
real values, like this:

    -OID updated by origin
    OID refs/heads/master

I probably should have been clearer about "message" being a
placeholder (since I was too lazy to look up the actual values). I
suppose the generic "message" you use here is no worse than the
original code with its 'grep' invocations which didn't care about the
message either. It makes me a bit uncomfortable for the test to
unnecessarily be loose like this when it doesn't have to be, but it's
not necessarily worth a re-roll.
