From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use
 is_git_directory() instead
Date: Mon, 14 Sep 2015 18:57:54 +0700
Message-ID: <CACsJy8D+3o-SKq-MAC1+KzRzMjcU6GUij1OokLWznfZ8V7zUmA@mail.gmail.com>
References: <20150715132552.GA28574@lanh> <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1440204002-7638-3-git-send-email-pclouds@gmail.com> <xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CD+cNdM5EppcStJViRA7yPpyAHyUX=ct4LEK6RCrJrFw@mail.gmail.com> <xmqqlhcbxh7l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, bjornar@snoksrud.no
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 13:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbSOy-0001m9-GL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 13:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbbINL6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 07:58:24 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33456 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbINL6X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 07:58:23 -0400
Received: by iofh134 with SMTP id h134so162623486iof.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BrAbkFQ+gKLby90/lSI4+5iJnTFVtXVOeLQA5GI0MZk=;
        b=YgiOmZ+tLsybNnl5KoW5HR3yijGejOckP7GQhJKSjeMPiMI6gOlIRBCtwiCqF09iT6
         XQlBPQ2saagiidIOLSZYaN03La5HAQ5Ar+fBlVkjucWUkkgBozzXpw5R4jt6ligWEBqr
         IpxCJsT2WZDpcqzR9T5p13erK2lviogh6j6jnRqXQFS82uQVTNoNnJ3SLzHyF6cPL47q
         95FKnitstZEfvd+AaWMxZxU8xTsV5WIv8jij+bhC99D2yPmFgbUslESFLIGqMxjop9Y1
         2yFDqAwys7B14Kz3LkVr3H1QtOwn8Lh19VlZLBeAjsPguSvNJRUdayjF+qrhk5ssaIVV
         oNOw==
X-Received: by 10.107.9.212 with SMTP id 81mr22776371ioj.191.1442231903346;
 Mon, 14 Sep 2015 04:58:23 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Mon, 14 Sep 2015 04:57:54 -0700 (PDT)
In-Reply-To: <xmqqlhcbxh7l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277815>

On Sun, Sep 13, 2015 at 8:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Sep 7, 2015 at 11:33 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>> ---
>>>
>>> The cover letter talks about "local clone", and in this entire
>>> series, I saw new tests only for the local case, but doesn't this
>>> and the next change also affect the case where a Git daemon or a
>>> upload-pack process is serving the remote repository?
>>>
>>> And if so, how is that case affected?
>>
>> People who serve .git-dir repos should not be affected (I think we
>> have enough test cases covering that). People can serve .git-file
>> repos as well, which is sort of tested in the local clone test case
>> because upload-pack is involved for providing remote refs, I think.
>
> Unfortunately, the above is still not unclear to me.
>
> Was serving from a linked repository working without these five
> patches, i.e. was the local case the only one that was broken and
> needed fixing with these five patches?  If so, the log message
> should mention that (i.e. "remote case was working OK but local was
> broken because ...; change this and that to make local one work as
> well").  If the remote case also was broken and fixed by these five
> patches, then that is also worth mentioning the same way.
>
> I didn't ask you to explain it to me in the first place in a
> response.  The review comment pointed out that the proposed log
> message was unclear and those who will be reading "git log" output
> need clearer description.

I know. I sent the re-roll before receiving this. I think I still
haven't mentioned the impact on remote case. Another update coming,
maybe next weekend.
--=20
Duy
