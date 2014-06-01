From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Sun, 1 Jun 2014 15:42:25 -0400
Message-ID: <CAPig+cTjJHRDQFckLqRCW0xHkMFLVbuYGrLCWHXZQoFsYY5WwA@mail.gmail.com>
References: <20140601150409.15428.27017.chriscool@tuxfamily.org>
	<20140601151038.15428.20661.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 21:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrBeJ-00022o-1t
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 21:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbaFATm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 15:42:26 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:65311 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbaFATmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 15:42:25 -0400
Received: by mail-yk0-f179.google.com with SMTP id 19so3080383ykq.24
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7IEFaCkcgsKFFoZIxtRmNR3IjQE3UXwlbgbDFXe/BHg=;
        b=RvOP/burrCK4K1vKXwtN6cXlzngVla0iI/ek3KLg/NmAgSNVZGiAv97i6Bz+psEVS3
         41hFYFo/9YpDp8EDoftS7Av2reNdFAYoOIukJs/KUvojHQUGOzWv6e2eOUrfcOAV1Uyk
         e3z3rFStussyJ1ngSK2HCCes3vqlyGOdw/YzehkNmJq0eNhxAxbDwH98VySOuA98ijSy
         og1aCE0HtRcEe8xfSh7wvakSicdWoUCpalLxmH4G3ZirGBVjAWUoSjiEsad+x2BD/+a9
         seTvRx/wM1OGxss1vn0ijKt3G51H+WY6dz6Day4dlb4FlBWqh8povTwGcYp4aR8XeOBn
         sjfA==
X-Received: by 10.236.66.139 with SMTP id h11mr44948362yhd.30.1401651745215;
 Sun, 01 Jun 2014 12:42:25 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 1 Jun 2014 12:42:25 -0700 (PDT)
In-Reply-To: <20140601151038.15428.20661.chriscool@tuxfamily.org>
X-Google-Sender-Auth: _JGBbTQr5l6HleCAHG9I5a-J5VY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250543>

On Sun, Jun 1, 2014 at 11:10 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch adds into contrib/ an example script to convert
> grafts from an existing grafts file into replace refs using
> the new --graft option of "git replace".
>
> While at it let's mention this new script in the
> "git replace" documentation for the --graft option.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
> new file mode 100755
> index 0000000..7718a53
> --- /dev/null
> +++ b/contrib/convert-grafts-to-replace-refs.sh
> @@ -0,0 +1,29 @@
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
> +               git replace --graft $definition ||
> +                       die "Convertion failed for: $definition"

s/Convertion/Conversion/  [1]

[1]: http://git.661346.n2.nabble.com/Re-PATCH-contrib-add-convert-grafts-to-replace-refs-sh-tp7611822.html

> +       }
> +done
> +
> +mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
> +       die "Could not mv '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"

"Could not rename..." might be a bit more friendly to non-Unixy folk.

> +echo "Success!"
> +echo "All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
> +echo "The grafts file '$GRAFTS_FILE' has been renamed: '$GRAFTS_FILE.bak'"
> --
> 2.0.0.rc0.40.gd30ccc4
