From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] branch: fix --verbose output column alignment
Date: Fri, 15 Nov 2013 09:45:16 +0800
Message-ID: <CANYiYbGPo4jZ5HShivK3Qk58pBaZAEnr71AML+9K4_Yzzkm+qQ@mail.gmail.com>
References: <1384453081-7679-1-git-send-email-hegge@resisty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Fri Nov 15 02:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh8TK-0002Bc-SY
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 02:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab3KOBpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 20:45:20 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33839 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3KOBpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 20:45:18 -0500
Received: by mail-wi0-f182.google.com with SMTP id i19so345669wiw.15
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iPz8TdyYUFoWuCtPCuvxQlpHQunadb1LLn6SU9DfF/U=;
        b=UBmTK7AMEqrDywoXXTjECyWxUNVc9RnU8I3vwrb+WhgNNqVx0xNHj8Kd3JJiGYPGl4
         BZPNi2bQBY9a6Mza6GSHsAabemmTMUbM8wsECPD6h0Yc/Nx7/nZ785apXtUFR20Gi3+M
         VyjbJmNjqujn6i6+lM3bFslsYhBc1aurAGmBdWLlQuYhfI0a37ac9RA44TEP16oI83EJ
         rCTpSzr7iq3V+4Edo02HAsK6AoXJitgRGsJkAhVZxTdBnJu2pza9k9DkMHs1gOIlS3lY
         d6xXr2gi85vRVq/Tb5yXfCgiVwkwHvYfgpA286hk5lb9K7lss4YlBpk8LThJa7Dr51xq
         Be2g==
X-Received: by 10.180.205.194 with SMTP id li2mr5380158wic.57.1384479916572;
 Thu, 14 Nov 2013 17:45:16 -0800 (PST)
Received: by 10.216.122.202 with HTTP; Thu, 14 Nov 2013 17:45:16 -0800 (PST)
In-Reply-To: <1384453081-7679-1-git-send-email-hegge@resisty.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237887>

2013/11/15 Torstein Hegge <hegge@resisty.net>:
> Commit f2e0873 (branch: report invalid tracking branch as gone) removed
> an early return from fill_tracking_info() in the path taken when 'git
> branch -v' lists a branch in sync with its upstream. This resulted in an
> unconditionally added space in front of the subject line:
>
>     $ git branch -v
>     * master f5eb3da  commit pushed to upstream
>       topic  f935eb6 unpublished topic

Thank you for catching this. Confirmed that the output of "git branch -v"
is not aligned well. This example may be more clear ;-)

    $ git branch -v
     branch1    f0ec0da [ahead 1, behind 2] divert from upstream
     branch2    f5eb3da  commit pushed to upstream
     branch3    f935eb6 unpublished topic

>
> Instead, only add the trailing space if a decoration have been added.
>
> To catch this kind of whitespace breakage in the tests, be a bit less
> smart when filtering the output through sed.
>
> Signed-off-by: Torstein Hegge <hegge@resisty.net>
> ---
>  builtin/branch.c         |  8 +++++++-
>  t/t6040-tracking-info.sh | 24 +++++++++++++-----------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0bb0e93..636a16e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -424,6 +424,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>         struct branch *branch = branch_get(branch_name);
>         struct strbuf fancy = STRBUF_INIT;
>         int upstream_is_gone = 0;
> +       int added_decoration = 1;
>
>         switch (stat_tracking_info(branch, &ours, &theirs)) {
>         case 0:
> @@ -451,9 +452,13 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>         if (upstream_is_gone) {
>                 if (show_upstream_ref)
>                         strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
> +               else
> +                       added_decoration = 0;
>         } else if (!ours && !theirs) {
>                 if (show_upstream_ref)
>                         strbuf_addf(stat, _("[%s]"), fancy.buf);
> +               else
> +                       added_decoration = 0;
>         } else if (!ours) {
>                 if (show_upstream_ref)
>                         strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
> @@ -474,7 +479,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>                                     ours, theirs);
>         }
>         strbuf_release(&fancy);
> -       strbuf_addch(stat, ' ');
> +       if (added_decoration)
> +               strbuf_addch(stat, ' ');
>         free(ref);
>  }
>

How about add "strbuf_addch(stat, ' ');" to each condition directly,  like this:


        if (upstream_is_gone) {
                if (show_upstream_ref) {
                        strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
                        strbuf_addch(stat, ' ');
                }
        } else if (!ours && !theirs) {
                if (show_upstream_ref) {
                        strbuf_addf(stat, _("[%s]"), fancy.buf);
                        strbuf_addch(stat, ' ');
                }
        } else if (!ours) {
                if (show_upstream_ref)
                        strbuf_addf(stat, _("[%s: behind %d]"),
fancy.buf, theirs);
                else
                        strbuf_addf(stat, _("[behind %d]"), theirs);
                strbuf_addch(stat, ' ');
        } else if (!theirs) {
                if (show_upstream_ref)
                        strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
                else
                        strbuf_addf(stat, _("[ahead %d]"), ours);
                strbuf_addch(stat, ' ');
        } else {
                if (show_upstream_ref)
                        strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
                                    fancy.buf, ours, theirs);
                else
                        strbuf_addf(stat, _("[ahead %d, behind %d]"),
                                    ours, theirs);
                strbuf_addch(stat, ' ');
        }
        strbuf_release(&fancy);
        free(ref);


-- 
Jiang Xin
