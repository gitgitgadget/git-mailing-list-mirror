From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib: add convert-grafts-to-replace-refs.sh
Date: Tue, 27 May 2014 17:19:47 -0400
Message-ID: <CAPig+cR4G916TwqGDRMr9fAH=SZkUB8kqGy3Hy5YBHZLgUw8ig@mail.gmail.com>
References: <20140527182719.14437.62235.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 27 23:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpOmm-0008Ra-B2
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 23:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbaE0VTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 17:19:48 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:58652 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaE0VTr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 17:19:47 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so8090369yho.29
        for <git@vger.kernel.org>; Tue, 27 May 2014 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tIJxfn2yqXSRxdxYoCNyarQ3UBDnjce7ojOWF3mDKg8=;
        b=RNCzj/7evt7MdJ0+ulBoAWcbeLwXX6C3US4dsGcRygWaXB3pfrZKC+j2rkcuirbAmJ
         qYJCyYu5FVymAtOQF4TsD4T2wZmyeePZTYMYThAz8rdR476sH3maRJb2+tQVO5JA4rRA
         UBVzZQoSqBGCHTQQxyEI5nWodREDTDvIL8xid20IVDT6midPWl5F3wk225pDDt/w3Vfp
         xJ892vBhonfKAs8/rIlv9yMLxqmEjf+1fGzNDZ+lIWDbnFULMjx9EfQlJgbRizvCuf9f
         Htut+54uTol7PJ663BGCmVOTaPJotdgNsrEI/wVhJlaUfGtTElz8mVFof6YN1R6AvteW
         ddKQ==
X-Received: by 10.236.134.169 with SMTP id s29mr6256927yhi.4.1401225587123;
 Tue, 27 May 2014 14:19:47 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 27 May 2014 14:19:47 -0700 (PDT)
In-Reply-To: <20140527182719.14437.62235.chriscool@tuxfamily.org>
X-Google-Sender-Auth: b9UMbXYAMH_WrguP4qQ2dJ2Uhu0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250239>

On Tuesday, May 27, 2014, Christian Couder <chriscool@tuxfamily.org> wrote:
>
> This script adds into contrib/ an example script to convert
> grafts from an existing grafts file into replace refs using
> the new --graft option of "git replace".
>
> While at it let's mention this new script in the
> "git replace" documentation for the --graft option.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-replace.txt             |  4 +++-
>  contrib/convert-grafts-to-replace-refs.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100755 contrib/convert-grafts-to-replace-refs.sh
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 491875e..e1be2e6 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -79,7 +79,9 @@ OPTIONS
>         content as <commit> except that its parents will be
>         [<parent>...] instead of <commit>'s parents. A replacement ref
>         is then created to replace <commit> with the newly created
> -       commit.
> +       commit. See contrib/convert-grafts-to-replace-refs.sh for an
> +       example script based on this option that can convert grafts to
> +       replace refs.
>
>  -l <pattern>::
>  --list <pattern>::
> diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
> new file mode 100755
> index 0000000..2404cc6
> --- /dev/null
> +++ b/contrib/convert-grafts-to-replace-refs.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +# You should execute this script in the repository where you
> +# want to convert grafts to replace refs.
> +
> +die () {
> +       echo >&2 "$@"
> +       exit 1
> +}
> +
> +GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
> +
> +test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
> +
> +grep '^[^# ]' "$GRAFTS_FILE" | while read definition
> +do
> +       test -n "$definition" && {
> +               echo "Converting: $definition"
> +               git replace --graft $definition || die "Convertion failed for: $definition"

s/Convertion/Conversion/

> +       }
> +done
> +
> +echo "Success! All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
> +echo "You should now move away or delete the grafts file: '$GRAFTS_FILE'"

Rather than merely giving advice, would it make sees for the script
rename the file (adding .bak or some such) and report that it did so?
