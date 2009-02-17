From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Tue, 17 Feb 2009 15:55:51 +0200
Message-ID: <94a0d4530902170555l4e3f769wa24513b0ffbdd6a0@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
	 <7vbpt1by1y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 14:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQRt-0002s9-Fw
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZBQNzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZBQNzy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:55:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:25363 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZBQNzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:55:53 -0500
Received: by fg-out-1718.google.com with SMTP id 16so419706fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gFzyBuWXnTJCMAi0H4IKbbPuixnISC2cIA3J5EmhPeA=;
        b=KdAINg7s8yi9bM6Z7Z/PdySGnePs3CkUOU+dpx+y6ZbvLZoz4wkqwvxBrFnYVVOCyv
         PmFZXuxNGifiYMBEzFYoWjS8kOVP6fMSM7rHiJBwMehXrrz8c5htB9iRpCPagx1gb8Nk
         EEdQxlSmpGWzklphy6A6Q9JX3+x9Dyb9heIjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XAlp82aLPz1Orzp0QO53bSxH5sCmrYEgS+6IFydYQjpx7gwnJlvkuQgyJpP92ziTfT
         oAo42atA7YuSpKRW7jjyixViqvE/AHRynyZ3P/fB0JdHsf88Cjpp9vIrNPn8tmt8aC70
         0tIQNrAOtxfDxNzhdsB/5MLgqbinzDVRRFuAY=
Received: by 10.86.71.1 with SMTP id t1mr152266fga.18.1234878951621; Tue, 17 
	Feb 2009 05:55:51 -0800 (PST)
In-Reply-To: <7vbpt1by1y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110381>

On Tue, Feb 17, 2009 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +     if (HAS_MULTI_BITS(actions)) {
>> +             error("only one action at a time.");
>> +             usage_with_options(builtin_config_usage, builtin_config_options);
>
> My initial reaction was:
>
>        Can we easily say "--get and --getall are mutually incompatible"?
>
> and knowing that it would take much more code, the second reaction was:
>
>        Does the user know what we mean by "action"?
>
> Since the answer to this is "Yes, the usage message comes from parseopt
> and there is a clear categorization", I think the message is good enough.
>
> What happens when the user says "config --get --get-colorbool user.name"?
> Is it an error?  Is it diagnosed as an error?
>
> It probably is easy to fix it by defining two bits of fake actions and do:
>
>        if (get_color_slot)
>                actions |= ACTION_GET_COLOR;
>        if (get_colorbool_slot)
>                actions |= ACTION_GET_COLORBOOL;
>
> immediately before this HAS_MULTI_BITS check.
>
> I know I suggested these to are type-like, but I realize that these two
> are better categorized as actions tied to a specific type (color), as you
> had in your earlier round.

All right, done.

>> +     if (actions == 0)
>> +             switch (argc) {
>> +             case 1: actions |= ACTION_GET; break;
>> +             case 2: actions |= ACTION_ADD; break;
>> +             case 3: actions |= ACTION_REPLACE_ALL; break;
>
> Straight assignment, not ORing-in please.  It wastes a few seconds from
> the reader wondering what other bits in the variable "actions" are used
> for things other than ACTION_* (the answer is none).
>
> Similarly, later conditions:
>
>> +     if (actions & ACTION_LIST) {
>
> would read better if they used equality == checks.

Cool, I was worried those where not logical to the reader but I
couldn't think of a better solution... this one looks much better!

I've also made the same change for the 'types' variable in a later patch.

-- 
Felipe Contreras
