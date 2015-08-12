From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/3] test_terminal: redirect child process' stdin to a pty
Date: Wed, 12 Aug 2015 12:16:02 +0800
Message-ID: <CACRoPnTu=rSMZXaP5y_5Fb9o6u3u=s-HO+Ny4CY226rT6Wx2zA@mail.gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697331-29948-1-git-send-email-pyokagan@gmail.com>
	<1438697331-29948-2-git-send-email-pyokagan@gmail.com>
	<CAPig+cS0RxCexLG+2ZjCMhDEBCa9HgF6JgC3RWbxRgQwd6uiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 06:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPNSV-0006eZ-J3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 06:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbbHLEQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 00:16:05 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35495 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbHLEQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 00:16:04 -0400
Received: by lbcbn3 with SMTP id bn3so2748973lbc.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZGRs0mjsBIoRSWnCk7bk4zKiwJze3rPMWemcdfjXSvk=;
        b=IDcoZ1czpHnvWts4TQHVoewGceLF/WDMEurY/uwStlcGReZS6A80x33weyxt98vcPO
         rTcTZHoRrRqUclEgkv7v8fJxR+KOUv0eEFOHbm79bprvgwmDZK/xlk1MJeJii9FbQIrO
         6p24dF8vrmiNOf6UhAlPzmsM93yr5RDcn7HB/PdqdVpD7Uk7woXaRf7A0r0PIKXn9QR5
         l96hkoGJtX7Z5jicccnnUgq+1yBVIXuY7RwY4HbHSm8b+i8v3HH8ptDgPljGRHVJogrF
         u36cat5vfo1FhbsmuV15TH398fB/Nf1MtfebRJmq7rQaNii0gEm4L0bYFq716b4ZumpN
         l/Eg==
X-Received: by 10.112.12.102 with SMTP id x6mr30548584lbb.80.1439352962938;
 Tue, 11 Aug 2015 21:16:02 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Tue, 11 Aug 2015 21:16:02 -0700 (PDT)
In-Reply-To: <CAPig+cS0RxCexLG+2ZjCMhDEBCa9HgF6JgC3RWbxRgQwd6uiZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275756>

On Fri, Aug 7, 2015 at 6:15 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> An alternative would be to have git-am detect that it is being tested
> and pretend that isatty() returns true.

I would vastly prefer a solution that would work for everything, for
all the C code and scripts, instead of implementing a workaround in
git-am :(

In this case, I implemented a generic solution in test-terminal.perl
that works for POSIX systems, so if there are no problems with its
implementation, I do think it's better. Other than the fact that it
does not work on non-Unix platforms, of course.

The other approach I would consider is to implement a xisatty()
function that returns true for xisatty(0) if TEST_TTY=0 or something.

However, I do wonder if this would lead us to have to hack around
other functions of terminals as well (e.g. if xisatty(0),
tcgetattr()), which would be a big can of worms I think...

> There is some precedent for
> having core functionality recognize that it is being tested. See, for
> instance, environment variable TEST_DATE_NOW,

(Hmm, I took a look, and it seems that TEST_DATE_NOW is only checked
in test-date.c...)

> and rev-list --test-bitmap.
> Doing so would allow the tests work on non-Unix
> platforms, as well.

Ehh, if the non-Unix platforms do not implement terminals, it means
that the git-am logic to detect if we are attempting to feed it a
patch by checking if stdin is a TTY is invalid anyway, so implementing
a "yeah-it-is-a-tty" workaround for the sake of tests would be hiding
the problem, I think.

Thanks,
Paul
