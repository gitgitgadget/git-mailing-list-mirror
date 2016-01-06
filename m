From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Initial git clone behaviour
Date: Wed, 6 Jan 2016 15:14:45 -0800
Message-ID: <CAPc5daXeNay1uF=qQ=G82kyu37uHhy-uEOWU6tz_bPYfFam=rA@mail.gmail.com>
References: <CANpvso58uPtMcz_L0D=WBcCj+mSLLYZ5LpfO1i5yLo-jrb6bsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Curtin <ericcurtin17@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 00:15:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxIN-0003fd-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbcAFXPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:15:08 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36317 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcAFXPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:15:05 -0500
Received: by mail-io0-f182.google.com with SMTP id g73so35648696ioe.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lcTT6H4DfuBriDFEe3/j2za71OLObOsdx26VM+3vcQ8=;
        b=SxdM7fsIRUPpgSpik8XKpdQ1AVPyje1CYcFf1Vw+pMzom8o+EqAu5lH15fF7Qdonpg
         wO6j/RUttw+VsphQEr756L6bKr9mYZNXJD1bSE/1dT79M5jwANrIFBoLtymVshnu0kjH
         HSWKWSqqx+77Skyi+RiwBtLfT4tHurw7OyE5LRQA+7Bs2gMotnlQjXlv/1+20scsx5zH
         pWcIC5Frql5AxnsMakn8QGfoUk1p3k0J6SbISA1tgy7klQQK4/a0ewdRhe3VmmZaxMaq
         BLM3xsJlz5EXl4hswPwQf3z+sd5YZje9JdhKFjff64EtD/YIegkRyXEgSO8ZxxMb4vnf
         /fzA==
X-Received: by 10.107.165.197 with SMTP id o188mr94297838ioe.132.1452122105087;
 Wed, 06 Jan 2016 15:15:05 -0800 (PST)
Received: by 10.36.52.137 with HTTP; Wed, 6 Jan 2016 15:14:45 -0800 (PST)
In-Reply-To: <CANpvso58uPtMcz_L0D=WBcCj+mSLLYZ5LpfO1i5yLo-jrb6bsA@mail.gmail.com>
X-Google-Sender-Auth: ZzRE0sGKtQ8RbD_VutzPQcTbe_4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283456>

On Wed, Jan 6, 2016 at 2:26 PM, Eric Curtin <ericcurtin17@gmail.com> wrote:
>
> Often I do a standard git clone:
>
> git clone (name of repo)
>
> Followed by a depth=1 clone in parallel, so I can get building and
> working with the code asap:
>
> git clone --depth=1 (name of repo)
>
> Could we change the default behavior of git so that we initially get
> all the current files quickly so that we can start working them and
> then getting the rest of the data? At least a user could get to work
> quicker this way. Any disadvantages of this approach?

It would put more burden on a shared and limited resource (i.e.
the server side).

For example, I just tried a depth=1 clone of Linus's repository from

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

which transferred ~150MB pack data to check out 52k files in 90 seconds.

On the other hand, a full clone transferred ~980MB pack data and it took
170 seconds to complete. You can already see that a full clone is highly
optimized--it does not take even twice the time of getting the most recent
checkout to grab 10 years worth of development (562k of commits).

This efficiency comes from some tradeoffs, and one of them is that not
all the data necessary to check out the latest tree contents can be stored
near the beginning of the pack data. So "we'll checkout the tip while the
remainder of the data is still incoming" would not be a workable, unless
you are willing to destroy the full-clone performance.
