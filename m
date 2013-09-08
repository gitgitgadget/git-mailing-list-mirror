From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] dir: remove dead code
Date: Sun, 08 Sep 2013 18:03:36 +0200
Message-ID: <522C9FD8.9000804@web.de>
References: <1378620563-32709-1-git-send-email-artagnon@gmail.com> <522C6DFA.10204@web.de> <CALkWK0kYq8nxUVg7bOr-93+WFRSVp4YcpVsJ+3wKcveRV8As2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 18:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIhSo-0002h4-Vz
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 18:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693Ab3IHQDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 12:03:46 -0400
Received: from mout.web.de ([212.227.17.11]:56308 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab3IHQDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 12:03:45 -0400
Received: from [192.168.2.102] ([79.253.173.109]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lm4lR-1Vs2982qRt-00ZdP6 for <git@vger.kernel.org>;
 Sun, 08 Sep 2013 18:03:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CALkWK0kYq8nxUVg7bOr-93+WFRSVp4YcpVsJ+3wKcveRV8As2A@mail.gmail.com>
X-Provags-ID: V03:K0:lDiE7cmQByRFhraqjXIW/UiozcewUhUWAjNylIo5Oa64oh76OYh
 FuLeglI9o1SxBLZhsNASsWPjobye2Ug+fxLi5pToAIJ2C3a1XPZQhhbbDhCawCirgp2O7Bq
 gmiw6k5k1MGjN9JCIC0rYhrcXhvwQx7taK53UO/S8Tn2aCvc2q0gKZ9K1AvxuWK7SOj7DME
 AjQka/mEsVJjZN+H2ek1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234253>

Am 08.09.2013 16:42, schrieb Ramkumar Ramachandra:
> On Sun, Sep 8, 2013 at 6:00 PM, Ren=C3=A9 Scharfe <l.s.r@web.de
> <mailto:l.s.r@web.de>> wrote:
>
>     Am 08.09.2013 08:09, schrieb Ramkumar Ramachandra:
>
>         Remove dead code around remove_dir_recursively().
>
>
>     This basically reverts ae2f203e (clean: preserve nested git workt=
ree
>     in subdirectories).  t7300 still seems to pass, though.  I wonder=
 why.
>
>
> t7300 has nothing to do with ae2f203e.

ae2f203e modified t/t7300-clean.sh.

>
>            dir.c | 21 ++++-----------------
>            1 file changed, 4 insertions(+), 17 deletions(-)
>
>         diff --git a/dir.c b/dir.c
>         index 910bfcd..2b31241 100644
>         --- a/dir.c
>         +++ b/dir.c
>         @@ -1464,11 +1464,11 @@ int is_empty_dir(const char *path)
>                  return ret;
>            }
>
>         -static int remove_dir_recurse(struct strbuf *path, int flag,
>         int *kept_up)
>         +int remove_dir_recursively(struct strbuf *path, int flag)
>            {
>                  DIR *dir;
>                  struct dirent *e;
>         -       int ret =3D 0, original_len =3D path->len, len, kept_=
down =3D 0;
>         +       int ret =3D 0, original_len =3D path->len, len;
>                  int only_empty =3D (flag & REMOVE_DIR_EMPTY_ONLY);
>                  int keep_toplevel =3D (flag & REMOVE_DIR_KEEP_TOPLEV=
EL);
>                  unsigned char submodule_head[20];
>         @@ -1476,8 +1476,6 @@ static int remove_dir_recurse(struct
>         strbuf *path, int flag, int *kept_up)
>                  if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
>                      !resolve_gitlink_ref(path->__buf, "HEAD",
>         submodule_head)) {
>                          /* Do not descend and nuke a nested git work
>         tree. */
>         -               if (kept_up)
>         -                       *kept_up =3D 1;
>                          return 0;
>                  }
>
>         @@ -1504,7 +1502,7 @@ static int remove_dir_recurse(struct
>         strbuf *path, int flag, int *kept_up)
>                          if (lstat(path->buf, &st))
>                                  ; /* fall thru */
>                          else if (S_ISDIR(st.st_mode)) {
>         -                       if (!remove_dir_recurse(path, flag,
>         &kept_down))
>         +                       if (!remove_dir_recursively(path, fla=
g))
>
>
>     kept_down could have been set to 1 here...
>
>
> Not possible.

Why?

I guess the answer is that kept_down could have only been set if the=20
flag REMOVE_DIR_KEEP_NESTED_GIT is given, which only git clean uses,=20
which in turn has its own implementation of remove_dir_recursively()=20
named remove_dirs() since f538a91e (git-clean: Display more accurate=20
delete messages).

That probably means you can remove even more code from=20
remove_dir_recursively().

>
>                                          continue; /* happy */
>                          } else if (!only_empty && !unlink(path->buf)=
)
>                                  continue; /* happy, too */
>         @@ -1516,22 +1514,11 @@ static int remove_dir_recurse(struct
>         strbuf *path, int flag, int *kept_up)
>                  closedir(dir);
>
>                  strbuf_setlen(path, original_len);
>         -       if (!ret && !keep_toplevel && !kept_down)
>         +       if (!ret && !keep_toplevel)
>                          ret =3D rmdir(path->buf);
>
>
>     ... and would have prevented the rmdir() call here.
>
>     Is the removed code really dead?  And if not, why does t7300 stil=
l pass?
>
>
> Yes, it clearly is. Shared secret.

What is the secret and who shares it?

Thanks,
Ren=C3=A9
