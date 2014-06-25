From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] test-config: add usage examples for non-callback
 query functions
Date: Wed, 25 Jun 2014 07:19:03 -0400
Message-ID: <CAPig+cTf+8H38SSxoLMSuU9JUSPiEuTCm=8wHFe5QSCK3j8ELw@mail.gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 13:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzlEN-00015e-QN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 13:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbaFYLTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 07:19:06 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:53742 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaFYLTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 07:19:05 -0400
Received: by mail-yh0-f49.google.com with SMTP id f73so1039804yha.8
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OteSVI85sJ/vWp6li1T8k1kXw4O+sBGYzemxyB6wb9M=;
        b=SWNNJxH9WclGaGelVoSszfKuKHWvfge4BKSWm9Nlq946hfifr+XCcOYaCfQt8T9JiB
         +krDfcfH/uSDSyomuYVIX9Fhm1r7et1t2a7McSk7jWi9bhR/4VTXJok76sYTsUua2Szi
         zPHhqC8o2viigzh4zwr3FgPoqx2/PYguytFTElS/Y5bivBAdn+ZUhi+i92N2vX60ei6i
         hFwHuXYc/lbcmwhOfRqPejDBifenS628+WlRU82u7iHb/wHyh1Xhuuw84xeZb3NFd5Xj
         bxab3+c5dCb7kKXTpx3DsTR1cWeH1nyh4BqD2J1wjO7UOOdpgucbHRddLFDmvkQ99r6D
         nnIA==
X-Received: by 10.236.116.38 with SMTP id f26mr5236675yhh.101.1403695143459;
 Wed, 25 Jun 2014 04:19:03 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Wed, 25 Jun 2014 04:19:03 -0700 (PDT)
In-Reply-To: <1403518300-23053-4-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: jScAr4wsxYmDf6AnXQb1VdTGgy4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252441>

On Mon, Jun 23, 2014 at 6:11 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Add different usage examples for 'git_config_get_string' and
> `git_config_get_string_multi`. They will serve as documentation
> on how to query for config values in a non-callback manner.

This is a good start, but it's not fully what Matthieu was suggesting
when he said that you should prove to other developers, by way of
reproducible tests, that your changes work. What he meant, was that
you should write a test-config program which exposes (as a runnable
command) the new config C API you've added, and then write tests which
exercise that API and implementation exhaustively.

For example, take a look at test-string-list.c and
t/t0063-string-list.sh. The C program does no checking itself. It
merely exposes the C API via command-line arguments, such as "split",
"filter", etc. The test script then employs that program to perform
the actual testing in a reproducible and (hopefully) exhaustive
fashion. Because t/t0063-string-list.sh is part of the test suite, the
string-list tests are run regularly by many developers. It's not just
something that someone might remember to run once in a while.

Contrary to your commit message and the comment in the program itself,
the purpose of test-config is not to serve as documentation or to
provide examples of usage. (Real documentation is better suited for
those purposes.) Instead, test-config should exist in support of a
real test script in t/ which is run regularly. The new script you add
to t/ should exercise the exposed C API as exhaustively as possible.
This means checking each possible state: for instance, (1) when a key
is absent, (2) when a value is boolean (NULL), (3) one non-boolean
(non-NULL) value, (4) multiple values, etc. Moreover, it should check
expected success _and_ expected failure modes. Check not only that it
returns expected values, but that it fails when appropriate.

More below.

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  .gitignore    |  1 +
>  Makefile      |  1 +
>  test-config.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 test-config.c
>
> diff --git a/.gitignore b/.gitignore
> index 42294e5..7677533 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -177,6 +177,7 @@
>  /gitweb/static/gitweb.min.*
>  /test-chmtime
>  /test-ctype
> +/test-config
>  /test-date
>  /test-delta
>  /test-dump-cache-tree
> diff --git a/Makefile b/Makefile
> index 07ea105..9544efb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -549,6 +549,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>
>  TEST_PROGRAMS_NEED_X += test-chmtime
>  TEST_PROGRAMS_NEED_X += test-ctype
> +TEST_PROGRAMS_NEED_X += test-config
>  TEST_PROGRAMS_NEED_X += test-date
>  TEST_PROGRAMS_NEED_X += test-delta
>  TEST_PROGRAMS_NEED_X += test-dump-cache-tree
> diff --git a/test-config.c b/test-config.c
> new file mode 100644
> index 0000000..ff24cb8
> --- /dev/null
> +++ b/test-config.c
> @@ -0,0 +1,93 @@
> +#include "cache.h"
> +#include "hashmap.h"
> +#include "string-list.h"
> +
> +/*
> + * This program gives examples on how to use non-callback based query
> + * functions like git_config_get_string & git_config_get_string_multi.

See above regarding the true purpose of test-config. A more accurate
description might be something like this:

    This program exposes the C API of the configuration mechanism
    as a set of simple commands in order to facilitate testing.

> + *
> + * Reads stdin and prints result of command to stdout:
> + *
> + * print_all -> prints all the key-value pairs contained in the hashmap
> + *             also checks if all entries in the hashmap matches with
> + *             the content of config files

Some comments:

This doesn't just print all values. It's doing validation on its own,
so the name 'print_all' is misleading.

This isn't part of the C API which you are exposing, so such a command
is somewhat out of place here. A script in t/ could perform similar
functionality via the exposed API.

Having said that, it probably doesn't hurt to do such internal
integrity checking, however, a better command name is warranted.
Perhaps 'check_integrity'. Moreover, a command which checks internal
integrity need not verbosely print all items. More useful, upon
success, would be to emit nothing at all or a simple "ok" or such. On
failure, emit enough information about detected problems to allow them
to be tracked down and fixed.

> + *
> + * get_value -> prints the value with highest priority for the entered key
> + *
> + * get_all_values -> prints all values for the given key in increasing order
> + *                  of priority

Since you're exposing the C API, it might make sense to name these
after the C functions. For instance, "get_string" and
"get_string_multi". (This can become important as the API is
expanded.)

> + * Examples:
> + *
> + * To print the value with highest priority for key "foo.bAr Baz.rock":
> + *     test-config get_value "foo.bAr Baz.rock"
> + *
> + */
> +
> +static const char *v;
> +static const struct string_list *strptr;
> +static int i;
> +static int *flag;

These variables are not shared between different functions in this
file, so they don't need to be global. Instead, you should declare
them as local variables where needed.

> +static int config_cache_callback(const char *key, const char *value, void *unused)

This name doesn't convey much. Since this is actually implementing
functionality of the 'show_all' command, perhaps show_all_cb() would
be better. Even better, given the comments above,
check_integrity_cb().

> +{
> +       strptr = git_config_get_string_multi(key);
> +       if (strptr) {
> +               for (i = 0; i < strptr->nr; i++)
> +               {

Style: { on same line as 'for'

> +                       v = strptr->items[i].string;
> +                       flag = strptr->items[i].util;
> +                       /* NULL values are flagged as 1 */
> +                       if (*flag == 1)
> +                               printf("%s\n", key);
> +                       else if (*flag == 0)
> +                               printf("%s=%s\n", key, v);
> +                       /* key-value pair printed so flag them as done */
> +                       *flag = -1;

Curious: It's not clear what the purpose of this -1 is. Is the
callback being invoked multiple times with the same key/value pair?

> +               }
> +               return 0;
> +       } else {
> +               printf("%s\n", "Config hashmap inconsistent\n");

Spelling out the actual inconsistency, rather than making a only
general statement, could help a programmer diagnose the problem.

> +               return -1;
> +       }
> +}
> +
> + int main(int argc, char **argv)
> +{
> +       if (argc == 2 && !strcmp(argv[1], "print_all")) {
> +               git_config(config_cache_callback, NULL);
> +               return 0;
> +       } else if (argc == 3 && !strcmp(argv[1], "get_value")) {
> +               /* enter key in canonical form enclosed in quotes */

What does this comment mean? Is it telling us what the code is doing
or is it an instruction to the person typing at the shell? The bit
about "canonical form" is something which you can document in the
comment block at the top of this file.

> +               if (!git_config_get_string(argv[2], &v)) {
> +                       printf("%s\n", v);

What happens if this is a boolean (NULL) value? Behavior of '%s' on a
NULL value is undefined. Better would be to emit some special,
recognizable token when NULL.

> +                       return 0;
> +               } else {
> +                       printf("%s\n", "Value not found for the entered key\n");

Although the key was specified on the command-line, this diagnostic
can be more helpful by mentioning which key was not found.

> +                       return -1;
> +               }
> +       } else if (argc == 3 && !strcmp(argv[1], "get_all_values")) {
> +               /* enter key in canonical form enclosed in quotes */

Ditto regarding comment.

> +               strptr = git_config_get_string_multi(argv[2]);
> +               if (strptr) {
> +                       for (i = 0; i < strptr->nr; i++)
> +                       {

Style: { on same line as 'for'

> +                               v = strptr->items[i].string;
> +                               flag = strptr->items[i].util;
> +                               /* prints NULL values as "-" */

Rather than "-", it might make more sense to choose a more unique and
identifiable representation which can be easily and reliably
recognized by the test script.

> +                               if (*flag)
> +                                       printf("%s ", "-");
> +                               else
> +                                       printf("%s ", v);
> +                       }
> +                       printf("\n");

Printing all items of a multi-part config value on a single line
delimited by spaces may not be the best output format. The values
themselves may contain whitespace. Taking into consideration that this
output should be easily consumable by a test script, it probably makes
more sees to print each value on its own line.

> +                       return 0;
> +               } else {
> +                       printf("%s\n", "Value not found for the entered key\n");

To be helpful, say which key was not found.

> +                       return -1;
> +               }
> +       }
> +
> +       fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
> +               argv[1] ? argv[1] : "(there was none)");

This is a bit of a lie. This diagnostic will be triggered, not only
for an unrecognized function, but also if the number of arguments to a
function was incorrect.

> +       return 1;
> +}
> --
> 1.9.0.GIT
