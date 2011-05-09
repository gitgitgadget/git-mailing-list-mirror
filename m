From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon, 9 May 2011 10:41:02 +0200
Message-ID: <BANLkTimR_S-px-MfRy0pKGrjxOgSC_=e=A@mail.gmail.com>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
 <1304927478-3112-1-git-send-email-kusmabite@gmail.com> <20110509080315.GA6205@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, steveire@gmail.com,
	felipe.contreras@gmail.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 10:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJM1w-0003lt-D5
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1EIIlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 04:41:23 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:42382 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1EIIlW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 04:41:22 -0400
Received: by pxi16 with SMTP id 16so3447850pxi.4
        for <git@vger.kernel.org>; Mon, 09 May 2011 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=evUwaUK23/BzeBYzGY58ctDdOdJcN8eSsYzV9kSF/nY=;
        b=hTPjXb+Ix8zVw7J2EpAIxzrX7KfdpzR1e2MuxTF462pj0BIIaBlTJNSpKc8g8WrciJ
         xz4nhcCVvfsZSO0lJXonER6kG6kY9GPi7s8dVpflEdDLQ0bDgwqnsujXAEwubISj3ARc
         z0ldSZgHPyB2omolt9YCESuLmwl4GetXgTv/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=xAWr5GDq2DwF3qkA0t1zm7jOqNDViNaTDlPEpMK5UVegZNVA4Tn6PSfaGsBPMLfJSi
         98UPVL8+nPjuD+F8tkk1zmXdU2Cgu4+QlXcnai1FHg8EV7ICJWWSpLOKNtPigWpkT6WI
         bsD+vO+rTb8OPT94nZSECufXxB+KnDYV8Dsbs=
Received: by 10.68.35.165 with SMTP id i5mr9222039pbj.449.1304930482095; Mon,
 09 May 2011 01:41:22 -0700 (PDT)
Received: by 10.68.66.98 with HTTP; Mon, 9 May 2011 01:41:02 -0700 (PDT)
In-Reply-To: <20110509080315.GA6205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173210>

On Mon, May 9, 2011 at 10:03 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2011 at 09:51:18AM +0200, Erik Faye-Lund wrote:
>
>> If there's a branch (either local or remote) called 'HEAD'
>> commands that take a ref currently emits a warning, no matter
>> if the output is going to a TTY or not.
>>
>> Fix this by making sure we only output this warning when stderr
>> is a TTY. Other git commands or scripts should not care about
>> this ambiguity.
>>
>> This fix prevents gitk from barfing when given no arguments and
>> there's a branch called 'HEAD'.
>
> This feels wrong. Gitk should not care about messages on stderr, for
> exactly the reason that they may be harmless warnings (if anything, i=
t
> should show them to the user in a dialog).

I agree.

>> In 2f8acdb ('core.warnambiguousrefs: warns when "name" is used
>> and both "name" branch and tag exists.'), a check for collisions
>> of refs was introduced. It does not seem to me like the intention
>> was to check HEAD for ambiguty (because the commit talks about
>> branches and tags), but it does.
>>
>> Because HEAD cannot be disambiguated like branches and tags can,
>> this can lead to an annoying warning, or even an error in the case
>> of gitk.
>
> This is a separate issue, isn't it? Gitk should probably handle
> ambiguous ref warnings better, no matter what the name. =A0And if
> ambiguous HEAD warnings are considered too annoying, they should be
> squelched for everyone. I don't personally have an opinion on the
> latter, though.
>

I agree; it's possible to squelch them already with the
core.warnambiguousrefs config, so people who want to live with
branched called 'HEAD' can already get around it.

>> A branch called HEAD can be 'injected' into another user's repo
>> through remotes, and this can cause annoyance (and in the case of
>> gitk, brokenness) just by pulling the wrong remote. Yuck.
>
> Can you give an example? If I am fetching your refs into
> refs/remotes/$remote/*, how does that create an ambiguity?
>

Actually, this is just something I read out of Stephen's report and
was too lazy to double check. It's not possible to do, because
refs/remotes/* does not seem to be checked for ambiguity. Thanks for
setting me straight :)

>> One question is if ANY warnings should be output to stderr if it's
>> not a TTY. My guess is that there probably are some classes of
>> warnings that should, but the vast majority should probably not.
>
> I disagree. If I do:
>
> =A0git foo 2>errors
>
> I would certainly expect any relevant errors to end up in that file. =
As
> for why I would do that, two cases I can think of offhand are:
>
> =A01. Test scripts, which use this extensively.
>
> =A02. Sometimes cron jobs will capture chatty output in a file and sh=
ow
> =A0 =A0 it only in the case of some error condition.
>

I was talking about warnings, not errors. But I can also see that one
would sometimes want warnings even when not connected to a tty, but
perhaps only when -v is specified?

>> Another question is if we should come up with a way of
>> disambiguating HEAD. Perhaps having something like 'refs/HEAD'
>> will do?
>
> Yeah, if we disambiguate, I would be tempted to say that "HEAD" alway=
s
> unambiguously refers to "HEAD".

While that would touch less code, my gut tells me it's a bit more
fragile. But perhaps you're right; I can't come up with any real
arguments (i.e use cases that I care about) on top of my head.

> And "refs/HEAD" should already work, no?

No:
$ git init foo
$ cd foo/
$ echo "foo" > bar
$ git add bar
$ git commit -m.
[master (root-commit) fc0cbef] .
warning: LF will be replaced by CRLF in bar.
The file will have its original line endings in your working directory.
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git show refs/HEAD
fatal: ambiguous argument 'refs/HEAD': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions

>> diff --git a/sha1_name.c b/sha1_name.c
>> index faea58d..c7e855e 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -391,7 +391,7 @@ static int get_sha1_basic(const char *str, int l=
en, unsigned char *sha1)
>> =A0 =A0 =A0 if (!refs_found)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>
>> - =A0 =A0 if (warn_ambiguous_refs && refs_found > 1)
>> + =A0 =A0 if (warn_ambiguous_refs && refs_found > 1 && isatty(2))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning(warn_msg, len, str);
>>
>
> I think I have made it clear that I am not in favor of this approach,
> but if we were to do it, it is too late to be calling isatty(2) here.
> You need to also check pager_in_use(), as we may have redirected stde=
rr
> into the pager's pipe.

Good point. I doubt I'll update the patch in this direction though,
since I agree it's not the right approach.
