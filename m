From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 13 Dec 2015 11:32:09 +0530
Message-ID: <CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-9-git-send-email-Karthik.188@gmail.com> <CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 07:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7zkf-0003xR-Sh
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 07:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbbLMGCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 01:02:40 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32880 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbLMGCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 01:02:40 -0500
Received: by vkca188 with SMTP id a188so138420863vkc.0
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 22:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pvNAUKCfY1GNc+dVbu+kplWjtAs8fkgHAFoAR7WD/zw=;
        b=e82i6fTMjvtqM5OuVRmJSCofMAPZs2svt3wjfRbqSNc2A77rM6bzdN6kUPUGoenFXH
         XkJnTt1WgX0rtaHXBhbhcMCS5eogvPzptgSKCd5Igy0xaMBTqMp5lTZze6MNf295L/r3
         uhZVWAL7itlmjPbm8oSR/0sU9koVxHnrbc2PIUwhKJC7QVqleGhJ8iagbYQ7sVh1ncx0
         WnwTnOe6QzmOvmctIirT6I1oJTj3CsH5YIC1XVlej7Y16XGGRvgpzPnIhhZfqg1OnWuE
         zQ101X3dwxyNK8D2UCIrfX7fhQu9zU/GkxkDiROCI48vi6Gu7zLRjvIncvJeQwoLLf/y
         95eQ==
X-Received: by 10.31.8.204 with SMTP id 195mr19701190vki.30.1449986559253;
 Sat, 12 Dec 2015 22:02:39 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sat, 12 Dec 2015 22:02:09 -0800 (PST)
In-Reply-To: <CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282321>

On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>> and '%(push)' atoms and store information into the 'used_atom'
>> structure based on the modifiers used along with the corresponding
>> atom.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -37,6 +37,11 @@ static struct used_atom {
>>         union {
>>                 const char *color;
>>                 struct align align;
>> +               struct {
>> +                       unsigned int shorten : 1,
>> +                               track : 1,
>> +                               trackshort : 1;
>> +               } remote_ref;
>
> Are 'shorten', 'track', and 'trackshort' mutually exclusive? If so, a
> simple enum would be clearer than bitfields:
>
>     union {
>         const char *color;
>         struct align align;
>         enum { RR_PLAIN, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>             remote_ref;
>     };
>
> Or something.
>

Sure, will do that.

>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -69,6 +74,24 @@ void color_atom_parser(struct used_atom *atom)
>> +void remote_ref_atom_parser(struct used_atom *atom)
>> +{
>> +       const char *buf;
>> +
>> +       buf = strchr(atom->str, ':');
>> +       if (!buf)
>> +               return;
>> +       buf++;
>> +       if (!strcmp(buf, "short"))
>> +               atom->u.remote_ref.shorten = 1;
>> +       else if (!strcmp(buf, "track"))
>> +               atom->u.remote_ref.track = 1;
>> +       else if (!strcmp(buf, "trackshort"))
>> +               atom->u.remote_ref.trackshort = 1;
>> +       else
>> +               die(_("improper format entered align:%s"), buf);
>
> "align:"? Also, how about a more grammatically-friendly error message?
>

Bad copy-paste, will change that.

>> +}
>> +
>> @@ -838,6 +861,42 @@ static inline char *copy_advance(char *dst, const char *src)
>> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>> +                                   struct branch *branch, const char **s)
>> +{
>> +       int num_ours, num_theirs;
>> +       if (atom->u.remote_ref.shorten)
>> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
>> +       else if (atom->u.remote_ref.track) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>> +                       return;
>> +               if (!num_ours && !num_theirs)
>> +                       *s = "";
>> +               else if (!num_ours)
>> +                       *s = xstrfmt("[behind %d]", num_theirs);
>> +               else if (!num_theirs)
>> +                       *s = xstrfmt("[ahead %d]", num_ours);
>> +               else
>> +                       *s = xstrfmt("[ahead %d, behind %d]",
>> +                                    num_ours, num_theirs);
>
> Tangent: These xstrfmt()'d strings are getting leaked, right? Is that
> something that we need to worry about (if, for instance, a repository
> contains a lot of tracking refs)? Should there be a NEEDSWORK comment
> here regarding the issue?
>

This is sort of a problem with most of the values in ref-filter, we dynamically
allocate memory and do not free it, since the program exits soon after and
we leave it to the Operating System to do the garbage collection.

Not sure if we'd want to work on this though.

>> +       } else if (atom->u.remote_ref.trackshort) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>> +                       return;
>> +
>> +               if (!num_ours && !num_theirs)
>> +                       *s = "=";
>> +               else if (!num_ours)
>> +                       *s = "<";
>> +               else if (!num_theirs)
>> +                       *s = ">";
>> +               else
>> +                       *s = "<>";
>> +       } else
>> +               *s = refname;
>> +}
>> +
>>  /*
>>   * Parse the object referred by ref, and grab needed value.
>>   */
>> @@ -948,49 +1011,11 @@ static void populate_value(struct ref_array_item *ref)
>>
>>                 formatp = strchr(name, ':');
>>                 if (formatp) {
>> -                       int num_ours, num_theirs;
>> -
>>                         formatp++;
>>                         if (!strcmp(formatp, "short"))
>>                                 refname = shorten_unambiguous_ref(refname,
>>                                                       warn_ambiguous_refs);
>
> Is this duplicating work already done by fill_remote_ref_details()?
>

No, this is only activated when using "refname". fill_remote_ref_details()
is used by the %(upstream) and %(push) atoms, both of which skip the
loop using "continue" in populate_value().

-- 
Regards,
Karthik Nayak
