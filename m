From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 19/44] builtin-am: implement --3way, am.threeWay
Date: Tue, 14 Jul 2015 17:32:48 +0800
Message-ID: <CACRoPnTh+rWhOah3u5Q4td5NDLj9CLU3krvw9xCO2DE-VaPudg@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-20-git-send-email-pyokagan@gmail.com>
	<xmqqfv4z3etn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEwa6-0003Ol-BK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 11:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbGNJcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 05:32:50 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35365 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbGNJct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 05:32:49 -0400
Received: by lblf12 with SMTP id f12so2638297lbl.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vYV0dY62VmdfzgH1IeoMVYhOBOcybNA1RaKnAbFdk9E=;
        b=OBd0PO29hDageJFMnMhNUrEElXMXFMTOgDlgjpqD/l7RQLYdVBIvdRZ0o3LUtv9Ovf
         y1caQIk/+ZZ+vtKYkZgCmQMR21BDUHcchBQlkpZZxzyTL0l0Gnd1N3Q8QwCItb8/KoHG
         Olq2A3OswkPKaTgMeJ/K7jGbKQCBVSCPdDrky6eIIQuy+C3iRVP7YzHQbm/+NdFuJ1Tg
         +x5cgaH4DMFytsVTaszmru1mAbkBOXJOfTGH9by9Hg9za5AXQVdcP0ZX0rp8YyATg87/
         iGEIbv7AR0QXADpvK5gr56ajbf9gMBE1JAj5/DhRDsgMHzWuxrvsBIdeSGBZNRQiZE68
         ROLQ==
X-Received: by 10.152.30.4 with SMTP id o4mr35588086lah.74.1436866368316; Tue,
 14 Jul 2015 02:32:48 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 14 Jul 2015 02:32:48 -0700 (PDT)
In-Reply-To: <xmqqfv4z3etn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273942>

On Wed, Jul 8, 2015 at 4:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> @@ -82,6 +84,8 @@ struct am_state {
>>       /* number of digits in patch filename */
>>       int prec;
>>
>> +     int threeway;
>> +
>>       int quiet;
>>
>>       int append_signoff;
>
> These "one line surrounded by blank on both sides" starts to get
> irritating, and the structure looksq horrifying after you apply all
> these patches.  Perhaps have a clean-up patch at the end to make
> them look more like this?
>
> struct am_state {
>         /* state directory path */
>         char *dir;
>
>         /* current and last patch numbers, 1-indexed */
>         int cur;
>         int last;
>
>         /* commit metadata and message */
>         char *author_name;
>         char *author_email;
>         char *author_date;
>         char *msg;
>         size_t msg_len;
>
>         /* when --rebasing, records the original commit the patch came from */
>         unsigned char orig_commit[GIT_SHA1_RAWSZ];
>
>         /* number of digits in patch filename */
>         int prec;
>
>         /* various operating modes and command line options */
>         int interactive;
>         int threeway;
>         int quiet;
>         int append_signoff;
>         int utf8;
>         int committer_date_is_author_date;
>         int ignore_date;
>         int allow_rerere_autoupdate;
>         const char *sign_commit;
>         int rebasing;
>
>         /* one of the enum keep_type values */
>         int keep;
>
>         /* pass -m flag to git-mailinfo */
>         int message_id;
>
>         /* one of the enum scissors_type values */
>         int scissors;
>
>         /* used when spawning "git apply" via run_command() */
>         struct argv_array git_apply_opts;
>
>         /* override error message when patch failure occurs */
>         const char *resolvemsg;

Okay. I would prefer to keep the above fields all in the same block
though, as they are all "various operating modes and command line
options". And in retrospect, the comments don't really add much value,
with the exception of the "enum" comments to make it explicit that we
expect an enum value in that field. So, something like this, perhaps?

struct am_state {
    /* state directory path */
    char *dir;

    /* current and last patch numbers, 1-indexed */
    int cur;
    int last;

    /* commit metadata and message */
    char *author_name;
    char *author_email;
    char *author_date;
    char *msg;
    size_t msg_len;

    /* when --rebasing, records the original commit the patch came from */
    unsigned char orig_commit[GIT_SHA1_RAWSZ];

    /* number of digits in patch filename */
    int prec;

    /* various operating modes and command line options */
    int interactive;
    int threeway;
    int quiet;
    int append_signoff;
    int utf8;
    int keep; /* enum keep_type */
    int message_id;
    int scissors; /* enum scissors_type */
    struct argv_array git_apply_opts;
    const char *resolvemsg;
    int committer_date_is_author_date;
    int ignore_date;
    int allow_rerere_autoupdate;
    const char *sign_commit;
    int rebasing;
};

Thanks,
Paul
