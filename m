From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Tue, 5 Nov 2013 03:45:53 +0100
Message-ID: <CALKQrgcweo+B8JKH85-4-SOHsAi6SAxstnXhRWCst_qEyXYmhA@mail.gmail.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
	<xmqqfvrcyoaj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 03:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdWee-0001mm-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 03:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab3KECqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 21:46:04 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:58974 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3KECqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 21:46:02 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VdWeU-0001Ll-J4
	for git@vger.kernel.org; Tue, 05 Nov 2013 03:45:58 +0100
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VdWeT-000Abm-HI
	for git@vger.kernel.org; Tue, 05 Nov 2013 03:45:57 +0100
Received: by mail-pa0-f47.google.com with SMTP id lf10so7742699pab.20
        for <git@vger.kernel.org>; Mon, 04 Nov 2013 18:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7GYizNWKZ6eqFYe3lr49Nnl5UosVCsZrLYYBf+VmHsI=;
        b=JqXqunerV4nQqaFz4f8YjLEDk9BnMYg2Lg8mSR586evwj00e90nzLpynXWo/oxAijz
         16K4TmJkVXB+ZA89gD6WxauMtXm6kQ5efConLUGOr1FRhmnYNBis13Cu8zDphYdHg5Ub
         dPCsmC7XWvRE7O3LlMKlGK12FjgFkNty461j1bFstLQ3vAFxO2MlHLdc5FaLamIexl8F
         9AJgUjpVivmHen1e7sk5yiiX/tRojk0J+mx7d3eZtTic292sTXogsNZfYcS5TnHPxI1C
         u2+fNLm6jp2Iv6OOijV+hzZZ50WZYE8oGZc9CML4OqZWCV5qMZISBss1MuywAWkbipM4
         5sUA==
X-Received: by 10.68.125.226 with SMTP id mt2mr20838481pbb.115.1383619553462;
 Mon, 04 Nov 2013 18:45:53 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Mon, 4 Nov 2013 18:45:53 -0800 (PST)
In-Reply-To: <xmqqfvrcyoaj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237320>

On Mon, Nov 4, 2013 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>>> +{
>>> +       char *end = strchr(arg, '=');
>>> +       if (!end)
>>> +               end = strchr(arg, ':');
>>
>> So both '=' (preferred) and ':' are accepted as field/value
>> separators. That's ok for the command-line, I believe.
>
> Why?
>
> Sometimes you have to be loose from the beginning _if_ some existing
> uses and established conventions make it easier for the users, but
> if you do not have to start from being loose, it is almost always a
> mistake to do so.  The above code just closed the door to use ":"
> for some other useful purposes we may later discover, and will make
> us regret for doing so.

Although I agree with the principle, I think there are (at least) two
established conventions that will be commonly used from the start, and
that we should support:

 - Using short forms with '=', e.g. "ack=Peff". There is already a
convention on how we specify <name> + <value> pairs on the command
line, e.g. "git -c foo=bar ..."

 - Copy-pasting footers from existing commit messages. These will have
the same format as the expected output of this command, and not
accepting the same format in its input seems silly, IMHO.

That said, I think this applies only to the formatting on the _command
line_. When it comes to how the resulting footers are formatted in the
commit message, I would argue it only makes sense to use ':', and I
think the testcase named 'with config setup and = sign' in the above
patch is ugly and unnecessary.

>> From the enum values, I assume that these declare the desired behavior
>> when there are two (or more?) or the same footer (i.e. same "field
>> name"). However, it's not (yet) obvious to me in which order they are
>> processed. There are several opportunities for multiple instances of
>> the same "field name":
>>
>>  - Two (or more) occurences in the infile
>>  - Two (or more) occurences on the command line
>>  - One occurence in the infile, and one of the command line
>
> Also, there is a distinction between fields with the same field name
> appearing twice and fields with the same field name and the same
> field value appearing twice. Some headers do want to have them, some
> do not.

True. This complexity is partly why I initially wanted to leave this
whole thing up to hooks, but I guess now we have to deal with it...
That said, I believe we don't need to cater to every possibility under
the sun, just the most common ones. If a minority of users are not
satisfied, they can simply configure this to leave all duplicates in
place, and then write their own commit-msg hook to do whatever weird
consolidation/cleanup they prefer.

...Johan

PS: Since this program will be run by "git commit", and might also be
invoked by hooks, we need to keep the following in mind:

 - Design for idempotence. A given set of headers might be filtered
through this program multiple times, and we should make sure that
multiple runs over the same data does not itself cause problems.

 - Optional/flexible configuration. When a hook runs this program, it
may want to impose its own set of rules that does not entirely (or at
all) coincide with what is set in the config. We should therefore
consider providing a way for the caller to specify a separate source
of trailer/footer config to apply on a given run.


-- 
Johan Herland, <johan@herland.net>
www.herland.net
