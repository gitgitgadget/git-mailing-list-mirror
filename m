From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 10/12] t5520: failing test for pull --all with no
 configured upstream
Date: Fri, 8 May 2015 02:05:35 +0800
Message-ID: <CACRoPnRXJOxUkT5sKQf2bLnWVQ-+xFPu8D2PbX2b_9XVEGwQnA@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-11-git-send-email-pyokagan@gmail.com>
	<xmqq3838qoeb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQBB-0003Po-6E
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbEGSFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:05:38 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34985 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEGSFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:05:37 -0400
Received: by lbbuc2 with SMTP id uc2so36880968lbb.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PmtL8+vsjmff3pl5rQhl9NINrBdT3VY9EHew98vRc+o=;
        b=zmHwRsEWaYTlvaldYPGH/0kU/7ZR6OVBl+reyxUg7UiZDfWBzouL2s6pW+er5tk/vn
         BoIIgJNnVQy5W9PMhLernPwTaF+Hr73c0vABjPZERl5WdfvyhZHM/naeB9glqR/23Qe+
         lLqdiISle+5XEpt8JcONcUkBy0N/6bflB3nmqCvH0n4cyoGbm9pUZQxnddKjR3oCLOWZ
         XeL7sO0U8fM3U2IvjrvOFQroyh+N7pmMSKQF1NseejiO7G4mD3rf70uqIJfKAmQHdzNh
         xVDeqWXgOlX9VxZOEER94O3C7Xlxe8vb5bL9zOi7cbu6JAQ4jWDep7RI0X4xzxEab9f9
         1g6Q==
X-Received: by 10.112.42.16 with SMTP id j16mr3947666lbl.98.1431021935715;
 Thu, 07 May 2015 11:05:35 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 11:05:35 -0700 (PDT)
In-Reply-To: <xmqq3838qoeb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268565>

Hi,

On Fri, May 8, 2015 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> error_on_no_merge_candidates() does not consider the case where "$#"
>> includes command-line flags that are passed to git-fetch.
>>
>> As such, when the current branch has no configured upstream, and there
>> are no merge candidates because of that, git-pull --all erroneously reports
>> that we are pulling from "--all", as it believes that the first argument
>> is the remote name.
>
> Interesting.
>
> I do not think "pull [origin] --all" makes much sense for the same
> reason why we error out when you say "pull [origin] --tag", so I am
> not sure "There is no tracking information" is the right diag we
> would want to give the user, but I agree that "--all" is not a
> remote name.
>
> Does the same comment as 11/12 applies to this as well?

This is actually only just one symptom of the problem of git-pull
assuming in many places that "$1" is the remote. There are other
possible ones, such as git pull --rebase failing silently at finding
the upstream branch to pass to git-rebase when git-fetch flags are
passed as well (see git-pull.sh:253), though crafting a test case for
that would be a bit more involved. Maybe if I have extra time to look
into it.

Then there is the problem where command line flag parsing stops when
an unidentified flag is encountered, assuming that it is for
git-fetch. E.g. git-pull --all --dry-run will pass --dry-run to
git-fetch, but will still run git-merge. Now, I haven't written this
up as a test case yet because I haven't the time yet, and it could be
argued that this is expected behavior, as the git-pull docs say that
options meant for git-fetch must come after git-pull.

However, this is ultimately really confusing for end-users, so I
propose that we just drop the distinction between git-pull's flags and
git-fetch's flags, and just parse them all at git-pull. This can be
done with the current git-pull.sh, but would be easier with the
superior C parse-options API.

Thanks,
Paul
