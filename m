From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 8/8] vcs-svn: allow to disable 'progress' lines
Date: Wed, 6 Jul 2011 13:55:17 +0530
Message-ID: <CALkWK0nWSVrrtzwE2ePucK=XTnSHWuojxhoayRSUbZmk1We9Fg@mail.gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com> <1309715877-13814-9-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 10:25:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeNQY-0001tT-5f
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 10:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1GFIZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 04:25:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58721 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1GFIZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 04:25:38 -0400
Received: by wyg8 with SMTP id 8so4497354wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cE6iiq5FP5YpAMeFs80BiRfojWk0y5aRzKJBo92IyW0=;
        b=By68JcaRdoMtAq7+JZv+8RNMs2cDULTXwGCBM9daK8vbOklx46Kxky+3cmkwHtqy0b
         CE5C7iHzOeEWFnQGdcE+/8SUqKb+3qsSsu7JDKPDfRHJhrsidsoznVjbjwOoot8HO6Y9
         SaVqRid+4Az1Wwz9dys/s6tRS8Ui5lw2+YF78=
Received: by 10.217.3.17 with SMTP id q17mr5123713wes.107.1309940737098; Wed,
 06 Jul 2011 01:25:37 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 01:25:17 -0700 (PDT)
In-Reply-To: <1309715877-13814-9-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176662>

Hi Dmitry,

Dmitry Ivankov writes:
> vcs-svn/ writes a progress line after each processed revision. It
> is too noisy for big imports. That's a stress for a terminal and
> any other output can be lost or scrolled away among these lines.
>
> For now just add a switch to turn progress lines off:
> $ svn-fe --no-progress ...

Agreed.  Sounds like a good change.

> diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
> index 32755b1..792ffad 100644
> --- a/contrib/svn-fe/svn-fe.c
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -38,7 +42,7 @@ int main(int argc, const char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D argv[0=
];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (argc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage_with_opt=
ions(svn_fe_usage, svn_fe_options);
> - =C2=A0 =C2=A0 =C2=A0 if (svndump_init(NULL, url, ref, backflow_fd))
> + =C2=A0 =C2=A0 =C2=A0 if (svndump_init(NULL, url, ref, backflow_fd, =
progress))

You're modifying the svndump_init API for every new option that's
added.  This'll clearly break down when you have many options -- how
about wrapping it up in an options structure and then passing that?

> diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
> index a7ad368..f1a459e 100644
> --- a/contrib/svn-fe/svn-fe.txt
> +++ b/contrib/svn-fe/svn-fe.txt
> @@ -39,6 +39,9 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Integer number of file descriptor from whi=
ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0responses to 'ls' and 'cat-blob' requests =
will come.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is fd=3D3.
> +--[no-]progress::
> + =C2=A0 =C2=A0 =C2=A0 Write 'progress' lines to fast-import stream. =
These
> + =C2=A0 =C2=A0 =C2=A0 can be displayed by fast-import.

Hm, this will make it a little too silent for the end-user.  What do
you feel about printing something minimalistic like a '.' for each
imported revision?  Atleast it won't look like it's hung.  Also, how
does this interact with the 'progress' option of fast-import protocol?

> =C2=A0INPUT FORMAT
> =C2=A0------------
> diff --git a/test-svn-fe.c b/test-svn-fe.c
> index 7885eb1..e4bfda0 100644
> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
> @@ -62,7 +62,7 @@ int main(int argc, const char *argv[])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return apply_d=
elta(argc, argv);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc =3D=3D 1) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (svndump_init(a=
rgv[0], NULL, ref, backflow_fd))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (svndump_init(a=
rgv[0], NULL, ref, backflow_fd, 1))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0svndump_read()=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0svndump_deinit=
();
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index cfb0f2b..a8b8603 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -19,6 +19,7 @@ static uint32_t first_commit_done;
> =C2=A0static struct line_buffer postimage =3D LINE_BUFFER_INIT;
> =C2=A0static struct line_buffer report_buffer =3D LINE_BUFFER_INIT;
> =C2=A0static struct strbuf ref_name =3D STRBUF_INIT;
> +static int print_progress;

> @@ -30,9 +31,10 @@ static int init_postimage(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return buffer_tmpfile_init(&postimage);
> =C2=A0}
>
> -void fast_export_init(int fd, const char *dst_ref)
> +void fast_export_init(int fd, const char *dst_ref, int progress)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0first_commit_done =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 print_progress =3D progress;

The only reason you're modifying the API of fast_export_init is so
that it can set a global static variable?  Also, this change seems
more absurd because progress reporting isn't directly related to
fast_export_init.  How about having a dedicated function for option
parsing that sets all the global statics?

I'm sorry I haven't been more involved with this project.  Still, I
hope this review helps.

-- Ram
