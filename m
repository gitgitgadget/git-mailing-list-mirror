From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 17:33:21 +0100
Message-ID: <81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	 <7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	 <7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:33:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRWPx-0002Jp-6y
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 17:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXCNQdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbXCNQdY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 12:33:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:27764 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXCNQdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 12:33:23 -0400
Received: by mu-out-0910.google.com with SMTP id g7so244896muf
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 09:33:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m1SRseb5wc2oPap+tH1YUAoH0cnQdxa0jh0Yo8+CssCoLd/hUuUq8s1IG3L2kwhcjAM/F66XW4rxIgXWe5uybASviw0XwUX6/bUMd0R6V9KHS3KQMJqPMzxpngbeyLKm0D2S5QoD4gtYDQMx43sTnLnB1ShfBnEC/Hg8HcsDGck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q+5fL78YLPNaWlx02jmPv7P/5H5gFm5lZxhOyhwsBjnMezFo4EgoKz+IRnKrfRNyzZH8wXGkkFNne17BTijrfJYcWbEznY4tn8qCdaQ2wRxCM8JERWzxnwSpfVQMhTIqNhO2cVbmhBYMOPDR/F2+9h7vLw4Ahtz2HETd1pAIZt8=
Received: by 10.78.146.11 with SMTP id t11mr1296854hud.1173890001656;
        Wed, 14 Mar 2007 09:33:21 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 09:33:21 -0700 (PDT)
In-Reply-To: <7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42212>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> > -     return run_diff_files_cmd(&rev, argc, argv);
> > +     result = run_diff_files_cmd(&rev, argc, argv);
> > +     return rev.diffopt.diff_exit_code ? rev.diffopt.exit_code: result;
> >  }
>
> Yuck.  Let's call the former "exit_with_status" (meaning, the
> caller instructed us to do that) and the latter "has_changes".

I like "exit_with_status". But has_changes looks confusing
good near return value of run_diff_files_cmd, which "has"
nothing. Or do you mean to highlight this "difference"?

> > +test_expect_failure 'git diff-index --cached HEAD^' '
> > +     echo text >>b &&
> > +     echo 3 >c &&
> > +     git add . &&
> > +     git diff-index --exit-code --cached HEAD^
> > +'
>
> Please:
>
>         test_expect_success '...
>                 echo ... &&
>                 git add . &&
>                 ! git diff-index ...
>         '
>
> I recall somebody on the list had a buggy shell that cannot
> handle "a && ! b" and tweaked a few tests to work around it.
> In that case...
>
>         echo ... &&
>         git add . &&
>         {
>                 git diff-index ...; test $? != 0
>         }

Confused. What's wrong with test_expect_failure which
does not need any of the both ugly constructions?
Hmm... Do you mean: "we expect successful
operation with exit code 1"? I like this, easier to follow.
Will do.

> > +test_expect_failure 'git diff-files' '
> > +     echo 3 >>c &&
> > +     git diff-files --exit-code
> > +'
>
> Likewise

Yep, I'll change this too.

> > +git update-index c || error "update-index failed"
>
> Please do not have command outside test_expect without good
> reason.

Well, it does not actually belongs to the test logic
(as well as the echo's, one may notice).
