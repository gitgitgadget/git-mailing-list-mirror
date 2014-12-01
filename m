From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 01 Dec 2014 06:55:41 +0100
Message-ID: <547C02DD.2010606@web.de>
References: <87vblxl8ah.fsf@gmail.com>	<547B7B27.90204@web.de> <CAEvUa7=R7Bm7e=HCuw7QnMPwhunjJ4LUYv4LzMHMugh-iUkt8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 06:57:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvJyo-0005wY-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 06:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbaLAF46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 00:56:58 -0500
Received: from mout.web.de ([212.227.15.4]:65287 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbaLAF46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 00:56:58 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MK6mD-1XuV1v0k9V-001SLv; Mon, 01 Dec 2014 06:56:54
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAEvUa7=R7Bm7e=HCuw7QnMPwhunjJ4LUYv4LzMHMugh-iUkt8A@mail.gmail.com>
X-Provags-ID: V03:K0:Cv0CYufU0zIGnObR/CtvnAaIgQIb7DSLFIXnXXcDpbG4dSfOtAG
 9qhtkEX700+m0NqsTNbJnEv1PaoL7MaY3dZOfzDs9RbXZCqVUm6dGckJf1/4J/6B0XkCWqn
 4rOpM1M2eR5SoBqR5LGoNQtM2cewNVEHiRUKQw6t4SYHXW/R224JdG97qUcwL2ww+JT+wXo
 XXUjEtqHkGj40Skiy+XSA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260471>

On 12/01/2014 04:40 AM, David Michael wrote:
> On Sun, Nov 30, 2014 at 3:16 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
> [snip]
>> Could the code be more human-readable ?
>> static inline mode_t mode_native_to_git(mode_t native_mode)
>> {
>>          int perm_bits =3D native_mode & 07777;
>>          if (S_ISREG(native_mode))
>>                  return 0100000 | perm_bits;
>>          if (S_ISDIR(native_mode))
>>                  return 0040000 | perm_bits;
>>          if (S_ISLNK(native_mode))
>>                  return 0120000 | perm_bits;
>>          if (S_ISBLK(native_mode))
>>                  return 0060000 | perm_bits;
>>          if (S_ISCHR(native_mode))
>>                  return 0020000 | perm_bits;
>>          if (S_ISFIFO(native_mode))
>>                  return 0010000 | perm_bits;
>>          /* Non-standard type bits were given. */
>>          /* Shouldn't we die() here ?? */
>>                  return perm_bits;
>> }
> Sure, I can send an updated patch with the new variable and without t=
he "else"s.
>
> Regarding the question in the last comment:  I was assuming if this
> case was ever reached, Git would handle the returned mode the same wa=
y
> as if it encountered an unknown/non-standard file type on a normal
> operating system, which could die() if needed in the function that
> called stat().
>
> Should I send an updated patch that die()s there?
>
> David
Not yet, please wait with a V2 patch until I finished my thinking ;-)

I take back the suggestion with the die(). I was thinking how to handle
unforeseen types, which may show up on the z/OS some day,
So die() is not a good idea, it is better to ignore them, what the code=
=20
does.

Knowing that Git does not track block devices, nor character devices no=
r sockets,
the above code could be simplyfied even more, by mapping everything whi=
ch
is not a directory, a file or a softlink to "device type 0)

This is just a suggestion, I want to here from others as well:

         int perm_bits =3D native_mode & 07777;
         if (S_ISREG(native_mode))
                 return 0100000 | perm_bits;
         if (S_ISDIR(native_mode))
                 return 0040000 | perm_bits;
         if (S_ISLNK(native_mode))
                 return 0120000 | perm_bits;
         /* Git does not track S_IFCHR, S_IFBLK, S_IFIFO, S_IFSOCK  */
                 return perm_bits;
