From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC 3/3] Teach mv to update the path entry in .gitmodules
 for moved submodules
Date: Thu, 11 Apr 2013 15:36:51 +0530
Message-ID: <CALkWK0m08_FmrMqcdRgy6-_7Pc8LyWeZqdtfJ3GGTGNTLaR0QA@mail.gmail.com>
References: <515C88FE.9020203@web.de> <515C89BA.9020806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQEPp-00047V-O8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab3DKKHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:07:33 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35305 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab3DKKHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:07:32 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so1365992iec.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=litJOu/QbEmmi8WC9g7MNqEVmuMAU3UIBfvlxjNZZwg=;
        b=iopH8/uegY8gXH/vO9Ad6xhvk+aCSBPfQJZ+nMGV0bN51Zs99Bs3OPlu2Bogl6BrI+
         GXdUsgxK2/UPST65giGdJYpiqT6LiSDn7vFg/IBKGBWMY/cwb7BOfRhrMpwQUW0Rc6iM
         q81vXZmw23w75ihaoFZHV5DkfFmrOhaqRuCIfWUdovYfHwCQCpKscXsV+RTDXaXzS8tQ
         yBGCagBMXMtG/em62wSsksvLGs7LDBOgCgpFrSTlduxleRpZ9Dj6X1WTczoQbSSKBZfX
         2v4StdZFWkVdnK8HOrIRfMrcd7YzqP0qT8iz0HOpeXA2LBxDrYsKTd9y65WwuRMzUF8s
         zCMg==
X-Received: by 10.50.108.235 with SMTP id hn11mr3919944igb.107.1365674851696;
 Thu, 11 Apr 2013 03:07:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 03:06:51 -0700 (PDT)
In-Reply-To: <515C89BA.9020806@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220838>

Jens Lehmann wrote:
> Currently using "git mv" on a submodule moves the submodule's work tree in
> that of the superproject.

It's not "Currently": it's the result of your last two patches.  The
wording is very unclear.  Perhaps: As a result of the last two patches
in this series, a 'git mv' moves the submodule directory to a new path
in the superproject's worktree, and updates the cache entry in the
index appropriately.

> But the submodule's path setting in .gitmodules
> is left untouched, which is now inconsistent with the work tree and makes
> git commands that rely on the proper path -> name mapping (like status and
> diff) behave strangely.

I'm frankly a little surprised that your previous two patches didn't
break any tests.  That's probably because we don't have enough tests
to exercise git-core with submodules.  I'm not saying that it's a bad
thing though: submodules are still immature, and tight tests would get
in the way of new patches.

> Let "git mv" help here by not only moving the submodule's work tree but
> also updating the "submodule.<submodule name>.path" setting from the
> .gitmodules file and stage both.

> This doesn't happen when no .gitmodules
> file is found and only issues a warning when it doesn't have a section for
> this submodule. This is because the user might just use plain gitlinks
> without the .gitmodules file

How will git-core work without a .gitmodules?  Shouldn't we create a
fresh .gitmodules here?

> or has already updated the path setting by
> hand before issuing the "git mv" command (in which case the warning
> reminds him that mv would have done that for him).

Shouldn't these two cases issue different warnings?

Besides, why is this explanation missing in your rm patch's commit message?

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 609bbb8..36e5605 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -239,6 +242,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                         rename_cache_entry_at(pos, dst);
>         }
>
> +       if (gitmodules_modified)
> +               stage_updated_gitmodules();
> +

I'm unhappy with this, but we I'll have to live with my
dissatisfaction until we get rid of ".gitmodules" (if that ever
happens).  mv has a clear task: it should perform a filesystem mv,
manipulate the index, and write out the changed index.  Adding an
unrelated file to the index has nothing to do with its primary task.

> diff --git a/submodule.c b/submodule.c
> index eba9b42..fb742b4 100644
> --- a/submodule.c
> +++ b/submodule.c

All my comments in the rm review apply here too, so I won't repeat myself.

> @@ -10,6 +10,7 @@
>  #include "string-list.h"
>  #include "sha1-array.h"
>  #include "argv-array.h"
> +#include "blob.h"

Interesting.  Let's see why you need blob.h.

>  static struct string_list config_name_for_path;
>  static struct string_list config_fetch_recurse_submodules_for_name;
> @@ -30,6 +31,67 @@ static struct sha1_array ref_tips_after_fetch;
>   */
>  static int gitmodules_is_unmerged;
>
> +/*
> + * Try to update the "path" entry in the "submodule.<name>" section of the
> + * .gitmodules file.
> + */
> +int update_path_in_gitmodules(const char *oldpath, const char *newpath)
> +{
> +       struct strbuf entry = STRBUF_INIT;
> +       struct string_list_item *path_option;
> +
> +       if (!file_exists(".gitmodules")) /* Do nothing whithout .gitmodules */
> +               return -1;

s/whithout/without.  Why are you not returning an error()?  Don't you
want to tell the user that no ".gitmodules" was found?

> +void stage_updated_gitmodules(void)

void return?  Don't you want the caller to know whether we were
successful or not?

Why does the name contain "updated"?  Why does the function care if I
updated the .gitmodules or not?  It's just staging .gitmodules, as it
is on the filesystem.

> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       struct stat st;
> +       int pos;
> +       struct cache_entry *ce;
> +       int namelen = strlen(".gitmodules");
> +
> +       pos = cache_name_pos(".gitmodules", strlen(".gitmodules"));

And you forgot about namelen just like that.

> +       if (pos < 0) {
> +               warning(_("could not find .gitmodules in index"));
> +               return;
> +       }

What could this mean?  I might have an untracked .gitmodules file in
my worktree, or I might not have a .gitmodules file at all.  Since
you're already checking the latter case in the previous function,
can't you persist the result, and return a more sensible error?

> +       ce = active_cache[pos];
> +       ce->ce_flags = namelen;
> +       if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
> +               die(_("reading updated .gitmodules failed"));

You're reading it because?  What does "_updated_ .gitmodules" mean here?

> +       if (lstat(".gitmodules", &st) < 0)
> +               die_errno(_("unable to stat updated .gitmodules"));
> +       fill_stat_cache_info(ce, &st);
> +       ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);

I don't understand why you're taking the pains to fill out a cache_entry.

> +       if (remove_file_from_cache(".gitmodules") < 0)
> +               die(_("unable to remove .gitmodules from index"));

You already have pos, so why not just remove_cache_entry_at()?

> +       if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
> +               die(_("adding updated .gitmodules failed"));

Ah, you need blob.h for blob_type.

Wait, why are you just reading and writing .gitmodules?  What changed?
 And why are you manually writing a blob to the object store?  Doesn't
git-core already do this if you just add it to the index? See the
S_IFLNK case in index_path().

What happens if there's a race?  Shouldn't you be locking .gitmodules
before updating it, like we do with the index and just about
everything else?

> +       if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
> +               die(_("staging updated .gitmodules failed"));

This is all you need: it calls index_path() and writes your blob
object to the database.
