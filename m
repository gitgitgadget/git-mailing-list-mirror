From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 40/44] builtin-am: support and auto-detect mercurial patches
Date: Wed, 1 Jul 2015 16:48:41 +0800
Message-ID: <CACRoPnSuh9qgtqqJZLCAjg+ad9+=qD+b5iateyOWa-X1hkDTAg@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-41-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZADhJ-0008UC-SR
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 10:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbGAIsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 04:48:45 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:32954 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbGAIsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 04:48:42 -0400
Received: by laar3 with SMTP id r3so36147953laa.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dz98SU3HGuR7flAbY1hB5CuG10M//qj/cHM1Xy6g6AE=;
        b=vH5VtMwldg+NEGTWRIoNISkoowfwkLrwfVxwndwx61kE/jcCrvdmLB3x+4xho+ybyn
         V0lbE92Z+79s7RLQtrDsFadjD4wAUguFlGSScgqmHe1SudTgkRyzKMkF8gkDZtFoEBd6
         +2ivQ6HpJzyf6so8ulM0Uewv4H/nsXMHo+VCwGiDgAkT3Pb/mSUb8f5aXJ5K4TZ3i8Dz
         4Tz6sFfVfsJB5A3w4n0InO4rU0Oc/4TngmkkIsyL/orphfAC7B66Y/w+2BjOCCBUQ4X0
         qsd8GHgIbcPUU8MVvnKzuXAFUGqp6K0l80ay2lrlQYusF1nnq8wylLJBy9Xf3n8rRlA+
         Nfhw==
X-Received: by 10.152.4.163 with SMTP id l3mr24458436lal.35.1435740521152;
 Wed, 01 Jul 2015 01:48:41 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 01:48:41 -0700 (PDT)
In-Reply-To: <CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273143>

On Tue, Jun 30, 2015 at 4:32 AM, Stefan Beller <sbeller@google.com> wrote:
> for calculating the minutes we would only need to take % 3600 (which
> you do), but
> then we still need to divide by 60 to convert seconds to minutes?

Whoops, yes we do. It should be:

tz = tz / 3600 * 100 + tz % 3600 / 60;
tz = -tz;

However...

> What happens if we have a negative input not matching a full hour, say -5400 ?
> (would equate to 0130 in git)

Hmm, I assumed that in C, integer division would always truncate to
zero, but turns out that is only so in C99. In C89, it is
implementation defined whether it rounds towards zero or towards
negative infinity.

So, if the compiler rounds towards negative infinity, then the above
will give the incorrect result. The best solution is probably to
ensure that all the integers are positive:

tz2 = labs(tz) / 3600 * 100 + labs(tz) % 3600 / 60;
if (tz > 0) tz2 = -tz2;

Thanks for bringing this up.

Regards,
Paul
