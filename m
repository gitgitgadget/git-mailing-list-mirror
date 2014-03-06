From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] test patch hunk editing with "commit -p -m"
Date: Thu, 6 Mar 2014 17:07:13 -0500
Message-ID: <CAPig+cTTCsMDJ_B73+cbedrxoEqbM_txV6JYWmCq-LyX12TpNw@mail.gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-2-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:08:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLgSY-00085c-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 23:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaCFWIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 17:08:04 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:49886 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaCFWHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 17:07:14 -0500
Received: by mail-yk0-f174.google.com with SMTP id 20so8375013yks.5
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ujPQyISHtzvhDP2VOp8pdnBbPJlyxTI4JJ6WhVPyeDw=;
        b=0H99Obl0ZhvlG0sx6xgQZzQ7FElNFo6kUB2vj1dc6djRor8JIAltP2ez8U4BsGvR2u
         h78L4QMWAGZYXBFQ373WJAqRHEOfVLwcRL5Z98AkFFfO5OsYb8OJM0RiSNK52kBLhhkD
         kuTZ0dimUe+zQdx6CLuKrNa68rkecQSCCsWNc0kprAzijq17xO76q1sgOhNldJrMyB6T
         3wOtOWD41v2yyM5JdNvv204IuZZViinrtyVljIAoGLSAB+9qqjxAY/piCOfxVFUXx3ud
         My+uINpKLMlW+4jt0jVulHdEORW43xdAoHAXvK5eBNvKaB7ZJ8GnULk0kTQgoZ1lDzrF
         /kIA==
X-Received: by 10.236.120.147 with SMTP id p19mr18254734yhh.6.1394143633917;
 Thu, 06 Mar 2014 14:07:13 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 6 Mar 2014 14:07:13 -0800 (PST)
In-Reply-To: <1394117424-29780-2-git-send-email-benoit.pierre@gmail.com>
X-Google-Sender-Auth: n7YnMGW-iYgahCAKmpu8ObSrAfY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243564>

On Thu, Mar 6, 2014 at 9:50 AM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> Add (failing) test: with commit changing the environment to let hooks
> now that no editor will be used (by setting GIT_EDITOR to ":"), the
> "edit hunk" functionality does not work (no editor is launched and the
> whole hunk is committed).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7513-commit_-p_-m_hunk_edit.sh | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

A rather unusual filename.

> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
> new file mode 100755
> index 0000000..e0ad905
> --- /dev/null
> +++ b/t/t7513-commit_-p_-m_hunk_edit.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='hunk edit with "commit -p -m"'
> +. ./test-lib.sh
> +
> +if ! test_have_prereq PERL
> +then
> +       skip_all="skipping '$test_description' tests, perl not available"
> +       test_done
> +fi
> +
> +test_expect_success 'setup (initial)' '
> +       echo line1 >file &&
> +       git add file &&
> +       git commit -m commit1

Broken &&-chain.

> +       echo line3 >>file
> +'
> +
> +test_expect_success 'setup expected' '
> +cat >expected <<EOF
> +diff --git a/file b/file
> +index a29bdeb..c0d0fb4 100644
> +--- a/file
> ++++ b/file
> +@@ -1 +1,2 @@
> + line1
> ++line2
> +EOF
> +'

If you use <<-EOF, you can indent the content you're dumping into
'expected', which can enhance readability. Even better, use <<-\EOF to
indicate that you don't want interpolation done within the content.

> +test_expect_failure 'edit hunk "commit -p -m message"' '
> +       echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
> +       git diff HEAD^ HEAD >diff &&
> +       test_cmp expected diff
> +'

If you ever add more tests, is it likely that they will be using the
same 'expected' file used by this test? If not, perhaps it makes sense
to move creation of 'expected' into the test itself.

> +test_done
> --
> 1.9.0
