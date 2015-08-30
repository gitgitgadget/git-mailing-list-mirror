From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sun, 30 Aug 2015 22:32:19 +0530
Message-ID: <CAOLa=ZSgjrg60r6bdWfCHC+J9_q+ZWUHXc7j_9ePkdTBE1+-Kg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-8-git-send-email-Karthik.188@gmail.com> <CAPig+cQmAkFAjUcJNJNF2gwunX6TKK+oQsd2QnmJwxLT=EEvjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 19:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW60L-0001q1-Fk
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 19:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbbH3RCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 13:02:50 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35870 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbbH3RCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 13:02:49 -0400
Received: by obkg7 with SMTP id g7so75113471obk.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a6iss4i287J9i6xAHymV8CA9LxBNYeaHySdqHUiEYNc=;
        b=T1gEPtdyppep6a5VyOx/0TF8mke8r0h9FVawJ91BZ6U7QxoZ+1V8uT3dM/q9Pp1xfl
         MVcRdqOOPBZBx4L27TRKPRcAVLRndr0lFRILk6s2WqFp7AmfOpLotogsxSEOb+V9taf4
         908XmCwFQ5ZxpCmMgZPIqbStrnR/7h0rwNJlQlHevuTUtPhLu4xEgxwjlU7E4RvBuAp9
         UUjLR1cKtZj4RKb6cnVP3NfYzKXCMIX6zp+rnsGdgdj3JrzhLogUp+Aik5HlEyVtNMa2
         wnQNMlCXBgSAXW2tFR1px4D925PiwJqafv2evA0Jl5irduc4DgVukzR/lsDgIrgRv1Lo
         9Oig==
X-Received: by 10.182.196.101 with SMTP id il5mr949570obc.41.1440954168353;
 Sun, 30 Aug 2015 10:02:48 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 30 Aug 2015 10:02:19 -0700 (PDT)
In-Reply-To: <CAPig+cQmAkFAjUcJNJNF2gwunX6TKK+oQsd2QnmJwxLT=EEvjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276825>

On Sun, Aug 30, 2015 at 1:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In 'tag.c' we can print N lines from the annotation of the tag using
>> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
>> modify it to support appending of N lines from the annotation of tags
>> to the given strbuf.
>>
>> Implement %(contents:lines=X) where X lines of the given object are
>> obtained.
>>
>> Add documentation and test for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 471d6b1..0fc7557 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -63,6 +64,11 @@ struct align {
>>         unsigned int width;
>>  };
>>
>> +struct contents {
>> +       unsigned int lines;
>> +       struct object_id oid;
>> +};
>> +
>>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
>>
>>  struct ref_formatting_stack {
>> @@ -80,6 +86,7 @@ struct ref_formatting_state {
>>  struct atom_value {
>>         const char *s;
>>         struct align *align;
>> +       struct contents *contents;
>
> Same question as for 'align': Does 'contents' need to be
> heap-allocated because it must exist beyond the lifetime of
> 'atom_value'? If not, making it just a plain member of 'atom_value'
> would simplify memory management (no need to free it).
>

In this context that makes sense, as the value is only needed for the
current atom value.

> Also, will 'align' and 'contents' ever be used at the same time? If
> not, it might make sense to place them in a 'union' (not for the
> memory saving, but to make it clear to the reader that their use is
> mutually exclusive).
>

Not quite sure if it needs to be mutually exclusive (isn't that up to the user?)
But this can be done, as they're separate atoms and at a time only one of them
is used.

> More below.
>
>>         void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
>>         unsigned long ul; /* used for sorting when not FIELD_STR */
>>  };
>> @@ -569,6 +576,61 @@ static void find_subpos(const char *buf, unsigned long sz,
>>         *nonsiglen = *sig - buf;
>>  }
>>
>> +/*
>> + * If 'lines' is greater than 0, append that many lines from the given
>> + * object_id 'oid' to the given strbuf.
>> + */
>> +static void append_tag_lines(struct strbuf *out, const struct object_id *oid, int lines)
>> +{
>> +       int i;
>> +       unsigned long size;
>> +       enum object_type type;
>> +       char *buf, *sp, *eol;
>> +       size_t len;
>> +
>> +       buf = read_sha1_file(oid->hash, &type, &size);
>> +       if (!buf)
>> +               die_errno("unable to read object %s", oid_to_hex(oid));
>> +       if (type != OBJ_COMMIT && type != OBJ_TAG)
>> +               goto free_return;
>> +       if (!size)
>> +               die("an empty %s object %s?",
>> +                   typename(type), oid_to_hex(oid));
>> +
>> +       /* skip header */
>> +       sp = strstr(buf, "\n\n");
>> +       if (!sp)
>> +               goto free_return;
>> +
>> +       /* only take up to "lines" lines, and strip the signature from a tag */
>> +       if (type == OBJ_TAG)
>> +               size = parse_signature(buf, size);
>> +       for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
>> +               if (i)
>> +                       strbuf_addstr(out, "\n    ");
>> +               eol = memchr(sp, '\n', size - (sp - buf));
>> +               len = eol ? eol - sp : size - (sp - buf);
>> +               strbuf_add(out, sp, len);
>> +               if (!eol)
>> +                       break;
>> +               sp = eol + 1;
>> +       }
>> +free_return:
>> +       free(buf);
>> +}
>
> I understand that you want to re-use this code from
> tag.c:show_tag_lines(), but (from a very cursory read) isn't this
> duplicating logic and processing already done elsewhere in
> ref-filter.c? More about this below.
>

Replied below.

>> +
>> +static void contents_lines_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +       struct contents *contents = (struct contents *)atomv->contents;
>
> Why is this cast needed?
>

Will remove.

>> +       struct strbuf s = STRBUF_INIT;
>> +
>> +       append_tag_lines(&s, &contents->oid, contents->lines);
>> +       quote_formatting(&state->stack->output, s.buf, state->quote_style);
>> +       strbuf_release(&s);
>> +
>> +       free(contents);
>> +}
>> @@ -588,7 +651,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>                     strcmp(name, "contents") &&
>>                     strcmp(name, "contents:subject") &&
>>                     strcmp(name, "contents:body") &&
>> -                   strcmp(name, "contents:signature"))
>> +                   strcmp(name, "contents:signature") &&
>> +                   !starts_with(name, "contents:lines="))
>>                         continue;
>>                 if (!subpos)
>>                         find_subpos(buf, sz,
>> @@ -608,6 +672,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>                         v->s = xmemdupz(sigpos, siglen);
>>                 else if (!strcmp(name, "contents"))
>>                         v->s = xstrdup(subpos);
>> +               else if (skip_prefix(name, "contents:lines=", &valp)) {
>> +                       struct contents *contents = xmalloc(sizeof(struct contents));
>> +
>> +                       if (strtoul_ui(valp, 10, &contents->lines))
>> +                               die(_("positive width expected align:%s"), valp);
>> +                       hashcpy(contents->oid.hash, obj->sha1);
>
> The logic in append_tag_lines() which was copied from
> tag.c:show_tag_lines() goes through the effort of loading the object
> and parsing it, but hasn't the object already been loaded and parsed
> by the time you get to this point? Assuming I'm reading this
> correctly, wouldn't it make more sense to take advantage of the work
> already done loading and parsing the object rather than repeating it
> all inside append_tag_lines()?
>

Makes sense, I'll work on this.

>> +                       v->handler = contents_lines_handler;
>> +                       v->contents = contents;
>> +               }
>>         }
>>  }
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index cef7a41..0277498 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -166,4 +166,20 @@ test_expect_success 'nested alignment' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'check `%(contents:lines=X)`' '
>> +       cat >expect <<-\EOF &&
>> +       master three
>> +       side four
>> +       odd/spot three
>> +       double-tag Annonated doubly
>> +       four four
>> +       one one
>> +       signed-tag A signed tag message
>> +       three three
>> +       two two
>> +       EOF
>> +       git for-each-ref --format="%(refname:short) %(contents:lines=1)" >actual &&
>
> Maybe also test some edge cases, such as line=0, lines=-1 (an invalid
> value), lines=2, lines=9999999 (a value larger than the number of
> lines in any object).
>

Will do. Thanks for the review.

--
Regards,
Karthik Nayak
