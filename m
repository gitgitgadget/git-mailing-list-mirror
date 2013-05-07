From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening
 refs/remotes/origin/HEAD to origin
Date: Tue, 7 May 2013 20:49:34 +0200
Message-ID: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 20:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZmxO-0004yK-4x
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460Ab3EGStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:49:41 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:52703 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab3EGStk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:49:40 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZmxG-0005p9-Qe
	for git@vger.kernel.org; Tue, 07 May 2013 20:49:38 +0200
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZmxG-000Ei6-De
	for git@vger.kernel.org; Tue, 07 May 2013 20:49:38 +0200
Received: by mail-ob0-f178.google.com with SMTP id 16so895797obc.37
        for <git@vger.kernel.org>; Tue, 07 May 2013 11:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=+GET+Mm+BlPa0xC75KXv3SihjXWxJfF5IiPs0i6jY/o=;
        b=QhSmqoahIQui4k+IAI295iUbdEzsqvZgd6r9JAgfACH2F20AENKk5+oIYCwllAX4hT
         2OFpNRIWZcHt4rbORmuBUuuTqDZdMKsSzBMSPCWFpTwYkuNHBg5sIJI0is6AqbwtyFRt
         WlI4nWJ7vp/oBWO83UzHV46dD6wYctyGHyBw95jfMQjwUW96wPpGoNgbZmYP87FbJU0B
         IaqvpZp5xsRSDh4sR1JODEL0x9YV5qC6MGQ8Mi6dTmxUe/As1ruoZHD5QsnH53a65qhp
         0HMXVZJmrYQJ8YIohsyaF3hT3+DkVke97mRAj3B5CMsLyXLMLIqD6zvRzSEiA6+bxbKI
         sJgA==
X-Received: by 10.60.134.241 with SMTP id pn17mr912222oeb.140.1367952574973;
 Tue, 07 May 2013 11:49:34 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Tue, 7 May 2013 11:49:34 -0700 (PDT)
In-Reply-To: <7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223593>

On Mon, May 6, 2013 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> ... there is AFAICS _no_ way for sscanf() - having
>> already done one or more format extractions - to indicate to its caller
>> that the input fails to match the trailing part of the format string.
>
> Yeah, we can detect when we did not have enough, but we cannot tell
> where it stopped matching.
>
> It is interesting that this bug has stayed so long with us, which
> may indicate that nobody actually uses the feature at all.

I don't know if people really care about whether
"refs/remotes/origin/HEAD" shortens to "origin/HEAD" or "origin". I'm
guessing that people _do_ depend on the reverse - having "origin"
expand into "refs/remotes/origin/HEAD", so we probably cannot rip out
the "refs/remotes/%.*s/HEAD" rule altogether...

> Good eyes.
>
>> Cc: Bert Wesarg <bert.wesarg@googlemail.com>
>> Signed-off-by: Johan Herland <johan@herland.net>
>> ---
>>  refs.c                  | 82 +++++++++++++++++++------------------------------
>>  t/t6300-for-each-ref.sh | 12 ++++++++
>>  2 files changed, 43 insertions(+), 51 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index d17931a..7231f54 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2945,80 +2945,60 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
>>       return NULL;
>>  }
>>
>> +int shorten_ref(const char *refname, const char *pattern, char *short_name)
>
> Does this need to be an extern?

Nope, it should be static. Will fix.

>>  {
>> +     /*
>> +      * pattern must be of the form "[pre]%.*s[post]". Check if refname
>> +      * starts with "[pre]" and ends with "[post]". If so, write the
>> +      * middle part into short_name, and return the number of chars
>> +      * written (not counting the added NUL-terminator). Otherwise,
>> +      * if refname does not match pattern, return 0.
>> +      */
>> +     size_t pre_len, post_start, post_len, match_len;
>> +     size_t ref_len = strlen(refname);
>> +     char *sep = strstr(pattern, "%.*s");
>> +     if (!sep || strstr(sep + 4, "%.*s"))
>> +             die("invalid pattern in ref_rev_parse_rules: %s", pattern);
>> +     pre_len = sep - pattern;
>> +     post_start = pre_len + 4;
>> +     post_len = strlen(pattern + post_start);
>> +     if (pre_len + post_len >= ref_len)
>> +             return 0; /* refname too short */
>> +     match_len = ref_len - (pre_len + post_len);
>> +     if (strncmp(refname, pattern, pre_len) ||
>> +         strncmp(refname + ref_len - post_len, pattern + post_start, post_len))
>> +             return 0; /* refname does not match */
>> +     memcpy(short_name, refname + pre_len, match_len);
>> +     short_name[match_len] = '\0';
>> +     return match_len;
>>  }
>
> OK. Looks correct, even though I suspect some people might come up
> with a more concise way to express the above.

Yeah, I made it sort of explicit to convince myself I'd gotten it
right. I'm sure the same can be expressed in fewer lines of code.

>>  char *shorten_unambiguous_ref(const char *refname, int strict)
>>  {
>>       int i;
>>       char *short_name;
>>
>>       /* skip first rule, it will always match */
>> -     for (i = nr_rules - 1; i > 0 ; --i) {
>> +     for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {
>>               int j;
>>               int rules_to_fail = i;
>>               int short_name_len;
>>
>> +             if (!ref_rev_parse_rules[i] ||
>
> What is this skippage about?  Isn't it what you already compensated
> away by starting from "ARRAY_SIZE() - 1"?

There are various things being skipped at various points... The
ref_rev_parse_rules array looks like this:

const char *ref_rev_parse_rules[] = {
	"%.*s",
	"refs/%.*s",
	"refs/tags/%.*s",
	"refs/heads/%.*s",
	"refs/remotes/%.*s",
	"refs/remotes/%.*s/HEAD",
	NULL
};

Obviously we want to skip looking at the last (sentinel) entry. But
there's also no point in looking at the first, since it trivially
"shortens" to itself.

The for loop in this function:
>> -     for (i = nr_rules - 1; i > 0 ; --i) {
>> +     for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {

is about skipping the _first_ array entry (we start at the last index,
and stop _before_ we reach 0).

The current line:
>> +             if (!ref_rev_parse_rules[i] ||

is about skipping the last (sentinel) entry. The previous code did
this by doing a pre-pass where nr_rules is set to
ARRAY_SIZE(ref_rev_parse_rules) - 1. I should have obviously done the
same by initializing i to ARRAY_SIZE(ref_rev_parse_rules) - 2 in the
above for loop.

> Ahh, no.  But wait.  Isn't there a larger issue here?
>
>> +                 !(short_name_len = shorten_ref(refname,
>> +                                                ref_rev_parse_rules[i],
>> +                                                short_name)))
>>                       continue;
>>
>> -             short_name_len = strlen(short_name);
>> -
>>               /*
>>                * in strict mode, all (except the matched one) rules
>>                * must fail to resolve to a valid non-ambiguous ref
>>                */
>>               if (strict)
>> -                     rules_to_fail = nr_rules;
>> +                     rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules);
>
> Isn't nr_rules in the original is "ARRAY_SIZE()-1"?

True. Good catch.

>>
>>               /*
>>                * check if the short name resolves to a valid ref,
>
> Could you add a test to trigger the "strict" codepath?

I imagined the strict codepath was already being tested by the
addition to t6300, seeing as core.warnAmbiguousRef defaults to true.
Obviously I will have to add some more tests to make sure I'm not
screwing things up.

New version coming up. I'm going to rip this patch out of the
surrounding series, since it doesn't really belong there anyway.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
