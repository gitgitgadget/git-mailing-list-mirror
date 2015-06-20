From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Sat, 20 Jun 2015 10:47:13 -0700
Message-ID: <xmqqzj3ujmqm.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434705059-2793-3-git-send-email-charles@hashpling.org>
	<xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
	<20150620165138.GA27488@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Jun 20 19:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6Mrb-0003F9-8x
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 19:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbbFTRrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 13:47:17 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36874 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbbFTRrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 13:47:15 -0400
Received: by igblr2 with SMTP id lr2so31536913igb.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2015 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jwvh7PBgs23NlB9/TNe2cXcg2pxubV23rp7KoTk6yOw=;
        b=WFMan3R1MoMeiHuJgUq+LNNc30hlQ8ys1qQImu4diZtEk2xe4b3vcXL2nVAtKsXt3I
         ck1FTsQKQV69apeIjqms1HGHsFFH1PBoCRHOqKNRsXznm3595HZ0v7OxLou57aH0ZhMk
         MEZxyOJUYrhl6fPmUhth5NvFlmaps5r+13dxa2hOf1BjBDuDsa022zoItwXdj/DPFm7g
         XN2bbW66a4W/c3DovOOk8v+uSI7gVptP0dNi7178WX3Fy67eP5Lx4QmLrJr4mYXDprs1
         KTdL1sEWmY8bsCairtICNhW8IY4UTi0AEO64B6iZis+Ncg6N4qTlFcC53lLhVQsh1foR
         8z7Q==
X-Received: by 10.50.87.38 with SMTP id u6mr4674050igz.39.1434822434797;
        Sat, 20 Jun 2015 10:47:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f44b:8ca4:e732:8441])
        by mx.google.com with ESMTPSA id je2sm3633410igb.8.2015.06.20.10.47.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Jun 2015 10:47:14 -0700 (PDT)
In-Reply-To: <20150620165138.GA27488@hashpling.org> (Charles Bailey's message
	of "Sat, 20 Jun 2015 17:51:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272236>

Charles Bailey <charles@hashpling.org> writes:

> On Fri, Jun 19, 2015 at 10:58:51AM -0700, Junio C Hamano wrote:
>
>> Eh, make that two:
>> 
>>  * We no longer say what value we did not like.  The user presumably
>>    knows what he typed, so this is only a minor loss.
>> 
>>  * We used to stop without giving "usage", as the error message was
>>    specific enough.  We now spew descriptions on other options
>>    unrelated to the specific error the user may want to concentrate
>>    on.  Perhaps this is a minor regression.
>> 
>> I wonder if "expects a numerical value" is the best way to say this.
>
> I was aware that I was changing the error reporting for max-pack-size
> and window-memory but thought that by going with the existing behaviour
> of OPT_INTEGER I'd be going with a more established pattern.

That is OK.  I just wanted to see that design decision explicitly
recorded in the proposed log message.

> Currently git package-objects --depth=5.5 prints:
>
>     error: option `depth' expects a numerical value
>     usage: git pack-objects --stdout [options...
>     [... many more lines omitted ...]

Interesting.  I get this instead:

    git: 'package-objects' is not a git command. See 'git --help'.

;-)  Jokes aside...

> Obviously, changing this to skip the full usage report would affect many
> existing commands.

Yes and I wouldn't suggest changing that in the same commit that
exposes the human-readable quantity parsing to parse-options API.
That is why I said "Perhaps this is a minor regression".  It is a
change in behaviour, and it may make it slightly worse, but on the
other hand it makes it in line with other types of options, so it
may be OK.

If we wanted to teach commands to omit "usage" when parsing of a
single option failed, we should be doing that consistently for
everybody, not just to pack-objects, and that is outside the scope
of this patch, I would think.

	Side note: Just to make it clear, regarding anything I say
	is "outside the scope of this patch", I am not asking you to
	do them as follow-up patches (as a precondition to accept
	this patch).  For that matter, I am not convinced myself
	that some of them are even worth doing.  And I am not asking
	you _not_ to do these changes, ever, either.  I am just
	asking you _not_ to do any of them in _this_ patch.

> Also, I preserved the PARSE_OPT_NONEG flag for OPT_ULONG but would this
> ever not make sense for an OPT_INTEGER option?

It depends on what "git cmd --depth=4 --no-depth" should do.  In any
case, changing OPT_INT would be a separate topic outside the scope
of this patch, I think.

My gut feeling is that

    git pack-objects --max-pack-size=20m --no-max-pack-size

should be usable as a way to countermand a pack size limit given
earlier on the command line to make it unlimited, but that is
definitely a separate topic outside the scope of this patch (whose
purpose is to make an existing callback available to other callers).
