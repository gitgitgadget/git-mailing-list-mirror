From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/7] tests: Fix race condition in t7006-pager
Date: Mon, 22 Feb 2010 03:12:30 -0600
Message-ID: <20100222091230.GA16490@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
 <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
 <20100221020317.GA7651@progeny.tock>
 <4B823E21.1060707@viscovery.net>
 <20100222084633.GA14432@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjULI-0005bc-3g
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 10:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0BVJM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 04:12:28 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:61714 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0BVJMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 04:12:25 -0500
Received: by yxe34 with SMTP id 34so864409yxe.15
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/0j6SBAX8lDLEC0YGxnAfsSJgQULx21NzQSXQLPfuVg=;
        b=KJLpkn43lQv076lBZKBR2OzD7VXgSMBWGAlh1BQ/H7sXyzCdjyCjkfaKWl9gqBRlZV
         nARKjavz1z5hXuR9fZl87Prq6UMTcUpzYKNZ6UirwdMh42FZjTkKICSDadHoxh/WhJRb
         sfOhFSo1Doo+W6IN2/mw4y3FYJOwRYjzhpVzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZW5bHLq3YvpuTXh2+zSgbjfc35+tgiN4rgFTDC5xdg2epBdzhnrLlz8knWXj3N6t47
         7mmBwpCoiXy04pVi9/kEeq8RkjX9gzi7svj8huXF4IuxhCJdzbsRfHVCtfF2mHynFAx3
         sDBkJGHXRjf+ESkof3uyzcZVKEh6CL1YupHg4=
Received: by 10.151.29.8 with SMTP id g8mr8489299ybj.74.1266829944834;
        Mon, 22 Feb 2010 01:12:24 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1705237yxe.54.2010.02.22.01.12.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 01:12:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100222084633.GA14432@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140653>

Jonathan Nieder wrote:
> Johannes Sixt wrote:
>=20
> > Don't the following pager settings suffer from a race condition?
>=20
> Yes.  Thanks for noticing.

And to save the reader time wondering: yes, the following examples
suffer from the same race, but if they are used then we _want_ the
test to fail.  It might make sense to squash them in anyway to make
the patch more self-explanatory.

There is also an instance of PAGER=3D'cat > paginated.out'; since the
pager string only starts with but does not equal "cat", this works
fine.  It needed for test =E2=80=9812: color when writing to a pager=E2=
=80=99 to be
able to read the paginated output.

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index ec6fd06..d9202d5 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -157,7 +157,7 @@ test_expect_success TTY 'PAGER overrides default pa=
ger' '
 unset GIT_PAGER
 rm -f core.pager_used
 test_expect_success TTY 'core.pager overrides PAGER' '
-	PAGER=3D: &&
+	PAGER=3Dwc &&
 	export PAGER &&
 	git config core.pager "wc > core.pager_used" &&
 	test_terminal git log &&
@@ -166,7 +166,7 @@ test_expect_success TTY 'core.pager overrides PAGER=
' '
=20
 rm -f GIT_PAGER_used
 test_expect_success TTY 'GIT_PAGER overrides core.pager' '
-	git config core.pager : &&
+	git config core.pager wc &&
 	GIT_PAGER=3D"wc > GIT_PAGER_used" &&
 	export GIT_PAGER &&
 	test_terminal git log &&
