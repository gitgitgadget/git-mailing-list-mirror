Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004A41205
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17560 invoked by uid 109); 10 Jan 2024 11:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 11:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25781 invoked by uid 111); 10 Jan 2024 11:02:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 06:02:29 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 06:02:26 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Message-ID: <20240110110226.GC16674@coredump.intra.peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>

On Tue, Jan 09, 2024 at 04:30:16PM +0100, Rubén Justo wrote:

> Using advise_if_enabled() to display an advice will automatically
> include instructions on how to disable the advice, along with the
> main advice:
> 
> 	hint: use --reapply-cherry-picks to include skipped commits
> 	hint: Disable this message with "git config advice.skippedCherryPicks false"
> 
> This can become distracting or noisy over time, while the user may
> still want to receive the main advice.
> 
> Let's have a switch to allow disabling this automatic advice.

If I'm reading your patch correctly, this is a single option that
controls the extra line for _all_ advice messages. But I'd have expected
this to be something you'd want to set on a per-message basis. Here's my
thinking.

The original idea for advice messages was that they might be verbose and
annoying, but if you had one that showed up a lot you'd choose to shut
it up individually. But you wouldn't do so for _all_ messages, because
you might benefit from seeing others (including new ones that get
added). The "Disable this..." part was added later to help you easily
know which config option to tweak.

The expectation was that you'd fall into one of two categories:

  1. You don't see the message often enough to care, so you do nothing.

  2. You do find it annoying, so you disable this instance.

Your series proposes a third state:

  3. You find the actual hint useful, but the verbosity of "how to shut
     it up" is too much for you.

That make sense to me, along with being able to partially shut-up a
message. But wouldn't you still need the "how to shut up" hint for
_other_ messages, since it's customized for each situation?

E.g., suppose that after getting annoyed at advice.skippedCherryPicks,
you run "git config advice.adviseOff false".

But now you run into another hint, like:

  $ git foo
  hint: you can use --empty-commits to deal with isn't as good as --xyzzy

and you want to disable it entirely. Which advice.* config option does
so? You're stuck trying to find it in the manpage (which is tedious but
also kind of tricky since you're now guessing which name goes with which
message). You probably do want:

  hint: Disable this message with "git config advice.xyzzy false"

in that case (at which point you may decide to silence it completely or
partially).

Which implies to me that the value of advice.* should be a tri-state to
match the cases above: true, false, or a "minimal" / "quiet" mode (there
might be a better name). And then you'd do:

  git config advice.skippedCherryPicks minimal

(or whatever it is called) to get the mode you want, without affecting
advice.xyzzy.

>  advice.c          | 3 ++-
>  advice.h          | 3 ++-
>  t/t0018-advice.sh | 8 ++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)

Speaking of manpages, we'd presumably need an update to
Documentation/config/advice.txt. :)

-Peff
