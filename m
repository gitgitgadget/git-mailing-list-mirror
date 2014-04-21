From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 03:25:39 -0400
Message-ID: <CAPig+cRbP_+fBBtmyLAbbj6685+OhrG_7sOD7hD_HJSZJoAWKg@mail.gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 09:26:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc8cA-0007yI-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 09:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaDUHZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 03:25:57 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:56622 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaDUHZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 03:25:40 -0400
Received: by mail-yk0-f171.google.com with SMTP id q9so3165782ykb.30
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=71LiXAcEr9mUdbjy6zEoUDQe/L8xTU4NcGQYhuR/+Lg=;
        b=KrLRRUmgFbZVIraLH9hoWN96vsJeseJpLw7iCCVvEYKNk0AU+xNvb6y5xN82LAy9kR
         froBJ996k+sX6EyVpPg4Tz01FUOlNeUi1vJSMP7dOSgRFct6wTWUkrw/acDdkGyx0lPZ
         8VU075bl3b6sxdle2T0m2vwouLprQhUmOJzBEzwpHXSfTQ8617IZTkDet6SUWEdZOwW1
         N5OUmsISHCuerC51SI8sFWJ23GXtC9he+Uh1sbpsC2YpR1AaAGMqpvWNdVoscG9ruhQ4
         rndRjqMnKqAKLfkw9lNM7nfu/E0V3opCjoip8VKS1TmjkmmatvVubNf7w3UEkVrAqZ48
         hROw==
X-Received: by 10.236.167.167 with SMTP id i27mr987949yhl.95.1398065139570;
 Mon, 21 Apr 2014 00:25:39 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Mon, 21 Apr 2014 00:25:39 -0700 (PDT)
In-Reply-To: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 6jMbNZqTbvVyTvlxuYf1VQcQEI0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246609>

On Sun, Apr 20, 2014 at 10:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This hook is invoked whenever a branch is updated, either when a branch
> is created or updated with 'git branch', or when it's rebased with 'git
> rebase'. It receives two parameters; the name of the branch, and the
> SHA-1 of the latest commit, additionally, if there was a base commit the
> branch was rebased onto, a third parameter contains it.
>
> It can be used to verify the validity of branch names, and also to keep
> track of the origin point of a branch, which is otherwise not possible
> to find out [1].
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/198587
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
> new file mode 100755
> index 0000000..d921c0e
> --- /dev/null
> +++ b/t/t5408-update-branch-hook.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +
> +test_description='Test the update-branch hook'
> +
> +. ./test-lib.sh
> +
> +setup () {
> +       mkdir -p .git/hooks &&
> +       cat > .git/hooks/update-branch <<-'EOF' &&
> +       #!/bin/sh
> +       echo $@ > .git/update-branch.args
> +       EOF
> +       chmod +x .git/hooks/update-branch &&
> +       echo one > content &&
> +       git add content &&
> +       git commit -a -m one
> +}
> +
> +setup
> +
> +test_expect_success 'creating a branch' '
> +       git checkout -b test master &&
> +       echo two > new &&
> +       git add new &&
> +       git commit -a -m two

Broken &&-chain.

> +       echo "test $(git rev-parse master)" > expected &&
> +       test_cmp expected .git/update-branch.args
> +'
> +
> +test_expect_success 'doing a rebase' '
> +       git checkout -b next master &&
> +       echo three > content &&
> +       git commit -a -m three &&
> +       git rebase --onto next master test &&
> +       echo "test $(git rev-parse HEAD) $(git rev-parse next)" > expected &&
> +       test_cmp expected .git/update-branch.args
> +'
> +
> +test_done
> --
> 1.9.2+fc1.1.g5c924db
