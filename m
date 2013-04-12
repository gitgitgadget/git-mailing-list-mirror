From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/12] pretty: share code between format_decoration and show_decorations
Date: Sat, 13 Apr 2013 09:34:01 +1000
Message-ID: <CACsJy8BnWg2JPmGUtLdA+XG9=UX65deYv9moefOHL-O7Kd3kww@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-3-git-send-email-pclouds@gmail.com>
 <7vd2uejfxr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 01:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQnUP-0005yc-1f
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 01:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab3DLXed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 19:34:33 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42732 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab3DLXeb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 19:34:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id tb18so2828875obb.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2Fl+q2aI2DXxHyHw0N4KvtMl7JWXmoukvH5HQXf5cjk=;
        b=T46+E8vNVpc4OVsCa4ymetO6fZ+YBdf7zBKn5DOWDBsACF1XL2OYZA83aS4yKZZS+t
         WyyvhPR9bqxAuYm/docaDTbQN8Qe2nfphrFyM4RfLmdOUVhFMWBU59xzviuWlc5TXblW
         II2eQfDC8TD3ZyXWHCqHWnw1oKWV+S8gl6Tn6Hz3aGL5u+Nbb/+kE6U5SPL8phn2Cr7a
         ASqjUDLJwsyMNmATFa0ZzWa2B01j+Ere4ONRtyxF11+2KAGmc/NGV/OPXnuPGFacduHR
         yLBEZdice0m9SrDocmNJ9a5H1VZmaUrKqB38EcC/AQz2gfQdaB8sVJJB8KbJWvCm72iI
         npeg==
X-Received: by 10.182.108.104 with SMTP id hj8mr601223obb.44.1365809671114;
 Fri, 12 Apr 2013 16:34:31 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 12 Apr 2013 16:34:01 -0700 (PDT)
In-Reply-To: <7vd2uejfxr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221039>

Sorry for this late reply. I've been quite busy lately..

On Tue, Apr 2, 2013 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> -void show_decorations(struct rev_info *opt, struct commit *commit)
>> +void format_decoration(struct strbuf *sb,
>> +                    const struct commit *commit,
>> +                    int use_color)
>>  {
>> -     const char *prefix;
>> -     struct name_decoration *decoration;
>> +     const char *prefix = " (";
>> +     struct name_decoration *d;
>
> This renaming of variable from decoration to d seems to make the
> patched result unnecessarily different from the original in
> show_decorations, making it harder to compare.  Intentional?

I think I just happened to reuse the style of the old
format_decoration(). Will reuse the name "decoration" instead.

>>       const char *color_commit =
>> -             diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
>> +             diff_get_color(use_color, DIFF_COMMIT);
>>       const char *color_reset =
>> -             decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
>> +             decorate_get_color(use_color, DECORATION_NONE);
>> +
>> +     load_ref_decorations(DECORATE_SHORT_REFS);
>
> In cmd_log_init_finish(), we have loaded decorations with specified
> decoration_style already.  Why is this needed (and with a hardcoded
> style that may be different from what the user specified)?

legacy from pretty.c:format_decoration(). Will move it to the caller
format_commit_one.

>
>> +     d = lookup_decoration(&name_decoration, &commit->object);
>> +     if (!d)
>> +             return;
>> +     while (d) {
>> +             strbuf_addstr(sb, color_commit);
>> +             strbuf_addstr(sb, prefix);
>> +             strbuf_addstr(sb, decorate_get_color(use_color, d->type));
>> +             if (d->type == DECORATION_REF_TAG)
>> +                     strbuf_addstr(sb, "tag: ");
>> +             strbuf_addstr(sb, d->name);
>> +             strbuf_addstr(sb, color_reset);
>> +             prefix = ", ";
>> +             d = d->next;
>> +     }
>> +     if (prefix[0] == ',') {
>> +             strbuf_addstr(sb, color_commit);
>> +             strbuf_addch(sb, ')');
>> +             strbuf_addstr(sb, color_reset);
>> +     }
>
> Was this change to conditionally close ' (' mentioned in the log
> message?  It is in line with the version taken from pretty.c, and I
> think it may be an improvement, but I do not think the check is
> necessary in the context of this function.  You will never see
> prefix[0] != ',' after the loop, because "while (d)" above runs at
> least once; otherwise the "if (!d) return" would have returned from
> the function early, no?

Yes, your eyeballs have really good quality ;)

>> @@ -625,8 +639,8 @@ void show_log(struct rev_info *opt)
>>                       printf(" (from %s)",
>>                              find_unique_abbrev(parent->object.sha1,
>>                                                 abbrev_commit));
>> +             fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), stdout);
>>               show_decorations(opt, commit);
>> -             printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
>
> We used to show and then reset.  I can see the updated
> show_decorations() to format_decoration() callchain always reset at
> the end, so the loss of the final reset here is very sane, but is
> there a need to reset beforehand?  What is the calling convention
> for the updated show_decorations()?  The caller should make sure
> there is no funny colors in effect before calling, and the caller
> can rest assured that there is no funny colors when the function
> returns?

I think it's a sane convention, unless we want a some background color
going through show_decorations.

>> +void format_decoration(struct strbuf *sb,
>> +                    const struct commit *commit,
>> +                    int use_color);
>
> I think you can fit these on a single line, especially if you drop
> the unused variable names (they help when there are more than one
> parameter of the same type to document the order of the arguments,
> but that does not apply here).  That would help people who run
> "grep" on the header files without using CTAGS/ETAGS.

No problem.

> Wouldn't it be "format_decorations()", or does it handle only one?

All in one, apparently. Will rename.
--
Duy
