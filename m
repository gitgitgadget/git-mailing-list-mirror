From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in get_pwd_cwd() in Windows?
Date: Wed, 23 Jul 2014 18:53:30 +0700
Message-ID: <CACsJy8Ch6FvWp-pOOG4-kDVmb+kyav7oromH8EpeEesPj7B9Yg@mail.gmail.com>
References: <CACsJy8BY8pyuZ0eY7qK86RGUh8Vp9FVE55TskcQhBTrwwPowEQ@mail.gmail.com>
 <53CEBD13.5040004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:54:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9v7Y-0003J0-It
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbaGWLyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:54:03 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:53040 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbaGWLyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 07:54:01 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so1123477qae.34
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q8j/su9em4r/cueNcZDNkah/CXg5aiXNwtCb9dJT9t4=;
        b=Q0QovZ28PgrlnyYz/jLitHre573KDO9O7LBqq0yb/aUDZN6LLvYG4Pw/aBbojCy73k
         gS51jONd9ebJzPR44Fpni3icQKclj3mYGzDe+Z6vUwPgbSK6tOZeVKJ/q1bizV8nqgBM
         /t+MWJiNHZjeGitPwrZITFONob8AWamJGJrHxIGsOv5pLFV5GeWYFpDBvJf87/AN75DV
         rvrYSun/4a+XuDWYoZuJ7EHxtJAcpBo+TUhWth1DzmKSmd5zwdshKF5E0aaQzS5Bzktc
         ZpVCrGEnu/BFopkQZIQFH71nZozqlrIzFKmvyvL+qL/DUyFpjgN5bv50x981eTz8I7lJ
         yiZA==
X-Received: by 10.140.82.113 with SMTP id g104mr1053091qgd.55.1406116440836;
 Wed, 23 Jul 2014 04:54:00 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 23 Jul 2014 04:53:30 -0700 (PDT)
In-Reply-To: <53CEBD13.5040004@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254069>

On Wed, Jul 23, 2014 at 2:35 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 21.07.2014 16:13, schrieb Duy Nguyen:
>
>> This function tests if $PWD is the same as getcwd() using st_dev and
>> st_ino. But on Windows these fields are always zero
>> (mingw.c:do_lstat). If cwd is moved away, I think falling back to $P=
WD
>> is wrong. I don't understand the use of $PWD in the first place.
>> 1b9a946 (Use nonrelative paths instead of absolute paths for cloned
>> repositories - 2008-06-05) does not explain much.
>
>
> The commit message reads:
>
>   Particularly for the "alternates" file, if one will be created, we
>   want a path that doesn't depend on the current directory, but we wa=
nt
>   to retain any symlinks in the path as given and any in the user's v=
iew
>   of the current directory when the path was given.
>
> The intent of the patch seems to be to prefer $PWD if it points to th=
e same
> directory as the one returned by getcwd() in order to preserve "the u=
ser's
> view".  That's why it introduces make_nonrelative_path() (now called
> absolute_path()), in contrast to make_absolute_path() (now called
> real_path()).
>
> I imagine it's useful e.g. if your home is accessed through a symlink=
:
>
>         /home/foo -> /some/boring/mountpoint
>
> Then real_path("bar") would give you "/some/boring/mountpoint/bar", w=
hile
> absolute_path("bar") returned "/home/foo/bar".  Not resolving symlink=
s keeps
> the path friendly in this case.  And it keeps working even after the =
user's
> home is migrated to /a/bigger/partition and /home/foo is updated
> accordingly.

If it's saved back, then yes it's useful. And I think that's the case
in clone.c. I was tempted to remove this code (because it only works
if you stand at worktree's root dir anyway, else cwd is moved) but I
guess we can just disable this code on Windows only instead.
--=20
Duy
