From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv10 01/10] receive-pack.c: shorten the execute_commands
 loop over all commands
Date: Mon, 5 Jan 2015 13:18:03 -0800
Message-ID: <20150105211803.GM29365@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
 <1420482355-24995-1-git-send-email-sbeller@google.com>
 <20150105202244.GL29365@google.com>
 <CAGZ79kbRLPYRw+iifigRHqJ5Lc1brQ3qkUV=4YYPSwr72+giPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 22:21:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8F2U-0005Fs-2L
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 22:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbbAEVSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 16:18:08 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:56493 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbbAEVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 16:18:06 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so3185428igb.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Lr3Hm+Za0OfeDZ0yCwebuSa1P70LiyEttFNycwcNdR4=;
        b=LNMyD40Gg97K+vYP1lL8jZifAAKALA3ImCGYtMCuM2oCkkakylibtQkl+YqKxyIR6l
         GJ/qa8DHGhOvhIvxjXO7glV+Pdhw6dBTkg3D2DCNJWv0/1SApStHhICLX2g1knsDVL17
         h7I6djaXIcViC5iGesRzta/+zmSqxCya9Ens0kVI2K2pJvAWjFqaStRzQIgjLB3NVPfV
         XFmCrEdZwC7+jFXPegAYEi9uKWaT84lHSw2jl/wphj1xvEXBkSbHAqVwj2f95WVBfU99
         D8yFQRKsG8hOfQ+NVCZW++gBxXlw0iYzSWDe7IBj9judGR0cXajhk87MWiNgTRzWtooL
         sVbw==
X-Received: by 10.107.150.137 with SMTP id y131mr83112052iod.11.1420492686283;
        Mon, 05 Jan 2015 13:18:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cbe:c7db:3064:452c])
        by mx.google.com with ESMTPSA id j139sm26970223ioe.20.2015.01.05.13.18.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 13:18:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRLPYRw+iifigRHqJ5Lc1brQ3qkUV=4YYPSwr72+giPg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262035>

Stefan Beller wrote:
> On Mon, Jan 5, 2015 at 12:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:

>>> --- a/builtin/receive-pack.c
>>> +++ b/builtin/receive-pack.c
>> [...]
>>> @@ -1077,27 +1100,15 @@ static void execute_commands(struct command *commands,
>> [...]
>>> +     if (shallow_update)
>>> +             assure_connectivity_checked(commands, si);
>>
>> Looking at this code alone, it seems like assure_connectivity_checked()
>> is going to ensure that connectivity was checked, so that I can assume
>> connectivity going forward.  But the opposite is true --- it is a
>> safety check that prints a warning and doesn't affect what I can
>> assume.
>
> I disagree on that. Combined with the next patch (s/error/die/) we can assume
> that the the connectivity is there as if it is not, git is dead.
>
> This is why I choose the word assure.

If this patch depends on the next one, would it make sense to put them
in the opposite order?

>> The factored-out function fails in what it is meant to do, which is to
>> save the reader of execute_commands from having to look at the
>> implementation of the parts they are not interested in.
>>
>> Would something like warn_if_skipped_connectivity_check() make sense?
>
> The next patch would then change this to die_if_... ?
> I'd be ok with that, but in your original email you would still have the last
> die(...) in the execute_command function which I dislike.
> So what about:
>
> if (shallow_update)
>        (warn|die)_on_skipped_connectivity_check()
>
> ?

My personal preference would be to refactor the preceding code to make
the check unnecessary.

But aside from that, anything that makes the code clearer is fine with
me.  I find ..._if_... clearer than ..._on_... here because it seems
more obvious that it is not an expected condition (i.e., it's a kind
of abbreviation for

	warn_if_skipped_connectivity_check_which_should_never_happen()

) but that's a more minor detail.  An alternative way to make the code
clearer would be to use a comment.

Thanks,
Jonathan
