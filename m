From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] blame: add support for --[no-]progress option
Date: Thu, 10 Dec 2015 02:43:14 -0500
Message-ID: <CAPig+cS8BwYboyRcEGPkGQm3nNvUrz9rf8HNuFyEdF83jXvi6Q@mail.gmail.com>
References: <1448426165-5139-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTQdnrHZWJDD6fqu_mQSJQv3oTz9_0Cu8j1aksUiq0FbQ@mail.gmail.com>
	<CAOc6etYM5NA8sPw49yioa9u3SwvDB-w4mcWzrLaR3FkFdNGoJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 08:43:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6vsm-00038w-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 08:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbbLJHnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 02:43:17 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34406 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbLJHnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 02:43:16 -0500
Received: by qgeb1 with SMTP id b1so127472971qge.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 23:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qefnU5RYiOA+PxrJTLWU+GeM6afpg+wMFzgLs3CPVTo=;
        b=022VJdaRhEVxBbxGtOYZ36jP/eL/Llo81q7hFsAUyNIO9QA4IHM0atGvRTBz1GdfGS
         eAkolSEtBfsS3UHB/JtZt1USBdaSy344RFjNvlSzJBiF/soAKXNq/u57PRE05GecBHXw
         UPjPbC5AJeFBKShjol9/MwhZQAq1//akTVGoVPs7kDqThJy5k67WBH1Zwh5geemoXfHl
         dAzermdKEzfVtd2tjUlGdIJ9aV4aFEXolvMchWoeObjOCIzXOVF3JT+H1YdXn9ZwAm/h
         8vdseYVaVsvQvZSPfd7LL/a075h3cdtqHQs/0Vj/FndLPx+LgZRCQ7yj1285ny7aBjla
         mqMw==
X-Received: by 10.31.13.205 with SMTP id 196mr9196992vkn.37.1449733394356;
 Wed, 09 Dec 2015 23:43:14 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 9 Dec 2015 23:43:14 -0800 (PST)
In-Reply-To: <CAOc6etYM5NA8sPw49yioa9u3SwvDB-w4mcWzrLaR3FkFdNGoJA@mail.gmail.com>
X-Google-Sender-Auth: BlHCJIt-mLJR0OaalQa7Eb5bVi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282213>

On Wed, Dec 9, 2015 at 11:20 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Tue, Dec 8, 2015 at 2:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Nov 24, 2015 at 11:36 PM, Edmundo Carmona Antoranz
>> <eantoranz@gmail.com> wrote:
>>> +--[no-]progress::
>>> +       Progress status is reported on the standard error stream
>>> +       by default when it is attached to a terminal. This flag
>>> +       enables progress reporting even if not attached to a
>>> +       terminal. Progress information won't be displayed if using
>>> +       `--porcelain` or `--incremental`.
>>
>> Is silently ignoring --progress a good idea when combined with
>> --porcelain or --incremental, or would it be better to error out with
>> a "mutually exclusive options" diagnostic? (Genuine question.)
>
> I think it makes sense (and so it's documented so people can know what
> could be going on but detecting mutually exclusive options and
> erroring out could also make sense. Who could give some insight?

It's a bit difficult to imagine a case when --progress would make
sense with --porcelain or --incremental, so I'd probably opt for
emitting a "mutually exclusive" diagnostic to inform the user
explicitly that the combination is nonsensical.

>> Overall, use of malloc/free for the progress_info struct seems to
>> makes the code more complex rather than less. It's not clear why you
>> don't just use a 'struct progress_info' directly, which would lift the
>> burden of freeing the allocated structure, and allow you to drop the
>> conditional around stop_progress() since NULL progress is accepted. In
>> other words, something like this (completely untested):
>>
>>     struct progress_info pi = { NULL, 0 };
>
> I like it! I'll adjust to not use the pointer.
>
>>     if (show_progress) {
>>         pi.progress = start_progress_delay(...);
>>     ...
>>     found_guilty_entry(ent, &pi);
>>     ...
>>     stop_progress(&pi.progress)
>>
>> which is more concise and less likely to leak resources. The code
>> within found_guilty_entry() is also simplified since you can drop the
>> "if (pi)" conditional entirely. This works because it's safe to call
>> display progress with NULL):
>>
>>     pi->blamed_lines += ent->num_lines;
>>     display_progress(pi->progress, pi->blamed_lines);
>
> Officially, I think not a single line of the patch survived. :-D

Adding Helped-by: footers before your Signed-off-by: is a way to
acknowledge those who've helped shape the patch if you feel that such
assistance had significant value.
