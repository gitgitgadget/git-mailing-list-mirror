From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.2.1 (and updates to older maintenance
 tracks)
Date: Fri, 19 Dec 2014 10:18:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412190955040.13845@s15462909.onlinehome-server.info>
References: <xmqq61d87jew.fsf@gitster.dls.corp.google.com> <CAF7_NFTwn5DcxJeRYHEUv5ae6-rh-8r7PXT81uOdPxvT2jtvug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1703005332-1418980697=:13845"
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 10:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1ths-0004Q1-RI
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 10:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbaLSJSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 04:18:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:59636 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbaLSJSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 04:18:36 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MeLKt-1YHVXK22cp-00QFgM;
 Fri, 19 Dec 2014 10:18:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAF7_NFTwn5DcxJeRYHEUv5ae6-rh-8r7PXT81uOdPxvT2jtvug@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:pdrZyWIFzkDsa0VCLLCjtdZXuWm+ut5tz2QUEc8o3sOZOb0xrH5
 Corrti2QAA7abcFrqvePVZQBZ7uquiCYT/jkuuEb6tBJj9eEHIhE7DKlUnVCGaNMSgbnlFt
 G/QpXRj9iZeSsAmwln0ob3bcGwKBPHYi/Hiqx80ke0I7a2RZAlSM5/fZ7FooJAeax3sW9F0
 09ETzVZ7nL7jRwauelmnQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261551>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1703005332-1418980697=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Max,

On Fri, 19 Dec 2014, Max Kirillov wrote:

> Hello. Thank you for the fix.

You are welcome.

> Would it be more reliable to compare inode of directory in question and
> ".git"? (there is [*] for windows). So that any unspotted name
> equivalence is prevented to cause any harm.
>=20
> *) http://stackoverflow.com/questions/7162164/does-windows-have-inode-num=
bers-like-linux

We were considering this, really. The biggest problem we had with this
approach is that the most important aspect of releasing a new version was
to let hosting sites protect their users via receive.fsckObjects =3D true
(which all hosting sites should activate anyway) by rejecting the
ill-intentioned file names in hand-crafted tree objects.

This turned out to be much more important than the user-facing aspect:
many users will not update (in many cases, users will be prevented by
administrators from updating their software themselves, even).

Therefore, we really tried very hard to get the checks right without
having to write out non-bare repositories on Windows (or for that matter,
on MacOSX).

Having said that, I would welcome additional safeguards on the users'
side, such as what you suggested; I had written out the code in a mail
thread between the Git security squad (in addition to nFileIndexHigh and
nFileIndexLow, we need to check dwVolumeSerialNumber, too), maybe you want
to take this further?

-- snip --
Untested code snippet to illustrate what I have in mind:

=09static int is_git_directory(const char *path) {
=09=09static int initialized;
=09=09static DWORD dwVolumeSerialNumber, nFileSizeHigh, nFileSizeLow;

=09=09HANDLE handle;
=09=09BY_HANDLE_FILE_INFORMATION info;
=09=09int result =3D 0;

=09=09if (!initialized) {
=09=09=09handle =3D CreateFile(get_git_dir(), 0,
=09=09=09=09FILE_SHARE_READ, 0, OPEN_EXISTING,
=09=09=09=09FILE_ATTRIBUTE_NORMAL);

=09=09=09if (handle !=3D INVALID_HANDLE_VALUE) {
=09=09=09=09if (GetFileInformationByHandle(handle, &info)) {
=09=09=09=09=09dwVolumeSerialNumber =3D
=09=09=09=09=09=09info.dwVolumeSerialNumber;
=09=09=09=09=09nFileSizeHigh =3D info.nFileSizeHigh;
=09=09=09=09=09nFileSizeLow =3D info.nFileSizeLow;
=09=09=09=09}
=09=09=09=09CloseHandle(handle);
=09=09=09}
=09=09=09initialized =3D 1;
=09=09}

=09=09handle =3D CreateFile(path, 0, FILE_SHARE_READ, 0, OPEN_EXISTING,
=09=09=09FILE_ATTRIBUTE_NORMAL);

=09=09if (handle !=3D INVALID_HANDLE_VALUE) {
=09=09=09if (GetFileInformationByHandle(handle, &info)) {
=09=09=09=09result =3D dwVolumeSerialNumber =3D=3D
=09=09=09=09=09info.dwVolumeSerialNumber &&
=09=09=09=09=09nFileSizeHigh =3D=3D info.nFileSizeHigh &&
=09=09=09=09=09nFileSizeLow =3D=3D info.nFileSizeLow;
=09=09=09}
=09=09=09CloseHandle(handle);
=09=09}
=09=09return result;
=09}

=09static inline int is_in_git_directory(const char *path) {
=09=09char *copy =3D xstrdup(path);
=09=09while (PathRemoveFileSpec(path)) {
=09=09=09if (is_git_directory(path)) {
=09=09=09=09free(copy);
=09=09=09=09return 1;
=09=09=09}
=09=09}
=09=09free(copy);
=09=09return 0;
=09}

This *should* be good enough.

I fear that this will have a performance impact that might be alleviated
by caching results.

What do you think?
-- snap --

Please note that this code has been written inside a mail program and has
never seen a compiler.

This function =E2=80=93 `is_in_git_directory()` =E2=80=93 would be called a=
t the start of
`verify_path()`, protected by an `if (protect_ntfs)` guard, and of course
we would need to have a POSIX version using inodes, too, because =E2=80=93 =
believe
it or not =E2=80=93 there are Linux users using Git on NTFS volumes.

The problems I see with this are:

1) it really might affect performance very negatively, as it has to
   perform recursive checks for *all* the paths about to be checked out,

2) we would really need to make sure that the function cannot be called
   *before* initializing the .git/ directory in `git init` and `git clone`,
   and

3) it would not protect submodules' .git/ directories (before we switched
   to writing out .git files redirecting to the super project's .git/
   directory, Git initialized .git/ directories inside the submodules'
   working directories).

Ciao,
Johannes
--1784107012-1703005332-1418980697=:13845--
