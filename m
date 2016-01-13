From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 14:47:20 -0800
Message-ID: <CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:47:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJUCq-0007vd-PG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 23:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbcAMWrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 17:47:41 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35176 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbcAMWrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 17:47:21 -0500
Received: by mail-io0-f182.google.com with SMTP id 77so403271903ioc.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 14:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AmC//MLwsvLpbNdovj2xJI3RWXR3wKBdaRfd5XogN2Y=;
        b=DA/ZV3ZYZlliYU+0kK7RUQVo6yUSymqiC0Fc5DTXM4mkSBcchrHZZEQUi2zVRHsbB4
         8kpNG4YDScAREoPhZLRsTlrM5sUVwflYbU640Sn2aOOKBeN47UqF+C0ycBvuRMSZkvhG
         2H4f6TOy1uF+xr9TQ5fMCycuegYZn/wUb2C0j7f02Ojz609Hg7e3NYop6pKhP1XmhXEz
         clLN2BC/he1XA1vs/DlrLpQoXQI3w44D2EHX69tLv5JN3+U+OHv1IDFLDAWeCLlU8CCS
         yHujMUpMC5141bzKYObg4KwGc3i0rxwwMmJsMjnowVKaiHJqV/WCXkABg7yZo3CBIHkz
         Km+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AmC//MLwsvLpbNdovj2xJI3RWXR3wKBdaRfd5XogN2Y=;
        b=KPUZPzmRMAxliHUQzaSbTTAa37p3sq/bFsfLDVAnhJD1E1Ju/R/nT3FlYpZ4EV0M9U
         q/VhmiZ+1VmjbnPUc1qCE0H0X7RNnUNO5LliIBtqh6YuYX6Cm6rbPO3MwLgTbU7Q9clf
         6C7YsGeNGnLeTD8oM6ZcRU9pVziqusjTwmabdTFL6PwSLyrgI3Jwgvi5J0IkFCo0MWlH
         6gKO8I9y5F/G576IJrNyXSv/dyGw25RVrq3UBBwTx8sb7l/f4BOnVlwMgiO2A1V98yAa
         O8E/ZT9F5vG2c9+ktu8NLTZH0WYkQnei3t/YlomHrE/nPS6MRgRjNtlNSbQR/SWc06j9
         Qx2w==
X-Gm-Message-State: ALoCoQkuasKKFa5SqmEkq33OwI9rebMfYz2eCz6PPRnDkaAlxIFJSaDJNRaugPLq4njfiwu5btya6eMzipEuO2KJWoUtFCfMYKTnkev/sLY9fbDdD4wLRBQ=
X-Received: by 10.107.129.149 with SMTP id l21mr1438124ioi.174.1452725240399;
 Wed, 13 Jan 2016 14:47:20 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 13 Jan 2016 14:47:20 -0800 (PST)
In-Reply-To: <xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283993>

On Wed, Jan 13, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Later on we want to deprecate the `git submodule init` command and make
>> it implicit in other submodule commands.
>
> I doubt there is a concensus for "deprecate" part to warrant the use
> of "we want" here.  I tend to think that the latter half of the
> sentence is uncontroversial, i.e. it is a good idea to make other
> "submodule" subcommands internally call it when it makes sense, and
> also make knobs available to other commands like "clone" and
> possibly "checkout" so that the users do not have to do the
> "submodule init" as a separate step, though.

Maybe I need to rethink my strategy here and deliver a patch series
which includes a complete port of `submodule init`, and maybe even
options in checkout (and clone) to run `submodule init`. That way the
immediate benefit would be clear on why the series is a good idea.

The current wording is mostly arguing to Jens, how to do the submodule
groups thing later on, but skipping the immediate steps.

>
>> As I was porting the functionality I noticed some odds with the inputs.
>
> I can parse but cannot quite grok.  You found some strange things in
> the input?  Whose input, that comes from where given by whom?
>
>> To fully understand the situation I added some logging to the function
>> temporarily to capture all calls to the function throughout the test
>> suite. Duplicates have been removed and all unique testing inputs have
>> been recorded into t0060.
>
> I can also parse this, but it is unclear what you did to the
> temporary debugging help at the end.  If you left it, then that is
> no longer a temporary but is part of the final product.  It is also
> unclear what "Duplicates" you are talking about here.

So in v1 somebody complained it's not clear what kind of input you'd get into
the relative_url(up_path, remoteurl, url) function. I did not know either, as it
was a straight port, passing the test suite. So I wanted to add tests.

To come up with reasonable tests I added a section to the code similar as this:

    {
        FILE *f = fopen("/tmp/testcases", "a");
        fprintf(f, "%s|%s|%s|%s\n", up_path, remoteurl, url, result);
        fclose(f);
    }

Then I run the whole test suite with the relative_url instrumented.
This gave me a file "/tmp/testcases" containing 500 lines with valid
in and output for the `relative_url` function.
However I run these 500 lines through sort|uniq to get about 90 lines
of unduplicated tests.

but in these 90 lines there were still syntactic duplicates where one
line may look like the other line just with
    s/trash directory.tXXXX/trash directory.tYYYY/
so I removed these lines manually, too.

And that's how I came up with the set of tests.
The logging function to "/tmp/testcases" was temporary and is not part
of the final product, but by mentioning that, some issues may be clear
to the reader, such as:
 * why there are tests with /u/trash directory-t7400.../...
 * the tests are as exhaustive as the test suite before.
 * there are no tests to test failure though, only test for good tests

>
> Do you mean that you found some of the existing tests were odd, and
> after examination with help from a temporary hack which does not
> remain in this patch, you determined that some tests were duplicated,
> which you removed, while adding new ones?

Yes, this.

>
>>  builtin/submodule--helper.c | 189 ++++++++++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            |  81 +------------------
>>  t/t0060-path-utils.sh       |  42 ++++++++++
>>  3 files changed, 235 insertions(+), 77 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f4c3eff..3e58b5d 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -9,6 +9,193 @@
>>  #include "submodule-config.h"
>>  #include "string-list.h"
>>  #include "run-command.h"
>> +#include "remote.h"
>> +#include "refs.h"
>> +#include "connect.h"
>> +
>> +static char *get_default_remote(void)
>> +{
>> +     char *dest = NULL, *ret;
>> +     unsigned char sha1[20];
>> +     int flag;
>> +     struct strbuf sb = STRBUF_INIT;
>> +     const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
>> +
>> +     if (!refname)
>> +             die("No such ref: HEAD");
>> +
>> +     refname = shorten_unambiguous_ref(refname, 0);
>> +     strbuf_addf(&sb, "branch.%s.remote", refname);
>
> Is it correct to use shorten_unambiguous_ref() here like this?  The
> function is meant to be used when you want heads/frotz because you
> have both refs/heads/frotz and refs/tags/frotz at the same time.  I
> think you want to say branch.frotz.remote even in such a case.  IOW,
> shouldn't it be skip_prefix() with refs/heads/, together with die()
> if the prefix is something else?

Right.

>
>> +     if (git_config_get_string(sb.buf, &dest))
>> +             ret = xstrdup("origin");
>> +     else
>> +             ret = xstrdup(dest);
>> +
>> +     strbuf_release(&sb);
>> +     return ret;
>> +}
>> +
>> +static int starts_with_dot_slash(const char *str)
>> +{
>> +     return str[0] == '.' && is_dir_sep(str[1]);
>> +}
>> +
>> +static int starts_with_dot_dot_slash(const char *str)
>> +{
>> +     return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
>> +}
>> +
>> +static char *last_dir_separator(char *str)
>> +{
>> +     char* p = str + strlen(str);
>
> Asterisk sticks to the variable, not the type.

ok

>
>> +     while (p-- != str)
>
> It is preferable to use '>' not '!=' here, because you know p
> approaches str from the larger side, for readability.

Also known as the limes operator (p--> str, "p goes to str")
just kidding :)

>
>> +             if (is_dir_sep(*p))
>> +                     return p;
>> +     return NULL;
>> +}
>
> (a useless comment) This is one of the rare places where I wish
> there were a version of strcspn() that scans from the right.
>
>> +static char *relative_url(const char *remote_url,
>> +                             const char *url,
>> +                             const char *up_path)
>> +{
>> +     int is_relative = 0;
>> +     int colonsep = 0;
>> +     char *out;
>> +     char *remoteurl = xstrdup(remote_url);
>> +     struct strbuf sb = STRBUF_INIT;
>> +     size_t len;
>> +
>> +     len = strlen(remoteurl);
>
> Nothing wrong here, but it looked somewhat inconsistent to see this
> assignment, while remoteurl is done as an initialization [*1*]

ok, noted.

>
>
> [Footnote]
>
> *1* as a personal preference, I tend to prefer seeing only simple
> operations in initialization and heavyweight ones as a separate
> assignment to an otherwise uninitialized variable, and strlen() is
> lighter-weight than xstrdup() in my dictionary.
>
>
>
>> +     if (is_dir_sep(remoteurl[len]))
>> +             remoteurl[len] = '\0';
>> +
>> +     if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
>> +             is_relative = 0;
>> +     else {
>> +             is_relative = 1;
>> +
>> +             /* Prepend a './' to ensure all relative remoteurls start
>> +              * with './' or '../'. */
>
> Adjust the style, and perhaps remove the final full-stop to make the
> last string literal easier to see?  I.e.
>
>         /*
>          * Prepend a './' to ensure all relative remoteurls
>          * start with './' or '../'
>          */
>
> would be easier to see what it is said.

ok

>
>> +             if (!starts_with_dot_slash(remoteurl) &&
>> +                 !starts_with_dot_dot_slash(remoteurl)) {
>> +                     strbuf_reset(&sb);
>> +                     strbuf_addf(&sb, "./%s", remoteurl);
>> +                     free(remoteurl);
>> +                     remoteurl = strbuf_detach(&sb, NULL);
>> +             }
>> +     }
>> +     /* When the url starts with '../', remove that and the
>> +      * last directory in remoteurl. */
>
> Style.

ok

>
>> +     while (url) {
>> +             if (starts_with_dot_dot_slash(url)) {
>> +                     char *rfind;
>> +                     url += 3;
>> +
>> +                     rfind = last_dir_separator(remoteurl);
>> +                     if (rfind)
>> +                             *rfind = '\0';
>> +                     else {
>> +                             rfind = strrchr(remoteurl, ':');
>> +                             if (rfind) {
>> +                                     *rfind = '\0';
>> +                                     colonsep = 1;
>> +                             } else {
>> +                                     if (is_relative || !strcmp(".", remoteurl))
>> +                                             die(_("cannot strip one component off url '%s'"), remoteurl);
>> +                                     else
>> +                                             remoteurl = xstrdup(".");
>> +                             }
>> +                     }
>
> It is somewhat hard to see how this avoids stripping one (or both)
> slashes just after "http:" in remoteurl="http://site/path/", leaving
> just "http:/" (or "http:").

it would leave just 'http:/' if url were to be ../../some/where/else,
such that the constructed url below would be http://some/where/else.

>
> This codepath has overly deep nesting levels.  Is this the simplest
> we can do?

it's a direct translation from shell. I could imagine the inside of
    if (starts_with_dot_dot_slash(url)) {
        ...
    }

may go to its own function, such that it becomes:

    while (url) {
        if (starts_with_dot_dot_slash(url)) {
            adjust_remoteurl_and_url(&url, &remoteurl)
        else if (starts_with_dot_slash(url))
            url += 2;
        else
            break;
    }


with a proper name for adjust_remoteurl_and_url of course.

>
> The final else { if .. else } can be made into else if .. else to
> dedent the overlong die() by one level, but I am wondering if the
> deep nesting is just a symptom of logic being unnecessarily complex.

I don't think it's unnecessary complex, but results from a direct
shell->C translation.

>
>> +             } else if (starts_with_dot_slash(url)) {
>> +                     url += 2;
>> +             } else
>> +                     break;
>> +     }
>> +     strbuf_reset(&sb);
>> +     strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
>> +
>> +     if (starts_with_dot_slash(sb.buf))
>> +             out = xstrdup(sb.buf + 2);
>> +     else
>> +             out = xstrdup(sb.buf);
>> +     strbuf_reset(&sb);
>> +
>> +     free(remoteurl);
>> +     if (!up_path || !is_relative)
>> +             return out;
>> +
>> +     strbuf_addf(&sb, "%s%s", up_path, out);
>> +     free(out);
>> +     return strbuf_detach(&sb, NULL);
>> +}
>
> Thanks.
