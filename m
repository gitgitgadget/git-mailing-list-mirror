From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] gc: reject if another gc is running, unless --force is given
Date: Sat, 3 Aug 2013 13:22:25 +0530
Message-ID: <CALkWK0k1vf_WE=pV5XTMAM6Ax6rL3sXu4qx_eyYwvWGsZjXgmA@mail.gmail.com>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com> <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5WeZ-0005pj-9O
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab3HCHxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 03:53:09 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:43864 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3HCHxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 03:53:07 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so3045968oag.32
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EFVbsEhCY5pLEwaQIw2Ly6cLXVsPPuDE6NTdUGlCDcI=;
        b=0EeBackETjQL3YHEmGcMA4CgfppFQHlMcag9NBC5/CzzOQClCz1U7YU++S6D0zdgwo
         ewWlZ/GBCHqi2uAhajFqKkuZIAjDIIb0OhtXwtgYNsDX2QpxI7rAqx9UuLAfZhoyuSLm
         8V+JEaZLs5khHnIfNwjEigNJOIVVhZT+OrT0+/lKx618WA9sYHwRfx4qHLwuTUOfG6vQ
         UdaS9LQ5JW7Mzfo1LBURMh/DxWiFaUIXAjoOd5rt6k17q7or6eryOzcSdtu7LPXKgQ9B
         RQmuBx7IV+XbTBJ5rq1vUFMCCxYstzQSP4VFBbY18OIyPRBCkOuYXf+qBGd99AgQlLCf
         1JbA==
X-Received: by 10.50.73.74 with SMTP id j10mr244059igv.50.1375516386174; Sat,
 03 Aug 2013 00:53:06 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 3 Aug 2013 00:52:25 -0700 (PDT)
In-Reply-To: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231571>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This may happen when `git gc --auto` is run automatically, then the
> user, to avoid wait time, switches to a new terminal, keeps working
> and `git gc --auto` is started again because the first gc instance ha=
s
> not clean up the repository.
>
> This patch tries to avoid multiple gc running, especially in --auto
> mode. In the worst case, gc may be delayed 12 hours if a daemon reuse=
s
> the pid stored in gc-%s.pid.

Definitely looks like a good solution. Thanks for this.

I'm currently on vacation, so can't apply and test: sorry.

> +       if (!force &&
> +           (fp =3D fopen(git_path("gc-%s.pid", utsname.nodename), "r=
")) !=3D NULL &&
> +           !fstat(fileno(fp), &st) &&

It's open for a very short period of time, so lockfile (which we'd
normally use) would probably be an overkill.

> +           time(NULL) - st.st_mtime <=3D 12 * 3600) {

Quick question: is this kind of file-lifetime used anywhere else in git=
=2Egit?

> +                       if (auto_gc)
> +                               return 0; /* be quiet on --auto */
> +                       die(_("gc is already running"));

Nice.
