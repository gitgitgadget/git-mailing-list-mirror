From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 10/10] branch: Fix display of remote branches in refs/peers/*
Date: Mon, 13 May 2013 01:19:49 -0400
Message-ID: <CAPig+cSRnsiYRQhX8Gz41D43005zgF9ysNTNSNn-C27nB9HftQ@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-11-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 07:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UblAx-0001Hq-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 07:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3EMFTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 01:19:52 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:44903 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab3EMFTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 01:19:51 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so406515lab.34
        for <git@vger.kernel.org>; Sun, 12 May 2013 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cWSEp0Zz5h06iFwcIBOeynTZjb/uhcYV9HagaZf8aJw=;
        b=sSaXOmQW65b3PXsEZ4aBLScHqnsK4kCTrgR0KsfPNPZg6043Ovwi/HrQ6gyvyfTFr0
         BbLDUtoojoAXAkHDpd7mzxCmleKNLTn4md4va3EFun/Vgmv/Hd2y+lqcK4f+4hZlmsdq
         hv3rQELyUb+WPR4mMO25gSY/TwCKel65P9Srby3DofXGxNX3xmKK/6+dQHKAnq6vpezA
         yjW9nK4gu+tHVVLNJHDbtFw7GbryVNAZk/uxdR/ccn2fA0RT7zpUmKEiBIlSdyt3I6cf
         6RKa/Gcm2F1L5bewTxNLdLO8w+70MFcc2jUUSydK4dzXeUggfG4eMthQ0SSGNlbEySPt
         RIzQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr12002342lbb.59.1368422389563;
 Sun, 12 May 2013 22:19:49 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 12 May 2013 22:19:49 -0700 (PDT)
In-Reply-To: <1368289280-30337-11-git-send-email-johan@herland.net>
X-Google-Sender-Auth: voPoOQg6tEwlccNgfW3AAEHlEg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224090>

On Sat, May 11, 2013 at 12:21 PM, Johan Herland <johan@herland.net> wrote:
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4480be2..9a6bce8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -328,74 +326,80 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>         struct ref_list *ref_list = cb->ref_list;
>         struct ref_item *newitem;
>         struct commit *commit;
> +       struct strbuf ref = STRBUF_INIT;
>         int kind, i;
> -       const char *prefix, *orig_refname = refname;
> +       const char *pattern;
> +       size_t refname_len = strlen(refname);
>
>         static struct {
>                 int kind;
> -               const char *prefix;
> -               int pfxlen;
> +               const char *pattern;
>         } ref_kind[] = {
> -               { REF_LOCAL_BRANCH, "refs/heads/", 11 },
> -               { REF_REMOTE_BRANCH, "refs/remotes/", 13 },
> +               { REF_LOCAL_BRANCH, "refs/heads/%*" },
> +               { REF_REMOTE_BRANCH, "refs/remotes/%*" },
> +               { REF_REMOTE_BRANCH, "refs/peers/%1/heads/%*" },
>         };
>
>         /* Detect kind */
>         for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
> -               prefix = ref_kind[i].prefix;
> -               if (strncmp(refname, prefix, ref_kind[i].pfxlen))
> +               if (refname_shorten(&ref, ref_kind[i].pattern, refname, refname_len))
>                         continue;
>                 kind = ref_kind[i].kind;
> -               refname += ref_kind[i].pfxlen;
> +               pattern = ref_kind[i].pattern;
>                 break;
>         }
>         if (ARRAY_SIZE(ref_kind) <= i)
> -               return 0;
> +               goto out;
>
>         /* Don't add types the caller doesn't want */
>         if ((kind & ref_list->kinds) == 0)
> -               return 0;
> +               goto out;
>
> -       if (!match_patterns(cb->pattern, refname))
> -               return 0;
> +       if (!match_patterns(cb->pattern, ref.buf))
> +               goto out;
>
>         commit = NULL;
>         if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
>                 commit = lookup_commit_reference_gently(sha1, 1);
>                 if (!commit) {
> -                       cb->ret = error(_("branch '%s' does not point at a commit"), refname);
> -                       return 0;
> +                       cb->ret = error(_("branch '%s' does not point at a commit"), ref.buf);
> +                       goto out;
>                 }
>
>                 /* Filter with with_commit if specified */
>                 if (!is_descendant_of(commit, ref_list->with_commit))
> -                       return 0;
> +                       goto out;
>
>                 if (merge_filter != NO_FILTER)
>                         add_pending_object(&ref_list->revs,
> -                                          (struct object *)commit, refname);
> +                                          (struct object *)commit, ref.buf);
>         }
>
> +       /*
> +        * When displaying more then just remote-tracking branches, make the

s/then/than/

> +        * remote-tracking branches more explicit, e.g. instead of printing
> +        * "origin/master", we should print "remote/origin/master" (or
> +        * "peers/origin/heads/master").
> +        */
> +       if (kind == REF_REMOTE_BRANCH && ref_list->kinds != REF_REMOTE_BRANCH)
> +               refname_shorten(&ref, "refs/%*", refname, refname_len);
> +
>         ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
>
>         /* Record the new item */
>         newitem = &(ref_list->list[ref_list->index++]);
>         strbuf_init(&newitem->name, 0);
> -       strbuf_addstr(&newitem->name, refname);
> +       strbuf_addbuf(&newitem->name, &ref);
>         newitem->kind = kind;
>         newitem->commit = commit;
>         strbuf_init(&newitem->dest, 0);
> -       orig_refname = resolve_symref(orig_refname, prefix);
> -       if (orig_refname)
> -               strbuf_addstr(&newitem->dest, orig_refname);
> -       /* adjust for "remotes/" */
> -       if (newitem->kind == REF_REMOTE_BRANCH &&
> -           ref_list->kinds != REF_REMOTE_BRANCH)
> -               strbuf_insert(&newitem->name, 0, "remotes/", 8);
> +       resolve_symref(&newitem->dest, pattern, refname);
>         newitem->width = utf8_strwidth(newitem->name.buf);
>         if (newitem->width > ref_list->maxwidth)
>                 ref_list->maxwidth = newitem->width;
>
> +out:
> +       strbuf_release(&ref);
>         return 0;
>  }
>
> diff --git a/refs.c b/refs.c
> index 188a9eb..a78199a 100644
> --- a/refs.c
> +++ b/refs.c
