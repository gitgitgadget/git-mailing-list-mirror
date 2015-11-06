From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/4] git-p4: add p4d timeout in tests
Date: Fri, 6 Nov 2015 04:23:15 -0500
Message-ID: <CAPig+cSnhxEQdjiLt8+hjMnYYAxaLRVAYX-S5s3BHTpFOMcWqA@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZudFU-0001Lf-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 10:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032001AbbKFJXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 04:23:19 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33374 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbbKFJXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 04:23:16 -0500
Received: by vkgy127 with SMTP id y127so10401595vkg.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 01:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8IMOqUn42NY8gBWlbOlI3eWXrgPVlrFgpZ8JEk+2ybo=;
        b=f9EHbt7G1INhZEOtV/NiFKngGJD4K9C41anJeEH8gpGV0QNEvIV/XZePPanXRHN2Pu
         ojUZWTm2lXQpXw0K8w3mH0qdCRrvYVw2xSo4EJhiNXaJa38QDPjU1ZqDrDhUKSgXjEfB
         ioOfjWLM36f2C3xivf+iq4+rfgDBkBnLH6EXjNvBwICgCVlv5riO2PTa36Q9yT1fhP4Y
         tAZ5UKTdDS0w1nQUrZCGbNbcamOQdg3K81HL0KaODaJcCAOt9n1zLFsbUPW7VjgGnQCU
         tADOokf+XKfW3MhtWN+JVogy900MUmHRuTtWf1hVPmpcbJbu+I9Xvjr1+vePw0tywOAK
         2X8A==
X-Received: by 10.31.153.210 with SMTP id b201mr11792001vke.117.1446801795505;
 Fri, 06 Nov 2015 01:23:15 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Fri, 6 Nov 2015 01:23:15 -0800 (PST)
In-Reply-To: <1446800323-2914-3-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: W1kawA-GiZUR625etG7OqBhL6g4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280968>

On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
> In rare cases p4d seems to hang. This watchdog will kill the p4d
> process after 300s in any case. That means each individual git p4 test
> needs to finish before 300s or it will fail.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> @@ -81,6 +85,19 @@ start_p4d() {
>         # will be caught with the "kill -0" check below.
>         i=${P4D_START_PATIENCE:-300}
>         pid=$(cat "$pidfile")
> +
> +       timeout=$(($(date +%s) + $P4D_TIMEOUT))
> +    while true

The 'while' line is incorrectly indented with spaces rather than tabs.

> +       do
> +               if test $(date +%s) -gt $timeout

I don't know how portable you intend this to be, but 'date +%s' is not
universally supported (it's missing on Solaris, for instance, and
perhaps AIX). For 6a9d16a (filter-branch: add passed/remaining seconds
on progress, 2015-09-07), we ultimately settled upon detecting +%s
support dynamically:

    if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
        # it's supported
    fi

Perhaps you'd want to detect this via a lazy prerequisite and skip
this if not supported?

> +               then
> +                       kill -9 $pid
> +                       exit 1
> +               fi
> +               sleep 1
> +       done &
> +       watchdog_pid=$!
> +
>         ready=
>         while test $i -gt 0
>         do
> @@ -131,7 +148,8 @@ kill_p4d() {
>         done &&
>         # complain if it would not die
>         test_must_fail kill $pid >/dev/null 2>&1 &&
> -       rm -rf "$db" "$cli" "$pidfile"
> +       rm -rf "$db" "$cli" "$pidfile" &&
> +       retry_until_fail kill -9 $watchdog_pid
>  }
>
>  cleanup_git() {
> --
> 2.5.1
