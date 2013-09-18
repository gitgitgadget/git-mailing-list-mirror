From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Wed, 18 Sep 2013 09:22:42 +0700
Message-ID: <CACsJy8CwtiJPLoFxts2NANH+i0ZoXcWSyS2qZC_zOx=WME2FkQ@mail.gmail.com>
References: <5236FBEA.80909@gmx.de> <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
 <vpqvc1z6eoo.fsf@anie.imag.fr> <CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
 <CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com> <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 04:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7QX-00052b-9r
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab3IRCXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:23:32 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37241 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3IRCXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:23:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so6750680obc.34
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fIhYQVLyYjz6cLm87lTvw827aS8zcijsPmzsUTmAmKs=;
        b=l/rCesDA1KZxYEfo91o5j7Yigy3wlxqq8plkJ3lIrzZ7zkqhP9Qnum10hew9uECliI
         VPZKcdTsstRz8IkKWH7Mikc/PyfraBI2Nin49E+A/pdc94No7YPV1m6E8YHLgzbvSXXA
         ru4KnKUQKnIHO7Jw8fupIozGFoe0WYwyCk8hBivd+DTOxzlfbjEiTdFtlN8JIwevnxLM
         Rz9nwPc6hPM7y5SX5ZoLa5OrN3VqX1taPSJEqvBhPuqXBRptejpeSc6o4rRoxrqx8Kdl
         1IoID6TuyUwVp/KWP9vEEvMFjINdpc6ZOMxI4a5G2fZ9kGad/CBR23E5NU3k2/PlPG/6
         DnRg==
X-Received: by 10.60.60.105 with SMTP id g9mr32345001oer.8.1379470992809; Tue,
 17 Sep 2013 19:23:12 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Tue, 17 Sep 2013 19:22:42 -0700 (PDT)
In-Reply-To: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234940>

On Wed, Sep 18, 2013 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Interaction with "git grep --depth"
>
> I am not sure how that affects anything.  Conceptually, isn't
> "--depth" an independent axis to filter out paths that have too many
> components after given positive pathspec elements?  E.g. given
>
>         git grep --depth=2 pattern -- A B/C
>
> we will grab paths from two levels starting at A and B/C (so A/1/2
> and B/C/1/2 may hit but not A/1/2/3 nor B/C/1/2/3).  Shouldn't
> negative pathspecs just filter that depth filtering, i.e. if you
> have ":(exclude)*/1/*", even though both "A/1/2" and "A/a/b" may
> pass the --depth=2 filter, the former is excluded while the latter
> is not.

Implementation details leaked into the design thoughts. I was worried
that the qsort() in pathspec() might make it incompatible with the
:(exclude). Or I was thinking that --depth should be part of this new
filter.. Never mind.

>> Syntax. I guess --ignore (or --exclude) is more intuitive than
>> ":(exclude)something" but then it might collide with existing options
>> (I did not check if --ignore or --exclude is used anywhere though).
>> The latter also enables combining with other filters, such as
>> case-insensitive matching..
>
> I do not think it is an option to do this with any mechanism other
> than negative pathspecs.

Under the hood, a new pathspec magic must be introduced (else we can't
pass them from "git add -u" to git-add--interactive then some other
commands that take pathspec). So --exclude would be transformed to the
pathspec magic, similar to "git grep --depth". But we could add that
later if :(exclude)something is too long to type.
-- 
Duy
