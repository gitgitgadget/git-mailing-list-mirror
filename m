From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Small "git clean" annoyance
Date: Fri, 1 Apr 2011 07:48:12 -0700
Message-ID: <AANLkTinD=Zx0tdY53n8mXvpufCUr96v0u1DbzasRXMfY@mail.gmail.com>
References: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com> <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 17:21:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5gA2-0007DU-7l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 17:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802Ab1DAPVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 11:21:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52530 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690Ab1DAPVL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 11:21:11 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id p31FKNgh015417
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 1 Apr 2011 08:20:23 -0700
Received: by iwn34 with SMTP id 34so3607865iwn.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 08:20:21 -0700 (PDT)
Received: by 10.42.155.136 with SMTP id u8mr2423886icw.403.1301669667501; Fri,
 01 Apr 2011 07:54:27 -0700 (PDT)
Received: by 10.231.11.4 with HTTP; Fri, 1 Apr 2011 07:48:12 -0700 (PDT)
In-Reply-To: <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
X-Spam-Status: No, hits=-102.976 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170592>

On Fri, Apr 1, 2011 at 12:34 AM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
>
> Something like this?
>
> diff --git a/dir.c b/dir.c
> index 325fb56..7251426 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1191,8 +1191,11 @@ int remove_dir_recursively(struct strbuf *path=
, int flag)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0dir =3D opendir(path->buf);
> - =A0 =A0 =A0 if (!dir)
> + =A0 =A0 =A0 if (!dir) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rmdir(path->buf) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> + =A0 =A0 =A0 }

Heh. My minimalist sensibilities go "yuck", and say that you should jus=
t do

    if (!dir)
        return rmdir(path->buf);

instead.

But not a big deal. Looks fine, and fixes the trivial annoyance.

I'd still like the better error message. With "rm -rf" I get good
error messages even for the complex case:

  [torvalds@i5 git]$ mkdir tmp
  [torvalds@i5 git]$ mkdir tmp/tmp
  [torvalds@i5 git]$ chmod -w tmp
  [torvalds@i5 git]$ rm -rf tmp
  rm: cannot remove `tmp/tmp': Permission denied

but "git clean" says:

  [torvalds@i5 git]$ git clean -dqfx
  warning: failed to remove tmp/

Hmm.

Adding the obvious "strerror(errno)" to builtin/clean.c just changes it=
 to

  warning: failed to remove tmp/ (Permission denied)

which I guess is better, but not entirely obvious (it's "tmp/tmp" that
failed to remove due to permissions, but clean.c only sees/cares about
the uppermost level)

But it's probably not worth worrying about any more. The simple
one-liner rmdir() looks worth it.

                         Linus
