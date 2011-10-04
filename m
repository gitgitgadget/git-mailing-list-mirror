From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] Teach transport about the gitfile mechanism
Date: Wed, 5 Oct 2011 08:46:33 +1100
Message-ID: <CACsJy8AtUWbuXVQxA7jT7rQmAzPpd72trqcSH_6X=P0FBU1vwQ@mail.gmail.com>
References: <CABURp0qkVcpNRyEg8gcNPjv2KbRbdHYk1XsqCjkp8Yrf7T_Lkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 23:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBCpT-0004pT-9h
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 23:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207Ab1JDVrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 17:47:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47476 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190Ab1JDVrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 17:47:04 -0400
Received: by bkbzt4 with SMTP id zt4so1237540bkb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yR2cavosLVBhRgjkMLkuC3ryv790r07CEc01w3p7enY=;
        b=M4Z6x3B5Bn2Mg8SIUMIvHPzpv9zmLbuKWd885Ah85GYDbJT0kRfnKtYcIXDpVMFL35
         0u9c/7bDX4a77ReAEZqGigEHk7t8HdG4/B6Kc0Hc9A+jc88P4of/Tfs50oLrPF6wFGMq
         Daf0JsPM7w2iKlQp+xCUNwiTZNJX4+PCLlMVE=
Received: by 10.204.129.4 with SMTP id m4mr1060667bks.251.1317764823205; Tue,
 04 Oct 2011 14:47:03 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Tue, 4 Oct 2011 14:46:33 -0700 (PDT)
In-Reply-To: <CABURp0qkVcpNRyEg8gcNPjv2KbRbdHYk1XsqCjkp8Yrf7T_Lkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182806>

On Wed, Oct 5, 2011 at 7:08 AM, Phil Hord <phil.hord@gmail.com> wrote:
> +static int is_gitfile(const char *url)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stat st;
> + =C2=A0 =C2=A0 =C2=A0 char buf[9];
> + =C2=A0 =C2=A0 =C2=A0 int fd, len;
> + =C2=A0 =C2=A0 =C2=A0 if (stat(url, &st))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 if (!S_ISREG(st.st_mode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 if (st.st_size < 10 || st.st_size > PATH_MAX)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 fd =3D open(url, O_RDONLY);
> + =C2=A0 =C2=A0 =C2=A0 if (fd < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno("Error o=
pening '%s'", url);
> + =C2=A0 =C2=A0 =C2=A0 len =3D read_in_full(fd, buf, sizeof(buf));
> + =C2=A0 =C2=A0 =C2=A0 close(fd);
> + =C2=A0 =C2=A0 =C2=A0 if (len !=3D sizeof(buf))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Error reading=
 %s", url);
> + =C2=A0 =C2=A0 =C2=A0 return !prefixcmp(buf, "gitdir: ");
> +}
> +

There's similar code in get_repo_path(), builtin/clone.c, added in
commit 9b0ebc7 (clone: allow to clone from .git file). Perhaps you can
reuse this function there and remove duplicate code.
--=20
Duy
