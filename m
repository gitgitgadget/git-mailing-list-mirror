From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 2/5] refs: add ref_type function
Date: Mon, 3 Aug 2015 20:55:59 +0700
Message-ID: <CACsJy8DK9k67yM_mJqbqgDxNKdGKpoLPOQQ4beqGgzUobzyFUQ@mail.gmail.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com> <1438322781-21181-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:56:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMGEG-0006JR-IT
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbbHCN4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:56:30 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35227 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbHCN43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 09:56:29 -0400
Received: by iodd187 with SMTP id d187so144808536iod.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GqZrryJpmRaHCiYDYd96PStSMXbKeJQrgTcHJc734iw=;
        b=z8Qt1z3hB/3Pb3z8uRbkuDKVp6jZS8nw739hckRyZxLvw6GBujUUXleLQoTXCTAMy+
         6lHqWMCay2mFwyFBU+DTN2GwRgXJl3om0iqS3S1peaNY6ZOGlfkuP7MVSdZ5afVEzoFd
         hErHsKFhn2NK9VoyWI/z+TPqyIMI64brsNev6Z9PEVQpQT2g1xMX68/1R6AP40mRbK0Q
         42Ttyyw5hdp7CnmJu6152Cl87HKgyTok6EWh85qmk9L0aQQRa47Q6glP2k+iBHRSl8Mq
         RCHtv49HO6dkbYJci6MO5QIHGoWzg4xMOd5yw1DJj6yNHNUrO8t1N1rg2Ls0IwRnAGPx
         0qWA==
X-Received: by 10.107.15.210 with SMTP id 79mr19788091iop.192.1438610188956;
 Mon, 03 Aug 2015 06:56:28 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 06:55:59 -0700 (PDT)
In-Reply-To: <1438322781-21181-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275168>

On Fri, Jul 31, 2015 at 1:06 PM, David Turner <dturner@twopensource.com> wrote:
> Add a function ref_type, which categorizes refs as per-worktree,
> pseudoref, or normal ref.

For per-worktree refs, you probably should follow common_list[] in
path.c because that's how file-based ref namespace is splitted between
per-repo and per-worktree, even though just as simple as "everything
outside refs/ is per-worktree" (with an exception of NOTES_MERGE_REF,
which should be on the list as well). At least the two should be
aligned so that the default file-based backend works the same way as
new backends.

Going further, I think you need to pass the "worktree identifier" to
ref backend, at least in ref_transaction_begin_fn. Each backend is
free to store per-worktree refs however it wants. Of course if I ask
for refs/foo of worktree A, you should not return me refs/foo of
worktree B. ref_transaction_begin_fn can return a fault code if it
does not support multiple worktrees, which is fine.

> Later, we will use this in refs.c to treat pseudorefs specially.
> Alternate ref backends may use it to treat both pseudorefs and
> per-worktree refs differently.

I'm not so sure that this can't be hidden behind backends and they can
have total control on falling back to file-based, or store them in
some secondary storage. I haven't re-read your discussion with Junio
yet (only skimmed through long ago) so I may be missing some important
points.

>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 26 ++++++++++++++++++++++++++
>  refs.h |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 0b96ece..0f87884 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2848,6 +2848,32 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>         return 0;
>  }
>
> +static int is_per_worktree_ref(const char *refname)
> +{
> +       return !strcmp(refname, "HEAD");
> +}
> +
> +static int is_pseudoref_syntax(const char *refname)
> +{
> +       const char *c;
> +
> +       for (c = refname; *c; c++) {
> +               if (!isupper(*c) && *c != '-' && *c != '_')
> +                       return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +enum ref_type ref_type(const char *refname)
> +{
> +       if (is_per_worktree_ref(refname))
> +               return REF_TYPE_PER_WORKTREE;
> +       if (is_pseudoref_syntax(refname))
> +               return REF_TYPE_PSEUDOREF;
> +       return REF_TYPE_NORMAL;
> +}
> +
>  int delete_ref(const char *refname, const unsigned char *old_sha1,
>                unsigned int flags)
>  {
> diff --git a/refs.h b/refs.h
> index e4e46c3..dca4fb5 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -445,6 +445,14 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
>
>  extern int ref_is_hidden(const char *);
>
> +enum ref_type {
> +       REF_TYPE_PER_WORKTREE,
> +       REF_TYPE_PSEUDOREF,
> +       REF_TYPE_NORMAL,
> +};
> +
> +enum ref_type ref_type(const char *refname);
> +
>  enum expire_reflog_flags {
>         EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
>         EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> --
> 2.0.4.315.gad8727a-twtrsrc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
