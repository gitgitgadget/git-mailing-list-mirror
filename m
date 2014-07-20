From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/3] strbuf: add strbuf_add_cwd()
Date: Sun, 20 Jul 2014 17:21:51 +0200
Message-ID: <53CBDE8F.7000804@web.de>
References: <53CBA59C.8050901@web.de> <53CBA62A.5010800@web.de> <CACsJy8BHJ8UFbnEn6C7FiA2SNvL5hZSZg5iDd6CQPDxt+bUJHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 17:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8swN-0001cZ-A6
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 17:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbaGTPWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 11:22:15 -0400
Received: from mout.web.de ([212.227.15.4]:54368 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 11:22:14 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LoYJu-1WbAgj2xJa-00gU8K; Sun, 20 Jul 2014 17:22:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8BHJ8UFbnEn6C7FiA2SNvL5hZSZg5iDd6CQPDxt+bUJHQ@mail.gmail.com>
X-Provags-ID: V03:K0:qsq6/pmFiArTebRs8l2ag6kzDklPMOqyv2OQl5oeG5Ew9ZfjU6i
 j2leZJkL+RqvLAAze63nDzdAkMIi+mffpBUjTEwHNyW3Wytl9RT4qdK+P/six0OtYtw78bZ
 NPXo19MgoGHCIYGyyXAFbJdgRa+EQLpTE6Fb78YKHhircfrEXhxv98xgzhpSu6pIdjrb03q
 2XGjbnGs++ulmdZyFgsHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253926>

Am 20.07.2014 14:33, schrieb Duy Nguyen:
> On Sun, Jul 20, 2014 at 6:21 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> +int strbuf_add_cwd(struct strbuf *sb)
>> +{
>> +       size_t oldalloc =3D sb->alloc;
>> +       size_t guessed_len =3D 32;
>
> For Linux, I think this is enough to succesfully get cwd in the first
> pass. Windows' $HOME is usually deep in C:\Users\Blahblah. Maybe
> increase this to 128? And we probably want to keep the guessed value,
> so if the first strbuf_add_cwd needs a few rounds to get cwd, the nex=
t
> strbuf_add_cwd() call does not.

The initial number is debatable, sure.  I just copied the 32 from=20
strbuf_readline().

"C:\Users\John Doe\Documents\Projects\foo" (or whatever) isn't thaaat=20
long either, though.  FWIW, the longest (non-hidden) path in my home on=
=20
Windows 8.1 is 139 characters long (as reported by dir -r | %{=20
$_.FullName.Length } | sort -desc | select -f 1), but there are no git=20
projects in that directory.  Not sure if that means 128 would be a=20
better start value, but I don't mind changing it in any case.

Before adding performance optimizations like remembering the last cwd=20
length I'd rather see measurements that demonstrate their use.  I doubt=
=20
we'll see getcwd() show up high on a profile (but didn't measure, excep=
t=20
for a run of t/perf).

>> +
>> +       for (;; guessed_len *=3D 2) {
>> +               char *cwd;
>> +
>> +               strbuf_grow(sb, guessed_len);
>> +               cwd =3D getcwd(sb->buf + sb->len, sb->alloc - sb->le=
n);
>> +               if (cwd) {
>> +                       strbuf_setlen(sb, sb->len + strlen(cwd));
>> +                       return 0;
>> +               }
>> +               if (errno !=3D ERANGE)
>> +                       break;
>> +       }
>> +       if (oldalloc =3D=3D 0)
>> +               strbuf_release(sb);
>> +       return -1;
>> +}
>
> The loop and the following strbuf_release() are correct. But I wonder
> if it's easier to read if you save getcwd in a separate/local strbuf
> variable and only concat it to "sb" when you successfully get cwd..

Adding an extra allocation and string copy sound more complicated.  But=
=20
you are right that the function is more complicated than necessary.=20
Reroll coming..

Ren=C3=A9
