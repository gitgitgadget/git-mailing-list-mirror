From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] update-ref: Handle large transactions properly
Date: Tue, 20 Jan 2015 17:21:48 -0800
Message-ID: <CAGZ79kZax5cyVy=uZq8eKLM0+FXDjOF1LS+_tkN4sbX0+HsUjQ@mail.gmail.com>
References: <1421803255-4037-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDjzW-0004eB-IG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 02:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbbAUBVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 20:21:50 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48750 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbAUBVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 20:21:49 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so12091717igd.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 17:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z7FHKFceyL1zQi+VmtZfxTs/NHNLsXwHfS6M6FT2H1s=;
        b=Jt82pPK8zOLWdOlg7m/valGLw4XWs8suJXQAxeU9rSZyjFykOywhbdqJTYx+QmYrvY
         4tQHI2NiHdIIygCXWEvPeVY3zyKGnD4gW0hFUuUX22rtuoVnhxZ9j2uO0cEX18Zxge53
         tpfFOuBPTe56SKqYJiqecIJHHlIRTK2Kmv0VXqf7doSmy5IIuGAP8r305Fx11xSgb12Z
         uqAlnEjyZhFhn9WzhhZtc5io0dgQ6SUpKHLWstv7iYOashew00Z69Iia9TuptUnNx1Z2
         E+y4o/ufWtAtQxPzJtaIlzu4v/SJ5HGH9MhZbq4IUV3VvneHtqNuhkxCC4x55BCDpGlq
         dmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z7FHKFceyL1zQi+VmtZfxTs/NHNLsXwHfS6M6FT2H1s=;
        b=YjTRnR1quVzWVTBniCc5Cg+rKN/XVojjKO5mmzXXC3NxzlEHKhau5KEaB4n19Ar+Iy
         pmr17KdzPQ8dWDunblbYRbX/Ak77Wbn6dsU9GQ618oEMi7F2lqB/a8rlFVb78C9DOSAm
         U0vdG+XMjF/PbekND4csJqobekdGrb9jSX/3q+7wzExin98ltMFxQ+ONn1EQ+rtLBtEN
         q4cmP9PgPf5Oj0ItYNQ2Sh3d1du7X3ywYooKIUzX+qBJr+ZG+rdMfr5o28onfbPybhGt
         1f+fQjqYF25FqubAMqrW70sO5pzWgYCNsm0O1U2G06yOv+vl+DRahRQtKjXzARqPU/+G
         KCLg==
X-Gm-Message-State: ALoCoQkECOeGBjZkY98Kepl8Ja8XuES9IcY1qVhQR5IHllY5fyfQ4WLcplXXvodT1+Auqc+9ZUUr
X-Received: by 10.42.230.67 with SMTP id jl3mr31222568icb.15.1421803308793;
 Tue, 20 Jan 2015 17:21:48 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 20 Jan 2015 17:21:48 -0800 (PST)
In-Reply-To: <1421803255-4037-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262710>

On Tue, Jan 20, 2015 at 5:20 PM, Stefan Beller <sbeller@google.com> wrote:
> Test if we can do arbitrary large transactions. Currently this is a known
> bug that we cannot do large transactions, so document it at least in the
> test suite.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t1400-update-ref.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 6805b9e..a7dd1ff 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1065,4 +1065,31 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
>         test_must_fail git rev-parse --verify -q $c
>  '
>
> +run_with_limited_open_files () {
> +       (ulimit -n 64 && "$@")
> +}
> +
> +test_lazy_prereq ULIMIT 'run_with_limited_open_files true'
> +
> +test_expect_failure ULIMIT 'large transaction creating branches does not burst open file limit' '
> +(
> +       for i in $(seq 65)
> +               echo "create refs/heads/$i HEAD"
> +       done >large_input &&
> +       git update-ref --stdin <large_input &&
> +       git rev-parse --verify -q refs/heads/65
> +)
> +'
> +
> +test_expect_failure ULIMIT 'large transaction deleting branches does not burst open file limit' '
> +(
> +       for i in $(seq 33)

This should be 65 of course. :/

> +       do
> +               echo "delete refs/heads/$i HEAD"
> +       done >large_input &&
> +       git update-ref --stdin <large_input &&
> +       test_must_fail git rev-parse --verify -q refs/heads/65
> +)
> +'
> +
>  test_done
> --
> 2.2.1.62.g3f15098
>
