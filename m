From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Tue, 17 Mar 2015 00:10:08 +0800
Message-ID: <CABwkPcrF9oFvNkbp6rFV28U3w-szyV9k4LFviYyFkoJvp8pjbA@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com> <CACsJy8AAsAO6gjWg0nsdiOXFEsZ4583pH9mkUx1Js3Yop5KHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:10:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXb8-0002IB-9P
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbbCPQKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 12:10:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34501 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115AbbCPQK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 12:10:29 -0400
Received: by pacwe9 with SMTP id we9so68857722pac.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5178cq8H7H08O4NNG81W0Bt+ZNvP3gAJ/g6PgMxI2/o=;
        b=hf1+TudGFlcYhs6StBfUg+scvX8JRuVbpJSipspDA6/AjfKVcZ0cHD/gDAHRL8dyKD
         Craw6tsHiWXcyY9YRq90siqT7co9wVE43NRt17f5IB4AqHeOWl13XyiTYZGEbKz6ZmFB
         0jHXkpPWW5OBoxBNuTiGsWnkSDDm+hKOFTPSkKZKkCHpEGHbur1a3r8MDZj1kFdWlnQo
         SuBp4uN4YI+2lRL2VdtnvB50dlpbvOQAzBPQxt2NnGep4ElXgczbnb5U0NrADgGKWs2J
         PP/9WzzI4/E/gh5mFsBzgjxGRXspUM9yFfrGiSOlRP8dRM0gwhPabKc4jjX0JxDMH/Ui
         R2FQ==
X-Received: by 10.66.241.36 with SMTP id wf4mr82186843pac.8.1426522228494;
 Mon, 16 Mar 2015 09:10:28 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Mon, 16 Mar 2015 09:10:08 -0700 (PDT)
In-Reply-To: <CACsJy8AAsAO6gjWg0nsdiOXFEsZ4583pH9mkUx1Js3Yop5KHHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265572>

Hi Duy,

Sorry for my late response.

> we need to make sure that upload-pack barf if some client sends both =
"deepen" and
> "depth".

Actually, in my current design, when client just wants "depth", it
sends "depth N";
when it want "deepen", it sends "depth N" as well as "depth_deepen".
=46or the latter
case, it tells upload-pack to collect objects for "deepen N".

Thus, I'm not so sure whether upload-pack needs to check their exclusio=
n.

> I was about to suggest you use "deepen" for both --depth and
> --deepen: --depth sends "deepen NUM" while --deepen sends "deepen
> +NUM". The protocol as described in pack-protocol.txt may allow this
> extension.

This suggestion looks neat! However, I'm afraid it may involves quite
a bit changes
as you've mentioned, which would be better to take in next stage.

Thanks,
Dongcan

2015-03-14 18:56 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Fri, Mar 13, 2015 at 8:04 PM, Dongcan Jiang <dongcan.jiang@gmail.c=
om> wrote:
>> @@ -317,7 +318,7 @@ static int find_common(struct fetch_pack_args *a=
rgs,
>>         if (is_repository_shallow())
>>                 write_shallow_commits(&req_buf, 1, NULL);
>>         if (args->depth > 0)
>> -               packet_buf_write(&req_buf, "deepen %d", args->depth)=
;
>> +               packet_buf_write(&req_buf, "depth %d", args->depth);
>>         packet_buf_flush(&req_buf);
>>         state_len =3D req_buf.len;
>
> Junio already questioned about your replacing starts_with("deepen "..=
)
> with starts_with("depth "..), this is part of that question. If you
> run "make test" you should find some breakages, or we need to improve
> our test suite.
>
> I think you just need to keep the old "if (args->depth > 0) send
> "depth" unchanged and add two new statements that check
> args->depth_deepen and sends "depth ". BTW, I think "deepen-more" or
> "deepen-relative" would be better than "depth" (*), which is a noun.
> But that's a minor point at this stage.
>
> And because --depth and --deepen are mutually exclusive, you need to
> make sure that the user must not specify that. The "user" includes th=
e
> "client" from the server perspective, we need to make sure that
> upload-pack barf if some client sends both "deepen" and "depth".
>
> (*) I was about to suggest you use "deepen" for both --depth and
> --deepen: --depth sends "deepen NUM" while --deepen sends "deepen
> +NUM". The protocol as described in pack-protocol.txt may allow this
> extension. Unfortunately the current implementation is too relaxed. W=
e
> use strtol() to parse "NUM" and it would accept the leading "+"
> instead of barfing out. So old clients would mistakes --deepen as
> --depth, not good. And it even accepts base 8 and 16!! We should fix
> this.
> --
> Duy



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
