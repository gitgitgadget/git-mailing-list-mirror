From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 27/27] count-objects: report unused files in $GIT_DIR/repos/...
Date: Tue, 4 Mar 2014 23:25:42 -0500
Message-ID: <CAPig+cToTqJ4PPX3mvt0ftC-+Ncfiakz5dd_=xymM76T01z4fQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-28-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 05:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL3PW-00075Z-60
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 05:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbaCEEZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 23:25:57 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:37686 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170AbaCEEZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 23:25:43 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so1396620ykb.8
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=DA442Gw4N7zL4Jdlrs8kndkElpfv/2OnnAMOZ3R6HRM=;
        b=HGX/zq+tLlnZdyqhJvh2Bjgv58qtkZSJFjiTT19Cb8SZQNd7Z0MBos49ltbHiFZNlM
         AvHiE2v3t8bp6kwH/uAuMgrFwpNNr0l1ldf18SrMN1WdYdfiUuOrhprAb4OhEhxrBqkp
         mbfAfVv/OfoppxGKdJCTmhMjVGnM3yXqwIkH5NVnAgB5YgwaWMFN5gacYRMSjEH51oi2
         MP5ivJZ5uIatsKbzZ/8UDmAImzc1v+Eo9AWydDR1Lowh99bYw+fANwsZbeu4jmTjKEZt
         ZeIR/zCmB4ZGVFdM+icfxTH2nkq1uJ8EznMA/Jr5Mzqw7SJ4v5FOOz+kQkbWuLA/TNgz
         zj+g==
X-Received: by 10.236.157.102 with SMTP id n66mr4009837yhk.41.1393993542729;
 Tue, 04 Mar 2014 20:25:42 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 20:25:42 -0800 (PST)
In-Reply-To: <1393675983-3232-28-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: GzcxXIaPYaOV2wkt6X1a5zhAYLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243417>

On Sat, Mar 1, 2014 at 7:13 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> In linked checkouts, borrowed parts like config is taken from
> $GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
> garbage.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/count-objects.c | 37 ++++++++++++++++++++++++++++++++++++-
>  path.c                  |  4 ++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index a7f70cb..725cd5f 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -78,6 +78,39 @@ static void count_objects(DIR *d, char *path, int =
len, int verbose,
>         }
>  }
>
> +static void report_linked_checkout_garbage(void)
> +{
> +       /*
> +        * must be more or less in sync with * path.c:update_common_d=
ir().
> +        *
> +        * "logs" is let slip because logs/HEAD is in $GIT_DIR but th=
e
> +        * remaining in $GIT_COMMON_DIR. Probably not worth traversin=
g
> +        * the entire "logs" directory for that.
> +        *
> +        * The same "gc.pid" for because it's a temporary file.
> +        */
> +       const char *list[] =3D {
> +               "branches", "hooks", "info", "lost-found", "modules",
> +               "objects", "refs", "remotes", "rr-cache", "svn",
> +               "config", "packed-refs", "shallow", NULL
> +       };
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char **p;
> +       int len;
> +
> +       if (!file_exists(git_path("commondir")))
> +               return;
> +       strbuf_addf(&sb, "%s/", get_git_dir());
> +       len =3D sb.len;
> +       for (p =3D list; *p; p++) {
> +               strbuf_setlen(&sb, len);
> +               strbuf_addstr(&sb, *p);
> +               if (file_exists(sb.buf))
> +                       report_garbage("unused in linked checkout", s=
b.buf);
> +       }
> +       strbuf_release(&sb);
> +}
> +
>  static char const * const count_objects_usage[] =3D {
>         N_("git count-objects [-v] [-H | --human-readable]"),
>         NULL
> @@ -102,8 +135,10 @@ int cmd_count_objects(int argc, const char **arg=
v, const char *prefix)
>         /* we do not take arguments other than flags for now */
>         if (argc)
>                 usage_with_options(count_objects_usage, opts);
> -       if (verbose)
> +       if (verbose) {
>                 report_garbage =3D real_report_garbage;
> +               report_linked_checkout_garbage();
> +       }
>         memcpy(path, objdir, len);
>         if (len && objdir[len-1] !=3D '/')
>                 path[len++] =3D '/';
> diff --git a/path.c b/path.c
> index 47383ff..2e6035d 100644
> --- a/path.c
> +++ b/path.c
> @@ -92,6 +92,10 @@ static void replace_dir(struct strbuf *buf, int le=
n, const char *newdir)
>
>  static void update_common_dir(struct strbuf *buf, int git_dir_len)
>  {
> +       /*
> +        * Remember to report_linked_checkout_garbage()
> +        * builtin/count-objects.c
> +        */

I couldn't figure out why this comment was telling me to remember to
report "linked checkout garbage" until I realized that you omitted the
word "update" (as in "remember to update"). It might be clearer to say
something along these lines:

    Keep synchronized with related list in
    builtin/count-objects.c:report_linked_checkout_garbage().

Is it not possible or just too much of a hassle to maintain this list
in just one place, as in a header which is included by these two
files? The exceptions, such as 'log' and 'gc.pid', could be marked by
a special character in the entry ("!gc.pid", for example) or any such
scheme.

>         const char *common_dir_list[] =3D {
>                 "branches", "hooks", "info", "logs", "lost-found", "m=
odules",
>                 "objects", "refs", "remotes", "repos", "rr-cache", "s=
vn",
> --
> 1.9.0.40.gaa8c3ea
