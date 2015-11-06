From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/4] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Fri, 6 Nov 2015 04:28:03 -0500
Message-ID: <CAPig+cQiGqo2rNSC_Lw-WXq0ABp6PRFV-2w1wtK+XccQt2RD=w@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:28:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZudJd-0004jO-49
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 10:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032812AbbKFJ2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 04:28:06 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34651 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFJ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 04:28:04 -0500
Received: by vkgs66 with SMTP id s66so10371224vkg.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T9U+1m2RUm7xbDdcfaKRyo+QUYvNEvYIgg9KC3xLTCI=;
        b=TZhkRI+6zAD77wWgj4s22SaMF3zNiD3njLaGvP/DDRkhaGTtQv4neBXG6ineFygTX5
         z7sYUNt8w8D6/+qbW03kvZyhDv51Jgh6l9/N3Yni0x20lL6QSnrmHUUpPAR48Nw3AXiK
         BduV4n2KJ0uOBTBDAM90pMY30PEBY8Fk1ilJ+YpY2zA7ceWomogkRE1n4Q2U9aJTuCfQ
         Ep5FltBkqo8FMAFjYqjFV6n/We7y5UvvC9VetRy1tTvgmj81YEOYL/6uu5z/icr/6n6D
         LMof3N/Nm/wVgmAg1wBKI7rUKSS49QYbQKnrLteCsru//wIYTo0VVZGQtkMSwc0rqI45
         +eaw==
X-Received: by 10.31.2.193 with SMTP id 184mr11808061vkc.151.1446802083287;
 Fri, 06 Nov 2015 01:28:03 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Fri, 6 Nov 2015 01:28:03 -0800 (PST)
In-Reply-To: <1446800323-2914-4-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: iDLdnKkY4FSgd_Gwb9WYhpsNT14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280969>

On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
> In rare cases kill/cleanup operations in tests fail. Retry these
> operations with a timeout to make the test less flaky.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> +retry_until_success() {
> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
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

I'm confused by this. Patch 2/4 was already calling
retry_until_fail(), but it's introduction seems to be here in patch
3/4. Am I missing something obvious?

>  kill_p4d() {
>         pid=$(cat "$pidfile")
> -       # it had better exist for the first kill
> -       kill $pid &&
> -       for i in 1 2 3 4 5 ; do
> -               kill $pid >/dev/null 2>&1 || break
> -               sleep 1
> -       done &&
> +       retry_until_fail kill $pid
> +       retry_until_fail kill -9 $pid
>         # complain if it would not die
>         test_must_fail kill $pid >/dev/null 2>&1 &&
>         rm -rf "$db" "$cli" "$pidfile" &&
> @@ -153,8 +167,9 @@ kill_p4d() {
>  }
>
>  cleanup_git() {
> -       rm -rf "$git" &&
> -       mkdir "$git"
> +       retry_until_success rm -r "$git"
> +       test_must_fail test -d "$git" &&
> +       retry_until_success mkdir "$git"
>  }
>
>  marshal_dump() {
> --
> 2.5.1
