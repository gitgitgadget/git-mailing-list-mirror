From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching reachable sha1
Date: Tue, 5 May 2015 18:29:00 -0400
Message-ID: <CAPig+cRqDdj0fHdt10x_YhZcEdJ9WN_bAjUH5MjQxKhdVaEKGg@mail.gmail.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
	<1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:29:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YplKt-0006JU-93
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 00:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbbEEW3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 18:29:01 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35933 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbEEW3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 18:29:01 -0400
Received: by iecnq11 with SMTP id nq11so1105386iec.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IvVl82M3vuiMQQEGdjRA/Raebk+FNszMxWMzlvNxdbo=;
        b=ME6cuumMl7sYsbFOF3aUb4E0CbKeVa7C0ITI//Y8jXh+54y00OVPOj5Xyei7oNROy4
         u/tlJJTxAzOa7PtFZW1KbDPoa7h1JNqZ7H3FXfx7M9HDF1aNvRoqZ1GZEbM54upM68C9
         Yl5UNg788RWen7Wk4JHpR5q2MnkMTehZHq08xBeATfpuANRvHc6GkZy7vpnhtvoZCo5j
         hqao2md3Jq/8AVfPg8oHvNn3ZcOD/ka8LCZpiaQTwcf797abOXyy6lbfNrGT52IW2fuH
         BMuwEu79PR/G0NZDi8zxa/bY4C6F69/1R4JLhvT82Cd1dxR5j3VdWmhM28FTcOF+Wb9x
         bx4Q==
X-Received: by 10.107.31.134 with SMTP id f128mr2443679iof.19.1430864940288;
 Tue, 05 May 2015 15:29:00 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 15:29:00 -0700 (PDT)
In-Reply-To: <1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
X-Google-Sender-Auth: v6G43lsvtkU9VFQLWRN0n3AcwJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268430>

On Tue, May 5, 2015 at 5:21 PM, Fredrik Medley <fredrik.medley@gmail.com> wrote:
> With uploadpack.allowreachablesha1inwant configuration option set on the
> server side, "git fetch" can make a request with a "want" line that names
> an object that has not been advertised (likely to have been obtained out
> of band or from a submodule pointer). Only objects reachable from the
> branch tips, i.e. the union of advertised branches and branches hidden by
> transfer.hiderefs, will be processed. Note that there is an associated
> cost of having to walk back the hstory to check the reachability.
> [...]
> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
> ---
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8a5f236..01fabfb 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1120,6 +1120,61 @@ test_expect_success 'fetch exact SHA1' '
>         )
>  '
>
> +for configallowtipsha1inwant in true false
> +do
> +       test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
> +               mk_empty testrepo &&
> +               (
> +                       cd testrepo &&
> +                       git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
> +                       git commit --allow-empty -m foo &&
> +                       git commit --allow-empty -m bar
> +               ) &&
> +               SHA1=`git --git-dir=testrepo/.git rev-parse HEAD^` &&

Use $(..) here and elsewhere rather than `...`.

    SHA1=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&

> +               mk_empty shallow &&
> +               (
> +                       cd shallow &&
> +                       test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
> +                       git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
> +                       git fetch --depth=1 ../testrepo/.git $SHA1 &&
> +                       git cat-file commit $SHA1 >/dev/null
> +               )
> +       '
> +
> +       test_expect_success "deny fetch unreachable SHA1, allowtipsha1inwant=$configallowtipsha1inwant" '
> +               mk_empty testrepo &&
> +               (
> +                       cd testrepo &&
> +                       git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
> +                       git commit --allow-empty -m foo &&
> +                       git commit --allow-empty -m bar &&
> +                       git commit --allow-empty -m xyz
> +               )
> +               SHA1_1=`git --git-dir=testrepo/.git rev-parse HEAD^^` &&
> +               SHA1_2=`git --git-dir=testrepo/.git rev-parse HEAD^` &&
> +               SHA1_3=`git --git-dir=testrepo/.git rev-parse HEAD` &&
> +               (
> +                       cd testrepo &&
> +                       git reset --hard $SHA1_2 &&
> +                       git cat-file commit $SHA1_3 >/dev/null &&
> +                       git cat-file commit $SHA1_3 >/dev/null
> +               ) &&
> +               mk_empty shallow &&
> +               (
> +                       cd shallow &&
> +                       test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
> +                       test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
> +                       git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
> +                       git fetch ../testrepo/.git $SHA1_1 &&
> +                       git cat-file commit $SHA1_1 >/dev/null &&
> +                       test_must_fail git cat-file commit $SHA1_2 >/dev/null &&
> +                       git fetch ../testrepo/.git $SHA1_2 &&
> +                       git cat-file commit $SHA1_2 >/dev/null &&
> +                       test_must_fail git fetch ../testrepo/.git $SHA1_3
> +               )
> +       '
> +done
> +
>  test_expect_success 'fetch follows tags by default' '
>         mk_test testrepo heads/master &&
>         rm -fr src dst &&
