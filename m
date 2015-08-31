From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 01:11:46 -0400
Message-ID: <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 07:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWHNn-00040e-OV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 07:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbbHaFLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 01:11:48 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36125 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbHaFLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 01:11:47 -0400
Received: by ykey204 with SMTP id y204so35668584yke.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 22:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gHxaEwlMZpcrvrXQiZJJZF2dejR63a6G6z1NzuD3nWo=;
        b=UCHK0m+MiH7x79L3yJnJw1HmbCtunVpv9QyqRBpcmtsx5Ns/STP2UaPox3xhnv4WAK
         zhqMTSFLSIGc8B4klU+AD4RUaC+HszP1hjJ+724j4dqFCWdugDHoOhCBbb7MfRcIdzdy
         5pGOEPY6/24Ta+1To4lWgNK6mTDl6IHPAZxC4GOZi3qoHRASFIFT7jlNLfz09Hd9rnwx
         1hcXau1st84OTL+74184D63i92IU8/WiZBMNU3ZeGaMm1O9u4nR/pHd8SWht4DYHFOAY
         hfcMFEWoEqqpHfFax5GHc+nGSTwp0txUDN4maaqX19mbtfjbk9nlOqOzlcg+FK906Qm7
         0uvQ==
X-Received: by 10.170.37.13 with SMTP id 13mr3388942ykf.71.1440997906782; Sun,
 30 Aug 2015 22:11:46 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 22:11:46 -0700 (PDT)
In-Reply-To: <1440961839-40575-2-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: y169jLU-_GrGGiVgg0NdeJKeziE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276847>

Thanks for working on this. I apologize for not reviewing earlier
rounds (other than v2 [1]); it's been difficult to find a block of
time to do so...

On Sun, Aug 30, 2015 at 3:10 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> for_each_worktree iterates through each worktree and invokes a callback
> function.  The main worktree (if not bare) is always encountered first,
> followed by worktrees created by `git worktree add`.

Why does this iteration function specially filter out a bare main
worktree? If it instead unconditionally vends the main worktree (bare
or not), then the caller can make its own decision about what to do
with it, thus empowering the caller, rather than imposing a (possibly)
arbitrary restriction upon it.

For instance, the "git worktree list" command may very well want to
show the main worktree, even if bare (possibly controlled by a
command-line option), annotated appropriately ("[bare]"). This may be
exactly the sort of information a user wants to know, and by leaving
the decision up to the caller, then the caller ("git worktree list" in
this example) has the opportunity to act accordingly, whereas if
for_each_worktree() filters out a bare main worktree unconditionally,
then the caller ("git worktree list") will never be able to offer such
an option.

> If the callback function returns a non-zero value, iteration stops, and
> the callback's return value is returned from the for_each_worktree
> function.

Stepping back a bit, is a for-each-foo()-style interface desirable?
This sort of interface imposes a good deal of complexity on callers,
demanding a callback function and callback data (cb_data), and is
generally (at least in C) more difficult to reason about than other
simpler interfaces. Is such complexity warranted?

An alternate, much simpler interface would be to have a function, say
get_worktrees(), return an array of 'worktree' structures to the
caller, which the caller would iterate over (which is a common
operation in C, thus easily reasoned about).

The one benefit of a for-each-foo()-style interface is that it's
possible to "exit early", thus avoiding the cost of interrogating
meta-data for worktrees in which the caller is not interested,
however, it seems unlikely that there will be so many worktrees linked
to a repository for this early exit to translate into any real
savings.

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 430b51e..7b3cb96 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -26,6 +26,14 @@ static int show_only;
>  static int verbose;
>  static unsigned long expire;
>
> +/*
> + * The signature for the callback function for the for_each_worktree()
> + * function below.  The memory pointed to by the callback arguments
> + * is only guaranteed to be valid for the duration of a single
> + * callback invocation.
> + */
> +typedef int each_worktree_fn(const char *path, const char *git_dir, void *cb_data);

In my review[1] of v2, I mentioned that (at some point) the "git
worktree list" command might like to show additional information about
the worktree other than just its location. Such information might
include its tag, the checked out branch (or detached HEAD), whether
it's locked (and the lock reason and whether the worktree is currently
"online"), whether it can be pruned (and the prune reason).

Commands such as "git worktree add" and "git checkout" need to know if
a branch is already checked out in some (other) worktree, thus they
also need the "branch" information.

This need by clients for additional worktree meta-data suggests that
the additional information ought to be encapsulated into a 'struct
worktree', and that for_each_worktree() should vend a 'struct
worktree' rather than vending merely the "git dir". (Alternately, the
above-suggested get_worktrees() should return an array of 'struct
worktree' items.)

An important reason for making for_each_worktree() vend a 'struct
worktree' is that it facilitates centralizing all the logic for
determining and computing the extra worktree meta-data in one place,
thus relieving callers of burden of having to compute the extra
information themselves. (Junio alluded to this in his v5 review[2].)

>  static int prune_worktree(const char *id, struct strbuf *reason)
>  {
>         struct stat st;
> @@ -359,6 +367,81 @@ static int add(int ac, const char **av, const char *prefix)
>         return add_worktree(path, branch, &opts);
>  }
>
> +/*
> + * Iterate through each worktree and invoke the callback function.  If
> + * the callback function returns non-zero, the iteration stops, and
> + * this function returns that return value
> + */
> +static int for_each_worktree(each_worktree_fn fn, void *cb_data)

Ultimately, code outside of builtin/worktree.c will want to benefit
from the encapsulation of this worktree iteration logic. For instance,
the support code in (top-level) branch.c invoked by "git worktree add"
and "git checkout" to determine if a branch is already checked out in
some (other) branch could avail itself of this iteration interface.

As such, it would make sense to place this code at location where it
can be accessed by callers other than just builtin/worktree.c. A good
location for it to reside might be in a new top-level file worktree.c.

It doesn't have to be part of the current patch series, but,
eventually, the code in branch.c for determining if a branch is
already checked out elsewhere also should migrate to the new top-level
worktree.c; in particular, die_if_checked_out(), find_shared_symref(),
and find_linked_symref().

> +{
> +       struct strbuf worktree_path = STRBUF_INIT;
> +       struct strbuf worktree_git = STRBUF_INIT;
> +       const char *common_dir;
> +       int main_is_bare = 0;
> +       int ret = 0;
> +
> +       common_dir = get_git_common_dir();
> +       if (!strcmp(common_dir, get_git_dir())) {
> +               /* simple case - this is the main repo */
> +               main_is_bare = is_bare_repository();
> +               if (!main_is_bare) {
> +                       strbuf_addstr(&worktree_path, get_git_work_tree());
> +               } else {
> +                       strbuf_addstr(&worktree_path, common_dir);
> +               }
> +       } else {
> +               strbuf_addstr(&worktree_path, common_dir);
> +               /* If the common_dir DOES NOT end with '/.git', then it is bare */
> +               main_is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> +       }
> +       strbuf_addstr(&worktree_git, worktree_path.buf);

I may have missed some discussion in earlier rounds (or perhaps I'm
too simple-minded), but I'm confused about why this logic (and most of
the rest of the function) differs so much from existing logic in
branch.c:find_shared_symref() and find_linked_symref() for iterating
over the worktrees and gleaning information about them. That logic in
branch.c seems to do a pretty good job of reporting the worktree in
which a branch is already checked out, so it's not clear why the above
logic takes a different (and seemingly more complex) approach.

> +       if (!main_is_bare) {
> +               strbuf_addstr(&worktree_git, "/.git");
> +
> +               ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
> +               if (ret)
> +                       goto done;
> +       }
> +       strbuf_addstr(&worktree_git, "/worktrees");
> +
> +       if (is_directory(worktree_git.buf)) {

As mentioned in my v2 review[1], this is_directory() invocation
doesn't buy you anything. The following opendir() will either succeed
or fail anyhow, so checking beforehand if 'worktree_git' is a
directory is wasted work. If you eliminate is_directory(), you avoid
that unnecessary work (and the rest of the code can be less deeply
indented).

> +               DIR *dir = opendir(worktree_git.buf);
> +               if (dir) {
> +                       struct stat st;
> +                       struct dirent *d;
> +                       size_t base_path_len = worktree_git.len;
> +
> +                       while ((d = readdir(dir)) != NULL) {
> +                               if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +                                       continue;
> +
> +                               strbuf_setlen(&worktree_git, base_path_len);
> +                               strbuf_addf(&worktree_git, "/%s/gitdir", d->d_name);
> +
> +                               if (stat(worktree_git.buf, &st)) {
> +                                       fprintf(stderr, "Unable to read worktree git dir: %s\n", worktree_git.buf);
> +                                       continue;
> +                               }
> +
> +                               strbuf_reset(&worktree_path);
> +                               strbuf_read_file(&worktree_path, worktree_git.buf, st.st_size);
> +                               strbuf_strip_suffix(&worktree_path, "/.git\n");
> +
> +                               strbuf_strip_suffix(&worktree_git, "/gitdir");
> +                               ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
> +                               if (ret)
> +                                       break;
> +                       }
> +               }
> +               closedir(dir);

This closedir() should be inside the `if (dir) {...}' block rather than outside.

Returning to the issue of this code differing from existing code in
branch.c for iterating worktrees, I'm curious as to why this
functionality was implemented again from scratch here rather than
re-using the existing (somewhat) well proven code and logic in
branch.c:find_shared_symref() and find_linked_symref(). My v2
review[1] hinted at re-use a couple times.

Considering that the existing code in branch.c for iterating worktrees
has gone through several code reviews and is already (somewhat)
proven, re-using that code for a general purpose worktree iterator
makes lots of sense compared with writing it again from scratch, as is
done here. Consequently, I, personally, would be happier to see the
existing code refactored (perhaps over several patches) to the point
that it can be re-used as a general purpose iterator. But, that's my
opinion; I can't speak for others.

> +       }
> +done:
> +       strbuf_release(&worktree_git);
> +       strbuf_release(&worktree_path);
> +       return ret;
> +}

[1]: http://article.gmane.org/gmane.comp.version-control.git/275528
[2]: http://article.gmane.org/gmane.comp.version-control.git/276471
