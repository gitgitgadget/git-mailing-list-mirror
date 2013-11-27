From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/28] fetch: support fetching from a shallow repository
Date: Wed, 27 Nov 2013 04:47:26 -0500
Message-ID: <CAPig+cTaNuq+f7=27wnZgNi4niMt0xQyQxKq3VdpuH8ZvXxdYQ@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 10:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlbij-0000zo-5w
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 10:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3K0Jr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 04:47:29 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60361 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3K0Jr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 04:47:26 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so11426919iej.14
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HGcaM5g7FgDLbM3KdUrHHRVPG70LX1DujJ4ToMztD5k=;
        b=Y8zIWzaSnfWT4dBrDcI/XX33IRPgrlGBSud7C+BONjcVeRtD5I6/MNacdVpuVAV/Rw
         RY3zY4DTcngrPFsfGsrSirhtPHJSCreiyp1ewsmtkMBewX/kUwU+yIM0nXx7TkVLjVei
         1BnZLQ1sd/ULdbXjVDgpVK19g9F4RqdW5pOZ3zOSwE7pS0vSP50vWeolhkLMk85t2e/U
         IxTXnNdq2EPTn8kFuLF6w5IgIuu4qeCg2+DvRERzeSbeIACz1YCJMzHA49fsN6vEO25z
         oq4hL/kCuolADDue8sKe47X3N9zecxK4+1g4lk2L36zFpYVjVehT2lqVz0+KEzHdkLFb
         Lsug==
X-Received: by 10.50.29.43 with SMTP id g11mr21043364igh.25.1385545646080;
 Wed, 27 Nov 2013 01:47:26 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 01:47:26 -0800 (PST)
In-Reply-To: <1385351754-9954-14-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: knkdZUcQwECahWRtfWz1TiiyfXo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238410>

On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
> new file mode 100755
> index 0000000..41de74d
> --- /dev/null
> +++ b/t/t5536-fetch-shallow.sh
> @@ -0,0 +1,128 @@
> +#!/bin/sh
> +
> +test_description=3D'fetch/clone from a shallow clone'
> +
> +. ./test-lib.sh
> +
> +commit() {
> +       echo "$1" >tracked &&
> +       git add tracked &&
> +       git commit -m "$1"
> +}
> +
> +test_expect_success 'fetch something upstream has but hidden by clie=
nts shallow boundaries' '
> +       # the blob "1" is available in .git but hidden by the
> +       # shallow2/.git/shallow and it should be resent
> +       ! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git has=
h-object --stdin` >/dev/null &&
> +       echo 1 > 1.t &&

s/> />/

> +       git add 1.t &&
> +       git commit -m add-1-back &&
> +       (
> +       cd shallow2 &&
> +       git fetch ../.git +refs/heads/master:refs/remotes/top/master =
&&
> +       git fsck &&
> +       git log --format=3D%s top/master >actual &&
> +       cat <<EOF >expect &&
> +add-1-back
> +4
> +3
> +EOF
> +       test_cmp expect actual
> +       ) &&
> +       git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-=
object --stdin` >/dev/null
> +
> +'
