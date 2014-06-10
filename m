From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 15:47:03 -0400
Message-ID: <CAPig+cTTOCe0-U_bMbzo6fp3PFsN+8eJHi9iTxoE9d3UHyRMhg@mail.gmail.com>
References: <1402418594-1377-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:35:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSlq-0001jv-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbaFJUfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:35:43 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:62197 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbaFJTrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 15:47:04 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so4231781yhl.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dsCU2X6z9ZGO8PYrVvT04VBqGJpjcbvTevN7RwbNsJs=;
        b=J7LRqJ6eoXs8giQk65XvUcQkOmG/CsAQ9BJsXjic2zjWMgNEgj/bSw4VH3FdqBRATB
         g4/IBSXdqPzXq1rPzhgG3uukXMrzQM0ooTAOZg1tsO1K2wV4/LnwKb00r6SctNtONI1m
         X5vTJx+x0ErD1gFOK7P1AfIyb8MqN3IZFKw57Ps+YjgHjDaeIMEyCzzjs/FnCuiCOCH7
         Tpbm0tc1qlDBMYxtY5s2ySqk1pV+ud9yCrJ5v8dHBO/HmHA0OI9QMURvTG1tZJg08obn
         WuE/O1ktHrMe7gyVUyuqY2wkmMz1M/aJ2LJjQZMq1dMmOxk3mCr2mE+4dZLrQsWxQnZv
         sMgA==
X-Received: by 10.236.66.139 with SMTP id h11mr25873147yhd.30.1402429623701;
 Tue, 10 Jun 2014 12:47:03 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 12:47:03 -0700 (PDT)
In-Reply-To: <1402418594-1377-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: 6p7vT9TH42z5tGW6IIOEw4sFik4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251235>

On Tue, Jun 10, 2014 at 12:43 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the fifth revision.
>
> Change based on Junio bugfix and better rewrite of the case condition
> http://permalink.gmane.org/gmane.comp.version-control.git/251198
>
> I dropped also the echo -> printf replacement for doing
> it in another patch.
>
> Pass all the t/*submodule* tests. Finally ! :=)
>
> Thank you all very much and sorry for the mess.
>
>  git-submodule.sh |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e146b83..e128a4a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
>                 while read mod_src mod_dst sha1_src sha1_dst status sm_path
>                 do
>                         # Always show modules deleted or type-changed (blob<->module)
> -                       test $status = D -o $status = T && echo "$sm_path" && continue
> +                       if test "$status" = D || test "$status" = T
> +                        then
> +                               echo "$sm_path" &&

Unnecessary &&.

> +                               continue
> +                       fi
>                         # Respect the ignore setting for --for-status.
>                         if test -n "$for_status"
>                         then
>                                 name=$(module_name "$sm_path")
>                                 ignore_config=$(get_submodule_config "$name" ignore none)
> -                               test $status != A -a $ignore_config = all && continue
> +                               test $status != A && test $ignore_config = all && continue
>                         fi
>                         # Also show added or modified modules which are checked out
>                         GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
