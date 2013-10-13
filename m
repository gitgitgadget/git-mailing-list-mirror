From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH try2 7/8] push: add --set-publish option
Date: Sun, 13 Oct 2013 06:03:04 -0400
Message-ID: <CAPig+cQ=RkFWssANKQ=mca1jD6MGQuPxAV-SyM8rfHMLYoDHfA@mail.gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
	<1381561561-20459-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 12:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIWF-00068l-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 12:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab3JMKDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 06:03:08 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38181 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3JMKDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 06:03:06 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4626768lbi.25
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=roYVEO30EGzChc1wr7UXIGDd/FOdgPA1d+yHQC60J/s=;
        b=sWRL+yghKTie1MUoXKpw1bd6AXwwIyIwQ7pyh358Gvxg3YhrLDUwdUuPQV3LWWRd3P
         no3pMk4DpwW3aaVMk7QZr03puAtfWQqCI+P/xC5bIlAW9NuQdMlnZpYvmpVRTiaO0yFW
         o+qliI8GkPvx+EfYhP5qZ1ceOmNk/g5KlQs198LgGHxhDWGFqfig5cuqhHPWmsf/L3nE
         QVNc4jjzoP8F7W+gCVDX0LBPQIuBAad0Y1eXAxS8Zdb6lNayzOXsRMr6jHpLwBXpRIQB
         RW6U3AkbO4MetTDulkS2cm6/1uo6JqGMRSrwCo7T15abshzQjZY6oqKdalL3v1s3ZjYX
         fwFg==
X-Received: by 10.112.14.3 with SMTP id l3mr1564847lbc.27.1381658584261; Sun,
 13 Oct 2013 03:03:04 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 13 Oct 2013 03:03:04 -0700 (PDT)
In-Reply-To: <1381561561-20459-2-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: HeJF7ZCJvq70_0RY5xh6b-NdKY0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236070>

On Sat, Oct 12, 2013 at 3:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> diff --git a/t/t5529-push-publish.sh b/t/t5529-push-publish.sh
> new file mode 100755
> index 0000000..2037026
> --- /dev/null
> +++ b/t/t5529-push-publish.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description='push with --set-publish'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup bare parent' '
> +       git init --bare parent &&
> +       git remote add publish parent
> +'
> +
> +test_expect_success 'setup local commit' '
> +       echo content >file &&
> +       git add file &&
> +       git commit -m one
> +'
> +
> +check_config() {
> +       (echo $2; echo $3) >expect.$1
> +       (git config branch.$1.pushremote
> +        git config branch.$1.push) >actual.$1
> +       test_cmp expect.$1 actual.$1
> +}

Do you want to maintain &&-chain in this test?

> +
> +test_expect_success 'push -p master:master' '
> +       git push -p publish master:master &&
> +       check_config master publish refs/heads/master
> +'
> +
> +test_expect_success 'push -u master:other' '
> +       git push -p publish master:other &&
> +       check_config master publish refs/heads/other
> +'
> +
> +test_expect_success 'push -p --dry-run master:otherX' '
> +       git push -p --dry-run publish master:otherX &&
> +       check_config master publish refs/heads/other
> +'
> +
> +test_expect_success 'push -p master2:master2' '
> +       git branch master2 &&
> +       git push -p publish master2:master2 &&
> +       check_config master2 publish refs/heads/master2
> +'
> +
> +test_expect_success 'push -p master2:other2' '
> +       git push -p publish master2:other2 &&
> +       check_config master2 publish refs/heads/other2
> +'
> +
> +test_expect_success 'push -p :master2' '
> +       git push -p publish :master2 &&
> +       check_config master2 publish refs/heads/other2
> +'
> +
> +test_expect_success 'push -u --all' '
> +       git branch all1 &&
> +       git branch all2 &&
> +       git push -p --all &&
> +       check_config all1 publish refs/heads/all1 &&
> +       check_config all2 publish refs/heads/all2
> +'
> +
> +test_expect_success 'push -p HEAD' '
> +       git checkout -b headbranch &&
> +       git push -p publish HEAD &&
> +       check_config headbranch publish refs/heads/headbranch
> +'
> +
> +test_done
