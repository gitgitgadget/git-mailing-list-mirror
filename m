From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Attempt to fix pread() threading issue on Cygwin and MinGW
Date: Tue, 26 Jun 2012 21:46:28 +0200
Message-ID: <CABPQNSZWLvYGH6sFkWa588+fPJXV3c5ViKsEyMABViN74ghaLg@mail.gmail.com>
References: <4FEA06DE.6080101@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjbjJ-000425-Al
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab2FZTrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 15:47:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63705 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2FZTrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:47:09 -0400
Received: by pbbrp8 with SMTP id rp8so507895pbb.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=63ppEmVH770E+P05AZJYRJbgqKxbzYkYRPpStHS07x4=;
        b=0gEB38PDCw5JAs562vi0GzQQG86UrUrxvKPtMORtQlSHVzGU0r9loUszbzYdaVTrVi
         OQvRFtQchH8MuCOFVHN/h3hd/8izDvz6bBM3T7/XR7NA9KGBReNVD1gQDoAYGw+YWfHL
         ZSJqVsncdXC/sdCJnali2GQkdFHlwHkCVWgNVNLnFR82f0h/KcLU6RRnoStpffz4XVpY
         BVvFn4XgcyhfPkMpRtqeUyMI4Xtwscp+sklJBPY0q0f1wYwDgH8cNBTRV+YizzZFfns/
         /KtLmfJBadJl2vAtVu5vzeT2aFmcVIY0d9fDvX2tJPlt4rN5G5jX++fuO5qxTYS4lN/p
         r8ig==
Received: by 10.68.241.8 with SMTP id we8mr54571066pbc.130.1340740028365; Tue,
 26 Jun 2012 12:47:08 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 26 Jun 2012 12:46:28 -0700 (PDT)
In-Reply-To: <4FEA06DE.6080101@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200675>

On Tue, Jun 26, 2012 at 9:00 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Hi Johannes,
>
> I had an "fix pread() on MinGW" item low on my todo list. As we have
> seen recently, Cygwin has the same problem. So, I decided to try and
> fix it up last night, since I had an idea that I thought would work.
>
> Several years ago, I read somewhere (a Microsoft Press publication of
> some sort) that, even when using *synchonous* I/O, you could pass an
> OVERLAPPED structure to ReadFile() and have it use the file offset in
> that structure, rather than the implicit stream pointer.
>
> So, I modified my "hacked up test program" from the other day to try
> it out; the diff looks like:
>
> -- >8 --
> diff --git a/test-pread.c b/test-pread.c
> index 61280cb..8a2b2ff 100644
> --- a/test-pread.c
> +++ b/test-pread.c
> @@ -1,5 +1,6 @@
> =A0#include "git-compat-util.h"
> =A0#include "thread-utils.h"
> +#include <windows.h>
>
> =A0#define DATA_FILE "junk.data"
> =A0#define MAX_DATA 256 * 1024
> @@ -16,6 +17,31 @@ struct thread_data {
>
> =A0static struct thread_data t[NUM_THREADS+1];
>
> +ssize_t pread_(int fd, void *buf, size_t count, off_t offset)
> +{
> + =A0 =A0 =A0 OVERLAPPED o =3D {0};
> + =A0 =A0 =A0 HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
> + =A0 =A0 =A0 uint64_t off =3D offset;
> + =A0 =A0 =A0 DWORD bytes;
> + =A0 =A0 =A0 BOOL ret;
> +
> + =A0 =A0 =A0 if (fh =3D=3D INVALID_HANDLE_VALUE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D EBADF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 o.Offset =3D off & 0xffffffff;
> + =A0 =A0 =A0 o.OffsetHigh =3D (off >> 32) & 0xffffffff;
> +
> + =A0 =A0 =A0 ret =3D ReadFile(fh, buf, (DWORD)count, &bytes, &o);
> + =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return (ssize_t)bytes;
> +}
> +
> =A0int create_data_file(void)
> =A0{
> =A0 =A0 =A0 =A0int i, fd =3D open(DATA_FILE, O_CREAT | O_TRUNC | O_WR=
ONLY, 0600);
> @@ -55,7 +81,7 @@ void *pread_thread(void *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssize_t sz;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d->n =3D d->n * 1103515245 + 12345;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0j =3D d->n % MAX_DATA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sz =3D pread(d->fd, &rd, sizeof(int), j=
 * sizeof(int));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sz =3D pread_(d->fd, &rd, sizeof(int), =
j * sizeof(int));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sz < 0 || rd !=3D j)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d->fails++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d->cnt++;
>
> -- 8< --
>
> The result of running the updated program looks like:
>
> =A0 =A0ramsay $ gcc -I. -o test-pread test-pread.c
> =A0 =A0ramsay $ ./test-pread.exe
> =A0 =A0 0: trials 524288, failed 262139
> =A0 =A0 1: trials 500000, failed 0
> =A0 =A0 2: trials 500000, failed 0
> =A0 =A0 3: trials 500000, failed 0
> =A0 =A0ramsay $
>
> So, the results are a little disappointing. :(
>
> Although ReadFile() is indeed using the OVERLAPPED structure to speci=
fy
> the read position, it is still updating the implicit stream position.
>
> So, this implementation does not faithfully reproduce the full semant=
ics
> of pread(), since it updates the stream position (affecting other I/O
> calls which rely on the implicit file position. eg read()).
>
> [Note: this was tested on Windows XP SP3. Maybe Vista/Win7/Win8 would
> behave differently?]
>
> This implementation should be sufficient to fix the immediate problem=
 with
> the threaded index-pack, but I'm not sure it would be a good idea to
> provide an *almost* compliant pread().
>
> I've attached the full test program below, just for completeness.
>

We've been through this before:

http://thread.gmane.org/CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZ=
N25w@mail.gmail.com

My worries are the same as yours: An approach like this looks a bit
too much like pread, and might make someone else assume it works the
same.
