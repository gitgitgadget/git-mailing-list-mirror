From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Wed, 8 May 2013 11:15:03 -0400
Message-ID: <CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 17:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua65K-0004n9-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 17:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab3EHPPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 11:15:06 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:61973 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab3EHPPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 11:15:04 -0400
Received: by mail-ia0-f178.google.com with SMTP id t29so1995836iag.23
        for <git@vger.kernel.org>; Wed, 08 May 2013 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=pj7gBEP7WlVpLKApEbz15Ci+L/DuduGNqHs1Xtp2yy0=;
        b=bKybQU90pNk3BhGPTdlLZX6yp86Ybu4YQVamyppYfaybd/nbFqkxPrqEqiHgOJl19X
         WprdDdTZ19Ryi9pOb3hs4p90tMJvJK4lS+aR/u7v8XJOAGR57YXDxzj4Mrtk2NfmFxK4
         wYXB7y+xlfdSzsbQO93cbFJYVdFU/v7OnV1iZJ6weVp9aTJHxC7+GHJnHOOib1kkP6ge
         bWnJQVCK8FSDHDfBj9zAa/StHr9YWyJVv++JQtj6ULgd/cbwoqPdZPMLh+a5wp9iFsVq
         zHDqbmTK+H1cw8YeXLJwi5Bd9EjQI/XkX5gmgoowgPM9y/41aeH8KUnG7sAm/wxYc0UF
         i+Rg==
X-Received: by 10.50.124.68 with SMTP id mg4mr558187igb.37.1368026103770; Wed,
 08 May 2013 08:15:03 -0700 (PDT)
Received: by 10.64.13.46 with HTTP; Wed, 8 May 2013 08:15:03 -0700 (PDT)
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: 6nER2vDLDhfSCkVyZ0pJrBJxN0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223672>

On Wed, May 8, 2013 at 7:38 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> When the command enters the interactive mode, it shows the
> files and directories to be cleaned, and goes into its
> interactive command loop.

Your current implementation only allows excluding items from the list
of files to delete. If you accidentally exclude some file which you
actually want in the deletion list, there is no way to re-add it.
Would it make sense to change the behavior so that it lists all files
but stars those which are to be deleted. This is similar to how the
"edit by numbers" mode operates, but would apply to the deletion list
printed for the top-level menu as well. For example:

  Will remove starred items:
    file1  *file2  *file3
    *file4  file5  file6
  *** Commands ***
  ...
  What now> clean
  Removing file2
  Removing file3
  Removing file4

> The command loop shows the list of subcommands available, and
> gives a prompt "What now> ".  In general, when the prompt ends
> with a single '>', you can pick only one of the choices given
> and type return, like this:
>
>     *** Commands ***
>       1: clean               2: edit by patterns    3: edit by numbers     4: rm -i
>       5: flags: none         6: quit                7: help
>     What now> 2
>
> You also could say `c` or `clean` above as long as the choice is unique.

It is not obvious by reading the menu that "edit by patterns" can be
abbreviated as 'p', and "edit by numbers" by 'n'. If you change the
names a bit, then the abbreviations become more obvious. For instance,
one possibility:

  2. filter by pattern
  3. select by number
  5. toggle flags: none

Also, the abbreviation 'i' for "rm -i" is not obvious.

> edit by patterns::
>
>    This shows the files and directories to be deleted and issues an
>    "Input ignore patterns>>" prompt. You can input a space-seperated
>    patterns to exclude files and directories from deletion.
>    E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
>    deletion. When you are satisfied with the filtered result, press
>    ENTER (empty) back to the main menu.
>
> edit by numbers::
>
>    This shows the files and directories to be deleted and issues an
>    "Select items to delete>>" prompt. When the prompt ends with double
>    '>>' like this, you can make more than one selection, concatenated
>    with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
>    to choose 2,3,4,5,7,9 from the list.  If the second number in a
>    range is omitted, all remaining patches are taken.  E.g. "7-" to
>    choose 7,8,9 from the list.  You can say '*' to choose everything.
>    Also when you are satisfied with the filtered result, press ENTER
>    (empty) back to the main menu.

It seems odd that "edit by patterns" _excludes_ files from deletion,
but "edit by patterns" _includes_ them in the deletion list. These
opposing behaviors force the user to invert his mode of thought when
editing by patterns vs. numbers. While playing with "edit by numbers",
I repeatedly found myself incorrectly inputting numbers of items I
wanted to exclude rather than those I wanted to keep in the list,
since my brain had not made the 180 degree flip from "edit by
patterns".

More generally, there are cases when it is more convenient to filter
the list by exclusion, and other cases when inclusion is more
convenient. For example, in a list of 20 files, I may want to delete
18 but keep 2. In this case, it typically is easier to specify the two
I want to keep. On the other hand, if I want to delete 2 files but
keep 18, it may be easier to specify the two I want to delete. Would
it makes sense to support pattern negation (via '!' perhaps) in order
to make this possible?

One thing not mentioned here is that "edit by numbers" (as with
git-add-interactive) also accepts input "foo" to match item "foo" in
the list. This suggests that it might make sense to accept patterns
also, so that "*oo" can match "foo". This, together with negation and
the idea mentioned above of always listing all files and only deleting
starred ones, would allow you to combine "edit by patterns" and "edit
by numbers" into a single mode of operation.

> rm -i::
>
>   This will show a "rm -i" style cleaning, that you must confirm one
>   by one in order to delete items. This action is not as efficient
>   as the above two actions.

The name "rm -i" is rather Unixy, and Windows users might not
understand it, nor people who don't use rm's -i option. Other
potentially better names might be: "ask", "ask each", "confirm",
"confirm each", "prompt", or "prompt each".

Functionally, the current implementation of this mode makes it an
oddball. "edit by patterns" and "edit by numbers" both return to the
top-level menu, allowing the user to invoke "clean" or "quit" (or some
other option), but "rm -i" always finishes by running "clean"
unconditionally. This is strangely inconsistent. Shouldn't it also
return to the top-level menu to give the user an opportunity to review
the final selection before invoking "clean" or "quit"?

> flags::
>
>   This lets you change the flags for git-clean, such as -x/-X/-d/-ff,
>   and refresh the cleaning candidates list automatically.

Is your "edit by patterns" and "edit by numbers" input remembered
across flags changes? Should it be? In other words, if you spent some
time fine-tuning the deletion list but then realized that you forgot
the -d flag on the command line, you might want to toggle the -d flag
here without losing the fine-tuning you already did.

>
> quit::
>
>   This lets you quit without do cleaning.
>
> help::
>
>   Show brief usage of interactive git-clean.

Have you considered the idea of an additional menu item which launches
an editor with a list of files to be removed so the user can edit it
[*1*]? This might also be a convenient way to fine-tune the deletion
list, though it certainly doesn't need to be part of this series.

[*1*] http://thread.gmane.org/gmane.comp.version-control.git/223271/focus=223431

> Jiang Xin (10):
>   Add support for -i/--interactive to git-clean
>   Show items of interactive git-clean in columns
>   Add colors to interactive git-clean
>   git-clean: use a git-add-interactive compatible UI
>   git-clean: interactive cleaning by select numbers
>   git-clean: rm -i style interactive cleaning
>   git-clean: update document for interactive git-clean
>   git-clean refactor: save some options in clean_flags
>   git-clean refactor: wrap in scan_clean_candidates
>   git-clean: change clean flags in interactive mode

The way this series is built up seems a bit odd for a couple reasons.

First, "edit by patterns" is just one of several selection modes
supported by --interactive. Why is it lumped in the first patch
whereas "edit by numbers" and "rm -i" are each added separately?
Shouldn't "edit by patterns", therefore, also be introduced in a
separate patch? Doing so might make review simpler.

Second, if you know that your intention is to emulate
git-add-interactive UI style, then implementing a "dumb" UI in patch 1
only to replace it entirely in patch 4 seems superfluous and
burdensome to reviewers. Wouldn't it make more sense to "do the right
thing" from the start by adding the desired UI early?

Given the above considerations, perhaps the series could be composed like this:

  ui: add a git-add-interactive-style UI for general use
  git-clean: add support for -i/--interactive to git-clean
    (with menu items "clean", "quit", "help")
  git-clean: interactive: show items in columns
  git-clean: interactive: add colors
  git-clean: interactive: add pattern-based fine-tuning
  git-clean: interactive: add number-based fine-turning
  git-clean: interactive: add "rm -i"-style fine-tuning
  git-clean: refactor: save some options in clean_flags
  git-clean: refactor: wrap in scan_clean_candidates
  git-clean: interactive: allow changing clean-flags
  doc: document interactive git-clean
