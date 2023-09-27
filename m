Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC80E7F14F
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 23:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0XaI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Sep 2023 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI0XaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 19:30:07 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0422F5
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 16:30:05 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-65b08bbd8b1so48202136d6.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 16:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857405; x=1696462205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgjk9qV5KBAkhwnVvQd6Ak9M6oaI8ptuHK2cPC4Eqak=;
        b=qN5wBxtzRcTgjcaG36X1d06rGsx2d127wGXD/00giJ3fDfN+FedNA9eEdc4Dt2nJqI
         eV70T8wTFlkjK+2T56/I3dD2LdL4ZH6MQbh6Mn66MlVDhoaD6TEs4fF1t6H9sbm1lzAD
         mSmo+KRJywd+Ck11fuzGLIAT1fAtb2yOqAEWTrvW/IX+Ve5sFXJKy8y0W/ZlYrIPG90i
         mfso4TNXdTK85LWufZg+rZs8Du0jGg5ssNsCg0UruTqf1CNJEtU0J1VNzED+/33ZHfzN
         SNUNFPwGw0tQbabTtIVr7aUuGnR7DhBu+VgOvL5RnUKIsJuvXQAitEyiVF7vKO5eSymC
         +4EA==
X-Gm-Message-State: AOJu0YzFpUWJe7RqDZ+W/McH87sOSB/CNVO7Ig0oeRcrK9myfSwLNv2Y
        ZIrl3x0QnrllMYdU2MLn+vGo53hNkYCx7PFd080=
X-Google-Smtp-Source: AGHT+IH28efrwj5JTjx987YOOQyLLGqrn255PDWVUuM0pYezf+J9rdJRJl1E+rbDiEPzocU4p67nNMOeUDS0sqdOkVU=
X-Received: by 2002:a0c:f3cb:0:b0:65b:1468:8210 with SMTP id
 f11-20020a0cf3cb000000b0065b14688210mr3556141qvm.23.1695857404676; Wed, 27
 Sep 2023 16:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> <20230927195537.1682-3-ebiederm@gmail.com>
In-Reply-To: <20230927195537.1682-3-ebiederm@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Sep 2023 19:29:53 -0400
Message-ID: <CAPig+cRHBxPZYQ5XYA5Un7LeS21NgqxZGg=Q8D+aQckrw9Ymtg@mail.gmail.com>
Subject: Re: [PATCH 03/30] object-names: Support input of oids in any
 supported hash
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2023 at 3:56 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> Support short oids encoded in any algorithm, while ensuring enough of
> the oid is specified to disambiguate between all of the oids in the
> repository encoded in any algorithm.
>
> By default have the code continue to only accept oids specified in the
> storage hash algorithm of the repository, but when something is
> ambiguous display all of the possible oids from any oid encoding.
>
> A new flag is added GET_OID_HASH_ANY that when supplied causes the
> code to accept oids specified in any hash algorithm, and to return the
> oids that were resolved.
>
> This implements the functionality that allows both SHA-1 and SHA-256
> object names, from the "Object names on the command line" section of
> the hash function transition document.
>
> Care is taken in get_short_oid so that when the result is ambiguous
> the output remains the same of GIT_OID_HASH_ANY was not supplied.

s/of/as if/

> If GET_OID_HASH_ANY was supplied objects of any hash algorithm
> that match the prefix are displayed.
>
> This required updating repo_for_each_abbrev to give it a parameter
> so that it knows to look at all hash algorithms.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> diff --git a/object-name.c b/object-name.c
> @@ -49,6 +50,7 @@ struct disambiguate_state {
>  static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
>  {
> +       /* The hash algorithm of the current has already been filtered */

Is there a word missing after "current"?

> @@ -503,8 +516,13 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
> -       if (a_type == b_type)
> -               return oidcmp(a, b);
> +       if (a_type == b_type) {
> +               /* Is the hash algorithm the same? */
> +               if (a->algo == b->algo)
> +                       return oidcmp(a, b);
> +               else
> +                       return a->algo > b->algo ? 1 : -1;
> +       }

Nit: unnecessary comment ("Is the hash algorithm...") is merely
repeating what the code itself already says clearly enough

> @@ -553,6 +575,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
>         else
>                 ds.fn = default_disambiguate_hint;
>
> +
>         find_short_object_filename(&ds);

Nit: unnecessary new blank line
