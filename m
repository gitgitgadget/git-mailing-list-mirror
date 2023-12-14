Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84010A
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:32:06 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4259cd18f85so47601251cf.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542726; x=1703147526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkF+tIDT0zNOGQMJ+lWxDtP91hCLh6+s23hJW1b6Uwg=;
        b=sRMcjbVkc34on/28WOjsUx69Pqj4R7HHNffFlyYODMY1Tt5ta9vIlbWfYp3QwupU4f
         tJmnakVewdnZqKu3vcMleAzB/Jmmd6SkBy7Jg6gNC67Bt2FylfsA/A/Zr6cS+Or0Qv48
         sT9qzauAbMHsZPahjPXDMFX4+D9SGhfTFRgWoRjc0V7T3XepKbeVrBnUutkrpaN6/HS8
         cRK+hQMJOmCrh5w/wBqPRQpL0ZVIsXhhc4hh1UemERzwACjnas8l1I5Y7ZIoj4pEBYBT
         nlqSDmmZjsNecRtV1tT/xWo2awDze0CPaEIVhsze10MvPRvh+RyH9sDSJu4sYLGLIKAc
         4lCw==
X-Gm-Message-State: AOJu0Yz8LUAt+bTR+243FP8yVPDXmASnxOOWpHNEGnY7zQt46cz6s08+
	dWTszAgrnBThFkABr1x8zh9woYrNvZt59fx+wjM=
X-Google-Smtp-Source: AGHT+IHiUqh2b5R60kF6W1Jga5E+rekbHewrozGrt/pDnGTVAm2OEajiJ/hv5fbPQSwJy4FPk3dPOtplGQUI6SI6zaE=
X-Received: by 2002:a05:6214:1944:b0:67f:de1:b1a7 with SMTP id
 q4-20020a056214194400b0067f0de1b1a7mr344910qvk.78.1702542725707; Thu, 14 Dec
 2023 00:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214032248.1615-1-ericsunshine@charter.net> <ZXq3YdK2RSKF3npE@tanuki>
In-Reply-To: <ZXq3YdK2RSKF3npE@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Dec 2023 03:31:54 -0500
Message-ID: <CAPig+cSkuRfkR2D3JqYcbaJqj485nfD9Nq6pM=vXWB5DJenWpA@mail.gmail.com>
Subject: Re: [PATCH] tests: drop dependency on `git diff` in check-chainlint
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Wed, Dec 13, 2023 at 10:22:48PM -0500, Eric Sunshine wrote:
> > This is an alternative solution to the issue Patrick's patch[1]
> > addresses. Hopefully, this approach should avoid the sort of push-back
> > Patrick's patch received[2].
> >
> > By the way, I'm somewhat surprised that this issue crops up at all
> > considering that --no-index is being used with git-diff. As such, I
> > would have thought that the local repository's format would not have
> > been interrogated at all. If that's a bug in `git diff --no-index`, the=
n
> > fixing that could be considered yet another alternative solution to the
> > issue raised here.
>
> This strongly reminds me of the thread at [1], where a similar issue was
> discussed for git-grep(1). Quoting Junio:
>
> > I actually do not think these "we are allowing Git tools to be used
> > on random garbage" is a good idea to begin with X-<.  If we invented
> > something nice for our variant in "git grep" and wish we can use it
> > outside the repository, contributing the feature to implementations
> > of "grep" would have been the right way to move forward, instead of
> > contaminating the codebase with things that are not related to Git.
>
> So this might not be the best way to go.

I recall Junio mentioning that, and I'm fine with the conclusion that
"fixing" --no-index is counter to the project's goals.

> > -                     sed -e '/^[     ]*$$/d' chainlint/$$i.expect; \
> > +                     sed -e 's/[     ][      ]*/ /g;/^ *$$/d;s/^ //;s/=
 $$//;s/\([<>|();&]\) /\1/g;s/ \([<>|();&]\)/\1/g' chainlint/$$i.expect; \
> >
> > The sed expressions for normalizing whitespace prior to `diff` may look
> > a bit hairy, but they are simple enough in concept:
> >
> > * collapse runs of whitespace to a single SP
> > * drop blank lines (this step is not new)
> > * fold out possible SP at beginning and end of each line
> > * fold out SP surrounding common punctuation characters used in shell
> >   scripts, such as `>`, `|`, `;`, etc.
>
> These sed expressions do look hairy indeed. I have to wonder: all that
> we're doing here is to munge the expected files we already have in our
> tree. Can't we fix those to look exactly like the actual results instead
> and then avoid any kind of post processing altogether? If I understand
> correctly the only reason we do this post processing is because the
> original implementation of the chainlinter produced slightly different
> whitespace.

Yes and no. It's not just whitespace.

I did strongly consider submitting patches to fix all the whitespace
differences in the "expect" files when chainlint.pl replaced
chainlint.sed, but I particularly didn't want to plague the mailing
list with such noise. It's really just unnecessary churn since it's so
easy to work around it with minor sed magic.

And time tells me that that was probably the correct decision since
the output of chainlint.pl has changed multiple times. Even the output
of chainlint.sed wasn't necessarily stable[1]. Then, of course
chainlint.pl replaced[2] chainlint.sed. The original implementation or
chainlint.pl just dumped out the parsed token stream, but [3] improved
it to preserve the original formatting of the test snippet, and [4]
annotated the output with line numbers of the original test snippet.
Had those changes been accompanied by extra patches to "fix" the
"expect" files to suit, it would have been just that much more noise
both in terms of patches to review and in terms of churn in the actual
history.

And, who knows, the output of chainlint.pl might change/improve again
some day. So, I still favor using sed to smooth over these minor
differences rather than "fixing" the "expect" file repeatedly to
adjust them for changes which are not significant to what is actually
being tested.

[1]: d73f5cfa89 (chainlint.sed: stop splitting "(..." into separate
lines "(" and "...", 2021-12-13)
[2]: d00113ec34 (t/Makefile: apply chainlint.pl to existing
self-tests, 2022-09-01)
[3]: 73c768dae9 (chainlint: annotate original test definition rather
than token stream, 2022-11-08)
[4]: 48d69d8f2f (chainlint: prefix annotated test definition with line
numbers, 2022-11-11)
