From: =?utf-8?Q?David_K=C3=A5gedal?= <david@virtutech.se>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Wed, 21 Nov 2007 11:43:00 +0100
Message-ID: <87oddnvpzf.fsf@virtutech.se>
References: <87tznfvqb4.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 12:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IunRT-0000e9-Dh
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbXKULIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 06:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbXKULIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:08:09 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:34936 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446AbXKULIH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 06:08:07 -0500
X-Greylist: delayed 1511 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2007 06:08:07 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 607A6200A1DF;
	Wed, 21 Nov 2007 11:42:53 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13755-01-85; Wed, 21 Nov 2007 11:42:53 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 004D3200A1DA;
	Wed, 21 Nov 2007 11:42:52 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 55AD37B406A; Wed, 21 Nov 2007 11:43:00 +0100 (CET)
In-Reply-To: <87tznfvqb4.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Wed\, 21 Nov 2007 11\:35\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65628>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>
> This test case fails on the kha/experimental branch.  Using "stg
> refresh -p <patch>" can cause all sorts of wieirdness, and there is n=
o
> test case for it.

I just checked, and it fails on kha/safe as well. So maybe there is
some problem with the test case, but I don't know what it is.

And maybe it should be called t2301 instead?

>  t/t2700-refresh.sh |   65 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100755 t/t2700-refresh.sh
>
> diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
> new file mode 100755
> index 0000000..2e7901c
> --- /dev/null
> +++ b/t/t2700-refresh.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +
> +test_description=3D'Run "stg refresh"'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'Initialize StGit stack' '
> +    stg init &&
> +    echo expected.txt >> .git/info/exclude &&
> +    echo patches.txt >> .git/info/exclude &&
> +    stg new p0 -m "base" &&
> +    for i in 1 2 3; do
> +        echo base >> foo$i.txt &&
> +        git add foo$i.txt
> +    done
> +    stg refresh &&
> +    for i in 1 2 3; do
> +        stg new p$i -m "foo $i" &&
> +        echo "foo $i" >> foo$i.txt &&
> +        stg refresh
> +    done
> +'
> +
> +cat > expected.txt <<EOF
> +p0
> +p3
> +EOF
> +test_expect_success 'Refresh top patch' '
> +    echo bar 3 >> foo3.txt &&
> +    stg refresh &&
> +    stg status &&
> +    test -z "$(stg status)" &&
> +    stg patches foo3.txt > patches.txt &&
> +    diff -u expected.txt patches.txt
> +'
> +
> +cat > expected.txt <<EOF
> +p0
> +p2
> +EOF
> +test_expect_success 'Refresh middle patch' '
> +    stg status &&
> +    echo bar 2 >> foo2.txt &&
> +    stg refresh -p p2 &&
> +    stg status &&
> +    test -z "$(stg status)" &&
> +    stg patches foo2.txt > patches.txt &&
> +    diff -u expected.txt patches.txt
> +'
> +
> +cat > expected.txt <<EOF
> +p0
> +p1
> +EOF
> +test_expect_success 'Refresh bottom patch' '
> +    stg status &&
> +    echo bar 1 >> foo1.txt &&
> +    stg refresh -p p1 &&
> +    stg status &&
> +    test -z "$(stg status)" &&
> +    stg patches foo1.txt > patches.txt &&
> +    diff -u expected.txt patches.txt
> +'
> +
> +test_done
> --=20
> 1.5.3.6.740.ge3d12

--=20
David K=C3=A5gedal, Virtutech
