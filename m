From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 17/25] t0020: use modern test_* helpers
Date: Wed, 25 Mar 2015 01:23:23 +0100
Message-ID: <20150325012323.Horde.zCWvV1mF8OBE1PxYPuuEFg8@webmail.informatik.kit.edu>
References: <20150320100429.GA17354@peff.net>
 <20150320101308.GQ12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:23:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaZ6h-0005zS-KA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 01:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbCYAXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 20:23:35 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44266 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830AbbCYAXe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 20:23:34 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YaZ6a-0004xA-KW; Wed, 25 Mar 2015 01:23:32 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YaZ6S-0001Ct-0e; Wed, 25 Mar 2015 01:23:24 +0100
Received: from x590cf8a1.dyn.telefonica.de (x590cf8a1.dyn.telefonica.de
 [89.12.248.161]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 25 Mar 2015 01:23:23 +0100
In-Reply-To: <20150320101308.GQ12543@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427243012.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266242>


Quoting Jeff King <peff@peff.net>:

> This test contains a lot of hand-rolled messages to show
> when the test fails. We can omit most of these by using
> "verbose" and "test_must_fail". A few of them are for
> update-index, but we can assume it produces reasonable error
> messages when it fails.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t0020-crlf.sh | 144  
> +++++++++++---------------------------------------------
>   1 file changed, 28 insertions(+), 116 deletions(-)
>
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index d2e51a8..9fa26df 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -104,18 +104,12 @@ test_expect_success 'update with autocrlf=input' '
>   	for f in one dir/two
>   	do
>   		append_cr <$f >tmp && mv -f tmp $f &&
> -		git update-index -- $f || {
> -			echo Oops
> -			false
> -			break
> -		}
> +		git update-index -- $f ||
> +		break
>   	done &&

Ah, these tests are evil, I remember them from the time when I was  
fiddling with Jonathan's patch.  They can fail silently without  
testing what they were supposed to test.

If something in the loop fails, the break will leave the loop but it  
will do so with zero return value and, consequently, the test will  
continue as if everything were OK.
And unless it was 'git update-index' that failed in a way that left a  
borked index behind, the 'git diff-index --cached' below will not  
error out or produce some output that would cause the test to fail.   
i.e. I tried e.g.

   append_cr <$f >tmp && mv -f tmp $f && false &&

in the loop and the test succeeded.

I think the best fix would be to unroll the loop: after this patch the  
loop body consists of only two significant lines and we iterate  
through the loop only twice, so the test would be even shorter.

>   	differs=$(git diff-index --cached HEAD) &&
> -	test -z "$differs" || {
> -		echo Oops "$differs"
> -		false
> -	}
> +	verbose test -z "$differs"
>
>   '
>
> @@ -128,18 +122,12 @@ test_expect_success 'update with autocrlf=true' '
>   	for f in one dir/two
>   	do
>   		append_cr <$f >tmp && mv -f tmp $f &&
> -		git update-index -- $f || {
> -			echo "Oops $f"
> -			false
> -			break
> -		}
> +		git update-index -- $f ||
> +		break
>   	done &&
>
>   	differs=$(git diff-index --cached HEAD) &&
> -	test -z "$differs" || {
> -		echo Oops "$differs"
> -		false
> -	}
> +	verbose test -z "$differs"
>
>   '
>
> @@ -152,19 +140,13 @@ test_expect_success 'checkout with autocrlf=true' '
>   	for f in one dir/two
>   	do
>   		remove_cr <"$f" >tmp && mv -f tmp $f &&
> -		git update-index -- $f || {
> -			echo "Eh? $f"
> -			false
> -			break
> -		}
> +		verbose git update-index -- $f ||
> +		break
>   	done &&
>   	test "$one" = $(git hash-object --stdin <one) &&
>   	test "$two" = $(git hash-object --stdin <dir/two) &&
>   	differs=$(git diff-index --cached HEAD) &&
> -	test -z "$differs" || {
> -		echo Oops "$differs"
> -		false
> -	}
> +	verbose test -z "$differs"
>   '
>
>   test_expect_success 'checkout with autocrlf=input' '
> @@ -187,10 +169,7 @@ test_expect_success 'checkout with autocrlf=input' '
>   	test "$one" = $(git hash-object --stdin <one) &&
>   	test "$two" = $(git hash-object --stdin <dir/two) &&
>   	differs=$(git diff-index --cached HEAD) &&
> -	test -z "$differs" || {
> -		echo Oops "$differs"
> -		false
> -	}
> +	verbose test -z "$differs"
>   '
>
>   test_expect_success 'apply patch (autocrlf=input)' '
> @@ -200,10 +179,7 @@ test_expect_success 'apply patch (autocrlf=input)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply patch.file &&
> -	test "$patched" = "$(git hash-object --stdin <one)" || {
> -		echo "Eh?  apply without index"
> -		false
> -	}
> +	verbose test "$patched" = "$(git hash-object --stdin <one)"
>   '
>
>   test_expect_success 'apply patch --cached (autocrlf=input)' '
> @@ -213,10 +189,7 @@ test_expect_success 'apply patch --cached
> (autocrlf=input)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply --cached patch.file &&
> -	test "$patched" = $(git rev-parse :one) || {
> -		echo "Eh?  apply with --cached"
> -		false
> -	}
> +	verbose test "$patched" = $(git rev-parse :one)
>   '
>
>   test_expect_success 'apply patch --index (autocrlf=input)' '
> @@ -226,11 +199,8 @@ test_expect_success 'apply patch --index
> (autocrlf=input)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply --index patch.file &&
> -	test "$patched" = $(git rev-parse :one) &&
> -	test "$patched" = $(git hash-object --stdin <one) || {
> -		echo "Eh?  apply with --index"
> -		false
> -	}
> +	verbose test "$patched" = $(git rev-parse :one) &&
> +	verbose test "$patched" = $(git hash-object --stdin <one)
>   '
>
>   test_expect_success 'apply patch (autocrlf=true)' '
> @@ -240,10 +210,7 @@ test_expect_success 'apply patch (autocrlf=true)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply patch.file &&
> -	test "$patched" = "$(remove_cr <one | git hash-object --stdin)" || {
> -		echo "Eh?  apply without index"
> -		false
> -	}
> +	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
>   '
>
>   test_expect_success 'apply patch --cached (autocrlf=true)' '
> @@ -253,10 +220,7 @@ test_expect_success 'apply patch --cached
> (autocrlf=true)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply --cached patch.file &&
> -	test "$patched" = $(git rev-parse :one) || {
> -		echo "Eh?  apply without index"
> -		false
> -	}
> +	verbose test "$patched" = $(git rev-parse :one)
>   '
>
>   test_expect_success 'apply patch --index (autocrlf=true)' '
> @@ -266,11 +230,8 @@ test_expect_success 'apply patch --index
> (autocrlf=true)' '
>   	git read-tree --reset -u HEAD &&
>
>   	git apply --index patch.file &&
> -	test "$patched" = $(git rev-parse :one) &&
> -	test "$patched" = "$(remove_cr <one | git hash-object --stdin)" || {
> -		echo "Eh?  apply with --index"
> -		false
> -	}
> +	verbose test "$patched" = $(git rev-parse :one) &&
> +	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
>   '
>
>   test_expect_success '.gitattributes says two is binary' '
> @@ -326,21 +287,8 @@ test_expect_success '.gitattributes says two and
> three are text' '
>   	echo "t* crlf" >.gitattributes &&
>   	git read-tree --reset -u HEAD &&
>
> -	if has_cr dir/two
> -	then
> -		: happy
> -	else
> -		echo "Huh?"
> -		false
> -	fi &&
> -
> -	if has_cr three
> -	then
> -		: happy
> -	else
> -		echo "Huh?"
> -		false
> -	fi
> +	verbose has_cr dir/two &&
> +	verbose has_cr three
>   '
>
>   test_expect_success 'in-tree .gitattributes (1)' '
> @@ -352,17 +300,8 @@ test_expect_success 'in-tree .gitattributes (1)' '
>   	rm -rf tmp one dir .gitattributes patch.file three &&
>   	git read-tree --reset -u HEAD &&
>
> -	if has_cr one
> -	then
> -		echo "Eh? one should not have CRLF"
> -		false
> -	else
> -		: happy
> -	fi &&
> -	has_cr three || {
> -		echo "Eh? three should still have CRLF"
> -		false
> -	}
> +	test_must_fail has_cr one &&
> +	verbose has_cr three
>   '
>
>   test_expect_success 'in-tree .gitattributes (2)' '
> @@ -371,17 +310,8 @@ test_expect_success 'in-tree .gitattributes (2)' '
>   	git read-tree --reset HEAD &&
>   	git checkout-index -f -q -u -a &&
>
> -	if has_cr one
> -	then
> -		echo "Eh? one should not have CRLF"
> -		false
> -	else
> -		: happy
> -	fi &&
> -	has_cr three || {
> -		echo "Eh? three should still have CRLF"
> -		false
> -	}
> +	test_must_fail has_cr one &&
> +	verbose has_cr three
>   '
>
>   test_expect_success 'in-tree .gitattributes (3)' '
> @@ -391,17 +321,8 @@ test_expect_success 'in-tree .gitattributes (3)' '
>   	git checkout-index -u .gitattributes &&
>   	git checkout-index -u one dir/two three &&
>
> -	if has_cr one
> -	then
> -		echo "Eh? one should not have CRLF"
> -		false
> -	else
> -		: happy
> -	fi &&
> -	has_cr three || {
> -		echo "Eh? three should still have CRLF"
> -		false
> -	}
> +	test_must_fail has_cr one &&
> +	verbose has_cr three
>   '
>
>   test_expect_success 'in-tree .gitattributes (4)' '
> @@ -411,17 +332,8 @@ test_expect_success 'in-tree .gitattributes (4)' '
>   	git checkout-index -u one dir/two three &&
>   	git checkout-index -u .gitattributes &&
>
> -	if has_cr one
> -	then
> -		echo "Eh? one should not have CRLF"
> -		false
> -	else
> -		: happy
> -	fi &&
> -	has_cr three || {
> -		echo "Eh? three should still have CRLF"
> -		false
> -	}
> +	test_must_fail has_cr one &&
> +	verbose has_cr three
>   '
>
>   test_expect_success 'checkout with existing .gitattributes' '
> --
> 2.3.3.520.g3cfbb5d
