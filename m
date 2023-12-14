Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962910F
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 10:11:00 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f01b911c5so9825146d6.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 10:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577459; x=1703182259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPanjACgAm2kkZsuzRBno6jeiNvYqWnJpt0STELsmB8=;
        b=iTZq9cStBnZV+yM0Ky9ip5FfolxxVdzV0fN2xA41a2d8+zAzNzNuBo309BCsJvm9qq
         wzPtVlaqFIWNEyaQSwrgmg+BYZi7jS7pVBmMv3GMTxpvozA6flO/hac+K5RlKEmqQpJx
         oY2XJ7IDj0tiRT9RySUou4OhmUGB74y8r7KmhKNQe3CZYtu7pjwiSTXwggT8943+cbUj
         rcZobhKpt7A+GIrA8/XjatrPgo+42INDVwzjWHcyY8GGBq9yfwPIRGcU+5Yri8gHX4Pd
         HZkfkLAJc212VnFPRwJZSN4k+Ppfb9wk0BQoVc5C8OCzkqrXfURSe45KsE44ZMatgJ7M
         oLiQ==
X-Gm-Message-State: AOJu0YyNJmNdscry8jr5G0zAiN6BrBAv9f/qebGoR6DMRSm1LoKURQcz
	bdHnfXJVEWB72oYoFu2YaAbqryMJWHq8w5KKAwNpWuQPBi8=
X-Google-Smtp-Source: AGHT+IFnmyTkfbeKP6OoR60aiSlk1rHny2G0Dx95fZ68H8bTSpZL3Cpq3QbG+a2jTg+RWaI8d6SZgNMU+SgVVUl08pM=
X-Received: by 2002:a05:6214:f27:b0:67f:efc:476d with SMTP id
 iw7-20020a0562140f2700b0067f0efc476dmr1230862qvb.44.1702577459189; Thu, 14
 Dec 2023 10:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki> <xmqqr0jqnnmn.fsf@gitster.g>
 <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
 <ZXq5GL723v4E3_IH@tanuki> <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
 <xmqqbkaspxn6.fsf@gitster.g>
In-Reply-To: <xmqqbkaspxn6.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Dec 2023 13:10:48 -0500
Message-ID: <CAPig+cQvcSeSKVE=0kDyNiSztNAgVwhfAzoL5K7uYHEKe=0f_A@mail.gmail.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I sent a reply[1] in the other thread explaining why I'm still leaning
> > toward `sed` to smooth over these minor differences rather than
> > churning the "expect" files, especially since the minor differences
> > are not significant to what is actually being tested.
>
> If it is just one time bulk conversion under t/chainlint/ to match
> what the chainlint.pl script produces, with the possibility of
> similar bulk updates in the future when the script gets updated, I
> tend to agree with Patrick that getting rid of the fuzzy comparison
> will be the best way forward.

Okay, that's fine. If we take this approach, though, then it would
make sense to eliminate _all_ gratuitous postprocessing of the
"expect" files[1] so that we really are comparing the direct output of
chainlint.pl with the "expect" files, rather than merely munging the
inline whitespace of the "expect" files slightly as Patrick's proposed
patch does[2].

(The only postprocessing of "expect" files which needs to stay is the
bit which removes the "# LINT:" comments which litter the "expect"
files explaining to human readers why the linter should insert a
"???FOO???" annotation at that particular point.)

> Especially if the fuzzy comparison is done only to hide differences
> between what the old chainlint.sed used to produce and what the
> current version produces, that is.  If for some reason the script
> started to create subtly different output for other reasons (e.g.,
> it may produce different whitespaces on a particular platform, or
> with a specific version of perl interpreter), we'd better be aware
> of it, instead of blindly ignoring the differences without
> inspecting them and verifying that they are benign.
>
> By going through the single conversion pain, it will force us to
> think twice before breaking its output stability while updating
> chainlint.pl, which would also be a good thing.

The chainlint self-tests were never meant to be about its general
output stability. They were intended to ensure that the "???FOO???"
annotations are: (1) indeed inserted for the set of linting problems
the tool detects, and (2) inserted at the correct spot in the emitted
output relative to the shell tokens to which the annotation applies.
Minor differences in the tool's output (whether over time or between
platforms) should be immaterial in respect to those correctness goals.

[1]: https://lore.kernel.org/git/CAPig+cTZmiXdPZEVO-F2UzV9YaP6c7r2MfPTC3QWk=
sJa+rM7VA@mail.gmail.com/
[2]: https://lore.kernel.org/git/aec86a15c69aa276eee4875fad208ee2fc57635a.1=
702542564.git.ps@pks.im/
