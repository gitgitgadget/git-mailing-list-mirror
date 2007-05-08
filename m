From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 08 May 2007 06:17:11 -0600
Message-ID: <46406A47.7050400@byu.net>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com> <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Liu Yubao <yubao.liu@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 14:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlOba-0006vE-Ht
	for gcvg-git@gmane.org; Tue, 08 May 2007 14:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967994AbXEHMP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 08:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967453AbXEHMPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 08:15:25 -0400
Received: from alnrmhc13.comcast.net ([204.127.225.93]:34770 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967476AbXEHMPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 08:15:23 -0400
Received: from [192.168.0.103] (c-71-199-58-92.hsd1.ut.comcast.net[71.199.58.92])
          by comcast.net (alnrmhc13) with ESMTP
          id <20070508121521b1300dqk15e>; Tue, 8 May 2007 12:15:22 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
In-Reply-To: <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
X-Enigmail-Version: 0.94.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46570>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Alex Riesen on 5/8/2007 3:08 AM:
> This does not "test again" if lstat returns 0. If lstat returns 0
> (file stat info
> obtained) the open is not even called. Besides, cygwin lies not only about
> .exe but also about .lnk files.
> 
> P.S. Somehow I have the feeling that even if it is a stupidity in cygwin
> they will not fix it (nor will they admit it is a bug).

It is a limitation of cygwin, and the cygwin developers will admit it; but
they will also stand behind calling it a feature rather than a bug due to
the attempts to make cygwin behave more like Linux in spite of Window's
insistence on file suffixes.  The cygwin port of coreutils has to do
similar stat() tricks to reverse engineer some of the .exe magic present
in cygwin.  However, it is possible to override the magic without
resorting to a full-blown open(), via careful use of additional stat()s or
readlink()s (trailing . is not legal in Windows, and on cygwin is only
legal on managed mounts, so stat("foo.") will fail when stat("foo")
succeeds if the reason stat("foo") succeeded was due only to the existence
of foo.exe):

/* Return -1 if PATH not found, 0 if PATH spelled correctly, and 1 if PATH
   had ".exe" automatically appended by cygwin.  Don't change errno.  */
int
cygwin_spelling (char const *path)
{
  char path_exact[PATH_MAX + 9];
  int saved_errno = errno;
  int result = 0; /* Start with assumption that PATH is okay.  */
  int len = strlen (path);

  if (! path || ! *path || len > PATH_MAX)
    /* PATH will cause EINVAL or ENAMETOOLONG, treat it as non-existing.  */
    return -1;
  if (path[len - 1] == '.' || path[len-1] == '/')
    /* Don't change spelling if there is a trailing `.' or `/'.  */
    return 0;
  if (readlink (path, NULL, 0) < 0)
    { /* PATH is not a symlink.  */
      if (errno == EINVAL)
	{ /* PATH exists.  Appending trailing `.' exposes whether it is
	     PATH or PATH.exe for normal disk files, but also check appending
	     trailing `.exe' to be sure on virtual/managed directories.  */
	  strcat (strcpy (path_exact, path), ".");
	  if (access (path_exact, F_OK) < 0)
	    { /* PATH. does not exist.  */
	      strcat (path_exact, "exe");
	      if (access (path_exact, F_OK) == 0)
		/* But PATH.exe does, so append .exe.  */
		result = 1;
	    }
	}
      else
	/* PATH does not exist.  */
	result = -1;
    }
  else
    { /* PATH is a symlink.  Appending trailing `.lnk' exposes whether
	 it is PATH.lnk or PATH.exe.lnk; but does not help with
	 old-style symlinks where it was just PATH and the system
	 attribute set.  */
      strcat (strcpy (path_exact, path), ".lnk");
      if (readlink (path_exact, NULL, 0) < 0)
	{
	  strcat (strcpy (path_exact, path), ".exe.lnk");
	  if (readlink (path_exact, NULL, 0) == 0)
	    result = 1;
	}
    }

  errno = saved_errno;
  return result;
}


In the upcoming cygwin 1.7.0, you can set CYGWIN=transparent_exe which
will cause ENOENT when dealing with any explicit .exe.  When enabled, that
will make it impossible to have both foo and foo.exe in the current
directory, and make it so that stat can never lie - stat("foo.exe") will
fail, and if stat("foo") succeeds, you no longer care if it succeeded
because of the Windows file foo or because of foo.exe, because the .exe is
transparent to cygwin.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQGpH84KuGfSFAYARAsCdAKCmqdgsppPY0MhxDWZ6QQxXExn2gwCeLN39
Zl3sRk/0IkkHkIyjf4RpAAA=
=rQrT
-----END PGP SIGNATURE-----
