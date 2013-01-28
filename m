From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo operations
Date: Mon, 28 Jan 2013 08:50:41 +0100
Message-ID: <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
	<1359290777-5483-2-git-send-email-hjemli@gmail.com>
	<7vk3qywiqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzjUg-0000tC-Ha
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 08:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab3A1Hup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 02:50:45 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:64716 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3A1Hun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 02:50:43 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so1125425bkv.32
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 23:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=piEgmo0k4zw3EM2Eyoin76cNWayWLco42Ej0BdO80xs=;
        b=rnZiQC9JWCANcIbFi1qq84NFt/JX1bJaGzAzq2dIa6uKQkgkv3dzLAxDGIYGpazAgT
         AptXihQoqe2pBFJZnNcc+k9g5ayfZ1M4eiQBqtwAkjS7jkioOPk5YY3+jvuuw375Xu0X
         0Dghcyv/eJxACjORdOoY8AiJNvIGlZHB/A5+45pO6O8HgzmDgxji4O+bGHqKXu1GMPs8
         YAL8nBc6mHxMXzUXO161VxWCEwGG2ih8E/dy+Mw3S6gV4OStj3Yt+f+VM5Bd0xsbVKaQ
         yejNQIX51sFQbwZEGCABbGtFgPkBgsGwwnH2aivFhubT9pBbZLPEPnC3mCSIWfKoZWEB
         5KKw==
X-Received: by 10.204.149.11 with SMTP id r11mr3637736bkv.93.1359359441987;
 Sun, 27 Jan 2013 23:50:41 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Sun, 27 Jan 2013 23:50:41 -0800 (PST)
In-Reply-To: <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214816>

On Sun, Jan 27, 2013 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> The command also honours the option '--clean' which restricts the set of
>> repos to those which '--dirty' would skip, and '-x' which is used to
>> execute non-git commands.
>
> It might make sense to internally use RUN_GIT_CMD flag when the
> first word of the command line is 'git' as an optimization, but
> I am not sure it is a good idea to force the end users to think
> when to use -x and when not to is a good idea.
>
> In other words, I think
>
>      git for-each-repo -d diff --name-only
>      git for-each-repo -d -x ls '*.c'
>
> is less nice than letting the user say
>
>      git for-each-repo -d git diff --name-only
>      git for-each-repo -d ls '*.c'
>

The 'git-for-each-repo' command was made to allow any git command to
be executed in all discovered repositories, and I've used it that way
for two years (in the form of a shell-script called 'git-all'). During
this time, I've occasionally thought about forking non-git commands
but the itch hasn't been strong enough for me to scratch. The point
I'm trying to make is that to me, this command acts as a modifier for
other git commands[1]. Having the possibility to execute non-git
commands would be nice, but it is not the main objective of this
command.

[1] The 'git -a' rewrite patch shows how I think about this command -
it's just an option to the 'git' command, modifying the way any
subcommand is invoked (btw: I don't expect that patch to be applied
since 'git-all' was deemed to generic, so I'll just carry the patch in
my own tree).

>> Finally, the command to execute within each repo is optional. If none is
>> given, git-for-each-repo will just print the path to each repo found. And
>> since the command supports -z, this can be used for more advanced scripting
>> needs.
>
> It amounts to the same thing, but I would rather describe it as:
>
>     To allow scripts to handle paths with shell-unsafe characters,
>     support "-z" to show paths with NUL termination.  Otherwise,
>     such paths are shown with the usual c-quoting.
>

Much better, thanks.


> One more thing that nobody brought up during the previous reviews is
> if we want to support subset of repositories by allowing the
> standard pathspec match mechanism.  For example,
>
>         git for-each-repo -d git diff --name-only -- foo/ bar/b\*z
>
> might be a way to ask "please find repositories match the given
> pathspecs (i.e. foo/ bar/b\*z) and run the command in the ones that
> are dirty".  We would need to think about how to mark the end of the
> command though---we could borrow \; from find(1), even though find
> is not the best example of the UI design.  I.e.
>
>         git for-each-repo -d git diff --name-only \; [--] foo/ bar/b\*z
>
> with or without "--".

I don't think this would be very nice to end users, and would prefer
--include and --exclude options (the latter is actually already a part
of git-all, added by one of my coworkers).

>> +NOTES
>> +-----
>> +
>> +For the purpose of `git-for-each-repo`, a dirty worktree is defined as a
>> +worktree with uncommitted changes.
>
> Is it a definition that is different from usual?  If so why does it
> need to be inconsistent with the rest of the system?

I just wanted to clarify what condition --dirty and --clean will
check. In particular, the lack of checking for untracked files (which
could be added as yet another option).

>> +static void print_repo_path(const char *path, unsigned pretty)
>> +{
>> +     if (path[0] == '.' && path[1] == '/')
>> +             path += 2;
>> +     if (pretty)
>> +             color_fprintf_ln(stdout, color, "[%s]", path);
>
> This is shown before running a command in that repository.  I am of
> two minds.  It certainly is nice to be able to tell which repository
> each block of output lines comes from, and not requiring the command
> to do this themselves is a good default.  However, I wonder if people
> would want to do something like this:
>
>         git for-each-repo sh -c '
>                 git diff --name-only |
>                 sed -e "s|^|$path/|"
>         '
>
> to get a consolidated view, in a way similar to how "submodule
> foreach" can be used.  This unconditional output will get in the way
> for such a use case.

I guess -q/--quiet could be useful.

>> +static int walk(struct strbuf *path, int argc, const char **argv)
>> +{
>> +     DIR *dir;
>> +     struct dirent *ent;
>> +     struct stat st;
>> +     size_t len;
>> +     int has_dotgit = 0;
>> +     struct string_list list = STRING_LIST_INIT_DUP;
>> +     struct string_list_item *item;
>> +
>> +     dir = opendir(path->buf);
>> +     if (!dir)
>> +             return errno;
>> +     strbuf_addstr(path, "/");
>> +     len = path->len;
>> +     while ((ent = readdir(dir))) {
>> +             if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
>> +                     continue;
>> +             if (!strcmp(ent->d_name, ".git")) {
>> +                     has_dotgit = 1;
>> +                     continue;
>> +             }
>> +             switch (DTYPE(ent)) {
>> +             case DT_UNKNOWN:
>> +             case DT_LNK:
>> +                     /* Use stat() to figure out if this path leads
>> +                      * to a directory - it's  not important if it's
>> +                      * a symlink which gets us there.
>> +                      */
>> +                     strbuf_setlen(path, len);
>> +                     strbuf_addstr(path, ent->d_name);
>> +                     if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
>> +                             break;
>> +                     /* fallthrough */
>> +             case DT_DIR:
>> +                     string_list_append(&list, ent->d_name);
>> +                     break;
>> +             }
>> +     }
>> +     closedir(dir);
>> +     strbuf_setlen(path, len);
>> +     if (has_dotgit)
>> +             handle_repo(path, argv);
>> +     sort_string_list(&list);
>> +     for_each_string_list_item(item, &list) {
>> +             strbuf_setlen(path, len);
>> +             strbuf_addstr(path, item->string);
>> +             walk(path, argc, argv);
>> +     }
>> +     string_list_clear(&list, 0);
>> +     return 0;
>> +}
>
> Is the "collect-first-and-then-sort" done so that the repositories
> are shown in a stable order regardless of the order in which
> readdir() returns he entries?

Yes (writing the testcases demonstrated a need for predictable output).


>> diff --git a/t/t6400-for-each-repo.sh b/t/t6400-for-each-repo.sh
>
> This command does not look like "6 - the revision tree commands" to
> me. "7 - the porcelainish commands concerning the working tree" or
> "9 - the git tools" may be a better match?

Ok, how about t9003?

>> new file mode 100755
>> index 0000000..af02c0c
>> --- /dev/null
>> +++ b/t/t6400-for-each-repo.sh
>> @@ -0,0 +1,150 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2013 Lars Hjemli
>> +#
>> +
>> +test_description='Test the git-for-each-repo command'
>> +
>> +. ./test-lib.sh
>> +
>> +qname="with\"quote"
>> +qqname="\"with\\\"quote\""
>
> If Windows does not have problems with paths with dq in it, then
> this is fine, but I dunno.  Otherwise, you may want to exclude the
> c-quote testing from the main part of the test, and have a single
> test that has prerequisite for filesystems that can do this at the
> end of the script.

I'll check my patch on msysgit before resending.


>> +test_expect_success "setup" '
>> +     test_create_repo clean &&
>> +     (cd clean && test_commit foo1) &&
>> +     git init --separate-git-dir=.cleansub clean/gitfile &&
>> +     (cd clean/gitfile && test_commit foo2 && echo bar >>foo2.t) &&
>> +     test_create_repo dirty-idx &&
>> +     (cd dirty-idx && test_commit foo3 && git rm foo3.t) &&
>> +     test_create_repo dirty-wt &&
>> +     (cd dirty-wt && mv .git .linkedgit && ln -s .linkedgit .git &&
>
> Some platforms are symlink-challenged.  Can we do this test without
> "ln -s"?  SYMLINKS prereq wouldn't be very useful for the setup
> step, as all the remaining tests won't work without setting up the
> test scenario.

I added this test to check the DT_UNKNOWN/DT_LINK case in walk() so
I'd rather not drop it, but it can be moved into a standalone,
SYMLINKS-enabled testcase.

Thanks for the review.

-- 
larsh
