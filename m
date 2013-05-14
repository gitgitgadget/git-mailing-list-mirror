From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between
 shorthand names and full refnames
Date: Tue, 14 May 2013 16:24:03 +0200
Message-ID: <CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
	<7vwqr2liv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 16:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcG9G-0008AT-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 16:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab3ENOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 10:24:10 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:52182 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3ENOYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 10:24:08 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcG99-000PNV-8b
	for git@vger.kernel.org; Tue, 14 May 2013 16:24:07 +0200
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcE4L-000Dbm-Mt
	for git@vger.kernel.org; Tue, 14 May 2013 14:11:01 +0200
Received: by mail-ob0-f174.google.com with SMTP id un3so613458obb.19
        for <git@vger.kernel.org>; Tue, 14 May 2013 07:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kCQGxPwkKqQocSBXwZ6jlpF7sUX7Uwj+ebpSr1lvIBY=;
        b=VkRz+P5tkuCBezK8+hD7DmfCLNtt1WFrgmIgmpqonuEeEJREutr5gNwZokpNlk7oE7
         BMdAXGRPFeTQNGGRDbDNyn1ZcTGe+Egl0RmmPXO97KKNXW8AX8/6mzWLKQKHSEoRzPtx
         a+r2g83rAQ453FI3btwffDqEJdvNCfeWEnKHyn1kZFXZMl5RPHa10Gg4F+oBQMiUuI0j
         nZwwWBZcv0d76XAsozAoY02LvtZkHbJAeeIWXRaLvGrcn1+4cuh546+u5qVIzE/imkNG
         3+TOebCMpxVBF2NLiinAPXVamRkk5EpP3TOrfMi1rlUUpJ4saA7XLzXQSPOJMam8kdNE
         ybqw==
X-Received: by 10.60.142.7 with SMTP id rs7mr2760132oeb.106.1368541443477;
 Tue, 14 May 2013 07:24:03 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Tue, 14 May 2013 07:24:03 -0700 (PDT)
In-Reply-To: <7vwqr2liv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224301>

On Mon, May 13, 2013 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Johan Herland <johan@herland.net> writes:
>>> Obviously, I named it '%1' since it expands into the _first_ component
>>> of the (slash-separated) shorthand.
>>
>> OK, I can buy something like
>>
>>       %*
>>         refs/%*
>>         refs/heads/%*
>>         ...
>>         refs/remotes/%*/HEAD
>>         refs/remotes/%1/%2
>>         refs/peers/%1/heads/%2
>>
>> that is, for a pattern that has %*, we feed the end-user string as a
>> whole, and for a pattern that has %1 thru %N, we find an appropriate
>> way to chop the end-user string into N pieces (e.g. nick/name would
>> be split into %1 = nick, %2 = name, while foo/bar/baz might have two
>> possibilities, <%1, %2> = <foo, bar/baz> or <foo/bar, baz>).  The
>> earlier ones on the above list can even be written with their %*
>> substituted with %1 if we go that route.
>
> Just to make sure.
>
> Please do not let "two possibilities" stop you.  As I said in the
> nearby thread, I do not necessarily insist that we must try all N
> possibilities.  "We find an appropriate way" could be just "we
> always chop at the first slash, and %1 is what comes before it, %2
> is what comes after it".
>
> That will close the possibility for us to use %1 thru %N (N is
> limited to 2), but it still is "We have %1 and we have %2, both fall
> into the same 'path components, numbered from left to right'
> category", and justifies the use of %1 ("one", not "el").
>
> So still no objection to %1 from me.

I think I like "refs/peers/%1/heads/%*" better than
"refs/peers/%1/heads/%2", since the latter sort of makes me wonder
whether the 3rd, 4th, etc. components would be discarded. That said,
having %* mean "the rest of the shorthand" means that we must adjust
the expansion of %* for every preceding %N, which prevents us from
simplifying the code by using strbuf_expand_dict_cb() with a static
dictionary [1].

I am not sure why we would want "refs/remotes/%1/%2" instead of
"refs/remote/%*". Maybe I've been staring at this for too long, but I
find the latter shorter and more descriptive and the "%1/%2" notation
needlessly cumbersome, especially if it's also supposed to match
"foo/bar/baz"

When it comes to multi-level remote names, I guess I could drop the
patch that disallows them, and still just have "%1" only map to the
first component (i.e. "foo/bar/baz" would always be interpreted as %1
= "foo", and never %1 = "foo/bar"). This would mean that the
"foo/bar/baz" shorthand notation would simply not work against
remote-tracking branch "baz" from remote "foo/bar", but we might say
that's ok, because (a) multi-level remote names are so rare, and (b)
the simple workaround of explicitly saying
"refs/peers/foo/bar/heads/baz" would always be available in any case.


...Johan


[1]: Maybe we could use '%N+' to mean "everything starting from
component #N"? Then we could construct the following dictionary the
shorthand "foo/bar/baz":

  "*" -> "foo/bar/baz"
  "1" -> "foo"
  "1+" -> "foo/bar/baz"
  "2" -> "bar"
  "2+" -> "bar/baz"
etc.

But I really think this is overkill. Avoiding having to write our own
expansion helper is not _that_ important.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
