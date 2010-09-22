From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] diff: don't use pathname-based diff drivers for symlinks
Date: Wed, 22 Sep 2010 07:40:51 +0200
Message-ID: <vpqvd5ycp3w.fsf@bauges.imag.fr>
References: <20100921205914.GA1166@sigill.intra.peff.net>
	<20100921210124.GA1188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 07:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyI6J-0001kE-56
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 07:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0IVFma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 01:42:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35969 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab0IVFm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 01:42:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8M5aEXD009857
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Sep 2010 07:36:14 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OyI4Z-0007Qp-K4; Wed, 22 Sep 2010 07:40:51 +0200
In-Reply-To: <20100921210124.GA1188@sigill.intra.peff.net> (Jeff King's message of "Tue\, 21 Sep 2010 17\:01\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 22 Sep 2010 07:36:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8M5aEXD009857
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285738576.41977@Zp3vSpIJXCIiwP2R51dDYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156782>

Jeff King <peff@peff.net> writes:

> We can drop the check in the textconv code, which is now redundant.

Am I correct if I say that this makes "[PATCH 3/3] RFC: blame,cat-file
--textconv: Don't assume mode is ``S_IFREF | 0664''" obsolete?

(but patches 1 and 2 are still useful to check the behavior)

> Technically, this could be breaking somebody's setup if:
>
>   1. They found some use for userdiff config on symlinks. Textconv is
>      already disabled. A custom diff driver might work.

I'm wondering about cases other than regular files and symlinks here.
Directories are not a problem, since for Git, they somehow don't
exist, but for example, "git diff" shows diff for subprojects too.
After little testing, it seem the textconv is never applied on
subprojects, but I couldn't say why.

> I find it unlikely, and given the potential breakage, it seems more like
> exploiting a bug to get what you want.

Agreed.

> +cat >expect <<'EOF'
> +diff --git a/file.bin b/file.bin
> +index e69de29..d95f3ad 100644
> +Binary files a/file.bin and b/file.bin differ
> +diff --git a/link.bin b/link.bin
> +index e69de29..dce41ec 120000
> +--- a/link.bin
> ++++ b/link.bin
> +@@ -0,0 +1 @@
> ++file.bin
> +\ No newline at end of file
> +EOF
> +test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
> +	git config diff.bin.binary true &&
> +	git diff file.bin link.bin >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

It's recommanded to put these cat <<'EOF' within the
test_expect_success, but otherwise, the code looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
