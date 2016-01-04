From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/14] shortlog: allow grouping by committer ident
Date: Mon, 4 Jan 2016 04:44:00 -0500
Message-ID: <CAPig+cT1pNXt2U1bd-KVapiUD=-6TQ8KRBNC8y+0wLAtuqUhQQ@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229073515.GK8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 10:44:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG1gn-00054v-HO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 10:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbcADJo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 04:44:29 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35336 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbcADJoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 04:44:00 -0500
Received: by mail-vk0-f52.google.com with SMTP id k1so119407689vkb.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DIRHwyM+szH90OiLd6kuc16WIfq3dURcTLBuzH7fd1g=;
        b=p7Jf65Jeh9ZrR0ofSDMJU4+OFBYG8smb8rwjkjUIVgik6U9X/FMToqd/E7DCT4NRi5
         h/3kRUZdmk8BJ4aq3gOpM6JTEaUCoFgBcFm7U2tZlTPE6oN6patVOvXrYoGNR/Tw1s6P
         AgZyY8gC2A7ZqR+KwvL+dE4Kd6Lt0pDQ8tZ6JUQ4KBR7G3o6btJLygqN1EvWlopOxjwU
         VqAHeJfVq11soFx0ZVUBlHw8i1vDS7455ye79n1nS9QodParUIY9hmeY4VuR5MhHC7Yd
         D7XHpO+biQQrLEufnu99F0gylbC2cu537/YpP8p48vHXi40YhgKfawnDNkPD3Sv/COTj
         CnNA==
X-Received: by 10.31.56.18 with SMTP id f18mr52830070vka.19.1451900640100;
 Mon, 04 Jan 2016 01:44:00 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 4 Jan 2016 01:44:00 -0800 (PST)
In-Reply-To: <20151229073515.GK8842@sigill.intra.peff.net>
X-Google-Sender-Auth: lUJGN68KlLq4fJeZ2I8N2xsRob8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283292>

On Tue, Dec 29, 2015 at 2:35 AM, Jeff King <peff@peff.net> wrote:
> Shortlog always groups commits by the author field. It can
> be interesting to group by other fields, as well. The
> obvious other identity in each commit is the committer
> field. This might be interesting if your project follows a
> workflow where committers and authors are not the same and
> where there is not simply one maintainer picking up all of
> the patches.
>
> For instance, you can use this in git.git to see interim and
> subsystem maintainers. Likewise, you can see in linux.git
> the patches picked up by lieutenants and merged into Linus's
> tree.
>
> This patch also provides some of the necessary
> infrastructure for adding more ident types (e.g., from
> trailers) in the future.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> @@ -47,6 +47,14 @@ OPTIONS
> +--ident=<type>::

Should this be called --group-by?

> +       By default, `shortlog` collects and collates author identities;
> +       using `--ident` will collect other types of identity. If
> +       `<type>` is:
> ++
> + - `author`, commits are grouped by author (this is the default)
> + - `committer`, commits are grouped by committer

There is a bit of redundancy here. I wonder if it could be described
more succinctly. For instance, instead of all the above, perhaps:

    Group commits by `<type>`, which can be one of:

    - `author` (default)
    - `committer`

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index d7eb0cb..39da2d4 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -147,11 +157,23 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> -       format_commit_message(commit, "%an <%ae>", &ident, &ctx);
> -       if (ident.len <= 3) {
> -               warning(_("Missing author: %s"),
> -                   oid_to_hex(&commit->object.oid));
> -               return;
> +       switch (log->ident_type) {
> +       case SHORTLOG_IDENT_AUTHOR:
> +               format_commit_message(commit, "%an <%ae>", &ident, &ctx);
> +               if (ident.len <= 3) {
> +                       warning(_("Missing author: %s"),
> +                               oid_to_hex(&commit->object.oid));
> +                       return;
> +               }
> +               break;
> +       case SHORTLOG_IDENT_COMMITTER:
> +               format_commit_message(commit, "%cn <%ce>", &ident, &ctx);
> +               if (ident.len <= 3) {
> +                       warning(_("Missing committer: %s"),
> +                               oid_to_hex(&commit->object.oid));
> +                       return;

Is this leaking strbuf 'ident'?

(Ditto for the "author" case as mentioned already in the patch 6/14 review.)

> +               }
> +               break;
>         }
