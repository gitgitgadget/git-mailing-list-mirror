From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Wed, 26 Nov 2014 00:03:54 +0600
Message-ID: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
	<xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
	<CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
	<CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
	<xmqqbnnvtbac.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:04:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKT1-00036q-1o
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 19:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbaKYSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 13:03:55 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:47432 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaKYSDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 13:03:54 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so873606obc.18
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AMyWsfxJk1vcYMeiuWf+ctWGk+EVm5JWpMl+wg2u/sM=;
        b=wgxjTCVbTh/QkNandkEW+9zJRUBlrtVEM9mH4Cc29y1oXD+GWp4khNTpNOVdECksU6
         Tpo/j62tGeksZzdbtqLRg3m6tMdN1kY6BwWiCi24fRF7Ez1efl8npFYX3YTErU/Nswts
         XUAMldHk4GoyayJ4r60WqaQaHxQ/v6+Ci7f1+I0grt+oZg2wVgyDmhz7qvk8RXJpM1Pi
         NwslVNagaTHmoyRFhPzUCpv56dz/De/O+lhK7OPNMHZN/9gedb563DkTgW7Umim3kmuk
         3Ubz0uYktCSOvgLfCLc8ujloogSF1ewSskU+DlYMgfFFM1Lu3LSDxhICH3aGt0GFZ8Sd
         EqWw==
X-Received: by 10.202.84.147 with SMTP id i141mr16436335oib.56.1416938634177;
 Tue, 25 Nov 2014 10:03:54 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 25 Nov 2014 10:03:54 -0800 (PST)
In-Reply-To: <xmqqbnnvtbac.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260230>

Ah, you little ahead me, so we do not care about config.c in this way,
because it takes git_etc_gitconfig() in the same way as
git_etc_gitattributes

2014-11-25 23:55 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> But if we still static const char* for git_etc_gitattributes and will
>> not free it in bootstrap_attr_stack there will no memory leak, just
>> tested it, so i'll remove free for it.
>
> Leak or no leak, freeing there is wrong.  It will free the piece of
> memory the next caller will obtain from the git_etc_gitattributes()
> function.  In other words, the return value from that function is
> owned by git_etc_gitattributes(), not by the caller.
>
> As to "leak", in the strictest sense of the word, i.e. "do we
> allocate on the heap and exit without freeing?", it _is_ leaking,
> and your above "just tested it" probably means "the tool I used did
> not find/report it".  But as I said, it is not something worth
> bothering about [*1*].
>
> Think of it this way.
>
> The git_etc_gitattributes() function goes like this with your patch
> (and there is no fundamental difference in the original version,
> which uses "const char *" where appropriate):
>
>          static char *git_etc_gitattributes(void)
>          {
>                 static char *system_wide;
>                 if (!system_wide)
>                         system_wide = system_path(ETC_GITATTRIBUTES);
>                 return system_wide;
>          }
>
> If you knew that the pathname for /etc/gitattributes substitute will
> never be longer than 256 bytes, you may have coded the above like so
> instead:
>
>         static char system_wide[256];
>         static char *git_etc_gitattributes(void)
>         {
>                 if (!system_wide[0]) {
>                         char *ret = system_path(ETC_GITATTRIBUTES);
>                         if (strncpy(system_wide, ret, 256) >= 256)
>                                 die("ETC_GITATTRIBUTES too long ");
>                 }
>                 return system_wide;
>         }
>
> Even though we used the memory occupied by system_wide[] and did not
> clean up before exit(), nobody would complain about leaking.
>
> The existing code is the moral equivalent of the "up to 256 bytes"
> illustration, but for a string whose size is not known at compile
> time.  It is using and keeping the memory until program exit.
> Nobody should complain about leaking.
>
> That is, unless (1) the held memory is expected to be very large and
> (2) you can prove that after the point you decide to insert free(),
> nobody will ever need that information again.
>
>
> [Footnote]
>
> *1* The leaks we care about are of this form:
>
>     void silly_leaker(void)
>     {
>         printf("%s\n", system_path(ETC_GITATTRIBUTES));
>     }
>
>     where each invocation allocates memory, uses it and then loses
>     the reference to it without doing anything to clean-up.  You can
>     call such a function unbounded number of times and waste
>     unbounded amount of memory.
>
>     The implementation of git_etc_gitattributes() is not of that
>     kind.  An invocation of it allocates, uses and keeps.  The
>     second and subsequent invocation does not allocate.  When you
>     call it unbounded number of times, it does not waste unbounded
>     amount of memory.  It just keeps what it needs to answer the
>     next caller with.
>
>     The pattern needs to be made thread-safe, but that is a separate
>     topic.



-- 
_________________________
0xAX
