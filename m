From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/11] ref-filter: introduce remote_ref_atom_parser()
Date: Thu, 24 Dec 2015 13:12:28 +0530
Message-ID: <CAOLa=ZQ1SXm6GG0jzokq7shrm0=4B8vvME13Qbh_QCEWt2X=0A@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-10-git-send-email-Karthik.188@gmail.com> <CAPig+cRG_HTWL=VNqOxDnv_M0NbYZSReCHSsGe1CJiFQS8h-XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 08:43:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC0YC-0001If-L7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 08:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbbLXHnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 02:43:00 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33067 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbLXHm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 02:42:58 -0500
Received: by mail-vk0-f51.google.com with SMTP id a188so145917806vkc.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 23:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tKWLiK/SPmj2qH1rdzSzk8n1IyoBTy3hYn+th2TYovM=;
        b=Q2MAxg0i5p8VVpBUZZpOWi8bhTLdG4DwRWljec1T7BLoLTCwdemuvnZyr44+dot+yJ
         SnRzx0MkI/Ob1w8vmfYxIWcl2rf34CZ8Ah9IP0vt9OPM6lSBiZ4Wekp6sbpKpkSABY/w
         Azg0bYq0JeCkUxnv+OGqx3eAoUogVk0nEfEWr1gZoS2fT6FW8116tu2EoGIn134dadY7
         l/mn/LyoX0wbXdI2c3SoJsh4nhDXqyCGhH+HhcnmSYUVwNR9Dg4wYWAiehNLGfJb5+zw
         AYyYDSQdSt4hOQP8F6bFBc41dq7GesHJ3nTO18t8HdZjIkhTpVAFeFjvpZw5tpIQ+cT0
         RD9g==
X-Received: by 10.31.16.140 with SMTP id 12mr21007898vkq.106.1450942977872;
 Wed, 23 Dec 2015 23:42:57 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Wed, 23 Dec 2015 23:42:28 -0800 (PST)
In-Reply-To: <CAPig+cRG_HTWL=VNqOxDnv_M0NbYZSReCHSsGe1CJiFQS8h-XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282973>

On Thu, Dec 17, 2015 at 2:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>> and '%(push)' atoms and store information into the 'used_atom'
>> structure based on the modifiers used along with the corresponding
>> atom.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -37,6 +37,8 @@ static struct used_atom {
>>         union {
>>                 const char *color;
>>                 struct align align;
>> +               enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
>
> Nit: I'd have expected to see the normal/plain case first rather than
> last (but not itself worth a re-roll).
>

Will add it in. That'll put it in an alphabetical order too.

>> +                       remote_ref;
>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -69,6 +71,25 @@ static void color_atom_parser(struct used_atom *atom)
>> +static void remote_ref_atom_parser(struct used_atom *atom)
>> +{
>> +       const char *buf;
>> +
>> +       buf = strchr(atom->str, ':');
>> +       atom->u.remote_ref = RR_NORMAL;
>> +       if (!buf)
>> +               return;
>
> This code is not as clear as it could be due to the way the 'buf'
> assignment and check for NULL are split apart. It can be made clearer
> either by doing this:
>
>     atom->u.remote_ref = RR_NORMAL;
>     buf = strchr(...);
>     if (!buf)
>         return;
>
> or (even better) this:
>
>     buf = strchr(...);
>     if (!buf) {
>         atom->u.remote_ref = RR_NORMAL;
>         return;
>     }
>

Will do the latter, thanks.

>> +       buf++;
>> +       if (!strcmp(buf, "short"))
>> +               atom->u.remote_ref = RR_SHORTEN;
>> +       else if (!strcmp(buf, "track"))
>> +               atom->u.remote_ref = RR_TRACK;
>> +       else if (!strcmp(buf, "trackshort"))
>> +               atom->u.remote_ref = RR_TRACKSHORT;
>> +       else
>> +               die(_("unrecognized format: %%(%s)"), atom->str);
>> +}
>> +
>> @@ -835,6 +856,42 @@ static inline char *copy_advance(char *dst, const char *src)
>> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>> +                                   struct branch *branch, const char **s)
>> +{
>> +       int num_ours, num_theirs;
>> +       if (atom->u.remote_ref == RR_SHORTEN)
>> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
>> +       else if (atom->u.remote_ref == RR_TRACK) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>> +                       return;
>
> The RR_TRACKSHORT branch below has a blank line following the
> 'return', but this branch lacks it, which is inconsistent.
>

will add.

>> +               if (!num_ours && !num_theirs)
>> +                       *s = "";
>> +               else if (!num_ours)
>> +                       *s = xstrfmt("[behind %d]", num_theirs);
>> +               else if (!num_theirs)
>> +                       *s = xstrfmt("[ahead %d]", num_ours);
>> +               else
>> +                       *s = xstrfmt("[ahead %d, behind %d]",
>> +                                    num_ours, num_theirs);
>> +       } else if (atom->u.remote_ref == RR_TRACKSHORT) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>
> What happened to the assert(branch) which was in the original code
> from which this was derived (below)? Is it no longer needed?
>

stat_tracking_info() takes care of that, instead of aborting, we gracefully
continue while leaving that value empty.

-- 
Regards,
Karthik Nayak
