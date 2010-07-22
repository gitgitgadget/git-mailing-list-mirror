From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix rebase with file move when diff.renames = copies
Date: Thu, 22 Jul 2010 02:51:33 -0500
Message-ID: <20100722075133.GA9292@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Jul 22 09:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obqa9-000283-1t
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 09:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620Ab0GVHwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 03:52:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52251 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155Ab0GVHwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 03:52:33 -0400
Received: by iwn7 with SMTP id 7so7669489iwn.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a7UqAy0GhjDKFg/fS123ks/8+XI31JL1yffqgcmgWUQ=;
        b=nztv1HXS4BQpo7RqGIn1RYwHQaFWK+SjDw5V8OSky0lnWYI9DKOy3MgAqY6z/EHgc4
         5zD9J6Kn0mGK+4n/Lip28xpCX1RY+UBZ9XF7y9ITdDgqadkEOrGjGNS6HSPKKboKYH6/
         LIOZOYMheRAeXdkgdYFdKqWNtv+hFbrhna5mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nvUPEM2FEOouLbLfOoHWBkkDbgdfs78JCNKUhQlU0t1oCDTwYjhYWhcxdkEi4RTakA
         x6RCFfmNd0BewzlVj57a2QLZHztQXVp5WXJwJ3mHRVFly2lyytbF1GhiCBKoU3zRcG92
         KYt0+LRBHwVy50P8ro969qRuhn2EAm1QTrZQA=
Received: by 10.231.152.210 with SMTP id h18mr1589707ibw.18.1279785152775;
        Thu, 22 Jul 2010 00:52:32 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm29671166ibe.11.2010.07.22.00.52.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 00:52:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151444>

David D. Kilzer wrote:

> With diff.renames =3D copies, a rebase with a file move will fail wit=
h
> the following error:
>
>     fatal: mode change for <file>, which is not in current HEAD
>     Repository lacks necessary blobs to fall back on 3-way merge.
>     Cannot fall back to three-way merge.
>     Patch failed at 0001.

I would think that the following works fine:

	git init test-repo &&
	cd test-repo &&
	echo hello >greeting.txt &&
	git add greeting.txt &&
	git commit -m base &&
	git checkout -b move &&
	git mv greeting.txt moved.txt &&
	git commit -m move &&
	git checkout master &&
	echo hi >greeting.txt &&
	git add greeting.txt &&
	git commit -m change &&
	git checkout move &&
	echo '[diff] renames =3D copies' >>.git/config &&
	git rebase master

What am I doing wrong?

On the other hand I find Junio=E2=80=99s explanation[1] compelling
already on its own.

 The end user configuration for "diff" should not affect the
 result produced by the higher level command that is related to
 "diff" only because internally it is implemented in terms of
 it.

In cases where a patch copies a file that was then removed on the
mainline, my intuition says =E2=80=98rebase=E2=80=99 without some extra=
 flag should
accept the change without complaint.  Of course, this intuition is
totally warped --- I tend to think of rebase as diff + apply.

Patch does not apply to master or maint, due to conflict with
v1.7.1-rc0~37^2~5 (rebase: support automatic notes copying,
2010-03-12).  One sneaky way to avoid this kind of thing would be to
insert new tests at some logical point in the middle of a test script.

Test nitpicks:

> +++ b/t/t3400-rebase.sh
> @@ -155,4 +155,21 @@ test_expect_success 'Rebase a commit that sprink=
les CRs in' '
>  	git diff --exit-code file-with-cr:CR HEAD:CR
>  '
> =20
> +test_expect_success 'rebase a single file move with diff.renames =3D=
 copies' '
> +     git config diff.renames copies &&

Use

	test_when_finished "git config --unset diff.renames" &&

to shelter future tests from the effect of this one.

> +     git checkout master &&
> +     echo 1 > Y &&
> +     git add Y &&
> +     test_tick &&
> +     git commit -m "prepare file move" &&

commit: new file Y.

> +     git checkout -b filemove HEAD^ &&
> +     echo 1 > Y &&
> +     git add Y &&
> +     mkdir D &&
> +     git mv A D/A &&
> +     test_tick &&
> +     git commit -m filemove &&

commit: new file Y, rename A to D/A.

> +     GIT_TRACE=3D1 git rebase master

This wants to notice that Y was already added so the top patch can be
simplified to include only a rename.

Can you explain why this test will fail without your patch?

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/100583/focus=
=3D100606
