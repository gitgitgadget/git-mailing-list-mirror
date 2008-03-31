From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive loses path info when opened with Winzip?
Date: Mon, 31 Mar 2008 21:47:26 +0200
Message-ID: <47F13FCE.1010502@lsrfire.ath.cx>
References: <47F0D215.1060700@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgQ7v-0004Mg-6b
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 21:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYCaT4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYCaT4I
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 15:56:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:54396 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYCaT4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 15:56:06 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 15:56:06 EDT
Received: from [10.0.1.101] (p57B7CE24.dip.t-dialin.net [87.183.206.36])
	by india601.server4you.de (Postfix) with ESMTPSA id 2C9E92F8002;
	Mon, 31 Mar 2008 21:47:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <47F0D215.1060700@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78600>

Rogan Dawes schrieb:
> Hi folks,
>=20
> I have noticed something strange with "git-archive"-created tarballs.=
 It
> seems that Winzip has trouble parsing the paths for certain files
> correctly.
>=20
> The symptom is that Winzip shows some files as having been created at
> the "top level" of the zip, without any path at all, while the rest o=
f
> the files are within their correct directory structure.
>=20
> I have attached a screenshot of a gitweb-created snapshot opened in
> Winzip 9.0 SR1 (build 6224), but it apparently happens in other (more
> recent) versions of Winzip as well.

Oh, well.

Each file in a tar archive has at least a 512-byte header.  This header
contains a name field, 100 bytes long.  When it became clear that it
would be nice to support file names longer than 100 characters, another
155 bytes in the header was designated as a prefix field (see tar.h).

The full file name is constructed by concatenating the prefix, a path
separator (/) and the name field -- if a prefix exists.  That's how
POSIX defines it, anyway.  Apparently WinZip ignores the prefix field.

7-Zip honours the prefix field, by the way.  But it doesn't understand
POSIX extended headers; I suspect that WinZip doesn't, too.

That probably makes the easiest way to fix this problem at git's end a
non-starter.  Git-archive tries to:

   1. fit the path in the name field (up to 100 bytes),
   2. in the prefix and name fields (up to 255 bytes),
   3. or if even that isn't enough it stores it in an extended header.

Now we could simply make git-archive forget the second option -- but
since support for POSIX extended headers is even more scarce, this
probably won't help.

The second option is to stop encoding long paths using the POSIX method
and start doing it e.g. the GNU way -- or some other tar dialect that i=
s
supported more widely than the official one.  NOTE: I haven't checked i=
f
WinZip understands the GNU extensions; it's possible that this problem
can't be solved on git's side at all!

In any case, there are better options:

  - Don't use long file names (just kidding :).
  - Use a tar extractor that understands the prefix field, e.g. 7-Zip.
  - Use zip (but beware of its 65535 bytes name length limit! ;).
  - File a bug report with WinZip.

Ren=E9
