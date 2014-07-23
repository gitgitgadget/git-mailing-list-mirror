From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Bug in get_pwd_cwd() in Windows?
Date: Wed, 23 Jul 2014 14:40:21 +0200
Message-ID: <53CFAD35.1080604@gmail.com>
References: <CACsJy8BY8pyuZ0eY7qK86RGUh8Vp9FVE55TskcQhBTrwwPowEQ@mail.gmail.com> <53CEBD13.5040004@web.de> <CACsJy8Ch6FvWp-pOOG4-kDVmb+kyav7oromH8EpeEesPj7B9Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:40:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9vqO-00055Z-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 14:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbaGWMkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 08:40:24 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:43684 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaGWMkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 08:40:24 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so1090642wes.8
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jtQMyqkWvRjynvzfQ+f1Dqqd5/Hx0vn/Lbo3yK6mm5Q=;
        b=PQQOtW+eG80vA4FYnVNFYc0FsDfGETQFSp6oTO2B/DjfUAcWORzK2y0hCLt0P7QR+G
         nkZ63xGgI1LdSianCxEfu4Q5U0V5Qp+IRgJ0hH3fY8jAtPP750lxnjSd1t6t/vOdwRsh
         2o4XPgg6pHKD9jQieNyAB8FwV5YkZGn2z/zlol6LJY/Sqn6WEvjwiu9dIha6yBzxiOgr
         cGxTo1wMnDk5e/wl9rC9FbYitqSCCiuGmR2ME7QvnG3Q16K11F7dQJh+w8jz0pypEqLO
         S2eLsn+qbKsnCwXmj4cj8uHYMHwvC+u7fmNJoNbOIZj2DNJC2wfJbuSScNH2Nf5DOTme
         waqA==
X-Received: by 10.180.83.225 with SMTP id t1mr3031791wiy.28.1406119220448;
        Wed, 23 Jul 2014 05:40:20 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ek3sm5959837wjd.17.2014.07.23.05.40.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 05:40:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8Ch6FvWp-pOOG4-kDVmb+kyav7oromH8EpeEesPj7B9Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254073>

Am 23.07.2014 13:53, schrieb Duy Nguyen:
> On Wed, Jul 23, 2014 at 2:35 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> Am 21.07.2014 16:13, schrieb Duy Nguyen:
>>
>>> This function tests if $PWD is the same as getcwd() using st_dev an=
d
>>> st_ino. But on Windows these fields are always zero
>>> (mingw.c:do_lstat). If cwd is moved away, I think falling back to $=
PWD
>>> is wrong. I don't understand the use of $PWD in the first place.
>>> 1b9a946 (Use nonrelative paths instead of absolute paths for cloned
>>> repositories - 2008-06-05) does not explain much.
>>
>>
>> The commit message reads:
>>
>>   Particularly for the "alternates" file, if one will be created, we
>>   want a path that doesn't depend on the current directory, but we w=
ant
>>   to retain any symlinks in the path as given and any in the user's =
view
>>   of the current directory when the path was given.
>>
>> The intent of the patch seems to be to prefer $PWD if it points to t=
he same
>> directory as the one returned by getcwd() in order to preserve "the =
user's
>> view".  That's why it introduces make_nonrelative_path() (now called
>> absolute_path()), in contrast to make_absolute_path() (now called
>> real_path()).
>>
>> I imagine it's useful e.g. if your home is accessed through a symlin=
k:
>>
>>         /home/foo -> /some/boring/mountpoint
>>
>> Then real_path("bar") would give you "/some/boring/mountpoint/bar", =
while
>> absolute_path("bar") returned "/home/foo/bar".  Not resolving symlin=
ks keeps
>> the path friendly in this case.  And it keeps working even after the=
 user's
>> home is migrated to /a/bigger/partition and /home/foo is updated
>> accordingly.
>=20
> If it's saved back, then yes it's useful. And I think that's the case
> in clone.c. I was tempted to remove this code (because it only works
> if you stand at worktree's root dir anyway, else cwd is moved) but I
> guess we can just disable this code on Windows only instead.
>=20

It is disabled on Windows as of 7d092adc get_pwd_cwd(): Do not trust st=
_dev/st_ino blindly
