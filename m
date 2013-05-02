From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/9] t1508 (at-combinations): test branches separately
Date: Thu, 2 May 2013 12:23:49 -0500
Message-ID: <CAMP44s3up_xo=oU+5EajoFo7VzA3RDK+hR-maxN9cUw7y=b3Eg@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxEd-0002qM-EM
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760783Ab3EBRXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:23:52 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:65274 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760754Ab3EBRXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:23:52 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so768482lab.13
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wmIHz5ushgPLT1g/tZ7ymV0vcGWFKh8o3mURZPcXAMo=;
        b=G5p2EdEVmjKqjAGMk/2uY6axyeHMSlQ4tdYFLrCwe3NNWz6ucDrvOZOxt33ixRfL1y
         DLQK/N1S9TE0UgyT0uviVr9xxdS0HJHc5phlG4BpbvD61xa/DDRgjiGjvWSYqApTk3a2
         jeztLadZ4LvXkXMxfxW2IYtk8/mHpYzePNyZ8aCWTXblNW15X2n8j2+PmyGIQNv8H+Q7
         R18SwhQLaEqEmcY0EIFHWtdfPibOxwe8oW/DY4i0BWLLlPYPU+FyXiv3PMeCvyF+Rr+y
         kNburMNj37kXiVAP9Fu2yMkGdeSlnZvnmaH72PoVpkr0448WYYZUEXPkuJpJBU3cAaVx
         8p1w==
X-Received: by 10.152.87.69 with SMTP id v5mr2914714laz.24.1367515429715; Thu,
 02 May 2013 10:23:49 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:23:49 -0700 (PDT)
In-Reply-To: <1367501974-6879-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223230>

On Thu, May 2, 2013 at 8:39 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> In the tests involving @{-1} and @{u} as the final component, what we
> really want to check is if it's pointing to the right ref.  We
> currently check the tip commit of the ref, but we can clarify this by
> separating out checking for commits versus checking for refs at
> check().
>
> [rr: commit message, fix arguments in check()]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t1508-at-combinations.sh | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 46e3f16..cacb2d0 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -4,9 +4,14 @@ test_description='test various @{X} syntax combinations together'
>  . ./test-lib.sh
>
>  check() {
> -test_expect_${3:-success} "$1 = $2" "
> -       echo '$2' >expect &&
> -       git log -1 --format=%s '$1' >actual &&
> +test_expect_${4:-success} "$1 = ${3:-$2}" "
> +       if [ '$2' == 'commit' ]; then
> +               echo '$3' >expect &&
> +               git log -1 --format=%s '$1' >actual
> +       else
> +               echo '${3:-$2}' >expect &&
> +               git rev-parse --symbolic-full-name '$1' >actual
> +       fi &&
>         test_cmp expect actual
>  "
>  }

I'm not sure about this. If we introduce a check that fails, we would
have to do:

check HEAD refs/heads/new-branch "" failure

Which doesn't seem clean. Perhaps it makes more sense to always add
the type of check:

check HEAD ref refs/heads/new-branch

-- 
Felipe Contreras
