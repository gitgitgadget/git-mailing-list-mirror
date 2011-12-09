From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Fri, 9 Dec 2011 11:27:18 +0530
Message-ID: <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com> <20111207070223.GC11737@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 06:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYtSv-0006H7-BI
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 06:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab1LIF5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 00:57:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50769 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1LIF5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 00:57:40 -0500
Received: by wgbdr13 with SMTP id dr13so4972627wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=g/wp220GmWOjccaIH/N6mbj+e7763nSm/T5vQvAYyg0=;
        b=pMsrW2gOSx8oVln+ZnvSE8he3JTVeGiv0cK0YZ6V2UfBy5exJqK9kZZogqKFdZVEvC
         vfJayZYuxVJH7k4eJUKJUTyi3pWPbuTShwc0L/1kyovwhhqms8BzPoxzs25GXMvggP0V
         FEFMEEXAbooC+hn2uHDiYUyKGowfi315ve9K4=
Received: by 10.227.209.9 with SMTP id ge9mr6049709wbb.1.1323410259315; Thu,
 08 Dec 2011 21:57:39 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 21:57:18 -0800 (PST)
In-Reply-To: <20111207070223.GC11737@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186610>

Hi again,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> [...]
>> While at it, also fix a bug: currently, we use a commit-id-shaped
>> buffer to store the word after "pick" in '.git/sequencer/todo'. =C2=A0=
This
>> is both wasteful and wrong because it places an artificial limit on
>> the line length. =C2=A0Eliminate the need for the buffer altogether,=
 and
>> add a test demonstrating this.
>
> Reading the above does not make it at all obvious that I should want
> to apply this patch because otherwise my prankster friend can cause m=
y
> copy of git to crash or run arbitrary code by putting a long commit

Working backwards:
get_sha1() is what will finally misbehave: how?  It uses strlen() and
let's assume that the number returned by it is too big to fit in a
size_t.  Surely, this means that we should only use get_sha1() on
something whose length is bounded.  So, do we ever try to get to the
end of the line?  Yes!  Let's assume that the problem starts when
end_of_object_name calls strcspn which returns something too big to
fit in a size_t.  From the manpage it has no standard way of reporting
failure.  I'm not sure what to do; I think I have two choices:
1. Implement the strscpn() using two strchrnul() calls.
2. Drop this patch and use strbuf to replace the fixed-size buffer.

I think I'll go with the second option.  What do you think?

-- Ram
