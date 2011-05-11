From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] setup_revisions(): take pathspec from command line and
 --stdin correctly
Date: Wed, 11 May 2011 19:00:36 -0300
Message-ID: <BANLkTin401CWZntHowyCw=Ua0+SNAZ7m7A@mail.gmail.com>
References: <7vd3jogbe0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 00:00:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKHSV-0005VE-CG
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 00:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833Ab1EKWAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 18:00:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47717 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764Ab1EKWAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 18:00:36 -0400
Received: by iyb14 with SMTP id 14so710713iyb.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0Q/70BiVXvYWfa+NQDbs3VviTQa4xwkmzwEY8kSWJ8Q=;
        b=fjPviHsy2HvZKH/2T9j8i6JnVvWPeGxOv6nOdhP4XS7NomMkOvQXzTNIUtQXor02xe
         7hfjZJb+gntJpO9I/Qk8AEGN7IhBGpTCSvDQA5W+c769+La3g0nS+ikUy3flBnMezySI
         R8pZlBU8FiGzxpqtbkUAspTofbpzPqxwPQlTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t0/l6zudReGMUnLIgTw7N+SIdDFKQrvwK+HHQ5/pGa1HlkYYpjZQo79U31Qd36AUO1
         efqsnf18eYtTysuvTEofgKz3UPDuMsprWEAWbZt7k4jovY/0XK6norHPFo163Dx35nNC
         VJ0zVzLgEGfWio6PE4w3I1n1tJQBJHXsZSunA=
Received: by 10.42.150.133 with SMTP id a5mr8299081icw.179.1305151236206; Wed,
 11 May 2011 15:00:36 -0700 (PDT)
Received: by 10.42.170.132 with HTTP; Wed, 11 May 2011 15:00:36 -0700 (PDT)
In-Reply-To: <7vd3jogbe0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173431>

On Wed, May 11, 2011 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> When the command line has "--" disambiguator, we take the remainder o=
f
> argv[] as "prune_data", but when --stdin is given at the same time, w=
e
> need to append to the existing prune_data and end up attempting to
> realloc(3) it, which would not work and can lead to a segfault or wor=
se.
>
> Fix it by consistently using append_prune_data() throughout the input
> processing. =C2=A0Also avoid counting the number of existing paths in=
 the
> function over and over again.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =C2=A0* This is relative to 1.6.6; the bug originates back to 60da8b1=
 (Make
> =C2=A0 --stdin option to "log" family read also pathspecs, 2009-11-20=
).
>
> =C2=A0revision.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 80 ++++++++++++++++-----------------------------
> =C2=A0t/t6017-rev-list-stdin.sh | =C2=A0 17 +++++++++
> =C2=A02 files changed, 45 insertions(+), 52 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index c92ffc2..58b5651 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -956,35 +956,34 @@ int handle_revision_arg(const char *arg, struct=
 rev_info *revs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static void read_pathspec_from_stdin(struct rev_info *revs, struct s=
trbuf *sb, const char ***prune_data)
> -{
> - =C2=A0 =C2=A0 =C2=A0 const char **prune =3D *prune_data;
> - =C2=A0 =C2=A0 =C2=A0 int prune_nr;
> - =C2=A0 =C2=A0 =C2=A0 int prune_alloc;
> +struct cmdline_pathspec {
Maybe prune_data_pathspec?

> + =C2=A0 =C2=A0 =C2=A0 int alloc;
> + =C2=A0 =C2=A0 =C2=A0 int nr;
> + =C2=A0 =C2=A0 =C2=A0 const char **path;
> +};
>
> - =C2=A0 =C2=A0 =C2=A0 /* count existing ones */
> - =C2=A0 =C2=A0 =C2=A0 if (!prune)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune_nr =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (prune_nr =3D =
0; prune[prune_nr]; prune_nr++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ;
> - =C2=A0 =C2=A0 =C2=A0 prune_alloc =3D prune_nr; /* not really, but w=
e do not know */
> +static void append_prune_data(struct cmdline_pathspec *prune, const =
char **av)
av is the same thing as argv? If so, is it worth naming it argv? I
know the old was av, so maybe not though.

> +{
> + =C2=A0 =C2=A0 =C2=A0 while (*av) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune->=
path, prune->nr+1, prune->alloc);
I'd add spaces between prune->nr + 1. But I think is fine as is too.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune->path[prune-=
>nr++] =3D *(av++);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
>
> +static void read_pathspec_from_stdin(struct rev_info *revs, struct s=
trbuf *sb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmdline_=
pathspec *prune)
> +{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (strbuf_getwholeline(sb, stdin, '\n'=
) !=3D EOF) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int len =3D sb=
->len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len && sb-=
>buf[len - 1] =3D=3D '\n')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sb->buf[--len] =3D '\0';
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune, =
prune_nr+1, prune_alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune[prune_nr++] =
=3D xstrdup(sb->buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune->=
path, prune->nr+1, prune->alloc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune->path[prune-=
>nr++] =3D xstrdup(sb->buf);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if (prune) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune, =
prune_nr+1, prune_alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune[prune_nr] =3D=
 NULL;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 *prune_data =3D prune;
> =C2=A0}
>
> -static void read_revisions_from_stdin(struct rev_info *revs, const c=
har ***prune)
> +static void read_revisions_from_stdin(struct rev_info *revs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cmdline=
_pathspec *prune)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf sb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int seen_dashdash =3D 0;
> @@ -1279,34 +1278,6 @@ static int for_each_good_bisect_ref(each_ref_f=
n fn, void *cb_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return for_each_ref_in("refs/bisect/good",=
 fn, cb_data);
> =C2=A0}
>
> -static void append_prune_data(const char ***prune_data, const char *=
*av)
> -{
> - =C2=A0 =C2=A0 =C2=A0 const char **prune =3D *prune_data;
> - =C2=A0 =C2=A0 =C2=A0 int prune_nr;
> - =C2=A0 =C2=A0 =C2=A0 int prune_alloc;
> -
> - =C2=A0 =C2=A0 =C2=A0 if (!prune) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *prune_data =3D av=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 /* count existing ones */
> - =C2=A0 =C2=A0 =C2=A0 for (prune_nr =3D 0; prune[prune_nr]; prune_nr=
++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;
> - =C2=A0 =C2=A0 =C2=A0 prune_alloc =3D prune_nr; /* not really, but w=
e do not know */
> -
> - =C2=A0 =C2=A0 =C2=A0 while (*av) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune, =
prune_nr+1, prune_alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune[prune_nr++] =
=3D *av;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av++;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 if (prune) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune, =
prune_nr+1, prune_alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune[prune_nr] =3D=
 NULL;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 *prune_data =3D prune;
> -}
> -
> =C2=A0/*
> =C2=A0* Parse revision information, filling in the "rev_info" structu=
re,
> =C2=A0* and removing the used arguments from the argument list.
> @@ -1317,7 +1288,9 @@ static void append_prune_data(const char ***pru=
ne_data, const char **av)
> =C2=A0int setup_revisions(int argc, const char **argv, struct rev_inf=
o *revs, const char *def)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, flags, left, seen_dashdash, read_fr=
om_stdin;
> - =C2=A0 =C2=A0 =C2=A0 const char **prune_data =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 struct cmdline_pathspec prune_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&prune_data, 0, sizeof(prune_data));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* First, search for "--" */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0seen_dashdash =3D 0;
> @@ -1328,7 +1301,7 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, const ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv[i] =3D NU=
LL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argc =3D i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argv[i + 1=
])
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 prune_data =3D argv + i + 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 append_prune_data(&prune_data, argv + i + 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seen_dashdash =
=3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -1420,8 +1393,11 @@ int setup_revisions(int argc, const char **arg=
v, struct rev_info *revs, const ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (prune_data)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->prune_data =3D=
 get_pathspec(revs->prefix, prune_data);
> + =C2=A0 =C2=A0 =C2=A0 if (prune_data.nr) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(prune_d=
ata.path, prune_data.nr+1, prune_data.alloc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prune_data.path[pr=
une_data.nr++] =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->prune_data =3D=
 get_pathspec(revs->prefix, prune_data.path);
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (revs->def =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0revs->def =3D =
def;
> diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
> index f1c32db..667b375 100755
> --- a/t/t6017-rev-list-stdin.sh
> +++ b/t/t6017-rev-list-stdin.sh
> @@ -58,4 +58,21 @@ check side-3 ^side-4 -- file-3
> =C2=A0check side-3 ^side-2
> =C2=A0check side-3 ^side-2 -- file-1
>
> +test_expect_success 'not only --stdin' '
> + =C2=A0 =C2=A0 =C2=A0 cat >expect <<-EOF &&
> + =C2=A0 =C2=A0 =C2=A0 7
> +
> + =C2=A0 =C2=A0 =C2=A0 file-1
> + =C2=A0 =C2=A0 =C2=A0 file-2
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 cat >input <<-EOF &&
> + =C2=A0 =C2=A0 =C2=A0 ^master^
> + =C2=A0 =C2=A0 =C2=A0 --
> + =C2=A0 =C2=A0 =C2=A0 file-2
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 git log --pretty=3Dtformat:%s --name-only --st=
din master -- file-1 \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <input >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> =C2=A0test_done
> --
> 1.7.5.1.315.ge7efa
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
