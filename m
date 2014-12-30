From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 16:15:10 -0500
Message-ID: <CAPig+cS0RYgmMzhkgMj=G939DADNG29dPQP2BQJQxVYS5d6ThQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
	<CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
	<CAGZ79kYds-oo-Q0=R6ny=CpZ3ja0__6CDm-wmamnSp3TBWcKdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y648O-0000N0-6I
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 22:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaL3VPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 16:15:12 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:39890 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3VPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 16:15:11 -0500
Received: by mail-yk0-f182.google.com with SMTP id 131so7417541ykp.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 13:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DsabkhXkIyCW4YqSgCFC42N+e29LHVMOqABq1tQLb5Y=;
        b=TpqpJp7rm76TxBUXF9qQzeL9DbrKpt/DTrLY5nHbhKdEfzRJ5xi+GSsWrd7tqNIQhe
         IdzhQ/2FibIDnX34yN26naK2q6xZac+PDqUwtAPJeOvisA6AzCjC5+39zVBaMSrHPjBl
         By1L604hJdd5OtotsOBrqOLA841pJIp4jdpl44tDQZPj/mqjTNHs0TDHvsxDqZ09U5gp
         JPRl+8/hlkK1FG+DQk3ng24KNZ5XIWknOLkf/rqE6oRlH5YwQtcMNSk93z0RgC3f0wwl
         y6ywXYWY5NKM7/tQN8GUgPQrZtBgaI3yRlsyVz74Xtt2HCuS7Q6eANdxLXUAUEhCjx00
         jHNg==
X-Received: by 10.170.127.5 with SMTP id t5mr29544688ykb.2.1419974110782; Tue,
 30 Dec 2014 13:15:10 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 13:15:10 -0800 (PST)
In-Reply-To: <CAGZ79kYds-oo-Q0=R6ny=CpZ3ja0__6CDm-wmamnSp3TBWcKdQ@mail.gmail.com>
X-Google-Sender-Auth: n0nVQKpNJbe78QffvWN_6y2f-OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261947>

On Tue, Dec 30, 2014 at 3:33 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Dec 29, 2014 at 10:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +static int should_process_cmd(struct command *cmd)
>>> +{
>>> +       if (cmd->error_string)
>>> +               return 0;
>>> +       if (cmd->skip_update)
>>> +               return 0;
>>> +       return 1;
>>
>> Alternately, depending upon the polarity of your brain, you could
>> collapse the entire function body to:
>>
>>     return !cmd->error_string && !cmd->skip_update;
>>
>> or:
>>
>>     return !(cmd->error_string || cmd->skip_update);
>
> I did not want to change the structure of the code when moving it around as
> you noted in another email that helps on reviewing.
> And having the exact same conditions in an if and then return instead
> of continue
> makes me think it is easier to review than if I also introduce that shortening?
> I can do so in a follow up.

It's a judgment call. When composing this review, I actually had a
parenthetical comment here saying that collapsing the body of the
function (as illustrated above) could be done as a patch separate from
the code movement, but I removed the comment just before sending the
email. This is such a simple change that the cognitive overhead from
combining the code movement and simplification is so slight that it
doesn't necessary warrant burdening reviewers with yet another patch.
Therefore, although I very slightly favor splitting it into two
patches, in this particular case, a single patch is not a great
burden, so I don't feel strongly one way or the other. Use your best
judgment.

>>> +}
>>> +
>>> +static void check_shallow_bugs(struct command *commands,
>>> +                              struct shallow_info *si)
>>> +{
>>> +       struct command *cmd;
>>> +       int checked_connectivity = 1;
>>> +       for (cmd = commands; cmd; cmd = cmd->next) {
>>> +               if (!should_process_cmd(cmd))
>>> +                       continue;
>>> +
>>> +               if (shallow_update && si->shallow_ref[cmd->index]) {
>>
>> Here, inside the loop, you check 'shallow_update'...
>>
>>> +                       error("BUG: connectivity check has not been run on ref %s",
>>> +                             cmd->ref_name);
>>> +                       checked_connectivity = 0;
>>> +               }
>>> +       }
>>> +       if (shallow_update && !checked_connectivity)
>>
>> And here, after the loop, you check 'shallow_update'.
>>
>> But, if you examine the overall logic, you will find that this
>> function does _nothing_ at all when 'shallow_update' is false (other
>> than uselessly looping through 'commands'). Therefore, either check
>> 'shallow_update' just once at the beginning of the function and exit
>> early if false, or have the caller check 'shallow_update' and only
>> invoke check_shallow_bugs() if true.
>
> That's a good idea. I'll definitely add that. But as said above, I
> also feel that this
> should rather go in a follow up patch as it twists the logic and this
> patch is all
> about moving the code.

Here, too, when composing the review, I had a parenthetical comment
stating that this improvement to the code might warrant a followup
patch after the code movement patch. However, this case is a bit
different because the combined code in the new function, although not
actively wrong, is uselessly iterating a do-nothing loop when
'shallow_update' is false, and even though not actively incorrect, it
_feels_ weird to commit such pointless code, only to fix it up later.
Due to that "weird" feeling, I didn't feel entirely comfortable
recommending splitting the change into two patches, so I removed the
comment before sending the email. Hence, this again is judgment call.
Try to find a balance which feels right, while taking the review
process into consideration.
