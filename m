From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Mon, 29 Dec 2014 14:21:57 +0100
Message-ID: <CACBZZX4qKyfRcbowYnM-KsrbKZ2=9RXr+HEgrOU1jaCsSX53QA@mail.gmail.com>
References: <54A085D1.8060407@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Kang-min Liu <gugod@gugod.org>
To: "Randy J. Ray" <rjray@blackperl.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 14:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5aH9-0005UQ-IR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 14:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbaL2NWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 08:22:19 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:46272 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaL2NWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 08:22:18 -0500
Received: by mail-oi0-f53.google.com with SMTP id g201so28969939oib.12
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 05:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6dwqEtml5+UaG5bGbIb+l7N4pdmRTFA5oTd1ahvRjl8=;
        b=P+R/CoT1XVxx5u/8f3PHNEZHois9oC4hgsfr8WROUawlIfpmuY2wqsb8Gll4J43tbj
         U7nZh0vcPedDtHMZbjntahTCIxao0au9ii9L1X+W8PRf6/jSCXU0iE2zqZNWwGzf7Gj+
         yCzoQ1wrqEHo7esGoJJdEPkChkQc33EfbuiTTJrqzfst/pLqCswI1tNgh0RrPoqpl2JY
         Z+eP7hst0dp9J41PRxXfubVcR+QwylNDVyk31DJoxi8wvaXh7q7cNHKdK2zj4emti/l0
         IohE5qYPKCzszkNHAwQEjoD/Sj7H27R34uYDxXNJ9z3LNCCJs1vcQlLl+ljdliRZI+Aj
         26zA==
X-Received: by 10.60.114.40 with SMTP id jd8mr257548oeb.12.1419859337791; Mon,
 29 Dec 2014 05:22:17 -0800 (PST)
Received: by 10.76.141.44 with HTTP; Mon, 29 Dec 2014 05:21:57 -0800 (PST)
In-Reply-To: <54A085D1.8060407@blackperl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261860>

On Sun, Dec 28, 2014 at 11:36 PM, Randy J. Ray <rjray@blackperl.com> wrote:
> I use git on MacOS via homebrew (http://brew.sh/), and a custom Perl
> installation built and managed via perlbrew (http://perlbrew.pl/). At some
> point, commands like "git add -i" broke. I say "at some point", because I'm
> not a git power-user and I only just noticed it this week.
>
> I am running Git 2.2.1 with a perlbrew'd Perl 5.20.1. When I would run "git
> add -i" (or "git add -p"), it would immediately die with a signal 11. Some
> poking around showed that those git commands that are implemented as Perl
> scripts run under /usr/bin/perl, and also prefix some directories to the
> module search-path. The problem stems from the fact that, when you are using
> perlbrew, you also have the PERL5LIB environment variable set. The contents
> of it lay between the git-provided paths and the default contents of @INC.
> When the Git module is loaded, it (eventually) triggers a load of
> List::Util, whose C-level code fails to load because of a version mismatch;
> you got List::Util from the paths in PERL5LIB, but it doesn't match the
> version of perl from /usr/bin/perl.
>
> After poking around and trying a few different things, I have found that
> using the following line in place of "#!/usr/bin/perl" solves this problem:
>
>         #!/usr/bin/env perl
>
> This can be done by defaulting PERL_PATH to "/usr/bin/env perl" in Makefile.
>
> I don't know enough about the overall git ecosystem to know if this would
> have an adverse effect on anything else (in particular, Windows
> compatibility, but then Windows probably isn't having this issue in the
> first place).
>
> I could just create and mail in the one-line patch for this, but I thought
> it might be better to open it up for some discussion first?

[CC'd the perlbrew author]

This is a bit of a tricky issue.

Using whatever perl is defined in the environment is just as likely to
break, in general the build process tries to pick these assets at
compile-time. Imagine you're experimenting with some custom perl
version and now Git inexplicably breaks.

It's better if Git detects a working perl when you compile it and
sticks with that, which is why we use /usr/bin/perl by default.

When you're setting PERL5LIB you're indicating to whatever perl
interpreter you're going to run that that's where they it should pick
up its modules. IMO they way perlbrew does this is broken, instead of
setting PATH + PERL5LIB globally for your login shell it should set
the PATH, and then the "perl" in that path should be a pointer to some
small shellscript that sets PERL5LIB for *its* perl.

I don't know what the right tradeoff here is, but I think it would be
just as sensible to unset PERL5LIB in our own perl scripts + modules,
it would make live monkeypatching when you wanted to harder, but we
could always add a GITPERL5LIB or something...
