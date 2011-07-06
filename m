From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line options
Date: Wed, 6 Jul 2011 16:50:14 +0530
Message-ID: <CALkWK0=gm-y3CB83TsSiWWF4qyS5hOJDhOYCz4HTWyT7iHP6MA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com> <20110706090915.GD15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:20:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQ9p-0007ST-Az
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab1GFLUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:20:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58194 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab1GFLUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:20:36 -0400
Received: by wyg8 with SMTP id 8so4591373wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gwHeajnxPFAapDgLFzBW1APcIMY/9hIuuHTdPzDwx+8=;
        b=gFbK8813Q4rUigiosicjtxolnPOKbmPMuZoZxh92W72dw7UPZ587ODWaXgALXrFcHI
         bp+h3+Flx9o8jHi9d1O0bRMuhN/ikyv4xMUABgRY9p2mxsgxrZOnju29pBir3vVChu46
         2mmdSyoTjRB90PBe/W0B8/uoqXIobfI2htfrU=
Received: by 10.216.62.3 with SMTP id x3mr5315777wec.77.1309951235146; Wed, 06
 Jul 2011 04:20:35 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:20:14 -0700 (PDT)
In-Reply-To: <20110706090915.GD15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176689>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> In later
>> steps in this series, we would like to introduce an API function tha=
t
>> calls into this machinery directly and have a way to tell it what to
>> do. =C2=A0Hence, introduce a structure to group these variables, so =
that
>> the API can take them as a single replay_options parameter.
>>
>> The variable "me" is left as a file-scope static variable because it
>> is not an independent option. =C2=A0"me" is simply a string that nee=
ds to
>> be inferred from the "action" option, and is kept global to save eac=
h
>> function the trouble of determining it independently.
>
> Hm, would it make sense for there to be a "private" section at the
> end of the replay_opts struct for variables like this?

No.  My justification: in later steps, we'd want to be able to mix
"pick" and "revert" instructions in the same instruction sheet.  This
will essentially require the parser to return a commit + a replay_opts
struct (which will contain the action information).  There's little
point in storing 100 "revert" strings for the 100 commits we want to
pick when that can easily be inferred from the action.

>> Unfortunately, this patch introduces a minor regression. =C2=A0Parsi=
ng
>> strategy-option violates a C89 rule: Initializers cannot refer to
>> variables whose address is not known at compile time. =C2=A0Currentl=
y, this
>> rule is violated by some other parts of Git as well, and it is
>> possible to get GCC to report these instances using the "-std=3Dc89
>> -pedantic" option.
>
> I would be interested in fixing that (as a patch on top, maybe).
> What do you suggest:
>
> =C2=A0A. Apply patch 8 and make cmd_revert, cmd_cherry_pick, and pars=
e_args
> =C2=A0 =C2=A0manipulate a static "struct replay_opts" while pick_comm=
its et al
> =C2=A0 =C2=A0pass around a pointer to it
>
> =C2=A0B. Make parse_args work like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0copy from argument to private static struc=
t replay_opts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0call parse_options()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0copy private static struct replay_opts to =
argument

This is something you suggested earlier, but I find it extremely ineleg=
ant.

> =C2=A0C. Use new option types:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOL_MEMBER('n', "no-commit",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(struc=
t replay_opts, no_commit),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"don't automat=
ically commit"),
>
> =C2=A0 =C2=A0and teach parse_options to take an additional parameter =
like it
> =C2=A0 =C2=A0takes "prefix" now, to be used as a base address for opt=
ions that
> =C2=A0 =C2=A0write to an offset instead of a pointer
>
> I'm leaning towards A but not sure if that would be wasted work in
> light of your plans for these APIs in the long run (i.e., is
> parse_args() going to be exposed and want to act on a caller-supplied
> struct)?

Yes, I'm definitely considering exposing parse_args in the future,
especially since I want to support command-line options in my
instruction sheet.  Implementing (C) correctly will probably have
several long-term benefits as well -- what do you feel about it?

-- Ram
