From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Fri, 26 Jun 2015 16:11:09 +0800
Message-ID: <CACRoPnSyu6or8nkMQ0yS_KcLwumJVNv3pfSFGcSDyk4-P_VZ_A@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<72c470f3a6890dfcb66f1439383d2278@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 10:11:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8OjH-0008C3-RU
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 10:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbbFZILQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 04:11:16 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35596 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbbFZILK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 04:11:10 -0400
Received: by lagi2 with SMTP id i2so59117614lag.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3deCmJ+4ZErR9vd6uHA0fJ7jziqAc/ZABuIfHEO9e6I=;
        b=sD5GfneQZ+NCPoY9segbsNwLdNZsoG8u9zkaYWyH4owJw1C06fvzpYIZ5dSKHHOc1U
         xKzCOjO6Nf8Zg8MPTCX9d8lw9NMA3laS+0pUImaDCgAY0GmJvtXW6c4bMVO9Iacu5OXe
         pUlam89VwSLvswKNh0uFomkn913cbRBOTxaV3DA6hB+ok+VNnHqpEKr5gPjyvL3tRbvB
         cZ1TYDqWqh6lM0iL5465xTXwxNRmW+IwWiFMTftJPFYakidt8lj618GSLtUgMBCxfTsW
         gAjOdrsez5taylAFvNdar0ghJaR2sw9dl3rqup+RbtTXyy7XmihZ1jZMh8+1/XHcjH7o
         5KSA==
X-Received: by 10.112.64.72 with SMTP id m8mr394642lbs.98.1435306269636; Fri,
 26 Jun 2015 01:11:09 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 26 Jun 2015 01:11:09 -0700 (PDT)
In-Reply-To: <72c470f3a6890dfcb66f1439383d2278@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272766>

On Thu, Jun 25, 2015 at 12:36 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-06-18 13:25, Paul Tan wrote:
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 7b97ea8..d6434e4 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -94,6 +126,105 @@ static int read_state_file(struct strbuf *sb,
>> const char *file, size_t hint, int
>>  }
>>
>>  /**
>> + * Reads a KEY=VALUE shell variable assignment from fp, and returns the VALUE
>> + * in `value`. VALUE must be a quoted string, and the KEY must match `key`.
>> + * Returns 0 on success, -1 on failure.
>> + *
>> + * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
>> + * the author-script.
>> + */
>> +static int read_shell_var(struct strbuf *value, FILE *fp, const char *key)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     char *str;
>> +
>> +     if (strbuf_getline(&sb, fp, '\n'))
>> +             return -1;
>> +
>> +     if (!skip_prefix(sb.buf, key, (const char **)&str))
>> +             return -1;
>> +
>> +     if (!skip_prefix(str, "=", (const char **)&str))
>> +             return -1;
>> +
>> +     str = sq_dequote(str);
>> +     if (!str)
>> +             return -1;
>> +
>> +     strbuf_reset(value);
>> +     strbuf_addstr(value, str);
>> +
>> +     strbuf_release(&sb);
>> +
>> +     return 0;
>> +}
>
> How about using `strbuf_remove()` and keeping `str` as `const char *`?

OK, I'll try that out. Looks like this now:

static char *read_shell_var(FILE *fp, const char *key)
{
    struct strbuf sb = STRBUF_INIT;
    const char *str;

    if (strbuf_getline(&sb, fp, '\n'))
        return NULL;

    if (!skip_prefix(sb.buf, key, &str))
        return NULL;

    if (!skip_prefix(str, "=", &str))
        return NULL;

    strbuf_remove(&sb, 0, str - sb.buf);

    str = sq_dequote(sb.buf);
    if (!str)
        return NULL;

    return strbuf_detach(&sb, NULL);
}

> I also think we can fold it into the `read_author_script()` function and make it more resilient with regards to the order of the variables. Something like this:
> [...]

Hmm, I think we should be very strict about parsing the author-script
file though. As explained in read_author_script(), git-am.sh evals the
author-script, which we can't in C. I would much rather we barf at the
first sign that the author-script is not what we expect, rather than
attempt to parse it as much as possible, but end up with the wrong
results as compared to git-am.sh.

Besides, currently git-am.sh will always write the author-script with
the order of GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE. If
the order is wrong, I would think it means that something is messing
with the author-script, and it would be better if we bail out
immediately, instead of potentially doing something wrong.

>> +/**
>> + * Saves state->author_name, state->author_email and state->author_date in
>> + * `filename` as an "author script", which is the format used by git-am.sh.
>> + */
>> +static void write_author_script(const struct am_state *state)
>> +{
>> +     static const char fmt[] = "GIT_AUTHOR_NAME=%s\n"
>> +             "GIT_AUTHOR_EMAIL=%s\n"
>> +             "GIT_AUTHOR_DATE=%s\n";
>> +     struct strbuf author_name = STRBUF_INIT;
>> +     struct strbuf author_email = STRBUF_INIT;
>> +     struct strbuf author_date = STRBUF_INIT;
>> +
>> +     sq_quote_buf(&author_name, state->author_name.buf);
>> +     sq_quote_buf(&author_email, state->author_email.buf);
>> +     sq_quote_buf(&author_date, state->author_date.buf);
>
> The `sq_quote_buf()` function does not call `strbuf_reset()`. Therefore you could just use a single strbuf to construct the entire three lines and then write that out. Again, if you follow my suggestion to keep a "scratch pad" strbuf in am_state, you could reuse that.

Right, makes sense. I've implemented it on my end.

Thanks,
Paul
