Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365BCA
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 13:07:02 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67ac8e5566cso8714116d6.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 13:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724021; x=1702328821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TMahYIt73ADUKDNveou2rLHKnF714+GprOq7iuAyE4=;
        b=mQwHRKYdcmWwYeyc6VCZZ57Oy6xPGlz9K159W5/6kb/ZFYXVtib7q3wErJITbcDsLv
         iigh07LT/DNXCx1XnHkHYim6SZLQrlxNVxY4LJo0ZlMwpw1i7Eh0t3GQpFoujmKhm2du
         mE+XhU1PHqsGNO5IuI39ewuo4rT6wVwLWk0spD62cC/OBlxhttl0JMSppFOus6SLZlZv
         6IbNu4X/h53iWGiY9MnTcx1GbdtIQE+l/JHNg12FJ64+kCKxqReceilOTkCvUybIaH9G
         lpYLlUTGNtnzGBi0faYXpwzyWibujRpUxOi8RL0CmUkRL5QUH9GZpRP5lmQ2lPONuhQ7
         H29w==
X-Gm-Message-State: AOJu0YyF9EuINljwTmOsc40z6ZNGu3cX6SH84PP1q79YbMU/OHsSkOux
	ttIfhcxM3sb3bpwY7cJ/bExLr3HymXtxH4QTQKA=
X-Google-Smtp-Source: AGHT+IFtt/PASSvAYiPrMJlRanNWFQxZ2OrDXhfAelMQQzmf6KouRjJrVx+ineqno/sRHqlcFPPSYGP9OBrKREUh2nw=
X-Received: by 2002:ad4:584f:0:b0:67a:ba98:b16e with SMTP id
 de15-20020ad4584f000000b0067aba98b16emr207100qvb.83.1701724021416; Mon, 04
 Dec 2023 13:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g> <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com> <xmqqwmu42ccb.fsf@gitster.g>
 <b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com> <CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
In-Reply-To: <CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 4 Dec 2023 16:06:50 -0500
Message-ID: <CAPig+cSGF+vQrnD0f99cbdpQOOC7X6ULa9tFe+FwVrG0SF4PGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
To: Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:21=E2=80=AFAM Willem Verstraeten
<willem.verstraeten@gmail.com> wrote:
> It's not clear for me from the email thread what the status is of this
> bug report, and whether there is still something expected from me.
>
> Is the current consensus that this is a real issue that needs fixing?
> If so, does the current patch-set fix the issue, and how does the fix
> get into (one of) the next release(s)?
>
> Do I still need to do something?

According to Junio's latest "What's cooking"[1], the status of this
patch series is:

  * jc/checkout-B-branch-in-use (2023-11-23) 2 commits
   - checkout: forbid "-B <branch>" from touching a branch used elsewhere
   - checkout: refactor die_if_checked_out() caller

   "git checkout -B <branch> [<start-point>]" allowed a branch that is
   in use in another worktree to be updated and checked out, which
   might be a bit unexpected.  The rule has been tightened, which is a
   breaking change.  "--ignore-other-worktrees" option is required to
   unbreak you, if you are used to the current behaviour that "-B"
   overrides the safety.

   Needs review and documentation updates.

I'm not sure if the "Needs review" comment is still applicable since
the patch did get some review comments, however, the mentioned
documentation update is probably still needed for this series to
graduate. I can't speak for what Junio had in mind, but perhaps
sufficient would be to add a side-note to the description of the -B
option saying that it historically (accidentally) would succeed even
if the named branch was checked out in another worktree, but now
requires --ignore-other-worktrees.

To move the series forward, someone will probably need to make the
necessary documentation update. That someone could be you, if you're
interested, either by rerolling Junio's series and modifying patch
[2/2] to also make the necessary documentation update, or by posting a
patch, [3/2] atop his series which updates the documentation.

[1]: https://lore.kernel.org/git/xmqq8r6j1dgt.fsf@gitster.g/
