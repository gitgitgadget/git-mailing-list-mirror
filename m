From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] revert: report success when using option --strategy
Date: Thu, 15 Jul 2010 17:37:06 -0500
Message-ID: <20100715223706.GA4788@burratino>
References: <20100713232816.7738.17380.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 00:38:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZX4C-0004ND-QV
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 00:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934907Ab0GOWiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 18:38:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40136 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934878Ab0GOWh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 18:37:59 -0400
Received: by qyk35 with SMTP id 35so3058195qyk.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RFMEF2Xuvciy0JQ64QiEFRpgDjvhXgVtEvPuPrDgNUc=;
        b=UbFy2k0its1Vv3s3K7iAs1u9AFndCV1QKUciD3+iQ35YC3YHImMZ60/wigJJ6Zn+j0
         KmsnsonTYa2pb+A9FJY4WzbKXI4BQQ0x1+LV2YrH4gQGeg4VQOlsEfIbGylNGm1WdnTU
         W1lt+loJdcWWH3ZWRK1SVXipNtvxlZ9BMeMM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KoTiwGElzFX8AS/T97NmrJ66OkyjMk0CU+QC4pXqW/olmLIhmW6vJGzUhTJPl/mzIr
         +OVW2sYHbgavHUQi7zK67/k4Eat7/8oQrb4O0nDNAKsbJdBc8lER9TcbxmpRG9+eP1Fo
         wX9fajR6BbuAGLuaxJQnDZWZEDDm8dRrSjyDQ=
Received: by 10.224.34.208 with SMTP id m16mr113614qad.285.1279233478329;
        Thu, 15 Jul 2010 15:37:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i26sm6790316qcm.43.2010.07.15.15.37.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 15:37:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713232816.7738.17380.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151124>

Christian Couder wrote:

> "git cherry-pick foo" has always reported success with
> "Finished one cherry-pick" but "cherry-pick --strategy"
> does not print anything.
[...]
> This patch also refactors the code that prints a message
> like "Automatic cherry-pick failed. <help message>". This
> code was duplicated in both do_recursive_merge() and
> do_pick_commit().

This is good.  Nitpicks below.

> +++ b/builtin/revert.c
> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index f90ed3d..6555f92 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -23,12 +23,36 @@ test_expect_success setup '
>  '
>  
>  test_expect_success 'cherry-pick first..fourth works' '
> +	cat <<-EOF > expected &&

Style:
	cat <<-\EOF >expected &&

The \quoting lets reviewers skim through a message without looking
for characters that might be expanded.  The decreased whitespace is
just for consistency.

> +	Finished one cherry-pick.
> +	Finished one cherry-pick.
> +	Finished one cherry-pick.
> +	EOF
> +
> +	git checkout -f master &&
> +	git reset --hard first &&
> +	test_tick &&
> +	git cherry-pick first..fourth 2>actual &&
> +	git diff --quiet other &&
> +	git diff --quiet HEAD other &&
> +	test_cmp expected actual &&
> +	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"

The --verify here does not accomplish much, since the exit status of
git rev-parse is not propagated to test.  So strictly speaking it
would be more robust to do something like

	head=$(git rev-parse --verify HEAD) &&
	fourth=$(git rev-parse --verify fourth) &&
	test "$head" = "$fourth"

though I do not think it is worth changing.

With or without the following changes,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 6555f92..d90b365 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
-	cat <<-EOF > expected &&
+	cat <<-\EOF >expected &&
 	Finished one cherry-pick.
 	Finished one cherry-pick.
 	Finished one cherry-pick.
@@ -40,7 +40,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
-	cat <<-EOF > expected &&
+	cat <<-\EOF >expected &&
 	Finished one cherry-pick with strategy resolve.
 	Finished one cherry-pick with strategy resolve.
 	Finished one cherry-pick with strategy resolve.
-- 
