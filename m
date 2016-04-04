From: Johan Herland <johan@herland.net>
Subject: Re: What is an efficient way to get all blobs / trees that have notes attached?
Date: Mon, 4 Apr 2016 19:33:38 +0200
Message-ID: <CALKQrgctNZU79rreN1RWEd+KOMNMmMgTce_wV4iCKyNw+TwmWg@mail.gmail.com>
References: <ndljs8$vj3$1@ger.gmane.org>
	<CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
	<CAHGBnuNQYrg70h+mjzDpYyKhHiR6tWx9j989KLO3bW-jC7XmZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:33:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8Ns-0000gZ-H4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbcDDRds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:33:48 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:44383 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcDDRdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:33:47 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1an8Nk-00048s-HY
	for git@vger.kernel.org; Mon, 04 Apr 2016 19:33:44 +0200
Received: from mail-yw0-f178.google.com ([209.85.161.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1an8Nk-000GY5-7a
	for git@vger.kernel.org; Mon, 04 Apr 2016 19:33:44 +0200
Received: by mail-yw0-f178.google.com with SMTP id g3so261900547ywa.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:33:44 -0700 (PDT)
X-Gm-Message-State: AD7BkJI5gOUXDkhgZOqUZRgH69HlcozWz05wh1n1VlS2OoD70dVirKdxBykbdBoEUWPOdD3yR+V49O1Rm9qwXA==
X-Received: by 10.129.29.3 with SMTP id d3mr10881245ywd.190.1459791218225;
 Mon, 04 Apr 2016 10:33:38 -0700 (PDT)
Received: by 10.37.75.133 with HTTP; Mon, 4 Apr 2016 10:33:38 -0700 (PDT)
In-Reply-To: <CAHGBnuNQYrg70h+mjzDpYyKhHiR6tWx9j989KLO3bW-jC7XmZw@mail.gmail.com>
X-Gmail-Original-Message-ID: <CALKQrgctNZU79rreN1RWEd+KOMNMmMgTce_wV4iCKyNw+TwmWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290704>

On Mon, Apr 4, 2016 at 9:46 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Fri, Apr 1, 2016 at 2:16 PM, Johan Herland <johan@herland.net> wrote:
>>> 3) Recursively list all blobs / trees (git-ls-tree) and look whether an
>>> object's hash is conatined in our table to get its notes.
>>>
>>> In particular 3) could be expensive for repos with a lot of files as we're
>>> looking at all of them just to see whether they have notes attached.
>>
>> In (3), why would you need to search through _all_ blobs/trees? Would
>> it not be cheaper to simply query the object type of each annotated
>> object from (2)? I.e. something like:
>>
>> for notes_ref in $(git for-each-ref refs/notes | cut -c 49-)
>> do
>>     echo "--- $notes_ref ---"
>>     for annotated_obj in $(git notes --ref=$notes_ref list | cut -c 41-)
>>     do
>>         type=$(git cat-file -t "$annotated_obj")
>>         if test "$type" != "commit"
>>         then
>>             echo "$annotated_obj: $type"
>>         fi
>>     done
>> done
>
> Thanks for the idea. The problem is that I do want to list the notes
> by path of the object they belong to. As a blob could potentially
> belong to more than one path (copies of files in the repo), I do not
> see another way of getting that information other than iterating over
> all blobs and checking what path(s) they belong to.

True; fundamentally what you want is a blob/tree ID -> path(s) mapping,
which is an independent problem, unrelated to to the initial notes lookup.

I don't know of a solution faster than the brute-force search you already
sketched. If this lookup is important to your use case, you could consider
building/caching the required mapping when the notes are added in the
first place, but I don't know if that is possible in your scenario...


...Johan

> --
> Sebastian Schuberth

-- 
Johan Herland, <johan@herland.net>
www.herland.net
