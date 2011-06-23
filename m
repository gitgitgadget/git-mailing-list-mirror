From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCHv2 3/9] archive: refactor list of archive formats
Date: Thu, 23 Jun 2011 14:05:35 -0300
Message-ID: <BANLkTim7O3pcJAy4U1d6QiS6cvv2-Og21A@mail.gmail.com>
References: <20110622011923.GA30370@sigill.intra.peff.net>
	<20110622012333.GC30604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnLZ-0007WW-FD
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535Ab1FWRFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 13:05:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43959 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab1FWRFg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2011 13:05:36 -0400
Received: by ywe9 with SMTP id 9so791363ywe.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3mCLk7otHjtAzJW0Raj01u4whAirGVH0XPaKfnDvIWU=;
        b=kI+qLn4OF0rxqLvvVrCevmZQPlQCglhH5MDLa19nZwJQ3bwY9KaZrTtXlFdSk9HiI8
         DhfUnzTplZn14M0xktNJWIuoii6PH/Ex6IDrt0qwg8uzZGpIOX0UpL7DqAY7psdmUEPd
         iIoR9BYkpl5vRPgmGi611XF26yTsL9MlA4C/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tq0vXv74vFFO4yM7cajnqn8G3/4tmUONulZDzcgeLfqWDXnc5ujDRqigJePdzpeFhj
         NgptuBnSIfdAtOZtmv/ywFDdk1xySdiMWv0Aq6j+yluyHtF2RdM9WfYv9wkQbCWUwJPh
         7MW8LKJxE0FDaXLgaBE+V1I5UEOMXCBBydq+A=
Received: by 10.150.166.1 with SMTP id o1mr2724945ybe.154.1308848735589; Thu,
 23 Jun 2011 10:05:35 -0700 (PDT)
Received: by 10.150.216.12 with HTTP; Thu, 23 Jun 2011 10:05:35 -0700 (PDT)
In-Reply-To: <20110622012333.GC30604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176280>

On Tue, Jun 21, 2011 at 10:23 PM, Jeff King <peff@peff.net> wrote:
> Most of the tar and zip code was nicely split out into two
> abstracted files which knew only about their specific
> formats. The entry point to this code was a single "write
> archive" function.
>
> However, as these basic formats grow more complex (e.g., by
> handling multiple file extensions and format names), a
> static list of the entry point functions won't be enough.
> Instead, let's provide a way for the tar and zip code to
> tell the main archive code what they support by registering
> archiver names and functions.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> New in v2. This turns archivers more into proper objects, rather than=
 a
> hard-coded list of functions, and makes the rest of the series much
> cleaner.
>
> =C2=A0archive-tar.c | =C2=A0 16 +++++++++++++---
> =C2=A0archive-zip.c | =C2=A0 13 ++++++++++++-
> =C2=A0archive.c =C2=A0 =C2=A0 | =C2=A0 33 +++++++++++++++++----------=
------
> =C2=A0archive.h =C2=A0 =C2=A0 | =C2=A0 17 ++++++++++-------
> =C2=A04 files changed, 52 insertions(+), 27 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 1ab1a2c..930375b 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -234,12 +234,10 @@ static int git_tar_config(const char *var, cons=
t char *value, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -int write_tar_archive(struct archiver_args *args)
> +static int write_tar_archive(struct archiver_args *args)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 git_config(git_tar_config, NULL);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (args->commit_sha1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D write_=
global_extended_header(args);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)
> @@ -248,3 +246,15 @@ int write_tar_archive(struct archiver_args *args=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_trailer(=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> =C2=A0}
> +
> +static struct archiver tar_archiver =3D {
> + =C2=A0 =C2=A0 =C2=A0 "tar",
> + =C2=A0 =C2=A0 =C2=A0 write_tar_archive,
> + =C2=A0 =C2=A0 =C2=A0 0
A named constant instead of 0, like you did with
ARCHIVER_WANT_COMPRESSION_LEVELS, would be better? 0 here means the
archiver does not want compression?
