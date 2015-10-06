From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Tue, 6 Oct 2015 15:30:29 -0400
Message-ID: <CANoM8SX6U0fdoUtemiaoxYErAKx0MfEf+N9UR7aDip2g=QA8+Q@mail.gmail.com>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com> <561339C1.704@web.de>
 <xmqqd1wswnfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:30:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjXwt-0005Fj-5n
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbbJFTau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 15:30:50 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36165 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbJFTat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 15:30:49 -0400
Received: by vkfp126 with SMTP id p126so124075469vkf.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=O89Jv7bqffeLI1Zdh0ZF67ZrzEo8CyRU8fBVULkozzA=;
        b=JYfUYmS25xAu43A0BzUtvjyYr7ca5w2rbd8vS2wnGUTVNqUqqJSFL5amA7KvqtjpSc
         NwZR52+et3+Daeu5ScbQw0o+BJNmx8hDxoDtBLoR2u6EqgdrAo+tEkECRifOkRe2JSGe
         n61fbcPKuTcWldRYDJXdFzE6hvHiHqA9AzxqEYhhkulvamehaqkieUCH0rpXSALki9Vs
         zeStf6I6OI3aLRV2VfdWkNQisV2Y+jJF5VeiWaXaJ0imKQ9F74h5ebP5apXVWQp+2wla
         j1L0G+FV53q34GYMWes5ydWIOcrBB5hB/S82llK/jvuxXJGQBidkgJMr4XiVVqlxfw16
         l/+Q==
X-Received: by 10.31.158.205 with SMTP id h196mr26062505vke.11.1444159848911;
 Tue, 06 Oct 2015 12:30:48 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Tue, 6 Oct 2015 12:30:29 -0700 (PDT)
In-Reply-To: <xmqqd1wswnfe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279161>

On Tue, Oct 6, 2015 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Minor comment from my compiler:
>>
>> worktree.c:181: warning: assuming signed overflow does not occur whe=
n assuming
>> that (X + c) > X is always true
>
> Thanks; I think the allocation in that function (the use it uses
> ALLOC_GROW()) is somewhat bogus.
>
> It does this:
>
>         if ((linked =3D get_linked_worktree(d->d_name))) {
>                 ALLOC_GROW(list, alloc + 1, alloc);
>                 list[counter++] =3D linked;
>         }
>
> where "alloc" keeps track of the size of the list, and "counter"
> keeps track of the first unused entry.  The second argument to the
> helper macro smells bad.
>
> The correct way to use ALLOC_GROW() helper macro is:
>
>  * Use three variables, an array, the size of the allocation and the
>    size of the used part of the array.  If you call the array $thing,
>    the size of the allocation is typically called $thing_alloc and
>    the size of the used part $thing_nr.  E.g. opts[], opts_alloc & op=
ts_nr.
>
>  * When adding a new thing at the end of the $thing, do this:
>
>         ALLOC_GROW($thing, $thing_nr + 1, $thing_alloc);
>         $thing[$thing_nr++] =3D <<new thing>>;
>
>
> Perhaps something like this needs squashing in.
>
> Subject: [PATCH] fixup! worktree: add a function to get worktree deta=
ils
>
> ---
>  worktree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/worktree.c b/worktree.c
> index 90282d9..f7304a2 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -178,12 +178,13 @@ struct worktree **get_worktrees(void)
>                                 continue;
>
>                                 if ((linked =3D get_linked_worktree(d=
->d_name))) {
> -                                       ALLOC_GROW(list, alloc + 1, a=
lloc);
> +                                       ALLOC_GROW(list, counter + 1,=
 alloc);
>                                         list[counter++] =3D linked;
>                                 }
>                 }
>                 closedir(dir);
>         }
> +       ALLOC_GROW(list, counter + 1, alloc);
>         list[counter] =3D NULL;
>         return list;
>  }
> --
> 2.6.1-284-g1f14bb6
>

Thanks for clearing this up for me.  I will add it to my branch an
re-roll in a day or two.
