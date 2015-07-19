From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] Modify tr expressions so that xpg4/tr handles it on Solaris
Date: Sun, 19 Jul 2015 17:49:33 -0400
Message-ID: <CAPig+cSpTgcBA5YbfQWY+x+wc7rBQjugcan+MwLuZVcHaOH9kQ@mail.gmail.com>
References: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
	<1437328836-19156-2-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 23:49:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGwSu-0006EC-8W
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 23:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbbGSVtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 17:49:35 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33513 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbbGSVte (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 17:49:34 -0400
Received: by ykfw194 with SMTP id w194so46536299ykf.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q0wFtbVSqQWpxBUrW5Btd51I2AwppJe+uqy7YCStotA=;
        b=ZEQE5vYRAZ9rhNEQzhZa7xQSM0hYKfxHl4DlOENmgjJtRKm+ui6qVhdi6DgzgjmipZ
         0+UbZeS3FWJV1KaD1YoRd4hsAD26YGdjSfKvgpjBLBvxQnoI6rRRl0ZEOL5eGIaL2BVO
         UzPYPpIorEdYI/8iLK+39sd5npFRN3VVgAAh7YLu5acPY3hWYeADJcdltsE75O9GNbCD
         9Mfk4YtaRNipQmflxbp2Q/Ub1s9Fd/mP4xKt5AW+d8glucPnvamCIRN75K+jYpLgxgwq
         byfBJGV5X2gqsQ0YCvbiJrSoZ/rM/HXeFwfGOP7yUcTavc0ZMSI+9ygACkTx78Xre3ky
         95cw==
X-Received: by 10.170.220.214 with SMTP id m205mr25352671ykf.13.1437342573702;
 Sun, 19 Jul 2015 14:49:33 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 14:49:33 -0700 (PDT)
In-Reply-To: <1437328836-19156-2-git-send-email-bdwalton@gmail.com>
X-Google-Sender-Auth: 0FcMpKKuNcT6Wb9aoVzKpvV1TEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274296>

On Sun, Jul 19, 2015 at 2:00 PM, Ben Walton <bdwalton@gmail.com> wrote:
> It seems that xpg4/tr mishandles some strings involving [ not followed
> by a character class:
> % echo '[::1]' | /usr/xpg4/bin/tr -d '[]'
> [::1
>
> % echo '[::1]' | /usr/xpg4/bin/tr -d '['
> usr/xpg4/bin/tr: Bad string.
>
> This was breaking two tests. To fix the issue, use the octal
> representations of [ and ] instead. Reference the octal expression as
> a newly exported variable so that it's shared across tests and more
> easily understood when reading it.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 39da9c2..6b5b6cd 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -173,7 +173,10 @@ LF='
>  # when case-folding filenames
>  u200c=$(printf '\342\200\214')
>
> -export _x05 _x40 _z40 LF u200c
> +# [ and ], for use by tr commands.
> +squarebrackets="\133\135"

While it's true that the reader may be able to consult the commit
message to learn more about "squarebrackets" and "tr", this might be
one of those cases where either a more explanatory in-code comment is
warranted or the comment should be dropped altogether, since the the
current comment is not illuminating. I'd vote for expanding the
comment a bit to mention "some versions of Solaris 'tr'" and a short
description of the misbehavior.

Also, Hannes wondered how Solaris 'tr' would react to '[][]'. Were you
able to test that or the alternative '[[]]'?
