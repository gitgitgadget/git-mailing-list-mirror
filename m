From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 19:35:39 +0530
Message-ID: <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-2-git-send-email-artagnon@gmail.com> <vpqhagnwraj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 16:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7PU-0005Xq-5C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab3FXOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:06:20 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62867 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3FXOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:06:19 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so25004375ieb.16
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M9NcAUzQQ4tKqx9xse8pyCYC0s7OjiNDFQ0ZXqDN8u0=;
        b=NhAWLY+wT7TewIXI85phU4GIV85nugqnZriJkFjSYU4ADk/eGyW5azrpicIG2Xn81x
         n1Ir5ysR1QmiPpKTvQLawdxyZe8KqNL1gNCKl7BzLf57/jF1cQfaCkZO6LB+8ka26/Tv
         9LTkq7qsfCCJI1zwQAEtsqMN8dpbr5DIZwaaahLxEvIJF0qgMChPTbvnwDo95qb6Um0u
         YFwXgBh4BUZYhdjBWkuRWVxwxJxuy+5gS7T5dx6f7EAfbduHhWm/3wW7CHh95wy8DxS3
         UFr2mSpmgWAV7ZI8XWzKX/NiF1mWGInxemU4dtc3frIr7c0ADaP51YlNVQyAjMIssR3N
         Gjcw==
X-Received: by 10.50.107.65 with SMTP id ha1mr5586777igb.50.1372082779394;
 Mon, 24 Jun 2013 07:06:19 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 07:05:39 -0700 (PDT)
In-Reply-To: <vpqhagnwraj.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228813>

Matthieu Moy wrote:
> [...]

Before we begin, let me say that this series is written with the
emergency-fix mindset, and targets maint.  I didn't spend time
thinking about how to do it best or even add tests.

>> The correct solution is therefore to skip the config parser completely
>> when --porcelain is given.  Unfortunately, to determine that --porcelain
>> is given, we have to run the command-line option parser.  Running the
>> command-line option parser before the config parser is undesirable, as
>> configuration variables would override options on the command-line.  As
>> a fair compromise, check that argv[1] is equal to the string
>> "--porcelain" and skip the config parser in this case.
>
> I really don't like this. If we go for a solution looking explicitely at
> argv[], we should at least iterate over it (also not satisfactory
> because --porcelain could be the argument of another switch).

Yep, that's the compromise.

> I think it's possible to have an actually robust solution, either
>
> * running the CLI parser after, if --porcelain is given, reset the
>   effect of the variables. Not very clean because we'd have to reset all
>   the variables to their default, and there is a risk of forgetting one.

Since it's impossible to determine what effect the CLI parser had on
various variables (some of which are static global), I'm against this
approach.

> * Or, running the CLI parser before, but with different variables to
>   specify what the command-line says and what will actually be done,
>   with something like

Basically, having the CLI parser and the config parser flip two
different sets of variables, so we can discriminate who set what.
What annoys me is that this is the first instance of such a
requirement.

The approach I'm currently tilting towards is extending the
parse-options API to allow parsing one special option early.  I would
argue that this is a good feature that we should have asked for when
we saw 6758af89e (Merge branch 'jn/git-cmd-h-bypass-setup',
2010-12-10).  What do you think?

>>  builtin/commit.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> No time to contribute one now myself, but this would really deserve a
> test.

Yeah, will do as a follow-up.  I'm interested in guarding against such
breakages too :)
