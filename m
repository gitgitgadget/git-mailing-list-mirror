From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 17:54:48 +0700
Message-ID: <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
References: <cover.1378840318.git.john@keeping.me.uk> <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org> <20130911082042.GR2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 12:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJi4x-0001IW-HY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 12:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab3IKKzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 06:55:20 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36127 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3IKKzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 06:55:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so8339642obb.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bN2Z5h2wSMjvPclDeYOweE/TJAtH5e079pZP6SaVPuQ=;
        b=gZo2/txGfM3rM/yskzbOHZUufY4mqCtTMHLCjOJ5K5ZyNC2aN1UWabjNElK69+x0zk
         +r6XNKfpYr5w7XSWFQEBhtkfWUsbk56bx4hlmrX6C7cRlKVkXApX1tSUHyC9OL7FCQDC
         xICVuzfeRmgCCTWVnrPSLsf5rvcahGD2n8lezJHC/75n46WV0T82ee1vNCcyCGVIU1ni
         QhySwECU0Ufek25H9haAl5dRkNOxHBPz53XIK88rfrZltlpOH91e9I5Ie8aDbZtXn3I5
         Zs0rSkN/QDa2AFQewRgercxmzLW8geEoOcCHz5jPjiMM+Ur4+yUH8IKxo2SBiCAB3bPY
         D6vA==
X-Received: by 10.182.181.34 with SMTP id dt2mr857006obc.30.1378896918443;
 Wed, 11 Sep 2013 03:55:18 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 11 Sep 2013 03:54:48 -0700 (PDT)
In-Reply-To: <20130911082042.GR2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234557>

On Wed, Sep 11, 2013 at 3:20 PM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Sep 11, 2013 at 08:05:44AM +0200, Johannes Sixt wrote:
>> Am 10.09.2013 21:13, schrieb John Keeping:
>> > When using tab-completion, a directory path will often end with a
>> > trailing slash which currently confuses "git rm" when dealing with
>> > submodules.  Now that we have parse_pathspec we can easily handle this
>> > by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.
>> >
>> > Signed-off-by: John Keeping <john@keeping.me.uk>
>> > ---
>> >  builtin/reset.c            | 5 +++++
>> >  t/t7400-submodule-basic.sh | 6 ++++--
>> >  2 files changed, 9 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/builtin/reset.c b/builtin/reset.c
>> > index 5e4c551..9efac0f 100644
>> > --- a/builtin/reset.c
>> > +++ b/builtin/reset.c
>> > @@ -220,8 +220,13 @@ static void parse_args(struct pathspec *pathspec,
>> >             }
>> >     }
>> >     *rev_ret = rev;
>> > +
>> > +   if (read_cache() < 0)
>> > +           die(_("index file corrupt"));
>>
>> When the index is now read here, I would have expected hunk in this
>> patch that removes a read_cache() invocation.
>
> I think that needs to look like this on top - there's also a
> read_cache_unmerged() around line 68 but I don't think we can remove
> that one.
>
> -- >8 --
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 9efac0f..800117f 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -143,7 +143,6 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.output_format = DIFF_FORMAT_CALLBACK;
>         opt.format_callback = update_index_from_diff;
>
> -       read_cache();
>         if (do_diff_cache(tree_sha1, &opt))
>                 return 1;
>         diffcore_std(&opt);
> @@ -169,7 +168,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
>
>  static void die_if_unmerged_cache(int reset_type)
>  {
> -       if (is_merge() || read_cache() < 0 || unmerged_cache())
> +       if (is_merge() || unmerged_cache())
>                 die(_("Cannot do a %s reset in the middle of a merge."),
>                     _(reset_type_names[reset_type]));

reset --soft does not go through these code paths (i.e. it does not
need index at all). If we fail to load index index in "reset --soft" I
think it's ok to die(). Corrupt index is fatal anyway. But "reset
--soft" now has to pay the cost to load index, which could be slow
when the index is big. Assuming nobody does "reset --soft" that often
I think this is OK.

Alternatively we could load index lazily in _CHEAP code only when we
see trailing slashes, then replace these read_cache() with
read_cache_unless_its_already_loaded_earlier() or something.
-- 
Duy
