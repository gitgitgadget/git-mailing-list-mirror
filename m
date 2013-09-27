From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 10:03:37 -0400
Message-ID: <CABURp0rrMV2Em=acG80KqqByo1nurC5azU5UBWB0L5p3Zcra8A@mail.gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com> <1380283828-25420-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:04:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPYeL-0003rW-O7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab3I0OEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:04:01 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:58225 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3I0OEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:04:00 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so882422wib.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9eDmNX+FFzIke5zMbTHJkEzx/8P+iRsZj0iCI1CNo+c=;
        b=DSJ+wqktQM3nRFmqykl725AV+VsWWQHYaSnxeb34g1Na0aSdTw2EThjD1xWzXulB2S
         Aqx+v/xf1MXA1muVL+DcfqZ7zt8Ztwtvg8lalKbolIXeiZGB12opC4joxrkm+GbrYFPz
         I+q3mesK+0BQtZSpYVji78KGI/dxDpAvRXRVuRbDX8rLj0Y33YFC2EeBtQZLwSHcEU/B
         aCCEvOvshtWm6giN68eOQmii7aZFlGY9yMAEU7+JyCvOItHBK3vsSYgFwVPddFce1WgI
         XTcTMqfFHxrRxFyfPftpKEMaXkNf2kTf1etTAB7xxMRFfSe1wbL66LRTPWwOrtGYGZ80
         9itw==
X-Received: by 10.180.171.7 with SMTP id aq7mr2802580wic.28.1380290637191;
 Fri, 27 Sep 2013 07:03:57 -0700 (PDT)
Received: by 10.227.145.73 with HTTP; Fri, 27 Sep 2013 07:03:37 -0700 (PDT)
In-Reply-To: <1380283828-25420-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235461>

On Fri, Sep 27, 2013 at 8:10 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Introduce %(upstream:track) to display "[ahead M, behind N]" and
> %(upstream:trackshort) to display "=", ">", "<", or "<>"
> appropriately (inspired by contrib/completion/git-prompt.sh).
>
> Now you can use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)%(upstream:trackshort)
>
> to display refs with terse tracking information.

Thanks.  I like this.

>
> Note that :track and :trackshort only work with "upstream", and error
> out when used with anything else.

I think I would like to use %(refname:track) myself, but this does not
detract from this change.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  6 +++++-
>  builtin/for-each-ref.c             | 44 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f1d4e9e..682eaa8 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -93,7 +93,11 @@ objectname::
>  upstream::
>         The name of a local ref which can be considered ``upstream''
>         from the displayed ref. Respects `:short` in the same way as
> -       `refname` above.
> +       `refname` above.  Additionally respects `:track` to show
> +       "[ahead N, behind M]" and `:trackshort` to show the terse
> +       version (like the prompt) ">", "<", "<>", or "=".  Has no
> +       effect if the ref does not have tracking information
> +       associated with it.
>
>  HEAD::
>         Used to indicate the currently checked out branch.  Is '*' if
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index e54b5d8..10843bb 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -631,6 +631,7 @@ static void populate_value(struct refinfo *ref)
>         int eaten, i;
>         unsigned long size;
>         const unsigned char *tagged;
> +       int upstream_present = 0;

This flag is out of place.  It should be in the same scope as 'branch'
since the code which depends on this flag also depends on '!!branch'.

However, I don't think it is even necessary.  The only way to reach
the places where this flag is tested is when (name="upstream") and
(upstream exists).  In all other cases, the parser loops before
reaching the track/trackshort code or else it doesn't enter it.

>
>         ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
>
> @@ -648,6 +649,7 @@ static void populate_value(struct refinfo *ref)
>                 int deref = 0;
>                 const char *refname;
>                 const char *formatp;
> +               struct branch *branch;
>
>                 if (*name == '*') {
>                         deref = 1;
> @@ -659,7 +661,6 @@ static void populate_value(struct refinfo *ref)
>                 else if (!prefixcmp(name, "symref"))
>                         refname = ref->symref ? ref->symref : "";
>                 else if (!prefixcmp(name, "upstream")) {
> -                       struct branch *branch;
>                         /* only local branches may have an upstream */
>                         if (prefixcmp(ref->refname, "refs/heads/"))
>                                 continue;
> @@ -669,6 +670,7 @@ static void populate_value(struct refinfo *ref)
>                             !branch->merge[0]->dst)
>                                 continue;
>                         refname = branch->merge[0]->dst;
> +                       upstream_present = 1;
>                 }
>                 else if (!strcmp(name, "flag")) {
>                         char buf[256], *cp = buf;
> @@ -686,6 +688,7 @@ static void populate_value(struct refinfo *ref)
>                 } else if (!strcmp(name, "HEAD")) {
>                         const char *head;
>                         unsigned char sha1[20];
> +
>                         head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
>                         if (!strcmp(ref->refname, head))
>                                 v->s = "*";
> @@ -698,11 +701,48 @@ static void populate_value(struct refinfo *ref)
>                 formatp = strchr(name, ':');
>                 /* look for "short" refname format */
>                 if (formatp) {
> +                       int num_ours, num_theirs;
> +
>                         formatp++;
>                         if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);
> -                       else
> +                       else if (!strcmp(formatp, "track") &&
> +                               !prefixcmp(name, "upstream")) {
> +                               char buf[40];
> +
> +                               if (!upstream_present)
> +                                       continue;
> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
> +                               if (!num_ours && !num_theirs)
> +                                       v->s = "";

Is this the same as 'continue'?

> +                               else if (!num_ours) {
> +                                       sprintf(buf, "[behind %d]", num_theirs);
> +                                       v->s = xstrdup(buf);
> +                               } else if (!num_theirs) {
> +                                       sprintf(buf, "[ahead %d]", num_ours);
> +                                       v->s = xstrdup(buf);
> +                               } else {
> +                                       sprintf(buf, "[ahead %d, behind %d]",
> +                                               num_ours, num_theirs);
> +                                       v->s = xstrdup(buf);
> +                               }
> +                               continue;
> +                       } else if (!strcmp(formatp, "trackshort") &&
> +                               !prefixcmp(name, "upstream")) {
> +                               if (!upstream_present)
> +                                       continue;
> +                               stat_tracking_info(branch, &num_ours, &num_theirs);
> +                               if (!num_ours && !num_theirs)
> +                                       v->s = "=";
> +                               else if (!num_ours)
> +                                       v->s = "<";
> +                               else if (!num_theirs)
> +                                       v->s = ">";
> +                               else
> +                                       v->s = "<>";
> +                               continue;
> +                       } else
>                                 die("unknown %.*s format %s",
>                                     (int)(formatp - name), name, formatp);
>                 }
> --
> 1.8.4.478.g55109e3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
