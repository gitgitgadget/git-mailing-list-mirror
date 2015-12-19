From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/11] ref-filter: introduce struct used_atom
Date: Sat, 19 Dec 2015 10:12:39 +0530
Message-ID: <CAOLa=ZTfBqkYiYpRyZQP5pNisa6kEz29FBpr-QKcAGYwrKk9Tw@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-4-git-send-email-Karthik.188@gmail.com> <CAPig+cR5=8urU+Vq_doC53+T4WCmEWJdKXyMEsbL3gWxsNpmxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 05:44:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA9NN-0003Pb-Eg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 05:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbbLSEnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 23:43:37 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34745 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbbLSEnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 23:43:09 -0500
Received: by mail-vk0-f42.google.com with SMTP id j66so76289756vkg.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 20:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5w5UsL7mj3Iw7pQlf5+JL8NmcPbV9f6Bj0MudJQhZoA=;
        b=O5dMToqloHIUGjONbvC8KgenCBevtIHX+Alf5bzM7kcp4fGIzDS34SfkqMDns4kwDn
         yeDT4tsIoXWQ8q8qd5sl/3ZQiJizbv0yRwr1VMdoBXt0QrhtliN8wqdZ7qQ0uhcnyA5o
         2V2n8nVTHwNKfK52RokejqEJrOW/12Rwt6CwCOg4oslpZpyk+q6t0awq5CHglpCr+WF5
         EKEXg9nYdkgSDpX0oWAKv+l83PLUP2/hgs0UzQDO2CTubvP6Elf7Jor0/PnBTdwOsz/z
         Fs9xk0pxxkvPfIu4HY9wPhqHzOzEX0YvnF/GRB825mqvKi7PlnRwLe+CYlbFv7UuqCoY
         FprQ==
X-Received: by 10.31.16.140 with SMTP id 12mr4423800vkq.106.1450500188525;
 Fri, 18 Dec 2015 20:43:08 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Fri, 18 Dec 2015 20:42:39 -0800 (PST)
In-Reply-To: <CAPig+cR5=8urU+Vq_doC53+T4WCmEWJdKXyMEsbL3gWxsNpmxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282735>

On Thu, Dec 17, 2015 at 2:27 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce the 'used_array' structure which would replace the existing
>> implementation of 'used_array' (which a list of atoms). This helps us
>> parse atom's before hand and store required details into the
>> 'used_array' for future usage.
>
> All my v1 review comments[1] about the commit message still apply to
> this version.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/281860
>

I totally missed this out, thanks for bringing it up.

>> Also introduce a parsing function for each atom in valid_atom. Using
>> this we can define special parsing functions for each of the atoms.
>
> This is a conceptually distinct change which probably deserves its own
> patch. In particular, the new patch would add this field to
> valid_atom[] *and* add the code which invokes the custom parser. (That
> code is currently commingled with introduction of the color parser in
> patch 6/11.)
>go

I guess that could be done, I was thinking it goes together, but it
makes sense to have a
separate patch for introduction of the parsing function and its invocations.

> More below...
>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -16,9 +16,27 @@
>> +/*
>> + * An atom is a valid field atom listed below, possibly prefixed with
>> + * a "*" to denote deref_tag().
>> + *
>> + * We parse given format string and sort specifiers, and make a list
>> + * of properties that we need to extract out of objects.  ref_array_item
>> + * structure will hold an array of values extracted that can be
>> + * indexed with the "atom number", which is an index into this
>> + * array.
>> + */
>> +static struct used_atom {
>> +       const char *str;
>> +       cmp_type type;
>> +} *used_atom;
>> +static int used_atom_cnt, need_tagged, need_symref;
>> +static int need_color_reset_at_eol;
>> +
>>  static struct {
>>         const char *name;
>>         cmp_type cmp_type;
>> +       void (*parser)(struct used_atom *atom);
>>  } valid_atom[] = {
>>         { "refname" },
>>         { "objecttype" },
>> @@ -786,7 +788,8 @@ static void populate_value(struct ref_array_item *ref)
>>
>>         /* Fill in specials first */
>>         for (i = 0; i < used_atom_cnt; i++) {
>> -               const char *name = used_atom[i];
>> +               struct used_atom *atom = &used_atom[i];
>> +               const char *name = atom->str;
>
> Same question as my previous review[1]: Why not just:
>
>     const char *name = used_atom[i].str;
>
> ?

I think It's leftover code, I was using the atom variable also before.
I'll remove it.

-- 
Regards,
Karthik Nayak
