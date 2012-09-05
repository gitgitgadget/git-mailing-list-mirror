From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Wed, 05 Sep 2012 10:40:35 +0200
Message-ID: <50471003.9010207@viscovery.net>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu> <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Sep 05 10:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9BAO-0005RZ-1r
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 10:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab2IEIkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 04:40:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60336 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914Ab2IEIkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 04:40:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1T9BA4-00047v-4Q; Wed, 05 Sep 2012 10:40:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DEB131660F;
	Wed,  5 Sep 2012 10:40:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204802>

Am 9/4/2012 10:14, schrieb mhagger@alum.mit.edu:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> These tests already pass, but make sure they don't break in the
> future.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> 
> It would be great if somebody would check whether these tests pass on
> Windows, and if not, give me a tip about how to fix them.
> 
>  t/t0000-basic.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index d929578..3c75e97 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -468,6 +468,17 @@ test_expect_success 'real path works on absolute paths' '
>  	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
>  '
>  
> +test_expect_success 'real path removes extra slashes' '
> +	nopath="hopefully-absent-path" &&
> +	test "/" = "$(test-path-utils real_path "///")" &&
> +	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&

Same here: test-path-utils operates on a DOS-style absolute path.
Furthermore, as Junio pointed out elsewhere, it is desirable that slashes
(dir-separators) at the beginning are not collapsed if there are exactly
two of them. Three or more can be collapsed to a single slash.

> +	# We need an existing top-level directory to use in the
> +	# remaining tests.  Use the top-level ancestor of $(pwd):
> +	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&

Same here: Account for the drive letter-colon.

> +	test "$d" = "$(test-path-utils real_path "//$d///")" &&
> +	test "$d/$nopath" = "$(test-path-utils real_path "//$d///$nopath")"

Since $d is a DOS-style path on Windows, //$d means something entirely
different than $d. You should split the test in two: One test checks that
slashes at the end or before $nopath are collapsed (this must work on
Windows as well), and another test protected by POSIX prerequisite to
check that slashes at the beginning are collapsed.

-- Hannes
