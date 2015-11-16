From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Mon, 16 Nov 2015 16:14:06 -0500
Message-ID: <CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
	<1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyR6L-0003Ak-I3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbbKPVOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:14:10 -0500
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36279 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbKPVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:14:07 -0500
Received: by ykdr82 with SMTP id r82so26033551ykd.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bbn4yCGgvXL8JMpdrOtrbKo5+I1XZOW4zQxg7By1168=;
        b=aZvfkp6UNUxn49sfYw0zq2hJ7pdqK4gSAtweZaEqpgOpxsmp9FJrRi1/Z2XXOOyAnO
         7o33/rZ+d061T3wVX/qNDmrUgTHR2NcygOzmg7s8MHQ/ieHAA2wsF3hLKo11fl6uKx3c
         kaUGXS+mSsBvZSfQI+x+Bx+h4r7/sC3Ff4P8QzlNv24+clq+/470hVClKEGwdRkLFbin
         dnbR8k+jJk1gSFIivurdu0LEuT0kKKCvJTPPCgGK9OAuRYjUzCG+RKZt0NTEwbixxlMf
         BpZD+hJYUPh9sMi5imWDXuu0DB0SCXfxH32dOg9wSjjP+A6OC+qrtmUzmx+b3O8BGQ+N
         /ovA==
X-Received: by 10.129.132.136 with SMTP id u130mr37525313ywf.208.1447708446333;
 Mon, 16 Nov 2015 13:14:06 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 13:14:06 -0800 (PST)
In-Reply-To: <1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: VnxhbSPz4EqKm1hPo9rAMT0D0yU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281356>

On Sun, Nov 15, 2015 at 8:08 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> In rare cases kill/cleanup operations in tests fail. Retry these
> operations with a timeout to make the test less flaky.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> @@ -121,22 +125,33 @@ p4_add_user() {
>         EOF
>  }
>
> +retry_until_success() {
> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))

There was some discussion previously[1] about detecting dynamically
whether 'date +%s' was supported. Was this something that you intended
to do, or did you decide against it since p4 is not supported on such
platforms?

Same question also applies to patch 4/6.

[1]: http://article.gmane.org/gmane.comp.version-control.git/280978/match=lazy+prerequisite

> +    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
> +    do :
> +    done
> +}
> +
> +retry_until_fail() {
> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
> +    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
> +    do :
> +    done
> +}
