From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [WIP/PATCH 9/9] submodule: teach unpack_trees() to update submodules
Date: Tue, 4 Feb 2014 07:11:32 +0700
Message-ID: <CACsJy8CiAPnatithenDKBBKVGFHQZsu4mJLEjuWFD2GXqO56Lw@mail.gmail.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF3E9.2060403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATcX-0006WC-6e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbaBDAME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 19:12:04 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:56212 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaBDAMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 19:12:03 -0500
Received: by mail-qa0-f41.google.com with SMTP id w8so11256753qac.28
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S67ED3zvv15Kup/+0CR0jaeP6YLDwCwXyCJaXaxUsNQ=;
        b=cVtx7AVZcgpBdh1I3/hM61eGW++KYKRomq2yCYRxZPZ2XplKI/tDQZVD3a0PDSfXbT
         vSRHav83XzOBgIjjCjtX0qXdmFqq+L1e6W9rccS+iUCAkGwMmDZ0TArqXPucWMZP9n1h
         NH918yPHKZHvpum2iDXOM5ZhJ13ifIOVDvppv0Nb8iW/ZSihUOJxHimphpd4YVCmMMLq
         KAUk9R6keLOZs0gt+fz+kytp91askwtwtkNJqLGxaU4atqQo/Djl1cdgBCYLH46En/f+
         gbhUM3u3OB4jbVIzSWDzQLOHEp+pfjFTKIXNDfpqB0mQerToq1/qCHYWYKGzr68TmwoY
         PKYQ==
X-Received: by 10.140.84.19 with SMTP id k19mr57778185qgd.98.1391472722378;
 Mon, 03 Feb 2014 16:12:02 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 3 Feb 2014 16:11:32 -0800 (PST)
In-Reply-To: <52EFF3E9.2060403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241502>

On Tue, Feb 4, 2014 at 2:54 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Implement the functionality needed to enable work tree manipulating
> commands so that an changed submodule does not only affect the index but
> it also updates the work tree of any initialized submodule according to
> the SHA-1 recorded in the superproject.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  entry.c        | 15 ++++++++--
>  submodule.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h    |  3 ++
>  unpack-trees.c | 69 ++++++++++++++++++++++++++++++++++++----------
>  unpack-trees.h |  1 +
>  5 files changed, 157 insertions(+), 17 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index d1bf6ec..61a2767 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -265,7 +265,7 @@ int checkout_entry(struct cache_entry *ce,
>
>         if (!check_path(path, len, &st, state->base_dir_len)) {
>                 unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
> -               if (!changed)
> +               if (!changed && (!S_ISDIR(st.st_mode) || !S_ISGITLINK(ce->ce_mode)))
>                         return 0;

Should we report something when ce is a gitlink, but path is not a
directory, instead of siliently exit?

> diff --git a/submodule.c b/submodule.c
> index 3907034..83e7595 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -520,6 +520,42 @@ int depopulate_submodule(const char *path)
>         return 0;
>  }
>
> +int update_submodule(const char *path, const unsigned char sha1[20], int force)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       struct child_process cp;
> +       const char *hex_sha1 = sha1_to_hex(sha1);
> +       const char *argv[] = {
> +               "checkout",
> +               force ? "-fq" : "-q",

respect "state->quiet" in checkout_entry() as well?

> +               hex_sha1,
> +               NULL,
> +       };
> +       const char *git_dir;
> +
> +       strbuf_addf(&buf, "%s/.git", path);
> +       git_dir = read_gitfile(buf.buf);
> +       if (!git_dir)
> +               git_dir = buf.buf;
> +       if (!is_directory(git_dir)) {
> +               strbuf_release(&buf);
> +               /* The submodule is not populated, so we can't check it out */
> +               return 0;
> +       }
> +       strbuf_release(&buf);
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.argv = argv;
> +       cp.env = local_repo_env;
> +       cp.git_cmd = 1;
> +       cp.no_stdin = 1;
> +       cp.dir = path;   /* GIT_WORK_TREE doesn't work for git checkout */

And if we do respect --quiet and it's not specified, paths printed by
this process is relative to "dir", not to user cwd. Could be
confusing.

> +       if (run_command(&cp))
> +               return error("Could not checkout submodule %s", path);
> +
> +       return 0;
> +}
> +
-- 
Duy
