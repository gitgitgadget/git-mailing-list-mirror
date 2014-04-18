From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 2/3] i18n: Only extract comments marked by special tag
Date: Fri, 18 Apr 2014 14:03:06 +0800
Message-ID: <CANYiYbGkjpdrzE25iRS33sm1=AodiREqWmJVkKVEok4mb4G5mQ@mail.gmail.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
	<2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
	<xmqqk3anesml.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	bug-gettext@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 08:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb1tK-0001mK-UJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 08:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbaDRGDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 02:03:10 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:54110 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaDRGDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 02:03:08 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so1258817wes.28
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2H0kLUEp9z7imPX6JvPXvW+I4Kk7v5c3CILkv1Gbb4U=;
        b=zA8yhYEx+filIxG0sLnr03M3z4eaJLLMHJ1KHopHh7NIpdyYgXo3p2I/pG6/44bf5Z
         uD2XI9VMlp4p+TqYCKy9PE9rxKYRJFEq4zTNWgIsyH3ki+Jw9ZpUSY62kRPTSo3RMOMb
         2Lr2B18CMuV+hiW8prUp10IyoUbUepJZNOLcrucCsf6dT1MVXyHxBM8IeGzQCMGI1alU
         u2InfYKJV00Tm66D60NaV4Tjnc9yjlYfetio+mkg+efiSKjtewupTQS3Pvqv/00HyuOV
         EDhBR2uYmNRZxXiDjgy7j7gxHn3BPlj0e/J+PniWj3Hkc41EfAZWjVMy7AlKkqpVFVrp
         mNqA==
X-Received: by 10.180.80.232 with SMTP id u8mr1091848wix.13.1397800986210;
 Thu, 17 Apr 2014 23:03:06 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Thu, 17 Apr 2014 23:03:06 -0700 (PDT)
In-Reply-To: <xmqqk3anesml.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246462>

2014-04-18 2:08 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> When extract l10n messages, we use "--add-comments" option to keep
>> comments right above the l10n messages for references.  But sometimes
>> irrelevant comments are also extracted.  For example in the following
>> code block, the comment in line 2 will be extracted as comment for the
>> l10n message in line 3, but obviously it's wrong.
>>
>>         { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>>           NULL /* takes no arguments */,
>>           N_("ignore paths removed in the working tree (same as
>>           --no-all)"),
>>           PARSE_OPT_NOARG, ignore_removal_cb },
>>
>> Since almost all comments for l10n translators are marked with the same
>> prefix (tag): "TRANSLATORS:", it's safe to only extract comments with
>> this special tag.  I.E. it's better to call xgettext as:
>>
>>         xgettext --add-comments=TRANSLATORS: ...
>>
>> Also tweaks the multi-line comment in "init-db.c", to make it start with
>> the proper tag, not "* TRANSLATORS:" (which has a star before the tag).
>
> Hmph.
>
> I am not very happy with this change, as it would force us to
> special case "Translators" comment to follow a non-standard
> multi-line comment formatting convention.  Is there a way to tell
> xgettext to accept both of these forms?
>
>         /* TRANSLATORS: this is a short comment to help you */
>         _("foo bar");
>
>         /*
>          * TRANSLATORS: this comment is to help you, but it is
>          * a lot longer to fit on just a single line.
>          */
>         _("bar baz");
>

We can not provide multiple `--add-comments=TAG` options to xgettext,
because xgettext holds the tag in one string, not in a list:

        /* Tag used in comment of prevailing domain.  */
        static char *comment_tag;

So if we won't change our multi-line comments for translators, must
hack gettext in some ways.

There maybe 3 ways to hack gettext:

1. When matching comments against TAG, using strstr not strncmp.

        2360         /* When the comment tag is seen, it drags in not
only the line
        2361            which it starts, but all remaining comment lines.  */
        2362         if (add_all_remaining_comments
        2363             || (add_all_remaining_comments =
        2364                   (comment_tag != NULL
        2365                    && strncmp (s, comment_tag, strlen
(comment_tag)) == 0)))

2. Add a extension to in-comment xgettext instructions.

    There is a undocumented feature in xgettext: User can provide
    instructions (prefixed by xgettext:) in comments, such as:

        /*
         * xgettext: fuzzy possible-c-format no-wrap
         * other comments...
         */

    But it does not help much, unless we hack xgettext to extend this
    hidden feature. I.E. Add an additional flag to support unconditionally
    reference to the commit block. Like:

        /*
         * xgettext: comments
         * TRANSLATORS: this comment is to help you, but it is
         * a lot longer to fit on just a single line.
         */
         _("bar baz");

3. Hack the parser for comments in "gettext-tools/src/x-c.c" (maybe
    function phase4_getc()) to support various multi-line comments style,
    such as:

        /*
         * TRANSLATORS: this comment is to help you, but it is
         * a lot longer to fit on just a single line.
         */

        /*
        ** TRANSLATORS: this comment is to help you, but it is
        ** a lot longer to fit on just a single line.
        */

        /********************************************************
         * TRANSLATORS: this comment is to help you, but it is  *
         * a lot longer to fit on just a single line.           *
         ********************************************************/


I CC this mail to the gettext mailing list. Full thread see:

 * http://thread.gmane.org/gmane.comp.version-control.git/246390/focus=246431

-- 
Jiang Xin
