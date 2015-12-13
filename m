From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 09/10] ref-filter: introduce contents_atom_parser()
Date: Mon, 14 Dec 2015 01:03:48 +0530
Message-ID: <CAOLa=ZTdyWe421m=G0ktnh4McH-xE86ek46uu5nbijSCFifcuw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-10-git-send-email-Karthik.188@gmail.com> <CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:34:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CPZ-0001kJ-8h
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbbLMTeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:34:19 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32887 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbbLMTeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:34:18 -0500
Received: by vkca188 with SMTP id a188so143589965vkc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3TlOCurk6vq5msnZarkPtpuX7o1oQq+IXxkOfsLyjDk=;
        b=oqvRLZ7+3XFIAN4cGTcjrkTAczwwt0vpy9H/v60f2cWNLziOlB4izxbXJXMPzNRjIM
         tET/yapIGzpTkVW6ggtr5zRshYrqWci2mE0bBj2ZIh0egUxhb4dYOj+udDhCZKQCWgil
         c8dPBPrzlVIj39ILyBMWL/S9b575EwIIFyjURx0shjdaV1XXSnwUfr6QctK/h+TIkV16
         YFlowv/tOF3wp/uabfBNzqXx4DE40lJmOD5vDB2hrIy+b2xsMX6i5QYsMscLtfw6P9CO
         sJBmh9oGVLde1y0443IIEhgAre1rf3EKNCGoWl8IO3uD1y944Gtia8zK5aeQxoj1EFIK
         xUhg==
X-Received: by 10.31.157.144 with SMTP id g138mr23341037vke.71.1450035257902;
 Sun, 13 Dec 2015 11:34:17 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 11:33:48 -0800 (PST)
In-Reply-To: <CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282345>

On Sun, Dec 13, 2015 at 8:40 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce contents_atom_parser() which will parse the '%(contents)'
>> atom and store information into the 'used_atom' structure based on the
>> modifiers used along with the atom.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 802629b..117bbbb 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -42,6 +42,14 @@ static struct used_atom {
>>                                 track : 1,
>>                                 trackshort : 1;
>>                 } remote_ref;
>> +               struct {
>> +                       unsigned int subject : 1,
>> +                               body : 1,
>> +                               signature : 1,
>> +                               all : 1,
>> +                               lines : 1,
>> +                               no_lines;
>> +               } contents;
>
> Same question as patch 8/10: With the exception of non-bitfield
> 'no_lines', are these 'contents' flags mutually exclusive? If so, an
> enum would be a more natural representation than bitfields.
>

Like I said, an enum would cause problems here.
If you see the code flow when we check for contents we currently (as
per this patch)
use the 'all' bit to denote usage of contents, but when using an enum we would
set the enum to the first value when using memset.

But this should go away with the 'enum atom_type' implementation which
you suggested.

>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -92,6 +100,29 @@ void remote_ref_atom_parser(struct used_atom *atom)
>> +void contents_atom_parser(struct used_atom *atom)
>> +{
>> +       const char * buf;
>> +
>> +       if (match_atom_name(atom->str, "contents", &buf))
>> +               atom->u.contents.all = 1;
>> +
>> +       if (!buf)
>> +               return;
>
> Hmm, I'd have placed the blank line after the 'if (!buf) return;'
> rather than before it.
>

Will change that.

>> +       if (!strcmp(buf, "body"))
>> +               atom->u.contents.body = 1;
>> +       else if (!strcmp(buf, "signature"))
>> +               atom->u.contents.signature = 1;
>> +       else if (!strcmp(buf, "subject"))
>> +               atom->u.contents.subject = 1;
>> +       else if (skip_prefix(buf, "lines=", &buf)) {
>> +               atom->u.contents.lines = 1;
>> +               if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
>> +                       die(_("positive value expected contents:lines=%s"), buf);
>> +       } else
>> +               die(_("improper format entered contents:%s"), buf);
>
> Perhaps a more grammatically-friendly error message?
>

Will do.

>> +}
>> +
>>  static align_type get_align_position(const char *type)
>>  {
>>         if (!strcmp(type, "right"))
>> @@ -761,20 +786,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>         unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
>>
>>         for (i = 0; i < used_atom_cnt; i++) {
>> -               const char *name = used_atom[i].str;
>> +               struct used_atom *atom = &used_atom[i];
>> +               const char *name = atom->str;
>>                 struct atom_value *v = &val[i];
>> -               const char *valp = NULL;
>>                 if (!!deref != (*name == '*'))
>>                         continue;
>>                 if (deref)
>>                         name++;
>>                 if (strcmp(name, "subject") &&
>>                     strcmp(name, "body") &&
>> -                   strcmp(name, "contents") &&
>> -                   strcmp(name, "contents:subject") &&
>> -                   strcmp(name, "contents:body") &&
>> -                   strcmp(name, "contents:signature") &&
>> -                   !starts_with(name, "contents:lines="))
>> +                   !atom->u.contents.all)
>>                         continue;
>>                 if (!subpos)
>>                         find_subpos(buf, sz,
>> @@ -784,26 +805,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>
>>                 if (!strcmp(name, "subject"))
>>                         v->s = copy_subject(subpos, sublen);
>> -               else if (!strcmp(name, "contents:subject"))
>> +               else if (atom->u.contents.subject)
>>                         v->s = copy_subject(subpos, sublen);
>
> With the disclaimer that I haven't fully digested the existing logic,
> is there a reason that you don't also preprocess bare "subject" as you
> preprocess "contents:subject"? Isn't "subject" just historic aliases
> for "contents:subject"?
>
> A similar observation may be made about "body" and "contents:body",
> although I see they mean slightly different things (for, I suppose,
> historical reasons).
>

Actually I missed that out, now that you mention it, i'll see how I
can come around this.

>>                 else if (!strcmp(name, "body"))
>>                         v->s = xmemdupz(bodypos, bodylen);
>> -               else if (!strcmp(name, "contents:body"))
>> +               else if (atom->u.contents.body)
>>                         v->s = xmemdupz(bodypos, nonsiglen);
>> -               else if (!strcmp(name, "contents:signature"))
>> +               else if (atom->u.contents.signature)
>>                         v->s = xmemdupz(sigpos, siglen);
>> -               else if (!strcmp(name, "contents"))
>> -                       v->s = xstrdup(subpos);
>> -               else if (skip_prefix(name, "contents:lines=", &valp)) {
>> +               else if (atom->u.contents.lines) {
>>                         struct strbuf s = STRBUF_INIT;
>>                         const char *contents_end = bodylen + bodypos - siglen;
>>
>> -                       if (strtoul_ui(valp, 10, &v->u.contents.lines))
>> -                               die(_("positive value expected contents:lines=%s"), valp);
>>                         /*  Size is the length of the message after removing the signature */
>> -                       append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
>> +                       append_lines(&s, subpos, contents_end - subpos, atom->u.contents.no_lines);
>>                         v->s = strbuf_detach(&s, NULL);
>> -               }
>> +               } else /*  For %(contents) without modifiers */
>
> Too many blanks following '/*'; downcase 'for' or drop it altogether:
>
>     /* bare %(contents) */
>

Will do thanks.

-- 
Regards,
Karthik Nayak
