From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Wed, 05 Sep 2012 10:40:27 +0200
Message-ID: <50470FFB.2070204@viscovery.net>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu> <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Sep 05 10:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9BAN-0005RZ-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 10:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab2IEIkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 04:40:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60252 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab2IEIke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 04:40:34 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1T9B9w-0002QZ-Cj; Wed, 05 Sep 2012 10:40:28 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 066351660F;
	Wed,  5 Sep 2012 10:40:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204803>

Am 9/4/2012 10:14, schrieb mhagger@alum.mit.edu:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> There is currently a bug: if passed an absolute top-level path that
> doesn't exist (e.g., "/foo") it incorrectly interprets the path as a
> relative path (e.g., returns "$(pwd)/foo").  So mark the test as
> failing.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t0000-basic.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 1a51634..ad002ee 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -458,7 +458,17 @@ test_expect_success 'real path rejects the empty string' '
>  	test_must_fail test-path-utils real_path ""
>  '
>  

These tests should really be in t0060-path-utils.sh.

> -test_expect_success SYMLINKS 'real path works as expected' '
> +test_expect_failure 'real path works on absolute paths' '
> +	nopath="hopefully-absent-path" &&
> +	test "/" = "$(test-path-utils real_path "/")" &&
> +	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&

These tests fail on Windows because test-path-utils operates on a
DOS-style absolute path even if a POSIX style absolute path is passed as
argument. The best thing would be to move this to a separate test that is
protected by a POSIX prerequisite (which is set in t0060).

> +	# Find an existing top-level directory for the remaining tests:
> +	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&

pwd -P actually expands to pwd -W on Windows, and produces a DOS-style
path. I suggest to insert [^/]* to skip drive letter-colon like so:

	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&

> +	test "$d" = "$(test-path-utils real_path "$d")" &&
> +	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"

Then these tests pass.

-- Hannes
