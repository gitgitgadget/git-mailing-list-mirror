From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 17:28:03 -0400
Message-ID: <CAPig+cT0gLzMV7p9-ZavZn2t00Oh_-4oQWZuk8ptYWEtmCuYVA@mail.gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
	<CAPig+cTR5SdDF0QnKN8GFEKFkNEK_HoCDHj_vTnAbp37HK3kDA@mail.gmail.com>
	<5396FB7C.6000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTaU-0003Ei-LM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbaFJV2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:28:06 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:36305 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaFJV2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:28:05 -0400
Received: by mail-yh0-f42.google.com with SMTP id i57so3394440yha.29
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=c/3vCZ75bdcOiBs5oQhleMrj7HttgOCgS6r8B9l4SGg=;
        b=U7RYR0N09k2jpgElb5ytmPf/s6/3jiHHa3/fsIQfsgUDe1Dd2WimwYV+KeQ2rChtto
         /wKKoAy/AHVb4Z8h/0Jn60+KrymRGLmR501Wjfez8eHwrzJ8BfqcU4ZZDYRMJJpU8ag+
         kR2cRYeK6b8a0fco+2f3HdZIFFHjCrrHrli2KhMZG2ArpsvZVixKU3qy28fADB1suQvd
         5QPQKHMa1YdyD6YdMP4BLtIRUM4l2dgcdutb6i9V1+u0L0G9wtN3XmHE0hq6R/zC30Ma
         bGRW5VeRfrQUwfcSXa/Hfs69yJbrlT+vAthMz4gksMPzVg/Ff7T70Qa2Czy5hy7WVUWD
         Je6Q==
X-Received: by 10.236.166.169 with SMTP id g29mr5144876yhl.135.1402435683769;
 Tue, 10 Jun 2014 14:28:03 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 14:28:03 -0700 (PDT)
In-Reply-To: <5396FB7C.6000709@gmail.com>
X-Google-Sender-Auth: AYAFgktjymMTFSt5lSKoiIWw1EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251238>

On Tue, Jun 10, 2014 at 8:35 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Thanks for the review, Eric. I have replied to your comments below,
> I will try to reply early and more promptly now.

Thanks for responding. More below.

> On 06/10/2014 04:27 AM, Eric Sunshine wrote:
>>> ---
>>> diff --git a/config.c b/config.c
>>> index a30cb5c..6f6b04e 100644
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -9,6 +9,8 @@
>>>  #include "exec_cmd.h"
>>>  #include "strbuf.h"
>>>  #include "quote.h"
>>> +#include "hashmap.h"
>>> +#include "string-list.h"
>>>
>>>  struct config_source {
>>>         struct config_source *prev;
>>> @@ -37,6 +39,120 @@ static struct config_source *cf;
>>>
>>>  static int zlib_compression_seen;
>>>
>>> +struct config_cache_entry {
>>> +       struct hashmap_entry ent;
>>> +       char *key;
>>> +       struct string_list *value_list;
>>
>> Same question as in my v1 and v2 reviews [1][2], and reiterated by
>> Matthieu [3]: Why is 'value_list' a pointer to a structure rather than
>> just a structure?
>
> Sorry for the lack of response on this part. I thought choosing a pointer to a
> structure or just the structure itself was a stylistic choice.

Each point or question raised in a review is meaningful to the
reviewer and deserves some sort of response or consideration, even if
you don't agree with the reviewer's opinion. It's okay to have
stylistic or other preferences (and to argue for them), but unless you
voice them, the reviewer is likely to conclude that his review effort
is wasted.

In this case, it's not a stylistic consideration which prompted the
question, but practical concern. (More on that below.)

> Since most of the
> functions just pass the pointer to this struct, I thought it would be more natural to
> use it. But I have changed my mind on this one. In the next iteration I will be using
> a plane old struct.

There are practical reasons for choosing a structure rather than a
pointer to a structure. Problems with a pointer include:

- Expense of an extra (unnecessary) heap allocation. You allocate both
config_cache_entry and string_list on the heap for each entry being
inserted into the hash, rather than allocating only a
config_cache_entry.

- Potential additional heap fragmentation.

- Increased possibility of leaking memory. The current implementation
of config_cache_free() drives this point home: although it correctly
clears the string_list, it leaks the heap-allocated string_list
itself.

- Potentially misleading readers of the code into thinking that there
is an important reason for the string_list to be allocated separately
from its containing object (for instance, "is the string list shared?"
or "does the string list need to exist beyond the lifetime of the
config_cache_entry?").

>>> +}
>>> +
>>> +static void config_cache_init(struct hashmap *config_cache)
>>> +{
>>> +       hashmap_init(config_cache, (hashmap_cmp_fn) config_cache_entry_cmp_case, 0);
>>
>> In his review [4], Peff suggested giving config_cache_entry_cmp_case()
>> the correct hashmap_cmp_fn signature so that this cast can be dropped.
>> It's not clear whether you disagree with his advice or overlooked or
>> forgot about it. If you disagree with his suggestion, it's okay to say
>> so and explain why you feel the way you do, but without feedback from
>> you, he or another reviewer is going to continue suggesting the same
>> change.
>
> Now on this one, I checked the code thoroughly. Every single hashmap_init()
> incantation in git code has a hashmap_cmp_fn cast.

That's a good argument for explaining to Peff why you did it this way,
but unless you voice this, he will likely feel that you simply ignored
his review comment.

> I don't think that it is necessary to do so. Is it?

There are good reasons for avoiding the cast. Jonathan gives one such
reason here [1]. In that case, he let it slide for the reason you
mention: existing hashmap clients use the cast. (However, the
implication is that it would be nice for someone -- not necessarily
you -- to submit a patch series eliminating the casts.)

Whether Peff will be swayed by the same argument, only he can answer.
(If he doesn't answer, taking [1] into consideration, you'd probably
be on safe ground to continue using the cast.)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243818/focus=243917
(see his comments about hashmap_init()).

>>> +       if (ret)
>>> +               return NULL;
>>> +
>>> +       hashmap_entry_init(&k, strhash(normalized_key));
>>> +       k.key = (char*) key;
>>
>> This looks fishy. You're hashing based upon 'normalized_key' but then
>> comparing against the unnormalized 'key'. Peff's suggestion [4] was to
>> store the normalized key in the hash, which means that you should use
>> 'normalized_key' for both hashing and comparing. (See additional
>> commentary about this issue below in config_cache_set_value().)
>
> Ouch, this I had corrected in a future commit. But forgot to include in
> this patch.

[Leaving unsnipped since it has relevance below.]

>> Style: (char *)key
>
> Noted. In function arguments the code uses (char*) key. I copied it from there.
> :)

Indeed, there's an unfortunate lack of consistency: in fact, even
config.c already has a mix of "(x*)y", "(x *)y", and "(x *) y", but I
think "(x *)y" is the one preferred and seems to be the most common.

>>> +static int config_cache_set_value(const char *key, const char *value)
>>> +{
>>> +       struct hashmap *config_cache;
>>> +       struct config_cache_entry *e;
>>> +
>>> +       config_cache = get_config_cache();
>>> +       e = config_cache_find_entry(key);
>>> +       if (!e) {
>>> +               e = xmalloc(sizeof(*e));
>>> +               hashmap_entry_init(e, strhash(key));
>>
>> The hash computed to store the key should be the same as the hash to
>> look it up. In config_cache_find_entry(), you're correctly computing
>> the hash based upon the normalized key, but here you're doing so from
>> the unnormalized key.
>>
>>> +               e->key = xstrdup(key);
>>
>> Likewise. Normalized keys should be stored in the hash, not unnormalized.
>>
>> You should be invoking git_config_parse_key() to normalize the key
>> both for hashing and storing.
>>
>> Note, also, that call git_config_parse_key() allocates the normalize
>> key on your behalf, so you do *not* want to xstrdup() it here.
>
> config_cache_set_value() gets its values from git_config() as it the callback.
> git_config() feeds the callback only normalized values by using functions like
> get_extended_base_var(), get_base_var() etc. Thus, I didn't use
> git_config_parse_key(). Please correct me if I am wrong, but I tested this case
> thoroughly.

You're right. Documentation/api-config.txt even states that 'key' is
already normalized here. Thanks for pointing it out. So, the only
thing in need of fixing is the fishy bit in config_cache_find_entry()
where it is incorrectly searching for the unnormalized key.

>>> +               e->value_list = xcalloc(sizeof(struct string_list), 1);
>>> +               e->value_list->strdup_strings = 1;
>>
>> This code is perhaps too intimate with the implementation of
>> string_list. It may work today (because it is safe to initialize all
>> string_list fields to 0 via xcalloc()), but a future change to the
>> string_list implementation may invalidate that assumption. The
>> initialization macros in string-list.h exist to preserve the
>> abstraction, so you don't have to know the details of initialization.
>> The macros are not suitable for your use-case, but an initialization
>> function, such as string_list_init(), would be suitable, and it would
>> be appropriate to add such a function in a preparatory patch (as
>> already suggested by [1]).
>
> Noted. As I am going to use a simple struct for the list, this won't be
> a problem.

Even after 'value_list' becomes a simple struct rather than a pointer
to a struct, the string_list will still require initialization, and
the STRING_LIST_INIT_* macros still don't help your case, so it
remains a problem. The suggested preparatory patch introducing a new
string_list_init() function would allow you to initialize your
string_list while preserving the abstraction.
