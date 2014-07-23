From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory
 is changed
Date: Wed, 23 Jul 2014 18:55:31 +0700
Message-ID: <CACsJy8B6JpqOnbGZuKQPGrY1y8SyKzg+4aSP2iiM-Gb=3Jv5sw@mail.gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com>
 <53CD1529.9080102@ramsay1.demon.co.uk> <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
 <xmqqr41ek5hl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9v9U-0005CS-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbaGWL4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:56:04 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41295 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbaGWL4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 07:56:02 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so1134033qac.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pKERJJdF7lvUx9smUdvnvNXJ3150Kw/+GiDcq5Y4vTk=;
        b=gVg9TMbGmd6eLZ6oQuwiYMi1sMecH/u6BOjbipnTqi3xjm3yQxOX8Gc2ao0YoLbZIu
         j6LUjUkrCMM+2bo/MXy20WviIMZ9yoC7Xi2qF8Apt9O+Izg3FOoB6wwvvkxtKCbZKnCp
         ehWpJwz6pG97gia4dnwD0nX0C3SxcpM+Ezzyh93r151GSxa3Cz+BpzaNa4YU5g7eNRHM
         OpcHmRB7RvNE9CXPd3FaFgq0ubBz9MQ2IosmfkZ6JKBOy8reu6K+cUM0a/rW8Ky+7nX9
         IASZp5zVQS6OVXdAlcH/HhaqqiU2UkKOGVK/X+FlJ+FhfUUr2BEcoSeVGsuCXKE8wjIO
         M7gQ==
X-Received: by 10.224.103.134 with SMTP id k6mr1529218qao.24.1406116561726;
 Wed, 23 Jul 2014 04:56:01 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 23 Jul 2014 04:55:31 -0700 (PDT)
In-Reply-To: <xmqqr41ek5hl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254070>

On Tue, Jul 22, 2014 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Jul 21, 2014 at 8:27 PM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>> +void make_locked_paths_absolute(void)
>>>> +{
>>>> +     struct lock_file *lk;
>>>> +     for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
>>>> +             if (lk->filename && !is_absolute_path(lk->filename))=
 {
>>>> +                     char *to_free =3D lk->filename;
>>>> +                     lk->filename =3D xstrdup(absolute_path(lk->f=
ilename));
>>>> +                     free(to_free);
>>>> +             }
>>>> +     }
>>>> +}
>>>
>>> I just have to ask, why are we putting relative pathnames in this
>>> list to begin with? Why not use an absolute path when taking the
>>> lock in all cases? (calling absolute_path() and using the result
>>> to take the lock, storing it in the lock_file list, should not be
>>> in the critical path, right? Not that I have measured it, of course=
! :)
>>
>> Conservative :) I'm still scared from 044bbbc (Make git_dir a path
>> relative to work_tree in setup_work_tree() - 2008-06-19). But yeah
>> looking through "grep hold_" I think none of the locks is in critica=
l
>> path. absolute_path() can die() if cwd is longer than PATH_MAX (and
>> doing this reduces the chances of that happening). But Ren=C3=A9 is =
adding
>> strbuf_getcwd() that can remove that PATH_MAX. So I guess we should =
be
>> fine with putting absolute_path() in hold_lock_file_...*
>
> OK, we should center these efforts around the strbuf_getcwd() topic,
> basing the other topic on realpath() and this one on it then?

OK.
--=20
Duy
