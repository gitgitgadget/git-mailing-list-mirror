From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Sat, 18 Jul 2015 23:39:26 -0400
Message-ID: <CAPig+cSXUoMniWABY-LrH=Z-A6josuAfqW7BVBTXPKG=vd7ouA@mail.gmail.com>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGfVz-0007f1-17
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbbGSDj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:39:27 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35861 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbGSDj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:39:26 -0400
Received: by ykay190 with SMTP id y190so117293258yka.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/Qen+pfMvzFyYRPIf1g8VvDCpRkji5J9rAKnTr1TU6E=;
        b=MCIb2rlGe4IGRjFnd2u8UHzliHsCqpJqzCud6pPpf4NT3Fo9ot1RpueEiNvw69i85r
         km+4ojW7JKM57e8kD9AcKPkNvVTUeuU4Gl/jD0X2oU0fWNXgKFvfFhRYvD+kdO/RyABr
         FdIOZierXikWo6y3vfpVh/9Kh7Z2WEi0tLHdWHuIlZzwy3ErRYOtnO9HGj9m6BHpoUV2
         FfgYQ6DjNl1vNVrzkiIpkXqogInP2pKkE4+yxr6WnxA3ewnMKSQVXZk5CTcgod2SpYSn
         lZdPqCpKKxzgi0dwDk3HOrcF8YJiDFjk2+7RQuOR2G+1A2sRBmrZ6VN54BCsH2lwnL2C
         VwhA==
X-Received: by 10.129.50.140 with SMTP id y134mr22321535ywy.39.1437277166088;
 Sat, 18 Jul 2015 20:39:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:39:26 -0700 (PDT)
In-Reply-To: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
X-Google-Sender-Auth: 1PWLTWWqVCybJ79I9V8LZZbrUms
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274200>

On Sat, Jul 18, 2015 at 11:21 AM, Ben Walton <bdwalton@gmail.com> wrote:
> The space following the last / in a sed command caused Solaris'
> xpg4/sed to fail, claiming the program was garbled and exit with
> status 2:
>
> % echo 'foo' | /usr/xpg4/bin/sed -e 's/foo/bar/ '
> sed: command garbled: s/foo/bar/
> % echo $?
> 2
>
> Fix this by simply removing the unnecessary space.
>
> Additionally, in 99094a7a, a trivial && breakage was fixed. This
> exposed a problem with the test when run on Solaris with xpg4/sed that
> had gone silently undetected since its introduction in
> e4bd10b2. Solaris' sed executes the requested substitution but prints
> a warning about the missing newline at the end of the file and exits
> with status 2.
>
> % echo "CHANGE_ME" | \
> tr -d "\\012" | /usr/xpg4/bin/sed -e 's/CHANGE_ME/change_me/'
> sed: Missing newline at end of file standard input.
> change_me
> % echo $?
> 2
>
> To work around this, use perl to execute the substitution instead. By
> using inplace replacement, we can subsequently drop the mv command.

This two unrelated fixes could be separate patches...

> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index fa6be3c..2583f84 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
>  #IPv6
>  for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
>  do
> -       ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "\133\135")
> +       ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "\133\135")
>         test_expect_success "clone ssh://$tuah/home/user/repo" "
>           test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>         "
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index e94b2f1..eb264f9 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -290,8 +290,7 @@ test_expect_success 'setup incomplete lines' '
>         echo "incomplete" | tr -d "\\012" >>file &&
>         git commit -a -m "Add incomplete line" &&
>         git tag incomplete_lines_add &&
> -       sed -e s/CHANGE_ME/change_me/ <file >file+ &&
> -       mv -f file+ file &&
> +       perl -pi -e "s/CHANGE_ME/change_me/" file &&
>         git commit -a -m "Incomplete context line" &&
>         git tag incomplete_lines_ctx &&
>         echo "Dominus regit me," >file &&
> --
> 1.7.10.4
