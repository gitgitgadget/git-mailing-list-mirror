From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 2/2] check-ignore.c: fix segfault with '.' argument from
 repo root
Date: Tue, 19 Feb 2013 19:07:13 +0000
Message-ID: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
	<1361282783-1413-1-git-send-email-git@adamspiers.org>
	<1361282783-1413-2-git-send-email-git@adamspiers.org>
	<7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sXX-0003YN-Os
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 20:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934208Ab3BSTHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 14:07:16 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:49699 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459Ab3BSTHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 14:07:13 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so7245825oag.28
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=sP2Kw5gH02ksvRM9C1wz55a3KsijLdzfbwW0YPe0k1M=;
        b=uTHnxi7D/JXdg5stN3DyuJwnWM2DtoRJurDU0+YukKS2l/a0gGIHVaMXjoG79huZEF
         +WUm9YJxicHacI+jRREd7zNMqu9MWAUu/EXyNp3KqXK6Rf7rRTWf9TDUVJ7PmsGTmlJW
         GjtfCYw9TueeUekvqua2Ygs+KmokDGu/XVnVbvhN2xb5NoRK0mfkaM9OxL99KZeHyU4M
         oDiDAcMKdeFV6ZO3Y0+tB5Gv5eYKYDjF957cC7aZNCil0MHyC5wetKEOa9gz1rGJVzLP
         PdVmsW+k/Muzj5UFxVVxJElZnyS1fGuzCIin7mWTCGQjk3SYGcEaDeNLpI1NUw1HVHIR
         e32A==
X-Received: by 10.182.190.19 with SMTP id gm19mr8006128obc.34.1361300833169;
 Tue, 19 Feb 2013 11:07:13 -0800 (PST)
Received: by 10.182.122.106 with HTTP; Tue, 19 Feb 2013 11:07:13 -0800 (PST)
In-Reply-To: <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: gsZlegB-u_gBnTmKkhPdgFqA7nU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216648>

On Tue, Feb 19, 2013 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> Fix a corner case where check-ignore would segfault when run with the
>> '.' argument from the top level of a repository, due to prefix_path()
>> converting '.' into the empty string.  It doesn't make much sense to
>> call check-ignore from the top level with '.' as a parameter, since
>> the top-level directory would never typically be ignored, but of
>> course it should not segfault in this case.
>>
>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>> ---
>
> Please step back a bit and explain why the original had check for
> path[0] in the first place?

I can't remember to be honest.

> If the answer is "the code wanted to special case the question 'is
> the top-level excluded?',

Yes, I think that's the most likely explanation.  Maybe it got missed
in a variable renaming refactoring.

> but used a wrong variable to implement the
> check, and this patch is a fix to that", then the proposed commit
> log message looks incomplete.  The cause of the segv is not that
> prefix_path() returns an empty string, but because the function
> called inside the "if" block was written without expecting to be fed
> the path that refers to the top-level of the working tree, no?
>
> While this change certainly will prevent the "check the top-level"
> request to last-exclude-matching-path, I have to wonder if it is a
> good idea to force the caller of the l-e-m-p function to even care.
>
> In other words, would it be a cleaner approach to fix the l-e-m-p
> function so that the caller can ask "check the top-level" and give a
> sensible answer (perhaps the answer may be "nothing matches"), and
> remove the "&& path[0]" (or "&& full_path[0]") special case from
> this call site?

Yes, that did cross my mind.  I also wondered whether hash_name()
should do stricter input validation, but I guess that could have an
impact on performance.

> The last sentence "It doesn't make much sense..." in the proposed
> log message would become a good justification for such a special
> case at the beginning of l-e-m-p function, I would think.

Fair enough.  I'll reply to this with a new version.[0]

[0] I wish there was a clean way to include the new version inline,
    but as I've noted before, there doesn't seem to be:

    http://article.gmane.org/gmane.comp.version-control.git/146110
