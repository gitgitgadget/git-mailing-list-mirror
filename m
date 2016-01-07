From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Fri, 8 Jan 2016 02:14:40 +0530
Message-ID: <CAOLa=ZSzPeqsObgno8q0hpbAGUgZgFJ5x8Oj7YtA7_uPLvG0Pw@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
 <CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com> <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:45:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHHQt-0002hF-3L
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbcAGUpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 15:45:12 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33702 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbcAGUpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 15:45:11 -0500
Received: by mail-vk0-f46.google.com with SMTP id i129so42804303vkb.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 12:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f0u1bXzN7ylu0XvMHRKbnDWcfdSJXBaXX5FnrTG+VnU=;
        b=p8Dl2Cey5JS7Nzamqq+eXUn+z9oswChzB2MCw+Aa+vJT8eRPg/SEPwsfwLmnolpgQ9
         IfzaybLbtfApXlRPrqVoMe8wPPjjfcLwFMwmUrFLVaiXIWc6hS1PKDluAqeaGp7Ufpmu
         KUuk4x6xIxZ6cMFFgs9CNo0jHcg+/arST5F7h6mLJ30L0kD1hBiIt9QZSd5Ciy8x67YX
         Jg/LsyUbzyJ9mPlCwLS6Ql/caDd/5y5VUeEsDgb9gzzMOxgpQhRWjb7Zd2Dkx6dH4Ggx
         ptUShdGnQQus/ck9RCyH7iHXnt3Do9pusxqfgLj7fQXi/iXk7jgFCP1d+U5TPgP9VuJB
         hSSA==
X-Received: by 10.31.159.136 with SMTP id i130mr45277937vke.144.1452199510410;
 Thu, 07 Jan 2016 12:45:10 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Thu, 7 Jan 2016 12:44:40 -0800 (PST)
In-Reply-To: <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283507>

On Fri, Jan 8, 2016 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> So it appears to me that match_atom_name() is a misguided helper
> function that you shouldn't have to use too often.  If the signature
> of parse() functions is changed to take not just the atom but the
> pointer to its argument (could be NULL, if we are seeing
> "%(contents)", for example) that is already available as "formatp"
> in the function, then contents_atom_parser() could become more like:
>
> contents_atom_parser(struct used_atom *atom, const char *arg)
> {
>         if (args)
>                 atom->u.contents.option = C_BARE;
>         else if (!strcmp(arg, "body"))
>                 atom->u.contents.option = C_BODY;
>         ...
> }
>
> and there is no reason for this caller to even look at atom->name or
> worry about that it might have the dereferencing asterisk in front.
>

So we something like this for the parsing function:

 int parse_ref_filter_atom(const char *atom, const char *ep)
 {
        const char *sp;
+       char *arg;
        int i, at;

        sp = atom;
@@ -141,6 +143,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
                const char *formatp = strchr(sp, ':');
                if (!formatp || ep < formatp)
                        formatp = ep;
+               arg = (char *)formatp;
                if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
                        break;
        }
@@ -154,6 +157,13 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
        REALLOC_ARRAY(used_atom, used_atom_cnt);
        used_atom[at].name = xmemdupz(atom, ep - atom);
        used_atom[at].type = valid_atom[i].cmp_type;
+       if (arg != ep)
+               arg = xstrndup(arg + 1, ep - arg - 1);
+       else
+               arg = NULL;
+       if (valid_atom[i].parser)
+               valid_atom[i].parser(&used_atom[at], arg);
+       free(arg);
        if (*atom == '*')
                need_tagged = 1;
        if (!strcmp(used_atom[at].name, "symref"))

-- 
Regards,
Karthik Nayak
