From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sat, 13 Jun 2015 23:42:58 -0400
Message-ID: <CAPig+cTQKxD9WRV3spVce=SfeECo4XR_ujZ1sGecuhTL-3DeRw@mail.gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
	<1433874279-30720-3-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 05:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3ywj-0003HB-5q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 05:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbbFNDte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2015 23:49:34 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33954 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbFNDtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 23:49:32 -0400
Received: by ykfl8 with SMTP id l8so35564650ykf.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mFT58d44bxZdFHTMQhfak8WpQWX+2rYPCgejLXnVyic=;
        b=Rc9uSaEthUcqGRMVwEl9L69kZcd+sMsHVI0PVdMG9ra9V9Sdhz3q76F/YHY9MOYNs5
         T1kRU3FSVJz9R7khEoiaxwgJFKEviLICSzrrTmXRDuXoa7YrCFHOaBtKI1ni2BO1rELK
         pKbuS/OLS4zKCHbjKn1bguygb4Uzr4spjiSCtknobGkcmzzk+SA0tWXdfm4xqjXF3am5
         IlRpzpYkgho9Slq3Nu5ZruotCfrnlvgkqqgyLMj+4E2kZzNmzxqKXT+jnxxtTVm1z7Dx
         OGX4Cd2BA+DJIddNP8eNmGkhk++3ZtMBZXjYYYxx1JvfvToSYU6sT3Vkz4jXV7gurKOK
         vuNQ==
X-Received: by 10.129.50.207 with SMTP id y198mr1170269ywy.39.1434253378925;
 Sat, 13 Jun 2015 20:42:58 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Sat, 13 Jun 2015 20:42:58 -0700 (PDT)
In-Reply-To: <1433874279-30720-3-git-send-email-erik.elfstrom@gmail.com>
X-Google-Sender-Auth: hTNY9rZxwC2uJbJMXLC48j5HUpo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271603>

On Tue, Jun 9, 2015 at 2:24 PM, Erik Elfstr=C3=B6m <erik.elfstrom@gmail=
=2Ecom> wrote:
> read_gitfile_gently will allocate a buffer to fit the entire file tha=
t
> should be read. Add a sanity check of the file size before opening to
> avoid allocating a potentially huge amount of memory if we come acros=
s
> a large file that someone happened to name ".git". The limit is set t=
o
> a sufficiently unreasonable size that should never be exceeded by a
> genuine .git file.
>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
> diff --git a/setup.c b/setup.c
> index 4748b63..e76955e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -414,6 +414,7 @@ static void update_linked_gitdir(const char *gitf=
ile, const char *gitdir)
>   */
>  const char *read_gitfile_gently(const char *path, int *return_error_=
code)
>  {
> +       static const int one_MB =3D 1 << 20;

This variable name doesn't convey much about its purpose, and
introduces a bit of maintenance burden if the limit is some day
changed. Perhaps "sane_size_limit" or something even more descriptive
(and/or terse) would be better.

>         int error_code =3D 0;
>         char *buf =3D NULL;
>         char *dir =3D NULL;
> @@ -430,6 +431,10 @@ const char *read_gitfile_gently(const char *path=
, int *return_error_code)
>                 error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
>                 goto cleanup_return;
>         }
> +       if (st.st_size > one_MB) {
> +               error_code =3D READ_GITFILE_ERR_TOO_LARGE;
> +               goto cleanup_return;
> +       }
>         fd =3D open(path, O_RDONLY);
>         if (fd < 0) {
>                 error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
> @@ -489,6 +494,8 @@ cleanup_return:
>                         return NULL;
>                 case READ_GITFILE_ERR_OPEN_FAILED:
>                         die_errno("Error opening '%s'", path);
> +               case READ_GITFILE_ERR_TOO_LARGE:
> +                       die("Too large to be a .git file: '%s'", path=
);
>                 case READ_GITFILE_ERR_READ_FAILED:
>                         die("Error reading %s", path);
>                 case READ_GITFILE_ERR_INVALID_FORMAT:
> --
> 2.4.3.373.gc496bfb
