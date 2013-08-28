From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 16:35:54 -0400
Message-ID: <CAPig+cSt6HCuB2VOj_-C+e7BeXJD72hKdtNN3ueyKn6B4DSu7A@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmTA-0004pb-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab3H1Uf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 16:35:56 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56106 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3H1Uf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 16:35:56 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so5204851lbh.37
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bUWOeBiqG+59ahT3bJovEO3uGCASafZvmxxB8jnPvkw=;
        b=PgZLxhPgBWN9Tv1A2l6CXLdv4wrj3eG65gWCcoC1SpG22vmKaxQwOU02gRR4YkWt1Q
         SRIcBIgKC0dKkrV6cq4wx7RqeHjZsdag/LN7ThqamVGyRMXZdGg1e9CAgnE8K7wGfySC
         0yZbN2to7h9zL2O3r7SC6rzkDPsnRRTfquPynfxiFIcJ8ufoLp6qHMMkLYke6BtQscSD
         aPmQwnbT/8EwX1h9JW92l9C1GeAX7RistvcrGnCqIKc9szXRp3jMOByLrfjIixJkFT4J
         gAAN6eGQsxby2m1TemhJLhSdjnFFPsobobemGXL29gALtpSw0UnHECyAbWMBFb9x+yBt
         XGlg==
X-Received: by 10.152.6.97 with SMTP id z1mr13314974laz.26.1377722154662; Wed,
 28 Aug 2013 13:35:54 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Wed, 28 Aug 2013 13:35:54 -0700 (PDT)
In-Reply-To: <1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: QvV5m7qDzl8lNIyOVcqDtrj6LCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233210>

On Wed, Aug 28, 2013 at 3:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Reported-by: Joakim Verona <joakim@verona.se>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr |  1 +
>  contrib/remote-helpers/test-bzr.sh    | 30 +++++++++++++++++++++++++=
+++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-help=
ers/test-bzr.sh
> index dce281f..ef8992a 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -358,4 +358,34 @@ test_expect_success 'strip' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'export utf-8 authors' '
> +       test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC && u=
nset GIT_COMMITTER_NAME" &&
> +
> +       LC_ALL=3Den_US.UTF-8
> +       export LC_ALL
> +
> +       GIT_COMMITTER_NAME=3D"Gr=E9goire"
> +       export GIT_COMMITTER_NAME
> +
> +       bzr init bzrrepo &&
> +
> +       (
> +       git init gitrepo &&
> +       cd gitrepo &&
> +       echo greg >> content &&
> +       git add content &&
> +       git commit -m one

Broken &&-chain.

> +       git remote add bzr "bzr::../bzrrepo" &&
> +       git push bzr
> +       ) &&
> +
> +       (
> +       cd bzrrepo &&
> +       bzr log | grep "^committer: " > ../actual
> +       ) &&
> +
> +       echo "committer: Gr=E9goire <committer@example.com>" > expect=
ed &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
