Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6E81FBB0
	for <e@80x24.org>; Mon, 21 Nov 2016 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbcKUImE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 03:42:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49244 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbcKUImD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 03:42:03 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id uAL8fkkv006790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 21 Nov 2016 09:41:46 +0100
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id uAL8fkvb027439;
        Mon, 21 Nov 2016 09:41:46 +0100
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 14/17] ref-filter: allow porcelain to translate messages in the output
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-15-Karthik.188@gmail.com>
        <af0b7bdc-2b29-0d04-85f1-aa1d5a2ba549@gmail.com>
        <CAOLa=ZRU--FyFWNvv7RGH2mho36hvUu2ye=JOapXZ6QoEy=nRw@mail.gmail.com>
Date:   Mon, 21 Nov 2016 09:41:46 +0100
In-Reply-To: <CAOLa=ZRU--FyFWNvv7RGH2mho36hvUu2ye=JOapXZ6QoEy=nRw@mail.gmail.com>
        (Karthik Nayak's message of "Sun, 20 Nov 2016 21:03:28 +0530")
Message-ID: <vpq1sy58bsl.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 21 Nov 2016 09:41:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: uAL8fkkv006790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1480322506.91902@IsBWfc1yK3Pk1Qws8zYH0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> cc'in Matthieu since he wrote the patch.
>
> On Sat, Nov 19, 2016 at 4:16 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> Introduce setup_ref_filter_porcelain_msg() so that the messages used in
>>> the atom %(upstream:track) can be translated if needed. This is needed
>>> as we port branch.c to use ref-filter's printing API's.
>>>
>>> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>>>  ref-filter.c | 28 ++++++++++++++++++++++++----
>>>  ref-filter.h |  2 ++
>>>  2 files changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ref-filter.c b/ref-filter.c
>>> index b47b900..944671a 100644
>>> --- a/ref-filter.c
>>> +++ b/ref-filter.c
>>> @@ -15,6 +15,26 @@
>>>  #include "version.h"
>>>  #include "wt-status.h"
>>>
>>> +static struct ref_msg {
>>> +     const char *gone;
>>> +     const char *ahead;
>>> +     const char *behind;
>>> +     const char *ahead_behind;
>>> +} msgs = {
>>> +     "gone",
>>> +     "ahead %d",
>>> +     "behind %d",
>>> +     "ahead %d, behind %d"
>>> +};
>>> +
>>> +void setup_ref_filter_porcelain_msg(void)
>>> +{
>>> +     msgs.gone = _("gone");
>>> +     msgs.ahead = _("ahead %d");
>>> +     msgs.behind = _("behind %d");
>>> +     msgs.ahead_behind = _("ahead %d, behind %d");
>>> +}
>>
>> Do I understand it correctly that this mechanism is here to avoid
>> repeated calls into gettext, as those messages would get repeated
>> over and over; otherwise one would use foo = N_("...") and _(foo),
>> isn't it?

That's not the primary goal. The primary goal is to keep untranslated,
and immutable messages in plumbing commands. We may decide one day that
_("gone") is not the best message for the end user and replace it with,
say, _("vanished"), but the "gone" has to remain the same forever and
regardless of the user's config for scripts using it.

We could have written

  in_porcelain ? _("gone") : "gone"

here and there in the code, but having a single place where we set all
the messages seems simpler. Call setup_ref_filter_porcelain_msg() and
get the porcelain messages, don't call it and keep the plumbing
messages.

Note that it's not the first place in the code where we do this, see
setup_unpack_trees_porcelain in unpack-trees.c for another instance.

Karthik: the commit message could be improved, for example:

Introduce setup_ref_filter_porcelain_msg() so that the messages used in
the atom %(upstream:track) can be translated if needed. By default, keep
the messages untranslated, which is the right behavior for plumbing
commands. This is needed as we port branch.c to use ref-filter's
printing API's.

Why not a comment right below "} msgs = {" saying e.g.:

	/* Untranslated plumbing messages: */

>> I wonder if there is some way to avoid duplication here, but I don't
>> see anything easy and safe (e.g. against running setup_*() twice).

I think we do need duplication for the reason above.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
