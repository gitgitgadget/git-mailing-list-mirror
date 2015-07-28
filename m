From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] refs: Introduce pseudoref and per-worktree ref concepts
Date: Tue, 28 Jul 2015 13:13:14 -0400
Message-ID: <CAPig+cRgp1F3S9DXWGABmrSDZM1As-R6FB7oBQbkoDLy-v6_PA@mail.gmail.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
	<1438027720-23074-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:13:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8RM-0003s3-1j
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbbG1RNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:13:16 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35475 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbG1RNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:13:15 -0400
Received: by ykdu72 with SMTP id u72so101240489ykd.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aDJU1SwC4wc3JiZIvt4FG2PqWjp4mnnl46RvVjrmzZA=;
        b=twqOfgJEWNVCKiZwW0IZ7MfHstpMokjR6vbsjD0plO8WHI5084luThGBG4O3O0s8yR
         vRyaOTopz83s2RSq5LHOlFuZ5wHd/p0wjz0jjpVBC8eZatOusRIn25qQ6si9NV0GmwOO
         /Zwkmjxd6FkeeOyl3aeXOTR4oP6rJCpg1ji4nFqrrYvhSD3YgWlpnsDwD4+rKigiLAkC
         RM7ZJ77PiQzWXR7M2uLdEEtB+z3BNjlVU232ngxrUBSkyq4Z5/Rj3WaQ/EHHR1a/XlGE
         W9EC1DMMUfvuakdFPZNF3RKf+3JgOrwSi8v6t0lHU2jC5je2scMvjfzXRCKPzIwme7b3
         cilg==
X-Received: by 10.13.202.204 with SMTP id m195mr37645361ywd.48.1438103594772;
 Tue, 28 Jul 2015 10:13:14 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 10:13:14 -0700 (PDT)
In-Reply-To: <1438027720-23074-2-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: NJ5daRmFi_uxbW03nddIqNmsnyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274794>

On Mon, Jul 27, 2015 at 4:08 PM, David Turner <dturner@twopensource.com> wrote:
> refs: Introduce pseudoref and per-worktree ref concepts
>
> Add glossary entries for both concepts.

Based upon the above, I thought this was going to be a
documentation-only patch and was mildly surprised to find that it also
changed code. Perhaps:

    Describe these concepts in the glossary and introduce
    is_per_worktree_ref() to distinguish such files.

or something. Of course the "and" in there suggests that this might be
better off split into two patches...

More below.

> Pseudorefs and per-worktree refs do not yet have special handling,
> because the files refs backend already handles them correctly.  Later,
> we will make the LMDB backend call out to the files backend to handle
> per-worktree refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index ab18f4b..67952f3 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -411,6 +411,27 @@ exclude;;
>         core Git. Porcelains expose more of a <<def_SCM,SCM>>
>         interface than the <<def_plumbing,plumbing>>.
>
> +[[def_per_worktree_ref]]per-worktree ref::
> +       Refs that are per-<<def_worktree,worktree>>, rather than
> +       global.  This is presently only <<def_HEAD,HEAD>>, but might
> +       later include other unusual refs.
> +
> +[[def_pseudoref]]pseudoref::
> +       Pseudorefs are a class of files under `$GIT_DIR` which behave
> +       like refs for the purposes of rev-parse, but which are treated
> +       specially by git.  Psuedorefs both have names are all-caps,

s/names/& that/

> +       and always start with a line consisting of a
> +       <<def_sha1,SHA-1>> followed by whitespace.  So, HEAD is not a
> +       pseudoref, because it is sometimes a symbolic ref.  They might
> +       optionally some additional data.  `MERGE_HEAD` and

s/optionally/& contain/

> +       `CHERRY_PICK_HEAD` are examples.  Unlike
> +       <<def_per_worktree_ref,per-worktree refs>>, these files cannot
> +       be symbolic refs, and never have reflogs.  They also cannot be
> +       updated through the normal ref update machinery.  Instead,
> +       they are updated by directly writing to the files.  However,
> +       they can be read as if they were refs, so `git rev-parse
> +       MERGE_HEAD` will work.
> +
>  [[def_pull]]pull::
>         Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
>         <<def_merge,merge>> it.  See also linkgit:git-pull[1].
> diff --git a/refs.c b/refs.c
> index 0b96ece..0d10b7b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2848,6 +2848,29 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>         return 0;
>  }
>
> +int is_per_worktree_ref(const char *refname)
> +{
> +       return !strcmp(refname, "HEAD");
> +}
> +
> +static int is_pseudoref(const char *refname)
> +{
> +       const char *c;
> +
> +       if (strchr(refname, '/'))
> +               return 0;
> +
> +       if (is_per_worktree_ref(refname))
> +               return 0;
> +
> +       for (c = refname; *c; ++c) {
> +               if (!isupper(*c) && *c != '-' && *c != '_')
> +                       return 0;
> +       }
> +
> +       return 1;
> +}

This static function doesn't seem to have any callers, thus seems out
of place in this patch.

> +
>  int delete_ref(const char *refname, const unsigned char *old_sha1,
>                unsigned int flags)
>  {
