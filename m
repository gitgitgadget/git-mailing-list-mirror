From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] Add support for matching full refs in hideRefs
Date: Sun, 1 Nov 2015 15:42:37 -0500
Message-ID: <CAPig+cST7sATT4W4Kwp5K=DcuvoFkdgsTDA9iOk=8c_8_GE=-Q@mail.gmail.com>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
	<1446406463-22527-4-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:42:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZszSd-0005kM-9w
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 21:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbbKAUmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 15:42:39 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33335 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbKAUmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 15:42:38 -0500
Received: by vkgy127 with SMTP id y127so75162347vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g9BjdLuaz238BPho3/my5BPT20enkG2Xqn6d4FX+vrs=;
        b=n/I39rE2bBljNYPSpKUdDVn1ATX3L6G2ytfOB8Tgm38Od665haA/oqwnW273JeaXoa
         AxtcDWOkoQPBaU2T/aa5wc0fW2qZyACGqn+AzsxqChrEC8iQ3yyHbb3NQ5JL0Xpwl/vq
         YFWx/d9Ns56yKw21tUtOwajQxYkivxts5xpdbPRXE4nkM/ekDp1BJyopnPuV3U8U/jUy
         rMRJYCg9p/69RTOfhmGxo3Pn3hA0Mz5rUcOdqIYbTDyBwVRHjJzlGGDNCeQkuxqBsq6a
         ++fFUH+kFk3R1Kx5d+AzwPkXKnZUDKUgD+wCBo196JORIFGtu9C/Ub3FxfSdwTvdxnb9
         4Wuw==
X-Received: by 10.31.151.16 with SMTP id z16mr12673420vkd.14.1446410557967;
 Sun, 01 Nov 2015 12:42:37 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 12:42:37 -0800 (PST)
In-Reply-To: <1446406463-22527-4-git-send-email-lfleischer@lfos.de>
X-Google-Sender-Auth: H15DFl_fM0kxfeq6dorIckZJ79c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280667>

On Sun, Nov 1, 2015 at 2:34 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> In addition to matching stripped refs, one can now add hideRefs patterns
> that the full (unstripped) ref is matched against. To distinguish
> between stripped and full matches, those new patterns must be prefixed
> with a circumflex (^).
>
> This commit also removes support for the undocumented and unintended
> hideRefs settings "have" (suppressing all "have" lines) and
> "capabilities^{}" (suppressing the capabilities line).
>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> @@ -1198,7 +1200,15 @@ static void reject_updates_to_hidden(struct command *commands)
>         struct command *cmd;
>
>         for (cmd = commands; cmd; cmd = cmd->next) {
> -               if (cmd->error_string || !ref_is_hidden(cmd->ref_name))

Would it make sense to retain the cmd->error_string check here in
order to avoid doing the extra refname_full construction work below?

    if (cmd->error_string)
        continue;

> +               const char *refname = cmd->ref_name;
> +               struct strbuf refname_full_buf = STRBUF_INIT;
> +               const char *refname_full;
> +
> +               strbuf_addf(&refname_full_buf, "%s%s", get_git_namespace(),
> +                               refname);
> +               refname_full = strbuf_detach(&refname_full_buf, NULL);
> +
> +               if (cmd->error_string || !ref_is_hidden(refname, refname_full))
>                         continue;

This is leaking refname_full each time through the loop since it never
gets free()d. If you restructure the code like this, it might be
easier to avoid leaks:

    for (cmd = ...; ... ; ...) {
        if (cmd->error_string)
            continue;
        strbuf_addf(&refname_full, "%s%s", ...);
        if (ref_is_hidden(...)) {
            if (is_null_sha1(...))
                cmd->error_string = "...";
            else
                cmd->error_string = "...";
        }
        strbuf_release(&refname_full);
    }

As a micro-optimization, you could also pre-populate the strbuf with
get_git_namespace() outside the loop and remember the length. Then,
each time through the loop, just append cmd->ref_name, do your
processing, and, at the bottom of the loop, set the strbuf back to the
remembered length. (And, you still need to free the strbuf after the
loop.)

>                 if (is_null_sha1(cmd->new_sha1))
>                         cmd->error_string = "deny deleting a hidden ref";
