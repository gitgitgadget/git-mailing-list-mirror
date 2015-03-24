From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 18/25] t1301: use modern test_* helpers
Date: Wed, 25 Mar 2015 00:51:20 +0100
Message-ID: <20150325005120.Horde.ClYI1WJflnvTzVgcL6i8Sg8@webmail.informatik.kit.edu>
References: <20150320100429.GA17354@peff.net>
 <20150320101311.GR12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaYbe-0007q3-KP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 00:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbCXXva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 19:51:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43971 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751874AbbCXXva (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 19:51:30 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YaYbY-00033q-W1; Wed, 25 Mar 2015 00:51:29 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YaYbQ-0008T4-Cn; Wed, 25 Mar 2015 00:51:20 +0100
Received: from x590cf8a1.dyn.telefonica.de (x590cf8a1.dyn.telefonica.de
 [89.12.248.161]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 25 Mar 2015 00:51:20 +0100
In-Reply-To: <20150320101311.GR12543@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427241089.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266241>


Quoting Jeff King <peff@peff.net>:

> This shortens the code and fixes some &&-chaining.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t1301-shared-repo.sh | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 7eecfb8..ac10875 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -12,12 +12,11 @@ setfacl -k . 2>/dev/null
>
>   # User must have read permissions to the repo -> failure on --shared=0400
>   test_expect_success 'shared = 0400 (faulty permission u-w)' '
> +	test_when_finished "rm -rf sub" &&
>   	mkdir sub && (
> -		cd sub && git init --shared=0400
> +		cd sub &&
> +		test_must_fail git init --shared=0400
>   	)
> -	ret="$?"
> -	rm -rf sub
> -	test $ret != "0"
>   '
>
>   modebits () {
> @@ -33,7 +32,7 @@ do
>   			git init --shared=1 &&
>   			test 1 = "$(git config core.sharedrepository)"
>   		) &&
> -		actual=$(ls -l sub/.git/HEAD)
> +		actual=$(ls -l sub/.git/HEAD) &&
>   		case "$actual" in
>   		-rw-rw-r--*)
>   			: happy

This hunk could go into the "moderate &&-chain breakage" patch.
Doesn't really matter, what matters most is that it's fixed, but I  
really liked your classification of missing &&s in the early patches.

> @@ -90,10 +89,8 @@ do
>   		rm -f .git/info/refs &&
>   		git update-server-info &&
>   		actual="$(modebits .git/info/refs)" &&
> -		test "x$actual" = "x-$y" || {
> -			ls -lt .git/info
> -			false
> -		}
> +		verbose test "x$actual" = "x-$y"
> +
>   	'
>
>   	umask 077 &&
> @@ -102,10 +99,7 @@ do
>   		rm -f .git/info/refs &&
>   		git update-server-info &&
>   		actual="$(modebits .git/info/refs)" &&
> -		test "x$actual" = "x-$x" || {
> -			ls -lt .git/info
> -			false
> -		}
> +		verbose test "x$actual" = "x-$x"
>
>   	'
>
> --
> 2.3.3.520.g3cfbb5d
