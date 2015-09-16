From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 5/8] branch: drop non-commit error reporting
Date: Wed, 16 Sep 2015 11:34:08 +0530
Message-ID: <CAOLa=ZQ+uAy6CfWqRgV_Wf8iQoyHdtYU=HEn748Vb=FRc36f_g@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-6-git-send-email-Karthik.188@gmail.com> <xmqqvbbcvl0v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 08:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc5q0-0004yc-UW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 08:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbIPGEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 02:04:39 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32842 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbIPGEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 02:04:38 -0400
Received: by vkgd64 with SMTP id d64so94645289vkg.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2fzZzYFBF9MXUG7KRx9zOSqwBlQfVrNli2v4wX/NwME=;
        b=x9LpleIf1t7tCsPLx1YLRVaK/wYkwVIcRoJxs7bIuCmNSzB5lkjMvgmP98RLM2MUXJ
         041AnpmjFofcRjjaEYBvcuIXD9Rs0gtSfHBAu5znfzf0fvsyo4oGY9RQ+P0C8ubPglSY
         Ag4yWye0GvsemgUVCvzYoQC+RdjQGXWm+vga282w98sh1RyT1m5Iqoz29VzTviQbd7HZ
         ht2u1KfU6zVAg3D1TtfzE0U8AW/CY7xCOW3SyMEFEcAJi6R9sIWHJqfhLTc7OGgxE0Gm
         Hgl4pMxDphzS80eI2Am1yy44qcVXCPAHnFFQmmRGUo7aim6+OcSKIVTk1w/DwsvSK3/4
         kJ6Q==
X-Received: by 10.31.50.196 with SMTP id y187mr25901813vky.142.1442383477676;
 Tue, 15 Sep 2015 23:04:37 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 15 Sep 2015 23:04:08 -0700 (PDT)
In-Reply-To: <xmqqvbbcvl0v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278002>

On Tue, Sep 15, 2015 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs. This variable is not required as in
>> ref-filter we already check for possible errors and report them.
>
> Hmmmm.  What do you exactly mean "possible errors" here?
>

The checking if it points to a commit.

> Unlike generic refs that can point at anything, refs/heads/* refs
> must point at a commit [*1*], and that is why the error message says
> 'does not point at a commit'.
>
> Does ref-filter API have corresponding check to treat the local and
> remote branch hierarchies differently from tags and others?
>

This check in the existing code is only done when one of these holds:
ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER

There is a similar check in ref-filter when we filter and obtain refs.

    if (filter->merge_commit || filter->with_commit || filter->verbose) {
        commit = lookup_commit_reference_gently(oid->hash, 1);
        if (!commit)
            return 0;
        /* We perform the filtering for the '--contains' option */
        if (filter->with_commit &&
            !commit_contains(filter, commit))
            return 0;
    }

> [Footnote]
>
> *1* Strictly speaking, use of lookup_commit_reference_gently() in
>     the existing code allows a committish to be there and does not
>     limit the tip objects to be commits, but I think it is a bug.
>     At least, even with deref_tag(), we reject non committish found
>     at the tip of branch refs and explain with the error message
>     this patch removes.

Ah, didn't go through this.

-- 
Regards,
Karthik Nayak
