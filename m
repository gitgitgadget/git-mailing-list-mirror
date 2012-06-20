From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Wed, 20 Jun 2012 09:38:15 -0400
Message-ID: <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
	<7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
	<CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
	<20120619135814.GA3210@sigill.intra.peff.net>
	<CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 15:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShL6y-0006ET-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 15:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab2FTNiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 09:38:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49316 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab2FTNiP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 09:38:15 -0400
Received: by yenl2 with SMTP id l2so5176952yen.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2PKNqDV0zl+OBg4obZNDGeyZFwwZx5DiVX2EGCULj3w=;
        b=NOlmV+7vgDmPvjnVkPeq5cQh0Hwjj07mi0rw9ecyxpZ7R5ClzR5ElGVuWxC2cFOh23
         9F3m7X9RQOJGAC2q5W6cKgsusgbdw4AsFvD37YXw43Qx1f0520Q82lEHMK5BpLWbX9+9
         Rnv4tzyAlJzdY31QwxgLxqfzzCp406XFQ/NjxqwoHuYM+WnjmstHL7MbyX0ynrgAaaZ5
         yw0/Uwg3NCwqy4eX7DcdZuahy/eQ9WKRqVHX7YfHdB4RJ2NKxPws1+yvKyhtqpFD7NFP
         K0HM/1KyHQXoNVZYAdo4BxpYYhMjBkJmk5Gp8oQLCnEQUQEzjsuiQY51UniEoY+onXFg
         lxDQ==
Received: by 10.50.236.71 with SMTP id us7mr4534027igc.16.1340199495090; Wed,
 20 Jun 2012 06:38:15 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Wed, 20 Jun 2012 06:38:15 -0700 (PDT)
In-Reply-To: <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200297>

On Tue, Jun 19, 2012 at 12:47 PM, Tim Henigan <tim.henigan@gmail.com> w=
rote:
> On Tue, Jun 19, 2012 at 9:58 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Jun 19, 2012 at 09:05:40AM -0400, Tim Henigan wrote:
>>
>>> As a side note, I found that these tests fail if a relative path is
>>> used for the file in 'non/git'. =C2=A0In other words, this passes:
>>>
>>> =C2=A0 =C2=A0 test_expect_code 0 git diff --quiet a
>>> "$TRASH_DIRECTORY/test-outside/non/git/matching-file"
>>>
>>> but this fails:
>>>
>>> =C2=A0 =C2=A0 test_expect_code 0 git diff --quiet a ../non/git/matc=
hing-file
>>>
>>> This surprised me, but I have not investigated any further.
>>
>> The problem is that path_outside_repo in diff-no-index.c does not bo=
ther
>> handling relative paths at all, and just assumes they are inside the
>> repository. This is obviously not true if the path starts with "..",=
 in
>> which case you would need to compare the number of ".." with the cur=
rent
>> depth in the repository.
>>
>> prefix_path already does this (and is what generates the later
>> "../non/git/matching-file is not in the repository" message). We cou=
ld
>> perhaps get rid of path_outside_repo and just re-use prefix_path's
>> logic, something like (not tested):
>
> With your patch applied, I was able to use relative paths in my tests=
=2E
> =C2=A0I also confirmed that all the t4*.sh tests pass.
>
> For what its worth, your patch looks correct to me. =C2=A0Existing
> consumers of 'prefix_path' should get the same results as before and
> the one added xmalloc is paired with a free.

Jeff,

Are you planning to send this patch to the list?  If not, can I
include it as 1 of 2 before my patch?  If we go that route, I'm not
sure how to properly show you as the author...

Also, in an earlier email [1] you mentioned that it may be a good idea
to rename 'found_changes' to something like 'xdiff_found_changes'.  I
like the idea...I could submit this change as another patch in the
series, if you have no objections.

Thanks again for your review and help.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/200160/focu=
s=3D200163
