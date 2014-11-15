From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v4] Allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 19:14:21 -0500
Message-ID: <CAEBDL5XHdRA1eqgEqdMV-HMA006XGcPQ+BVQgkhzhaGLErGwgw@mail.gmail.com>
References: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
	<20141114232106.GA6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Blume <blume.mike@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, dborowitz@google.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 01:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpR0V-0002Q4-UH
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 01:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbaKOAOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 19:14:24 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:41790 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaKOAOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 19:14:23 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so13536725lbv.26
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xH8KbLxDldc8bXHpIWOG12UI/gkq1W00lBTTexT6w1o=;
        b=TF0wCjgC+neqpNh2occwQVJa5civWLzVbwKvmX9iUT8/OKUlGBoYeFZOs3U3umqzdx
         Kuv39dIVtS0DZ98BnuyAXpzXUrrxLqUK7H+gNZ/n8VKWdJxLKIuTj+qgZaStUKBRUJN6
         MkZ3pbyBBs3ol3e7+mFNBFwsLwoad4c1GkRjkTMnKqCNFjPUVlk4IGefgTdVe/wZJu7R
         LO6DkfmeAWP0k38ZckYdLStbYVqt8dRtLzQNlXqoDda3x/whM/Zp8KolhdrkDwJDycSB
         bzpGEkWLUPBcQMjpStHTEU6pwQZoT9Rf2+zCYZpEyxBhIRH97fn6PmVmTpQEZOImIW0a
         UWmw==
X-Received: by 10.112.25.73 with SMTP id a9mr11297969lbg.10.1416010461538;
 Fri, 14 Nov 2014 16:14:21 -0800 (PST)
Received: by 10.25.166.20 with HTTP; Fri, 14 Nov 2014 16:14:21 -0800 (PST)
In-Reply-To: <20141114232106.GA6527@google.com>
X-Google-Sender-Auth: 9CaIHEY3qIYlyXFt9b1QQhc2hsI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 6:21 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Mike Blume wrote:
>
>> TTY tests were previously skipped on all Mac OS systems because of a
>> bug where reading from pty master occasionally hung. This bug has since
>> been found not to be reproducible under Mac OS 10.9 and 10.10.1.
>>
>> Therefore, run TTY tests under Mac OS 10.9 (Mavericks) and higher.
>
> *puzzled* Testing on Yosemite with the following script[1]
>
>         perl -MIO::Pty -MFile::Copy -e '
>                for (my $i = 0;; $i++) {
>                        my $master = new IO::Pty;
>                        my $slave = $master->slave;
>                        if (fork == 0) {
>                                close $master or die "close: $!";
>                                open STDOUT, ">&", $slave or die "dup2: $!";
>                                close $slave or die "close: $!";
>                                exec("echo", "hi", $i) or die "exec: $!";
>                        }
>                        close $slave or die "close: $!";
>                        copy($master, \*STDOUT) or die "copy: $!";
>                        close $master or die "close: $!";
>                        wait;
>                }
>         '
>
> still seems to hang eventually (after 61 iterations when my officemate
> tried it), reproducing the bug.
>
> Do you get a different result?

Interesting.  It took quite a while, but it did finally fail on my
Mavericks box on the 115,140th iteration.

> The bug was originally found in an autobuilder that would run the test
> suite when new versions were pushed to check for regressions.  Even if
> the hang only happened 0.1% of the time, that would get the
> autobuilder stuck after a while, which was how the problem got
> noticed.

Eek... that's nasty.

-John
