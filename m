From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Thu, 25 Jun 2015 23:16:18 +0800
Message-ID: <CACRoPnSZn=8keW3meUvLY-B_4vQigMTQW_VVvY2rU8ctjcxcaQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-5-git-send-email-pyokagan@gmail.com>
	<6560adbc8b1842dd369628980f1264c3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 17:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88t7-0002AG-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 17:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbFYPQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 11:16:22 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33966 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbFYPQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 11:16:20 -0400
Received: by lagx9 with SMTP id x9so47110900lag.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LF4OqIq6YMuUxDax0Xvq/3iS/Ok9JQgFiVY6WQJ2Umk=;
        b=FffaBmH3eGKB8asaW6AI122p+4qqADCw5c5YVk21p21qs7puPXoyblyu2FnP+ZhU4O
         4fIq/7vMS2k6AUq/8olV3WHbZ0Qogzwu+SeSjqshrbiSNoMzJd3H8Yj798haCqVNf4Il
         ME63AUGKI3DumTBzzHhZei4NaOusAA1zEuJgiFog/AUTnhHQzY8lmO4wqqIUwexShW40
         TGIgyKrisUmlAG8eWw3UzMOCRzFw6KhTE71KSVzfU0Cd7hUJigbgzs17CQ8LxabSZD7q
         WsN439vW4IvFX4kFG7iz3GjUCWjgQJgecGxbXx6ELrnfWyz/F8+I1NfCHeP4uLqFAQLO
         itxQ==
X-Received: by 10.152.2.38 with SMTP id 6mr46069338lar.80.1435245378706; Thu,
 25 Jun 2015 08:16:18 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 25 Jun 2015 08:16:18 -0700 (PDT)
In-Reply-To: <6560adbc8b1842dd369628980f1264c3@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272685>

On Wed, Jun 24, 2015 at 10:59 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>> diff --git a/builtin/am.c b/builtin/am.c
>> index dbc8836..af68c51 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -6,6 +6,158 @@
>>  #include "cache.h"
>>  #include "builtin.h"
>>  #include "exec_cmd.h"
>> +#include "parse-options.h"
>> +#include "dir.h"
>> +
>> +struct am_state {
>> +     /* state directory path */
>> +     struct strbuf dir;
>> +
>> +     /* current and last patch numbers, 1-indexed */
>> +     int cur;
>> +     int last;
>> +};
>> +
>> +/**
>> + * Initializes am_state with the default values.
>> + */
>> +static void am_state_init(struct am_state *state)
>> +{
>> +     memset(state, 0, sizeof(*state));
>> +
>> +     strbuf_init(&state->dir, 0);
>> +}
>
> With strbufs, we use the initializer STRBUF_INIT. How about using
>
> #define AM_STATE_INIT { STRBUF_INIT, 0, 0 }
>
> here?

Later in the patch series am_state_init() will also take into account
config settings when filling up the default values. e.g. see patches
25/31[1] or 31/31[2]. I think that is reasonable: the purpose of
am_state_init() is to initialize the am_state struct with the default
values, and the default values can be set by the user through the
config settings.

This means, though, that we can't use initializers without introducing
global variables.

[1] http://thread.gmane.org/gmane.comp.version-control.git/271967/focus=271972
[2] http://thread.gmane.org/gmane.comp.version-control.git/271967/focus=271972

>> +/**
>> + * Reads the contents of `file`. The third argument can be used to give a hint
>> + * about the file size, to avoid reallocs. Returns number of bytes read on
>> + * success, -1 if the file does not exist. If trim is set, trailing whitespace
>> + * will be removed from the file contents.
>> + */
>> +static int read_state_file(struct strbuf *sb, const char *file,
>> size_t hint, int trim)
>> +{
>> +     strbuf_reset(sb);
>> +     if (strbuf_read_file(sb, file, hint) >= 0) {
>> +             if (trim)
>> +                     strbuf_trim(sb);
>> +
>> +             return sb->len;
>> +     }
>> +
>> +     if (errno == ENOENT)
>> +             return -1;
>> +
>> +     die_errno(_("could not read '%s'"), file);
>> +}
>
> A couple of thoughts:
>
> - why not reuse the strbuf by making it a part of the am_state()? That way, you can allocate, say, 1024 bytes (should be plenty enough for most of our operations) and just reuse them in all of the functions. We will not make any of this multi-threaded anyway, I don't think.

But too much usage of this temporary strbuf may lead to a situation
where one function calls another, and both functions write to the
strbuf and clobber its contents.

Besides, if we are talking about read_state_file(), it takes an
external strbuf, so it gives the caller the freedom to choose which
strbuf it uses (e.g. if it is stack allocated or in the am_state
struct). I think it's more flexible this way.

> - Given that we only read short files all the time, why not skip the hint parameter? Especially if we reuse the strbuf, it should be good enough to allocate a reasonable buffer first and then just assume that we do not have to reallocate it all that often anyway.

Doh! Right, the hint parameter is quite useless, since in am_load() we
use the same strbuf anyway. (And strbuf_init() can set a hint as well)
I've removed it on my side.

> - Since we only read files from the state directory, why not pass the basename as parameter? That way we can avoid calling `am_path()` explicitly over and over again (and yours truly cannot forget to call `am_path()` in future patches).

Makes sense. After all, this function is called read_STATE_file() ;-)

> - If you agree with these suggestions, the signature would become something like
>
> static void read_state_file(struct am_state *state, const char *basename, int trim);

So for now, my function signature is

static void read_state_file(struct strbuf *sb, const struct am_state
*state, const char *basename, int trim);

>> +/**
>> + * Remove the am_state directory.
>> + */
>> +static void am_destroy(const struct am_state *state)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>> +     strbuf_addstr(&sb, state->dir.buf);
>> +     remove_dir_recursively(&sb, 0);
>> +     strbuf_release(&sb);
>> +}
>
> Given that `remove_dir_recursively()` has to reset the strbuf with the directory's path to the original value before it returns (because it recurses into itself, therefore the value *has* to be reset when returning), we can just call
>
>     remove_dir_recursively(&state->dir, 0);
>
> and do not need another temporary strbuf.

Ah right. Although, state->dir is not an strbuf anymore on my side. As
Junio[3] rightfully noted, state->dir is not modified by the am_*()
API, so it's been changed to a char*. Which means an strbuf is
required to be passed to remove_dir_recursively();

>> +/**
>> + * Increments the patch pointer, and cleans am_state for the application of the
>> + * next patch.
>> + */
>> +static void am_next(struct am_state *state)
>> +{
>> +     state->cur++;
>> +     write_file(am_path(state, "next"), 1, "%d", state->cur);
>> +}
>
> Locking and re-checking the contents of "next" before writing the incremented value would probably be a little too paranoid...

Yeah, Junio did bring something like that[3]. I'm still thinking about
it, though I don't think I would like this issue to block the patch
series since it's a delicate issue, and git-am.sh does not do anything
special either.

For now though, I've moved all the write_file()s into a central
am_save() function, so if we want to do any locking or syncing it
would be easy to modify am_save(), and then all the callers will
benefit.

[3] http://thread.gmane.org/gmane.comp.version-control.git/271967/focus=271972
