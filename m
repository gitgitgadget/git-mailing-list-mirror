From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] test_terminal: redirect child process' stdin to a pty
Date: Thu, 6 Aug 2015 18:15:53 -0400
Message-ID: <CAPig+cS0RxCexLG+2ZjCMhDEBCa9HgF6JgC3RWbxRgQwd6uiZg@mail.gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697331-29948-1-git-send-email-pyokagan@gmail.com>
	<1438697331-29948-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:16:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNTSB-0003FO-R4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 00:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbbHFWPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 18:15:55 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36224 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbHFWPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 18:15:54 -0400
Received: by ykeo23 with SMTP id o23so74566263yke.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=myXkC0CnTHticHQQROzWGJPPirFV4LsNgwbHXkLh0yU=;
        b=dYd1T+7ZXHtUI0IrTfbNkQX86/vWz1pZesCnSRJID/5+o/SsWTpq5DO4fmUjGIUloO
         yeoQkH77QY997ze2YpOJxFM3mAl3hwWPP4SBZnL48gTnSkOEq989wBe82fPnqKvbWMVd
         pU7Qpi4P35cJbctcwrZN/LJ2eqGRKBBU4dS+2FNTT8k1KtPoEiPOlgYMBmcCWLKzONW9
         Ocsterh3g5dKtj6YHKabXVE0CNWXGJx90NrbRkwPEievizNaBZWPlYEverlemhtdg+pb
         Psy5rsDHDMovZE7itR04noEQK0fR0SCdKlpbgcqu3XolsPsY+elqtcWreXv4Szgc7IAm
         yTLw==
X-Received: by 10.13.192.132 with SMTP id b126mr4441246ywd.163.1438899353706;
 Thu, 06 Aug 2015 15:15:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 15:15:53 -0700 (PDT)
In-Reply-To: <1438697331-29948-2-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: 9ss0Nn_gDYcYQufdLo9cdpNueug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275447>

On Tue, Aug 4, 2015 at 10:08 AM, Paul Tan <pyokagan@gmail.com> wrote:
> When resuming, git-am detects if we are trying to feed it patches or not
> by checking if stdin is a TTY.
>
> However, the test library redirects stdin to /dev/null. This makes it
> difficult, for instance, to test the behavior of "git am -3" when
> resuming, as git-am will think we are trying to feed it patches and
> error out.
>
> Support this use case by extending test-terminal.perl to create a
> pseudo-tty for the child process' standard input as well.

An alternative would be to have git-am detect that it is being tested
and pretend that isatty() returns true. There is some precedent for
having core functionality recognize that it is being tested. See, for
instance, environment variable TEST_DATE_NOW, and rev-list
--test-bitmap. Doing so would allow the tests work on non-Unix
platforms, as well.

> Note that due to the way the code is structured, the child's stdin
> pseudo-tty will be closed when we finish reading from our stdin. This
> means that in the common case, where our stdin is attached to /dev/null,
> the child's stdin pseudo-tty will be closed immediately. Some operations
> like isatty(), which git-am uses, require the file descriptor to be
> open, and hence if the success of the command depends on such functions,
> test_terminal's stdin should be redirected to a source with large amount
> of data to ensure that the child's stdin is not closed, e.g.
>
>         test_terminal git am --3way </dev/zero
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
