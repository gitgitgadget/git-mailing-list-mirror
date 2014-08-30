From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Fri, 29 Aug 2014 19:59:32 -0700
Message-ID: <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com> <20140829220818.GA24834@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 04:59:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNYtS-0003P9-93
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 04:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbaH3C7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 22:59:54 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53590 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaH3C7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 22:59:53 -0400
Received: by mail-ie0-f179.google.com with SMTP id tr6so3789368ieb.10
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DuU2oi9N9Z5ODMpOjsLjkXmrYt3LpDBwglRKT5CHChk=;
        b=aoSSj5optQOFfKxwyDcvJkRU8/OCVLoaFiA28aqe84oe2xIdq9kYj7bkiDVqDZXXeI
         3LEfBxRbHCZNbpUCGKfGPCq/000bcxhdQN3mk1MVPHzNkxqLjjycA6nTiyX16xpvs/UK
         rhh7/T+s4lrvMm8Hz0QZYXgBuYO7I9v8jbsI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DuU2oi9N9Z5ODMpOjsLjkXmrYt3LpDBwglRKT5CHChk=;
        b=NJFxFy0EReVYn9Mk7zK7lnCN4xx8pR9oOi6Ba2DgQ8oeP9AnGgK+dFUUFt+q6MYiJU
         Mvrag8pyGy//TOKEO+qKOLW882Ah4yL7I4fhhB9OAw3WNsneJGMO01kQof3+Kdl28frc
         s0iB4UDApg1nnYqhIHGZK0+2pR9vwkdbiWxnAl5Y3zP92XAZSQ/tEVHU0rmqzSZ+78NV
         QN/e90mBEsRH/ZB6dksKNfb/GWGl45ah4Pu3qwyuo4TX0WGtkvZ114ZYMGXhv1G35Sir
         hG35OBfncFVYryPeKJnwFLwcud0prAz84jaubDG6bOxL6Zc28djSegPc4RfcXitSNqel
         7nag==
X-Gm-Message-State: ALoCoQnFj7XZzdBEBPSkja1ieFzCCgk+PT6N6ilRkaIL4b5UyC4LshexvnAQ/UwmvQT45VmYMOKr
X-Received: by 10.50.1.37 with SMTP id 5mr8224313igj.47.1409367592693; Fri, 29
 Aug 2014 19:59:52 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Fri, 29 Aug 2014 19:59:32 -0700 (PDT)
In-Reply-To: <20140829220818.GA24834@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256206>

On Fri, Aug 29, 2014 at 3:08 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 29, 2014 at 02:56:18PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > If a pack contains duplicates of an object, and if that
>> > object has any deltas pointing at it with REF_DELTA, we will
>> > try to resolve the deltas twice. While unusual, this is not
>> > strictly an error, but we currently die() with an unhelpful
>> > message.
>>
>> Hmm, I vaguely recall Shawn declaring this as an error in the pack
>> stream, though.
>
> I agree it is probably a bug on the sending side, but I think last time
> this came up we decided to try to be liberal in what we accept.  c.f.
> http://thread.gmane.org/gmane.comp.version-control.git/232305/focus=232310

IIRC they aren't valid pack files to contain duplicates.

Once upon a time JGit had a bug and android.googlesource.com returned
duplicate objects in a Linux kernel repository. This caused at least
some versions of git-core to fail very badly in binary search at
object lookup time or something. We had a lot of users angry with us.
:)

I know Nico said its OK last year, but its really not. I don't think
implementations are capable of handling it.
