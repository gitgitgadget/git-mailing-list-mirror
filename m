From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Bug in get_pwd_cwd() in Windows?
Date: Tue, 22 Jul 2014 21:35:47 +0200
Message-ID: <53CEBD13.5040004@web.de>
References: <CACsJy8BY8pyuZ0eY7qK86RGUh8Vp9FVE55TskcQhBTrwwPowEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 21:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9frY-0004Aj-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbaGVTga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2014 15:36:30 -0400
Received: from mout.web.de ([212.227.15.3]:59281 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756777AbaGVTg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 15:36:28 -0400
Received: from [192.168.178.27] ([79.250.170.92]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lcxjk-1Wj6XC00m0-00iCJr; Tue, 22 Jul 2014 21:36:26
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8BY8pyuZ0eY7qK86RGUh8Vp9FVE55TskcQhBTrwwPowEQ@mail.gmail.com>
X-Provags-ID: V03:K0:pYDhUQoZUjUVLJR7rsJKQCdsYyo0mj5DpzadQHfTuzGh1Xod2ET
 64EJuzPROAXBzevKPJp43nroIpk9ojEF5LT/jIYFmckwAz4UQU0hXU3e/87v1j7eRBZbvj0
 xIA/v/UoYWBfPAMYTtBWjvR6gbvCAYBWGjf47K25BSmaHKZ30xd5aR56e0n0+78GC+aGmHU
 zSL7HSk9XDE4LTSI4ZAwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254033>

Am 21.07.2014 16:13, schrieb Duy Nguyen:
> This function tests if $PWD is the same as getcwd() using st_dev and
> st_ino. But on Windows these fields are always zero
> (mingw.c:do_lstat). If cwd is moved away, I think falling back to $PW=
D
> is wrong. I don't understand the use of $PWD in the first place.
> 1b9a946 (Use nonrelative paths instead of absolute paths for cloned
> repositories - 2008-06-05) does not explain much.

The commit message reads:

   Particularly for the "alternates" file, if one will be created, we
   want a path that doesn't depend on the current directory, but we wan=
t
   to retain any symlinks in the path as given and any in the user's vi=
ew
   of the current directory when the path was given.

The intent of the patch seems to be to prefer $PWD if it points to the=20
same directory as the one returned by getcwd() in order to preserve "th=
e=20
user's view".  That's why it introduces make_nonrelative_path() (now=20
called absolute_path()), in contrast to make_absolute_path() (now calle=
d=20
real_path()).

I imagine it's useful e.g. if your home is accessed through a symlink:

	/home/foo -> /some/boring/mountpoint

Then real_path("bar") would give you "/some/boring/mountpoint/bar",=20
while absolute_path("bar") returned "/home/foo/bar".  Not resolving=20
symlinks keeps the path friendly in this case.  And it keeps working=20
even after the user's home is migrated to /a/bigger/partition and=20
/home/foo is updated accordingly.

Ren=C3=A9
