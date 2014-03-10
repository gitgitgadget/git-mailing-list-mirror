From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 16:20:59 -0400
Message-ID: <CAPig+cQoUW5dqSzs-wAVOD1xrbSzuzGoHCDKdmgT_BprngMbvQ@mail.gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:21:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6h7-0006cW-FV
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbaCJUVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:21:01 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:53784 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbaCJUVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:21:00 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so20485879yks.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R1MX3wjpj9BoTv+A5hkrFgYhvJREYA4Byyy8/7YDLHA=;
        b=h1Md0a9vog4EtLySsxQH8LKLHSMnk3XtBwCekV2x9GHjbsM6EY8s6QZ5985UWob7+5
         +dBpOMzqf74YrQHqX6TrLq9gla4WbtzxMFgBMp971i5YLJaEoU3G2g3B53/2M8wqzPaz
         d323WuyhaSNDhrYELOjjhrxd+LxB4+imN9sgs5U7wNTVjYOO5qsl6ZIdT6Qd75iUrQZV
         rlxgDPyoln6s2rnyizIBxSiUNWWDIABc34Ppm2cyaCk++Pb1E7OhMcKSvebBuqIYcy2g
         tUX2rkA0j+SN7pPprEkK+e1KDy33K0Ld8mfSIad1m2dITuSSiwQ8ILeSB2VCl0XZhLqa
         ug8A==
X-Received: by 10.236.86.180 with SMTP id w40mr4735017yhe.116.1394482859474;
 Mon, 10 Mar 2014 13:20:59 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 13:20:59 -0700 (PDT)
In-Reply-To: <1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
X-Google-Sender-Auth: Lge3HHEO3msdy53r-hfuEXU1By0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243808>

On Mon, Mar 10, 2014 at 2:49 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> Add (failing) test: with commit changing the environment to let hooks
> now that no editor will be used (by setting GIT_EDITOR to ":"), the
> "edit hunk" functionality does not work (no editor is launched and the
> whole hunk is committed).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

Is it possible to give this file a name less unusual and more
consistent with other test scripts? Perhaps choose a more generic name
which may allow other similar tests to be added to the file in the
future (if needed)?

> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
> new file mode 100755
> index 0000000..994939a
> --- /dev/null
> +++ b/t/t7513-commit_-p_-m_hunk_edit.sh
> @@ -0,0 +1,34 @@
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
> +       git commit -m commit1 &&
> +       echo line3 >>file &&
> +       cat >expect <<-\EOF
> +       diff --git a/file b/file
> +       index a29bdeb..c0d0fb4 100644
> +       --- a/file
> +       +++ b/file
> +       @@ -1 +1,2 @@
> +        line1
> +       +line2
> +       EOF

In the previous review, the suggestion was that creation of 'expect'
should be moved to the test below where it is actually used rather
than into the 'setup' phase above.

> +'
> +
> +test_expect_failure 'edit hunk "commit -p -m message"' '
> +       echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
> +       git diff HEAD^ HEAD >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_done
> --
> 1.9.0
