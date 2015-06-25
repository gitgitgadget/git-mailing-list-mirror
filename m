From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Thu, 25 Jun 2015 21:40:30 +0800
Message-ID: <CACRoPnQAGt_mLbG-EtJ+qTpD2OvNgi-MZfU=NoKCoSmhCOnBEw@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-7-git-send-email-pyokagan@gmail.com>
	<334feea4cee88d06a10a7363956d2bfe@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z87OQ-00080W-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 15:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbFYNke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 09:40:34 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36315 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFYNkc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 09:40:32 -0400
Received: by lacny3 with SMTP id ny3so45113433lac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jqq8C4yqc9XrmsPc8VZj8VP4WTZ36gPo8fL5XF568tU=;
        b=B0MBiPsgH7s0WBKUbv04TNxZV4Ajy14YgVk10Ux9jf59AwSVcHnhABKehDWbDftA7N
         V19nyQIlkYWIWHy6w6v0McFPjZtAcIx8JLb2aI19J8BGofqBWukGtsMIeLdvmGuq87kf
         GixJKcSGcCwBWhktFVuto0QOt0ZSYz2+X5IbX0AyGuCIgReC59BiMLWMOQ5tyg2QXl73
         uy9uAm2djylXBoJbF4hS1DY1rzmyva8/LiJsWm8SXLwfz+Vj3q4ifoNxUO8DkX2k5l87
         9Hc1/ZOAJzmO7NZnZCQ3FKTFXb1hU8jQcFgIMrOyHjT+/d94mxf8194sJf4FNB9kUY0f
         SlBA==
X-Received: by 10.152.4.163 with SMTP id l3mr12328611lal.35.1435239630674;
 Thu, 25 Jun 2015 06:40:30 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 25 Jun 2015 06:40:30 -0700 (PDT)
In-Reply-To: <334feea4cee88d06a10a7363956d2bfe@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272676>

On Wed, Jun 24, 2015 at 11:10 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-06-18 13:25, Paul Tan wrote:
>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index e9a3687..7b97ea8 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -121,6 +121,96 @@ static void am_destroy(const struct am_state *state)
>>       strbuf_release(&sb);
>>  }
>>
>> +/*
>> + * Returns 1 if the file looks like a piece of email a-la RFC2822, 0 otherwise.
>> + * We check this by grabbing all the non-indented lines and seeing if they look
>> + * like they begin with valid header field names.
>> + */
>> +static int is_email(const char *filename)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     FILE *fp = xfopen(filename, "r");
>> +     int ret = 1;
>> +
>> +     while (!strbuf_getline(&sb, fp, '\n')) {
>> +             const char *x;
>> +
>> +             strbuf_rtrim(&sb);
>> +
>> +             if (!sb.len)
>> +                     break; /* End of header */
>> +
>> +             /* Ignore indented folded lines */
>> +             if (*sb.buf == '\t' || *sb.buf == ' ')
>> +                     continue;
>> +
>> +             /* It's a header if it matches the regexp "^[!-9;-~]+:" */
>
> Why not just compile a regex and use it here? We use regexes elsewhere anyway...

Ah, you're right. A regular expression would definitely be clearer.
I've fixed it on my end.

>> +/**
>> + * Attempts to detect the patch_format of the patches contained in `paths`,
>> + * returning the PATCH_FORMAT_* enum value. Returns PATCH_FORMAT_UNKNOWN if
>> + * detection fails.
>> + */
>> +static int detect_patch_format(struct string_list *paths)
>> +{
>> +     enum patch_format ret = PATCH_FORMAT_UNKNOWN;
>> +     struct strbuf l1 = STRBUF_INIT;
>> +     struct strbuf l2 = STRBUF_INIT;
>> +     struct strbuf l3 = STRBUF_INIT;
>> +     FILE *fp;
>> +
>> +     /*
>> +      * We default to mbox format if input is from stdin and for directories
>> +      */
>> +     if (!paths->nr || !strcmp(paths->items->string, "-") ||
>> +         is_directory(paths->items->string)) {
>> +             ret = PATCH_FORMAT_MBOX;
>> +             goto done;
>> +     }
>> +
>> +     /*
>> +      * Otherwise, check the first 3 lines of the first patch, starting
>> +      * from the first non-blank line, to try to detect its format.
>> +      */
>> +     fp = xfopen(paths->items->string, "r");
>> +     while (!strbuf_getline(&l1, fp, '\n')) {
>> +             strbuf_trim(&l1);
>> +             if (l1.len)
>> +                     break;
>> +     }
>> +     strbuf_getline(&l2, fp, '\n');
>
> We should test the return value of `strbuf_getline()`; if EOF was reached already, `strbuf_getwholeline()` does not touch the strbuf. I know, the strbuf is still initialized empty here, but it is too easy to forget when changing this code.

Ah OK. I'll vote for doing a strbuf_reset() just before the
strbuf_getline() though.

>> +     strbuf_trim(&l2);
>> +     strbuf_getline(&l3, fp, '\n');
>> +     strbuf_trim(&l3);
>> +     fclose(fp);
>> +
>> +     if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: "))
>> +             ret = PATCH_FORMAT_MBOX;
>
> Hmm. We can test that earlier and return without reading from the file any further, I think.

The "reading 3 lines at the beginning" logic is meant to support a
later patch where support for StGit and mercurial patches is added.
That said, it's true that we don't need to read 3 lines in this patch,
so I think I will remove it in this patch.

>> +     else if (l1.len && l2.len && l3.len && is_email(paths->items->string))
>> +             ret = PATCH_FORMAT_MBOX;
>
> Maybe we can do better than this by folding the `is_email() function into this here function, reusing the same strbuf to read the lines and keeping track of the email header lines we saw... I would really like to avoid opening the same file twice just to figure out whether it is in email format.

Okay, how about every time we call a strbuf_getline(), we save the
line to a string_list as well? Like string_list_getline_crlf() below:

/**
 * Like strbuf_getline(), but supports both '\n' and "\r\n" as line
 * terminators.
 */
static int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
{
    if (strbuf_getwholeline(sb, fp, '\n'))
        return EOF;
    if (sb->buf[sb->len - 1] == '\n') {
        strbuf_setlen(sb, sb->len - 1);
        if (sb->len > 0 && sb->buf[sb->len - 1] == '\r')
            strbuf_setlen(sb, sb->len - 1);
    }
    return 0;
}

/**
 * Like strbuf_getline_crlf(), but appends the line to a string_list and
 * returns it as a string. Returns NULL on EOF.
 */
static const char *string_list_getline_crlf(struct string_list *list, FILE *fp)
{
    struct strbuf sb = STRBUF_INIT;
    struct string_list_item *item;

    if (strbuf_getline_crlf(&sb, fp))
        return NULL;
    item = string_list_append_nodup(list, strbuf_detach(&sb, NULL));
    return item->string;
}

So now, is_email() can have access to previously-read lines, and if it
needs some more, it can read more as well:

static int is_email(struct string_list *lines, FILE *fp)
{
    const char *header_regex = "^[!-9;-~]+:";
    regex_t regex;
    int ret = 1;
    size_t i;

    if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
        die("Invalid search pattern: %s", header_regex);

    for (i = 0; i < lines->nr || string_list_getline_crlf(lines, fp); i++) {
        const char *line = lines->items[i].string;

        if (!*line)
            break; /* End of header */

        /* Ignore indented folded lines */
        if (*line == '\t' || *line == ' ')
            continue;

        /* It's a header if it matches header_regex */
        if (regexec(&regex, line, 0, NULL, 0)) {
            ret = 0;
            goto done;
        }
    }

done:
    regfree(&regex);
    return ret;
}

Which solves the problem of opening the file 2 times. What do you think?

Regards,
Paul
